using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using plant_app_backend.DAL.Models;
using plant_app_backend.DAL.Repository.Interface;

namespace plant_app_backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AnnoncesController : ControllerBase
    {
        private readonly IAnnoncesRepository annoncesRepository;

        public AnnoncesController(IAnnoncesRepository annoncesRepository)
        {
            this.annoncesRepository = annoncesRepository;
        }

        [Authorize]
        [HttpPost]
        public ActionResult CreateAnnonce(Annonces annonces)
        {
            annoncesRepository.InsertAnnonce(annonces);
            return Ok(annonces);
        }
    }
}
