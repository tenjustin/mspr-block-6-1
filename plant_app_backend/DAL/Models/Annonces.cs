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

        public double Price { get; set; }

        public string ImageName { get; set; }

        public User User { get; set; }

        public string Ville { get; set; }

        public double Latitude { get; set; }

        public double Longitude { get; set; }

        public DateTime DateCreation { get; set; } = DateTime.Now;

        public DateTime DateModification { get; set; } = DateTime.Now;

        public bool IsAvailable { get; set; }

    }
}
