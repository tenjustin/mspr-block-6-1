using plant_app_backend.Common.Models;
using plant_app_backend.DAL.Models;

namespace plant_app_backend.Common.Services.Interface
{
    public interface IAnnoncesService
    {
        List<byte[]> ConvertToByte(List<IFormFile> files);

        Annonces ConvertToAnnonces(AnnonceDto annonceDto, string filename);
    }
}
