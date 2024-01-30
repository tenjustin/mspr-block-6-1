using Microsoft.Web.Helpers;
using plant_app_backend.Common.Services.Interface;

namespace plant_app_backend.Common.Services
{
    public class AnnoncesService : IAnnoncesService
    {

        public List<byte[]> ConvertToByte(List<IFormFile> files)
        {
            var result = new List<byte[]>();
            foreach (IFormFile file in files)
            {
                using (var memoryStream = new MemoryStream())
                {
                    file.CopyTo(memoryStream);

                    result.Add(memoryStream.ToArray());
                }
            }

            return result;
        }
    }
}
