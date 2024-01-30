namespace plant_app_backend.Common.Services.Interface
{
    public interface IAnnoncesService
    {

        List<byte[]> ConvertToByte(List<IFormFile> files);
    }
}
