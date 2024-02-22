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

        public AnnoncesController(IAnnoncesRepository annoncesRepository, IAnnoncesService annoncesService)
        {
            this.annoncesRepository = annoncesRepository;
            this.annoncesService = annoncesService;
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
        [HttpGet]
        public ActionResult GetAnnoncesProche(string ville)
        { 
            var result = annoncesRepository.GetAllAnnoncesByVille(ville);
            var res = result.Select(a =>
            {                
                return new
                {
                    Title = a.Titre,
                    Description = a.Description,
                    Location = a.Ville,
                    Price = a.Price,
                    Latitude = a.Latitude,
                    Longitude = a.Longitude,
                    UserId = a.User.Id,
                    ImageUrl = $"https://localhost:5001/api/annonces/image/{a.Id}"
                };
            });
            return Ok(res);
        }

        [Authorize]
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
    }
}
