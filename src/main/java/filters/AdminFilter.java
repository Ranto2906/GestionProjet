package filters;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/admin/*")
public class AdminFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        // Check if user is logged in and is admin
        if (session == null || session.getAttribute("user") == null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            return;
        }

        String userRole = (String) session.getAttribute("userRole");
        if (!"admin".equals(userRole)) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/unauthorized");
            return;
        }

        // User is admin, continue with the request
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}