using System.Web.Mvc;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Owin;
using System.Web;

namespace IkyaWeb.Controllers.Home
{
    public class HomeController : Controller
    {
        // GET: Home
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult About()
        {
            return View();
        }

        public ActionResult Contact()
        {
            return View();
        }
        public ActionResult OpenLogin()
        {
            return View("Login");
        }
        public void SignUp()
        {
            UserStore<IdentityUser> userStore = new UserStore<IdentityUser>();
            UserManager<IdentityUser> userManager = new UserManager<IdentityUser>(userStore);

            IdentityUser newUser = new IdentityUser("karthik");
            IdentityResult userResult = userManager.Create(newUser, "karthik123");
            if (!userResult.Succeeded)
            {

            }
            else
            {
                RoleStore<IdentityRole> roleStore = new RoleStore<IdentityRole>();
                RoleManager<IdentityRole> roleManager = new RoleManager<IdentityRole>(roleStore);

                if (!roleManager.RoleExists("Administrator"))
                {
                    IdentityResult roleResult = roleManager.Create(new IdentityRole("Administrator"));
                }
               IdentityResult addRoleRsult =  userManager.AddToRole(newUser.Id, "Administrator");
                var authManager = System.Web.HttpContext.Current.GetOwinContext().Authentication;
                var userIdentity = userManager.CreateIdentity(newUser, DefaultAuthenticationTypes.ApplicationCookie);
                authManager.SignIn(userIdentity);
                Response.Redirect("~/Welcome.aspx");
            }
        }
        public void Login()
        {
            UserManager<IdentityUser> userManager = new UserManager<IdentityUser>(new UserStore<IdentityUser>());
            IdentityUser user = userManager.Find("karthik", "karthik123");
            if (user == null)
            { }
            else
            {
                var authManager = System.Web.HttpContext.Current.GetOwinContext().Authentication;
                var userIdentity = userManager.CreateIdentity(user, DefaultAuthenticationTypes.ApplicationCookie);
                authManager.SignIn(userIdentity);
            }
            Response.Redirect("~/Welcome.aspx");
        }

        public ActionResult LogOut()
        {
            var authManager = System.Web.HttpContext.Current.GetOwinContext().Authentication;
            authManager.SignOut();
            return View("Home");
        }
    }
}