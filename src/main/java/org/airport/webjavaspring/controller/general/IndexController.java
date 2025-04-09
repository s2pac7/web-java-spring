package org.airport.webjavaspring.controller.general;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class IndexController {

    @GetMapping("/")
    public String redirectToHome() {
        return "redirect:/home";
    }

    @GetMapping("/home")
    public String showHomePage() {
        return "home"; // Spring будет искать home.jsp в /WEB-INF/views/
    }

    @GetMapping("/board")
    public String showBoardPage() {
        return "board"; // Для онлайн-табло (board.jsp)
    }

    @GetMapping("/about")
    public String showAboutPage() {
        return "about"; // Для страницы "О нас" (about.jsp)
    }

    @GetMapping("/signin")
    public String showSigninPage() {
        return "signin";
    }

    @GetMapping("/signup")
    public String showSignupPage() {
        return "signup";
    }

    @GetMapping("/dashboard")
    public String showDashboardPage() {
        return "dashboard";
    }

    @GetMapping("/user")
    public String showUserDashboard() {
        return "user-dashboard";
    }

    @GetMapping("/admin")
    public String showAdminDashboard() {
        return "admin-dashboard";
    }
}
