namespace plant_app_backend.Common.Models
{
    public class AnnonceDto
    {
        public string Title { get; set; }

        public string Name { get; set; }

        public string LastName { get; set; }

        public string Description { get; set; }

        public string Location { get; set; }

        public double Price { get; set; }

        public IFormFile Image { get; set; }

        public double Latitude { get; set; }

        public double Longitude { get; set; }

        public int UserId { get; set; }
    }
}
