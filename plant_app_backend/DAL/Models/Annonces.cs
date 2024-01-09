using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using static System.Net.Mime.MediaTypeNames;

namespace plant_app_backend.DAL.Models
{
    public class Annonces
    {
        [Key]
        public int Id { get; set; }

        public string Titre { get; set; }

        public string Description { get; set; }

        public List<string> Photos { get; set; }

        public User User { get; set; }

        public bool IsAvailable { get; set; }
    }
}
