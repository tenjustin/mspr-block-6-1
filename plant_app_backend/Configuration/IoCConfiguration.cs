using plant_app_backend.Common.Services;
using plant_app_backend.Common.Services.Interface;
using plant_app_backend.DAL.Repository;
using plant_app_backend.DAL.Repository.Interface;

namespace plant_app_backend.Configuration
{
    public static class IoCConfiguration
    {
        public static void ConfigureScopeService(this IServiceCollection services, IConfiguration configuration)
        {
            services.AddScoped<IUserRepository, UserRepository>();
            services.AddScoped<IAnnoncesRepository, AnnoncesRepository>();
            services.AddScoped<IAnnoncesService, AnnoncesService>();
        }
    }
}
