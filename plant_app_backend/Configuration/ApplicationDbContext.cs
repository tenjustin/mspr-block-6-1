using Microsoft.EntityFrameworkCore;
using plant_app_backend.DAL.Models;

namespace plant_app_backend.Configuration
{
    public class ApplicationDbContext : DbContext 
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }

        DbSet<Annonces> Annonces { get; set; }
        DbSet<User> User { get; set; }
    }
}
