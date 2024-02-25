using plant_app_backend.DAL.Models;

namespace plant_app_backend.DAL.Repository.Interface
{
    public interface IAnnoncesRepository
    {
        void InsertAnnonce(Annonces annonce);

        List<Annonces> GetAllAnnoncesByVille(string ville);

        string GetImageName(int id);

        Annonces GetAnnonceById(int id);
    }
}
