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

        public List<byte[]> Photos { get; set; }

        public User User { get; set; }

        public string Ville { get; set; }

        public DateTime DateCreation { get; set; } = DateTime.Now;

        public DateTime DateModification { get; set; } = DateTime.Now;

        public bool IsAvailable { get; set; }

    }
}
