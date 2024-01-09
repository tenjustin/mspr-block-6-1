using System.ComponentModel.DataAnnotations;

namespace plant_app_backend.DAL.Models
{
    public class User
    {
        [Key]
        public int Id { get; set; }

        public string Nom { get; set; }

        public string Prenom { get; set; }

        public string Pseudo { get; set; }

        [Required]
        public string Password { get; set; }

        [Required]
        public string Email { get; set; }

        public string Sexe { get; set; }

        [Required]
        public DateOnly DateDeNaissance { get; set; }

        public bool IsBotanist { get; set; }
    }
}
