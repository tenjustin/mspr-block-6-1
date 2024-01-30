namespace plant_app_backend.Common.Models
{
    public class AnnonceDto
    {
        public string Title { get; set; }

        public string Description { get; set; }

        public List<IFormFile> Images { get; set; }

        public int UserId { get; set; }

        public double Latitude { get; set; }

        public double Longitude { get; set; }

        public string Ville { get; set; }
    }
}
