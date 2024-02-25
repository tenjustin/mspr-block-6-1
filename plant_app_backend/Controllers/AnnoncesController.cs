using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using plant_app_backend.Common.Models;
using plant_app_backend.Common.Services.Interface;
using plant_app_backend.DAL.Models;
using plant_app_backend.DAL.Repository.Interface;

namespace plant_app_backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AnnoncesController : ControllerBase
    {
        private readonly IAnnoncesRepository annoncesRepository;

        private readonly IAnnoncesService annoncesService;

        private readonly IUserRepository _userRepository;

        public AnnoncesController(IAnnoncesRepository annoncesRepository, IAnnoncesService annoncesService, IUserRepository userRepository)
        {
            this.annoncesRepository = annoncesRepository;
            this.annoncesService = annoncesService;
            _userRepository = userRepository;
        }

        [Authorize]
        [HttpPost]
        [Route("CreateAnnonce")]
        public async Task<IActionResult> UploadImage(AnnonceDto annonces)
        {
            if (annonces.Image == null || annonces.Image.Length == 0)
                return Content("file not selected");

            var fileName = Guid.NewGuid().ToString() + annonces.Image.FileName;

            var path = Path.Combine(Directory.GetCurrentDirectory(), "img", fileName);

            var annoucement = annoncesService.ConvertToAnnonces(annonces, path);

            annoncesRepository.InsertAnnonce(annoucement);

            using (var stream = new FileStream(path, FileMode.Create))
            {
                await annonces.Image.CopyToAsync(stream);
            }

            return Ok();
        }

        [Authorize]
        [HttpPost("Annonces")]
        public ActionResult GetAnnonces([FromBody] string ville)
        {
            var result = annoncesRepository.GetAllAnnoncesByVille(ville);
            var res = result.Select(a =>
            {
                var user = _userRepository.GetUserById(a.UserId);
                return new
                {
                    id = a.Id,
                    title = a.Titre,
                    description = a.Description,
                    location = a.Ville,
                    price = a.Price,
                    latitude = a.Latitude,
                    longitude = a.Longitude,
                    userId = a.UserId,
                    imageUrl = $"https://localhost:32768/api/annonces/image/{a.Id}",
                    name = user.Prenom,
                    lastName = user.Nom
                };
            });
            return Ok(res);
        }

        [Authorize]
        [HttpPost("HomePage")]
        public ActionResult GetAnnoncesProche([FromBody]string ville)
        { 
            var result = annoncesRepository.GetAllAnnoncesByVille(ville).Take(4);
            var res = result.Select(a =>
            {                
                var user = _userRepository.GetUserById(a.UserId);
                return new
                {
                    id = a.Id,
                    title = a.Titre,
                    description = a.Description,
                    location = a.Ville,
                    price = a.Price,
                    latitude = a.Latitude,
                    longitude = a.Longitude,
                    userId = a.UserId,
                    imageUrl = $"https://localhost:32768/api/annonces/image/{a.Id}",
                    name = user.Prenom,
                    lastName = user.Nom
                };
            });
            return Ok(res);
        }

     
        [HttpGet("image/{id}")]
        public ActionResult GetImageFromAnnonce(int id)
        {
            string imagePath = Path.Combine(Directory.GetCurrentDirectory() + "/img", annoncesRepository.GetImageName(id));

            if (!System.IO.File.Exists(imagePath))
            {
                return NotFound(); // Si le fichier image n'est pas trouvé
            }

            // Déterminer le type de contenu de la réponse (par exemple, "image/jpeg")
            string contentType = "image/jpeg"; // Remplacez par le type de contenu approprié

            // Retourner le fichier image avec le type de contenu approprié
            return PhysicalFile(imagePath, contentType);
        }

        [Authorize]
        [HttpGet("{id}")]
        public ActionResult GetAnnonceById(int id)
        {
            var result = annoncesRepository.GetAnnonceById(id);
            var user = _userRepository.GetUserById(result.UserId);
            var res = new
            {
                id = result.Id,
                title = result.Titre,
                description = result.Description,
                location = result.Ville,
                price = result.Price,
                latitude = result.Latitude,
                longitude = result.Longitude,
                userId = result.UserId,
                imageUrl = $"https://10.0.2.2:32768/api/annonces/image/{result.Id}",
                name = user.Prenom,
                lastName = user.Nom
            };
            return Ok(res);
        }
    }
}
