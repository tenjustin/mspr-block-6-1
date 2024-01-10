using plant_app_backend.DAL.Models;

namespace plant_app_backend.DAL.Repository.Interface
{
    public interface IAnnoncesRepository
    {
        void InsertAnnonce(Annonces annonce);
    }
}
