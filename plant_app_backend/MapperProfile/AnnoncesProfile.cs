using AutoMapper;
using plant_app_backend.Common.Models;
using plant_app_backend.Common.Services.Interface;
using plant_app_backend.DAL.Models;
using plant_app_backend.DAL.Repository.Interface;

namespace plant_app_backend.MapperProfile
{
    public class AnnoncesProfile : Profile
    {

        private readonly IUserRepository _userRepository;

        private readonly IAnnoncesService _annoncesServices;

        public AnnoncesProfile(IUserRepository userRepository, IAnnoncesService annoncesService)
        {
            _userRepository = userRepository;
            _annoncesServices = annoncesService;
        }

        public AnnoncesProfile() {
            CreateMap<AnnonceDto, Annonces>()
                .ForMember(s => s.User, opt => opt.MapFrom(a => _userRepository.GetUserById(a.UserId)))
                .ForMember(s => s.Titre, opt => opt.MapFrom(a => a.Title))
                .ForMember(s => s.Description, opt => opt.MapFrom(a => a.Description))
                .ForMember(s => s.Photos, opt => opt.MapFrom(a => _annoncesServices.ConvertToByte(a.Images)))
                .ForMember(s => s.Ville, opt => opt.MapFrom(a => a.Ville));
        }
    }
}
