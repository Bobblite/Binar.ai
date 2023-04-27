using System.Web;
using System.Web.Mvc;

namespace Cloudy_With_A_Chance_Of_Binar.ai
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}
