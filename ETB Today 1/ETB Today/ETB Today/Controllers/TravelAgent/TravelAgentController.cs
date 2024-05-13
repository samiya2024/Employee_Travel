using System;
using System.Linq;
using System.Web.Mvc;
using ETB_Today.Models;

namespace ETB_Today.Controllers.TravelAgent
{
    public class TravelAgentDashboardController : Controller
    {
        private readonly Emp_travel_booking_systemEntities1 db;

        public TravelAgentDashboardController()
        {
            db = new Emp_travel_booking_systemEntities1();
        }

        // GET: /TravelAgentDashboard/Index
        public ActionResult Index()
        {
            // Check if the user is logged in
            if (!IsUserLoggedIn())
            {
                // If not logged in, redirect to the login page
                return RedirectToAction("Login");
            }

            // Retrieve pending travel requests and pass them to the view
            var pendingRequests = db.travelrequests.Where(tr => tr.bookingstatus == "Pending").ToList();
            return View(pendingRequests);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult UpdateStatus(int requestId, string status)
        {
            try
            {
                // Check if the user is logged in
                if (!IsUserLoggedIn())
                {
                    // If not logged in, redirect to the login page
                    return RedirectToAction("Login");
                }

                // Retrieve the travel request by ID
                var travelRequest = db.travelrequests.FirstOrDefault(tr => tr.requestid == requestId);

                if (travelRequest == null)
                {
                    throw new Exception("Travel request not found.");
                }

                // Update the booking status based on availability
                travelRequest.bookingstatus = status;

                db.SaveChanges();

                TempData["SuccessMessage"] = "Booking status updated successfully.";
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = ex.Message;
            }

            return RedirectToAction("Index");
        }

        // GET: /TravelAgentDashboard/Login
        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(string username, string password)
        {
            // Your login authentication logic goes here
            // Example code provided for demonstration purposes only
            if (IsValidLogin(username, password))
            {
                // Store travel agent details in session or authentication cookie
                Session["TravelAgentId"] = 1; // Replace with actual ID
                Session["TravelAgentName"] = username; // Use the provided username
                // Redirect to the dashboard
                return RedirectToAction("Index");
            }
            else
            {
                TempData["ErrorMessage"] = "Invalid username or password.";
                return View();
            }
        }

        // Example method to check if the user is logged in (replace with your actual logic)
        private bool IsUserLoggedIn()
        {
            // Check if the user is logged in (e.g., check for authentication cookie or session variable)
            // Return true if logged in, false otherwise
            return Session["TravelAgentId"] != null;
        }

        // Example method for validating login credentials (replace with your actual logic)
        private bool IsValidLogin(string username, string password)
        {
            // Your authentication logic here (e.g., check against database)
            // Check if the provided username and password match any record in the database
            var user = db.travelagents.FirstOrDefault(u => u.name == username && u.travel_agent_password == password);

            // Return true if the user is found, false otherwise
            return user != null;
        }
    }
}
