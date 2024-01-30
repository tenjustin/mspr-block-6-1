using plant_app_backend.DAL.Models;

namespace plant_app_backend.DAL.Repository.Interface
{
    public interface IUserRepository
    {
        bool GetUserFromCred(string username, string password);

        public void InsertUser(User user);

        User GetUserById(int id);
    }
}
