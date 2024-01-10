using plant_app_backend.Configuration;
using plant_app_backend.DAL.Models;
using plant_app_backend.DAL.Repository.Interface;

namespace plant_app_backend.DAL.Repository
{
    public class UserRepository : IUserRepository
    {
        private readonly ApplicationDbContext _context;

        public UserRepository(ApplicationDbContext context)
        {
            _context = context;
        }

        public bool GetUserFromCred(string username, string password)
        {              
            try
            {
                var user = _context.User.Where(u => u.Pseudo == username && u.Password == password);
                if (user == null)
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                throw;
            }

            return true;
        }

        public void InsertUser(User user)
        {
            _context.User.Add(user);

            try
            {
                _context.SaveChanges();
            }
            catch (Exception ex)
            {
                throw;
            }
        }
    }
}
