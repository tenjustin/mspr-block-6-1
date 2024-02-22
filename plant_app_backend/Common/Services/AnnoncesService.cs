using Microsoft.Web.Helpers;
using plant_app_backend.Common.Models;
using plant_app_backend.Common.Services.Interface;
using plant_app_backend.DAL.Models;
using plant_app_backend.DAL.Repository.Interface;

namespace plant_app_backend.Common.Services
{
    public class AnnoncesService : IAnnoncesService
    {
        private readonly IUserRepository _userRepository;

        public AnnoncesService(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        public List<byte[]> ConvertToByte(List<IFormFile> files)
        {
            var result = new List<byte[]>();
            foreach (IFormFile file in files)
            {
                using (var memoryStream = new MemoryStream())
                {
                    file.CopyTo(memoryStream);

                    result.Add(memoryStream.ToArray());
                }
            }

            return result;
        }

        public Annonces ConvertToAnnonces(AnnonceDto annonceDto, string filename)
        {
            return new Annonces
            {
                Titre = annonceDto.Title,
                Description = annonceDto.Description,
                ImageName = filename,
                Ville = annonceDto.Location,
                IsAvailable = true,
                Price = annonceDto.Price,
                Latitude = annonceDto.Latitude,
                Longitude = annonceDto.Longitude,
            };
        }
    }
}
