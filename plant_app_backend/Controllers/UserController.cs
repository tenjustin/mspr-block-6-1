using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using plant_app_backend.Common.Models;
using plant_app_backend.Configuration;
using plant_app_backend.DAL.Models;
using plant_app_backend.DAL.Repository;
using plant_app_backend.DAL.Repository.Interface;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using System.Web.Helpers;

namespace plant_app_backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly IUserRepository _userRepository;

        private readonly IConfiguration _configuration;

        public UserController(IUserRepository userRepository, IConfiguration configuration)
        {
            _userRepository = userRepository;
            _configuration = configuration;
        }

        [HttpPost]
        [Route("LogUser")]
        public ActionResult LogUser(UserDto userdto)
        {
            User user = _userRepository.GetUserFromCred(userdto.Identifiant, userdto.Password);
            if (user != null)
            {
                var issuer = _configuration["Jwt:Issuer"];
                var audience = _configuration["Jwt:Audience"];
                var key = Encoding.ASCII.GetBytes(_configuration["Jwt:Key"]);
                var tokenDescriptor = new SecurityTokenDescriptor
                {
                    Subject = new ClaimsIdentity(new[]
                    {
                        new Claim("Id", Guid.NewGuid().ToString()),
                        new Claim(JwtRegisteredClaimNames.Sub, userdto.Identifiant),
                        new Claim(JwtRegisteredClaimNames.Email, userdto.Identifiant),
                        new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
                    }),
                    Expires = DateTime.UtcNow.AddDays(5),
                    Issuer = issuer,
                    Audience = audience,
                    SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha512Signature)
                };
                var tokenHandler = new JwtSecurityTokenHandler();
                var token = tokenHandler.CreateToken(tokenDescriptor);
                var jwtToken = tokenHandler.WriteToken(token);
                var stringToken = tokenHandler.WriteToken(token);
                var response = new
                {
                    token = stringToken,
                    id = user.Id,
                    pseudo = user.Pseudo,
                    nom = user.Nom,
                    prenom = user.Prenom,
                    email = user.Email
                };

                return Ok(response);
            }
            return Unauthorized();
        }

        [HttpPost(Name = "InsertUser")]
        public ActionResult InsertUser(User user)
        {
            _userRepository.InsertUser(user);
            return Ok();
        }


    }
}
