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

        public User GetUserFromCred(string username, string password)
        {
            User user;
            try
            {
                user = _context.User.Where(u => u.Pseudo == username && u.Password == password).Single();
                if (user == null)
                {
                    throw new NullReferenceException("Aucun utilisateur correspondant");
                }
            }
            catch (Exception ex)
            {
                return null;
            }

            return user;
        }

        public User GetUserById(int id)
        {
            var user = _context.User.Where(u => u.Id == id).FirstOrDefault();

            return user;
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
