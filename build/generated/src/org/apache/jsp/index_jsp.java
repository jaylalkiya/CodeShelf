package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import java.util.logging.*;
import java.text.SimpleDateFormat;
import java.util.Date;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\">\n");
      out.write("<head>\n");
      out.write("    <meta charset=\"UTF-8\">\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("    <meta name=\"description\" content=\"CodeShelf offers innovative software solutions for real-world problems, including calculators, drawing tools, and more.\">\n");
      out.write("    <meta name=\"keywords\" content=\"software solutions, CodeShelf, calculator, drawing canvas, typing test, C compiler, IP tracker\">\n");
      out.write("    <meta name=\"author\" content=\"CodeShelf Team\">\n");
      out.write("    <title>CodeShelf - Innovative Software Solutions</title>\n");
      out.write("   <link rel=\"icon\" href='data:image/svg+xml;utf8,\n");
      out.write("              <svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"blue\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\">\n");
      out.write("              <path d=\"M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4\"/>\n");
      out.write("              </svg>'>\n");
      out.write("    <script src=\"https://cdn.tailwindcss.com\"></script>\n");
      out.write("    <link href=\"https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap\" rel=\"stylesheet\">\n");
      out.write("    <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css\">\n");
      out.write("    <style>\n");
      out.write("        body {\n");
      out.write("            font-family: 'Inter', sans-serif;\n");
      out.write("        }\n");
      out.write("        .smooth-scroll {\n");
      out.write("            scroll-behavior: smooth;\n");
      out.write("        }\n");
      out.write("        .project-card {\n");
      out.write("            transition: transform 0.3s ease, box-shadow 0.3s ease;\n");
      out.write("        }\n");
      out.write("        .project-card:hover {\n");
      out.write("            transform: translateY(-8px);\n");
      out.write("            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.2);\n");
      out.write("        }\n");
      out.write("        .nav-link {\n");
      out.write("            transition: color 0.3s ease, background-color 0.3s ease;\n");
      out.write("        }\n");
      out.write("        .nav-link:hover {\n");
      out.write("            color: #3b82f6;\n");
      out.write("        }\n");
      out.write("        .modal {\n");
      out.write("            position: fixed;\n");
      out.write("            z-index: 1000;\n");
      out.write("            left: 0;\n");
      out.write("            top: 0;\n");
      out.write("            width: 100%;\n");
      out.write("            height: 100%;\n");
      out.write("            overflow: auto;\n");
      out.write("            background-color: rgba(0, 0, 0, 0.85);\n");
      out.write("            backdrop-filter: blur(10px);\n");
      out.write("            display: none;\n");
      out.write("            justify-content: center;\n");
      out.write("            align-items: center;\n");
      out.write("            opacity: 0;\n");
      out.write("            transition: opacity 0.3s ease, display 0.3s ease;\n");
      out.write("        }\n");
      out.write("        .modal.is-visible {\n");
      out.write("            display: flex;\n");
      out.write("            opacity: 1;\n");
      out.write("        }\n");
      out.write("        .modal-content {\n");
      out.write("            background-color: #ffffff;\n");
      out.write("            padding: 2rem;\n");
      out.write("            border-radius: 1rem;\n");
      out.write("            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);\n");
      out.write("            max-width: 90%;\n");
      out.write("            width: 450px;\n");
      out.write("            text-align: center;\n");
      out.write("            transform: scale(0.7);\n");
      out.write("            transition: transform 0.3s ease;\n");
      out.write("        }\n");
      out.write("        .modal.is-visible .modal-content {\n");
      out.write("            transform: scale(1);\n");
      out.write("        }\n");
      out.write("        .hamburger {\n");
      out.write("            display: none;\n");
      out.write("        }\n");
      out.write("        @media (max-width: 768px) {\n");
      out.write("            .hamburger {\n");
      out.write("                display: block;\n");
      out.write("            }\n");
      out.write("            .nav-links {\n");
      out.write("                display: none;\n");
      out.write("                flex-direction: column;\n");
      out.write("                position: absolute;\n");
      out.write("                top: 60px; /* Adjust based on header height */\n");
      out.write("                left: 0;\n");
      out.write("                width: 100%;\n");
      out.write("                background-color: white;\n");
      out.write("                box-shadow: 0 4px 6px rgba(0,0,0,0.1);\n");
      out.write("                padding: 1rem;\n");
      out.write("                z-index: 10;\n");
      out.write("            }\n");
      out.write("            .nav-links.active {\n");
      out.write("                display: flex;\n");
      out.write("            }\n");
      out.write("            .nav-links a {\n");
      out.write("                margin-bottom: 1rem;\n");
      out.write("                width: 100%;\n");
      out.write("                text-align: left;\n");
      out.write("                padding: 0.5rem 0;\n");
      out.write("            }\n");
      out.write("            .nav-links .user-info {\n");
      out.write("                margin-bottom: 1rem;\n");
      out.write("            }\n");
      out.write("        }\n");
      out.write("    </style>\n");
      out.write("</head>\n");
      out.write("<body class=\"bg-gray-50 smooth-scroll\">\n");
      out.write("    ");

        Logger logger = Logger.getLogger("index.jsp");
        logger.setLevel(Level.ALL);

        String dbDriver = "com.mysql.jdbc.Driver";
        String dbUrl = "jdbc:mysql://localhost:3306/csdb?useSSL=false&allowPublicKeyRetrieval=true";
        String dbUser = "root";
        String dbPassword = "";

        boolean isLoggedIn = session.getAttribute("isLoggedIn") != null && (Boolean) session.getAttribute("isLoggedIn");
        String errorMessage = "";
        String successMessage = "";
        String csrfToken = (String) session.getAttribute("csrfToken");
        if (csrfToken == null) {
            csrfToken = java.util.UUID.randomUUID().toString();
            session.setAttribute("csrfToken", csrfToken);
        }

        if (request.getMethod().equalsIgnoreCase("POST")) {
            String formAction = request.getParameter("action");
            String submittedCsrfToken = request.getParameter("csrfToken");

            if (!csrfToken.equals(submittedCsrfToken)) {
                errorMessage = "Invalid CSRF token. Please try again.";
                logger.warning("CSRF token validation failed.");
            } else if ("login".equals(formAction)) {
                String email = request.getParameter("email");
                String password = request.getParameter("password");

                if (email != null && password != null && !email.trim().isEmpty() && !password.trim().isEmpty()) {
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName(dbDriver);
                        conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
                        logger.info("Database connection established successfully.");

                        String sql = "SELECT fullname FROM users WHERE email = ? AND password = ?";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, email);
                        pstmt.setString(2, password);
                        rs = pstmt.executeQuery();

                        if (rs.next()) {
                            session.setAttribute("isLoggedIn", true);
                            session.setAttribute("fullname", rs.getString("fullname"));
                            isLoggedIn = true;
                            logger.info("User '" + email + "' logged in successfully.");
                        } else {
                            errorMessage = "Invalid email or password.";
                            logger.warning("Failed login attempt for email: " + email);
                        }
                    } catch (SQLException | ClassNotFoundException e) {
                        errorMessage = "Database error: " + e.getMessage();
                        logger.log(Level.SEVERE, "Exception during login.", e);
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException e) { logger.log(Level.SEVERE, "Failed to close ResultSet.", e); }
                        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { logger.log(Level.SEVERE, "Failed to close PreparedStatement.", e); }
                        if (conn != null) try { conn.close(); } catch (SQLException e) { logger.log(Level.SEVERE, "Failed to close Connection.", e); }
                    }
                } else {
                    errorMessage = "Email and password are required.";
                }
            } else if ("register".equals(formAction)) {
                String fullname = request.getParameter("fullname");
                String email = request.getParameter("email");
                String password = request.getParameter("password");

                if (fullname != null && email != null && password != null && !fullname.trim().isEmpty() && !email.trim().isEmpty() && !password.trim().isEmpty()) {
                    Connection conn = null;
                    PreparedStatement pstmt = null;

                    try {
                        Class.forName(dbDriver);
                        conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
                        String sql = "INSERT INTO users (fullname, email, password) VALUES (?, ?, ?)";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, fullname);
                        pstmt.setString(2, email);
                        pstmt.setString(3, password);
                        int rowsAffected = pstmt.executeUpdate();

                        if (rowsAffected > 0) {
                            successMessage = "Registration successful! Please log in.";
                        } else {
                            errorMessage = "Registration failed.";
                        }
                    } catch (SQLIntegrityConstraintViolationException e) {
                        errorMessage = "Email already registered.";
                        logger.log(Level.SEVERE, "Duplicate email registration attempt.", e);
                    } catch (SQLException | ClassNotFoundException e) {
                        errorMessage = "Database error: " + e.getMessage();
                        logger.log(Level.SEVERE, "Exception during registration.", e);
                    } finally {
                        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { logger.log(Level.SEVERE, "Failed to close PreparedStatement.", e); }
                        if (conn != null) try { conn.close(); } catch (SQLException e) { logger.log(Level.SEVERE, "Failed to close Connection.", e); }
                    }
                } else {
                    errorMessage = "All fields are required.";
                }
            }
        }
    
      out.write("\n");
      out.write("\n");
      out.write("    <div id=\"authModal\" class=\"modal ");
      out.print( isLoggedIn ? "" : "is-visible");
      out.write("\" aria-labelledby=\"authModalTitle\">\n");
      out.write("        <div class=\"modal-content\">\n");
      out.write("            <h2 id=\"authModalTitle\" class=\"text-2xl font-bold text-gray-900 mb-4\"></h2>\n");
      out.write("            <p class=\"text-gray-600 mb-6\"></p>\n");
      out.write("\n");
      out.write("            <form id=\"loginForm\" action=\"index.jsp\" method=\"post\" class=\"space-y-4\">\n");
      out.write("                <input type=\"hidden\" name=\"action\" value=\"login\">\n");
      out.write("                <input type=\"hidden\" name=\"csrfToken\" value=\"");
      out.print( csrfToken );
      out.write("\">\n");
      out.write("                <div>\n");
      out.write("                    <label for=\"loginEmail\" class=\"sr-only\">Email</label>\n");
      out.write("                    <input type=\"email\" id=\"loginEmail\" name=\"email\" placeholder=\"Email\" required class=\"w-full border border-gray-300 rounded-lg p-3 focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-300\" aria-required=\"true\">\n");
      out.write("                </div>\n");
      out.write("                <div>\n");
      out.write("                    <label for=\"loginPassword\" class=\"sr-only\">Password</label>\n");
      out.write("                    <input type=\"password\" id=\"loginPassword\" name=\"password\" placeholder=\"Password\" required class=\"w-full border border-gray-300 rounded-lg p-3 focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-300\" aria-required=\"true\">\n");
      out.write("                </div>\n");
      out.write("                <button type=\"submit\" class=\"w-full bg-blue-600 text-white py-3 rounded-lg font-semibold hover:bg-blue-700 transition duration-300\">Log In</button>\n");
      out.write("            </form>\n");
      out.write("\n");
      out.write("            <form id=\"registerForm\" action=\"index.jsp\" method=\"post\" class=\"hidden space-y-4\">\n");
      out.write("                <input type=\"hidden\" name=\"action\" value=\"register\">\n");
      out.write("                <input type=\"hidden\" name=\"csrfToken\" value=\"");
      out.print( csrfToken );
      out.write("\">\n");
      out.write("                <div>\n");
      out.write("                    <label for=\"registerFullname\" class=\"sr-only\">Full Name</label>\n");
      out.write("                    <input type=\"text\" id=\"registerFullname\" name=\"fullname\" placeholder=\"Full Name\" required class=\"w-full border border-gray-300 rounded-lg p-3 focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-300\" aria-required=\"true\">\n");
      out.write("                </div>\n");
      out.write("                <div>\n");
      out.write("                    <label for=\"registerEmail\" class=\"sr-only\">Email</label>\n");
      out.write("                    <input type=\"email\" id=\"registerEmail\" name=\"email\" placeholder=\"Email\" required class=\"w-full border border-gray-300 rounded-lg p-3 focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-300\" aria-required=\"true\">\n");
      out.write("                </div>\n");
      out.write("                <div>\n");
      out.write("                    <label for=\"registerPassword\" class=\"sr-only\">Password</label>\n");
      out.write("                    <input type=\"password\" id=\"registerPassword\" name=\"password\" placeholder=\"Password\" required class=\"w-full border border-gray-300 rounded-lg p-3 focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-300\" aria-required=\"true\">\n");
      out.write("                </div>\n");
      out.write("                <button type=\"submit\" class=\"w-full bg-blue-600 text-white py-3 rounded-lg font-semibold hover:bg-blue-700 transition duration-300\">Register</button>\n");
      out.write("            </form>\n");
      out.write("\n");
      out.write("            <div id=\"modalMessageContainer\" class=\"mt-4\">\n");
      out.write("                <p id=\"errorMessage\" class=\"text-red-500 text-sm ");
      out.print( errorMessage.isEmpty() ? "hidden" : "block");
      out.write('"');
      out.write('>');
      out.print( errorMessage );
      out.write("</p>\n");
      out.write("                <p id=\"successMessage\" class=\"text-green-500 text-sm ");
      out.print( successMessage.isEmpty() ? "hidden" : "block");
      out.write('"');
      out.write('>');
      out.print( successMessage );
      out.write("</p>\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("            <p id=\"toggleAuthLink\" class=\"text-gray-500 text-sm mt-4\"></p>\n");
      out.write("        </div>\n");
      out.write("    </div>\n");
      out.write("\n");
      out.write("    <div id=\"mainContent\" class=\"");
      out.print( isLoggedIn ? "block" : "hidden");
      out.write("\">\n");
      out.write("        <header class=\"bg-white shadow-lg sticky top-0 z-50\">\n");
      out.write("            <nav class=\"max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4 flex justify-between items-center\">\n");
      out.write("                <div class=\"flex items-center space-x-3\">\n");
      out.write("                    <svg class=\"h-10 w-10 text-blue-600\" fill=\"none\" viewBox=\"0 0 24 24\" stroke=\"currentColor\" stroke-width=\"2\">\n");
      out.write("                        <path stroke-linecap=\"round\" stroke-linejoin=\"round\" d=\"M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4\" />\n");
      out.write("                    </svg>\n");
      out.write("                    <a href=\"index.jsp\" class=\"text-2xl font-bold text-gray-900\">CodeShelf</a>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"hamburger md:hidden\">\n");
      out.write("                    <i class=\"fas fa-bars text-2xl text-gray-600 cursor-pointer\"></i>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"nav-links flex items-center space-x-6\">\n");
      out.write("                    <a href=\"#about\" class=\"nav-link text-gray-600 hover:text-blue-500 font-medium py-2 md:py-0\">About</a>\n");
      out.write("                    <a href=\"#projects\" class=\"nav-link text-gray-600 hover:text-blue-500 font-medium py-2 md:py-0\">Projects</a>\n");
      out.write("                    <a href=\"#contact\" class=\"nav-link text-gray-600 hover:text-blue-500 font-medium py-2 md:py-0\">Contact</a>\n");
      out.write("                    ");
 if (session.getAttribute("fullname") != null) { 
      out.write("\n");
      out.write("                        <div class=\"flex items-center space-x-4 py-2 md:py-0 user-info\">\n");
      out.write("                            <span class=\"bg-blue-100 text-blue-800 text-sm font-semibold px-3 py-1 rounded-full\">\n");
      out.write("                                Welcome, ");
      out.print( session.getAttribute("fullname") );
      out.write("\n");
      out.write("                            </span>\n");
      out.write("                            <a href=\"logout.jsp\" class=\"nav-link text-white bg-blue-600 px-4 py-2 rounded-lg hover:bg-blue-700 transition\">Logout</a>\n");
      out.write("                        </div>\n");
      out.write("                    ");
 } 
      out.write("\n");
      out.write("                </div>\n");
      out.write("            </nav>\n");
      out.write("        </header>\n");
      out.write("\n");
      out.write("        <section class=\"bg-gradient-to-br from-blue-700 to-indigo-600 text-white py-24\">\n");
      out.write("            <div class=\"max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center\">\n");
      out.write("                <h1 class=\"text-4xl md:text-5xl font-bold mb-6\">Innovate with CodeShelf</h1>\n");
      out.write("                <p class=\"text-lg md:text-xl max-w-3xl mx-auto\">Discover cutting-edge software solutions designed to solve real-world challenges with creativity and precision.</p>\n");
      out.write("                <a href=\"#projects\" class=\"mt-8 inline-block bg-white text-blue-600 px-8 py-3 rounded-lg font-semibold hover:bg-gray-100 transition\">Explore Projects</a>\n");
      out.write("            </div>\n");
      out.write("        </section>\n");
      out.write("\n");
      out.write("        <section id=\"about\" class=\"py-20 bg-gray-100\">\n");
      out.write("            <div class=\"max-w-7xl mx-auto px-4 sm:px-6 lg:px-8\">\n");
      out.write("                <h2 class=\"text-3xl font-bold text-gray-900 text-center mb-12\">About Us</h2>\n");
      out.write("                <p class=\"text-gray-600 text-lg max-w-3xl mx-auto text-center\">CodeShelf is a technology hub dedicated to creating innovative software that empowers users. From productivity tools to creative platforms, our mission is to make technology accessible and impactful.</p>\n");
      out.write("            </div>\n");
      out.write("        </section>\n");
      out.write("\n");
      out.write("        <section id=\"projects\" class=\"py-20 bg-white\">\n");
      out.write("            <div class=\"max-w-7xl mx-auto px-4 sm:px-6 lg:px-8\">\n");
      out.write("                <h2 class=\"text-3xl font-bold text-gray-900 text-center mb-12\">Our Projects</h2>\n");
      out.write("                <div class=\"grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8\">\n");
      out.write("                    <div class=\"project-card bg-gray-50 rounded-xl shadow-lg p-6 flex flex-col space-y-4\">\n");
      out.write("                        <div class=\"flex items-center space-x-4\">\n");
      out.write("                            <div class=\"p-3 rounded-full bg-blue-100 text-blue-600\">\n");
      out.write("                                <i class=\"fas fa-calculator h-6 w-6\"></i>\n");
      out.write("                            </div>\n");
      out.write("                            <h3 class=\"text-xl font-bold text-gray-900\">Calculator</h3>\n");
      out.write("                        </div>\n");
      out.write("                        <p class=\"text-gray-600 flex-grow\">A powerful calculator for basic and scientific operations, designed for speed and ease of use.</p>\n");
      out.write("                        <a href=\"Calculator.jsp\" class=\"inline-flex items-center justify-center px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition\">Launch App <i class=\"fas fa-arrow-right ml-2\"></i></a>\n");
      out.write("                    </div>\n");
      out.write("                    <div class=\"project-card bg-gray-50 rounded-xl shadow-lg p-6 flex flex-col space-y-4\">\n");
      out.write("                        <div class=\"flex items-center space-x-4\">\n");
      out.write("                            <div class=\"p-3 rounded-full bg-green-100 text-green-600\">\n");
      out.write("                                <i class=\"fas fa-paint-brush h-6 w-6\"></i>\n");
      out.write("                            </div>\n");
      out.write("                            <h3 class=\"text-xl font-bold text-gray-900\">Drawing Canvas</h3>\n");
      out.write("                        </div>\n");
      out.write("                        <p class=\"text-gray-600 flex-grow\">Unleash your creativity with our intuitive drawing tool featuring customizable brushes and colors.</p>\n");
      out.write("                        <a href=\"DrawingCanvas.jsp\" class=\"inline-flex items-center justify-center px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition\">Launch App <i class=\"fas fa-arrow-right ml-2\"></i></a>\n");
      out.write("                    </div>\n");
      out.write("                    <div class=\"project-card bg-gray-50 rounded-xl shadow-lg p-6 flex flex-col space-y-4\">\n");
      out.write("                        <div class=\"flex items-center space-x-4\">\n");
      out.write("                            <div class=\"p-3 rounded-full bg-yellow-100 text-yellow-600\">\n");
      out.write("                                <i class=\"fas fa-keyboard h-6 w-6\"></i>\n");
      out.write("                            </div>\n");
      out.write("                            <h3 class=\"text-xl font-bold text-gray-900\">Typing Test</h3>\n");
      out.write("                        </div>\n");
      out.write("                        <p class=\"text-gray-600 flex-grow\">Test and improve your typing skills with engaging challenges and detailed analytics.</p>\n");
      out.write("                        <a href=\"typingtest.jsp\" class=\"inline-flex items-center justify-center px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition\">Launch App <i class=\"fas fa-arrow-right ml-2\"></i></a>\n");
      out.write("                    </div>\n");
      out.write("                    <div class=\"project-card bg-gray-50 rounded-xl shadow-lg p-6 flex flex-col space-y-4\">\n");
      out.write("                        <div class=\"flex items-center space-x-4\">\n");
      out.write("                            <div class=\"p-3 rounded-full bg-purple-100 text-purple-600\">\n");
      out.write("                                <i class=\"fas fa-code h-6 w-6\"></i>\n");
      out.write("                            </div>\n");
      out.write("                            <h3 class=\"text-xl font-bold text-gray-900\">C Compiler</h3>\n");
      out.write("                        </div>\n");
      out.write("                        <p class=\"text-gray-600 flex-grow\">Write and run C code online with real-time syntax checking and execution.</p>\n");
      out.write("                        <a href=\"onlineEditor.jsp\" class=\"inline-flex items-center justify-center px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition\">Launch App <i class=\"fas fa-arrow-right ml-2\"></i></a>\n");
      out.write("                    </div>\n");
      out.write("                    <div class=\"project-card bg-gray-50 rounded-xl shadow-lg p-6 flex flex-col space-y-4\">\n");
      out.write("                        <div class=\"flex items-center space-x-4\">\n");
      out.write("                            <div class=\"p-3 rounded-full bg-red-100 text-red-600\">\n");
      out.write("                                <i class=\"fas fa-map-marker-alt h-6 w-6\"></i>\n");
      out.write("                            </div>\n");
      out.write("                            <h3 class=\"text-xl font-bold text-gray-900\">IP Address Finder</h3>\n");
      out.write("                        </div>\n");
      out.write("                        <p class=\"text-gray-600 flex-grow\">Locate any IP address with detailed geolocation data and a real-time map.</p>\n");
      out.write("                        <a href=\"IPAddressTracker.jsp\" class=\"inline-flex items-center justify-center px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition\">Launch App <i class=\"fas fa-arrow-right ml-2\"></i></a>\n");
      out.write("                    </div>\n");
      out.write("                    <div class=\"project-card bg-gray-50 rounded-xl shadow-lg p-6 flex flex-col space-y-4\">\n");
      out.write("                        <div class=\"flex items-center space-x-4\">\n");
      out.write("                            <div class=\"p-3 rounded-full bg-orange-100 text-orange-600\">\n");
      out.write("                                <i class=\"fas fa-file-alt h-6 w-6\"></i>\n");
      out.write("                            </div>\n");
      out.write("                            <h3 class=\"text-xl font-bold text-gray-900\">Word Counter</h3>\n");
      out.write("                        </div>\n");
      out.write("                        <p class=\"text-gray-600 flex-grow\">Analyze text with detailed word, character, and sentence counts.</p>\n");
      out.write("                        <a href=\"WordCharacterCounter.jsp\" class=\"inline-flex items-center justify-center px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition\">Launch App <i class=\"fas fa-arrow-right ml-2\"></i></a>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </section>\n");
      out.write("\n");
      out.write("        <section id=\"contact\" class=\"py-20 bg-gray-100\">\n");
      out.write("            <div class=\"max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center\">\n");
      out.write("                <h2 class=\"text-3xl font-bold text-gray-900 mb-6\">Contact Us</h2>\n");
      out.write("                <p class=\"text-lg text-gray-600 mb-4\">Have a question or a problem? Feel free to reach out to us at:</p>\n");
      out.write("                <a href=\"mailto:jaylalkiya02@gmail.com\" class=\"text-blue-600 font-semibold hover:underline text-xl\">jaylalkiya02@gmail.com</a>\n");
      out.write("            </div>\n");
      out.write("        </section>\n");
      out.write("\n");
      out.write("        <footer class=\"bg-gray-900 text-white py-8\">\n");
      out.write("            <div class=\"max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center\">\n");
      out.write("                <p>&copy; 2025 CodeShelf. All rights reserved.</p>\n");
      out.write("                ");

                    Date now = new Date();
                    SimpleDateFormat dateFormat = new SimpleDateFormat("MMMM dd, yyyy");
                    SimpleDateFormat dayFormat = new SimpleDateFormat("EEEE");
                    SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
                    String currentDate = dateFormat.format(now);
                    String currentDay = dayFormat.format(now);
                    String currentTime = timeFormat.format(now);
                
      out.write("\n");
      out.write("                <p class=\"mt-2 text-sm\">Date: ");
      out.print( currentDate );
      out.write(" | Day: ");
      out.print( currentDay );
      out.write(" | Time: ");
      out.print( currentTime );
      out.write("</p>\n");
      out.write("                 <div class=\"mt-4 flex justify-center space-x-4\">\n");
      out.write("                        <a href=\"https://www.linkedin.com/in/jay-lalkiya-527149302/\" class=\"text-gray-400 hover:text-white\" target=\"_blank\">\n");
      out.write("                            <i class=\"fab fa-linkedin\"></i>\n");
      out.write("                        </a>\n");
      out.write("                        <a href=\"https://github.com/jaylalkiya\" class=\"text-gray-400 hover:text-white\" target=\"_blank\">\n");
      out.write("                            <i class=\"fab fa-github\"></i>\n");
      out.write("                        </a>\n");
      out.write("                        <a href=\"https://wa.me/918200411490\" class=\"text-gray-400 hover:text-white\" target=\"_blank\">\n");
      out.write("                            <i class=\"fab fa-whatsapp\"></i>\n");
      out.write("                        </a>\n");
      out.write("                    </div>\n");
      out.write("            </div>\n");
      out.write("        </footer>\n");
      out.write("    </div>\n");
      out.write("\n");
      out.write("    <script>\n");
      out.write("        document.addEventListener('DOMContentLoaded', () => {\n");
      out.write("            const authModal = document.getElementById('authModal');\n");
      out.write("            const loginForm = document.getElementById('loginForm');\n");
      out.write("            const registerForm = document.getElementById('registerForm');\n");
      out.write("            const loginButton = loginForm.querySelector('button[type=\"submit\"]');\n");
      out.write("            const registerButton = registerForm.querySelector('button[type=\"submit\"]');\n");
      out.write("            const modalTitle = authModal.querySelector('#authModalTitle');\n");
      out.write("            const modalDescription = authModal.querySelector('p:not(#toggleAuthLink, #errorMessage, #successMessage)');\n");
      out.write("            const toggleAuthLink = document.getElementById('toggleAuthLink');\n");
      out.write("            const errorMessageElement = document.getElementById('errorMessage');\n");
      out.write("            const successMessageElement = document.getElementById('successMessage');\n");
      out.write("            const modalMessageContainer = document.getElementById('modalMessageContainer');\n");
      out.write("            const hamburger = document.querySelector('.hamburger');\n");
      out.write("            const navLinks = document.querySelector('.nav-links');\n");
      out.write("            const isLoggedIn = ");
      out.print( isLoggedIn );
      out.write("; // Get login status from JSP\n");
      out.write("\n");
      out.write("            // Function to show the correct modal content\n");
      out.write("            function showLoginView() {\n");
      out.write("                modalTitle.textContent = 'Welcome to CodeShelf';\n");
      out.write("                modalDescription.textContent = 'Log in to explore our innovative solutions.';\n");
      out.write("                loginForm.classList.remove('hidden');\n");
      out.write("                registerForm.classList.add('hidden');\n");
      out.write("                toggleAuthLink.innerHTML = 'No account? <a href=\"#\" id=\"showRegister\" class=\"text-blue-500 hover:underline\">Create one</a>';\n");
      out.write("                // Clear messages when switching views\n");
      out.write("                errorMessageElement.classList.add('hidden');\n");
      out.write("                successMessageElement.classList.add('hidden');\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            function showRegisterView() {\n");
      out.write("                modalTitle.textContent = 'Join CodeShelf';\n");
      out.write("                modalDescription.textContent = 'Create an account to get started.';\n");
      out.write("                registerForm.classList.remove('hidden');\n");
      out.write("                loginForm.classList.add('hidden');\n");
      out.write("                toggleAuthLink.innerHTML = 'Have an account? <a href=\"#\" id=\"showLogin\" class=\"text-blue-500 hover:underline\">Log In</a>';\n");
      out.write("                // Clear messages when switching views\n");
      out.write("                errorMessageElement.classList.add('hidden');\n");
      out.write("                successMessageElement.classList.add('hidden');\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            // Initial modal state\n");
      out.write("            if (!isLoggedIn) {\n");
      out.write("                authModal.classList.add('is-visible');\n");
      out.write("                showLoginView(); // Default to login view\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            // Toggle mobile menu\n");
      out.write("            if (hamburger && navLinks) {\n");
      out.write("                hamburger.addEventListener('click', () => {\n");
      out.write("                    navLinks.classList.toggle('active');\n");
      out.write("                    hamburger.querySelector('i').classList.toggle('fa-bars');\n");
      out.write("                    hamburger.querySelector('i').classList.toggle('fa-times');\n");
      out.write("                });\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            // Modal toggling via links within the modal\n");
      out.write("            authModal.addEventListener('click', (e) => {\n");
      out.write("                if (e.target.id === 'showRegister') {\n");
      out.write("                    e.preventDefault();\n");
      out.write("                    showRegisterView();\n");
      out.write("                } else if (e.target.id === 'showLogin') {\n");
      out.write("                    e.preventDefault();\n");
      out.write("                    showLoginView();\n");
      out.write("                }\n");
      out.write("            });\n");
      out.write("\n");
      out.write("            // Form submission handling\n");
      out.write("            loginForm.addEventListener('submit', (e) => {\n");
      out.write("                const email = loginForm.querySelector('#loginEmail').value;\n");
      out.write("                const password = loginForm.querySelector('#loginPassword').value;\n");
      out.write("                if (!email || !password) {\n");
      out.write("                    e.preventDefault();\n");
      out.write("                    errorMessageElement.textContent = 'Please fill in both email and password fields.';\n");
      out.write("                    errorMessageElement.classList.remove('hidden');\n");
      out.write("                    successMessageElement.classList.add('hidden');\n");
      out.write("                } else {\n");
      out.write("                    // If fields are filled, let the form submit and server handle validation\n");
      out.write("                    errorMessageElement.classList.add('hidden');\n");
      out.write("                    successMessageElement.classList.add('hidden');\n");
      out.write("                }\n");
      out.write("            });\n");
      out.write("\n");
      out.write("            registerForm.addEventListener('submit', (e) => {\n");
      out.write("                const fullname = registerForm.querySelector('#registerFullname').value;\n");
      out.write("                const email = registerForm.querySelector('#registerEmail').value;\n");
      out.write("                const password = registerForm.querySelector('#registerPassword').value;\n");
      out.write("                if (!fullname || !email || !password) {\n");
      out.write("                    e.preventDefault();\n");
      out.write("                    errorMessageElement.textContent = 'Please fill in all fields.';\n");
      out.write("                    errorMessageElement.classList.remove('hidden');\n");
      out.write("                    successMessageElement.classList.add('hidden');\n");
      out.write("                } else {\n");
      out.write("                    // If fields are filled, let the form submit and server handle validation\n");
      out.write("                    errorMessageElement.classList.add('hidden');\n");
      out.write("                    successMessageElement.classList.add('hidden');\n");
      out.write("                }\n");
      out.write("            });\n");
      out.write("\n");
      out.write("            // Close modal when clicking outside of content\n");
      out.write("            authModal.addEventListener('click', (e) => {\n");
      out.write("                if (e.target === authModal) {\n");
      out.write("                    // Only close if the user is NOT logged in and the modal is visible\n");
      out.write("                    if (!isLoggedIn && authModal.classList.contains('is-visible')) {\n");
      out.write("                         authModal.classList.remove('is-visible');\n");
      out.write("                    }\n");
      out.write("                }\n");
      out.write("            });\n");
      out.write("\n");
      out.write("            // Show appropriate messages if they exist from server-side processing\n");
      out.write("            const initialErrorMessage = \"");
      out.print( errorMessage );
      out.write("\";\n");
      out.write("            const initialSuccessMessage = \"");
      out.print( successMessage );
      out.write("\";\n");
      out.write("            if (initialErrorMessage) {\n");
      out.write("                errorMessageElement.textContent = initialErrorMessage;\n");
      out.write("                errorMessageElement.classList.remove('hidden');\n");
      out.write("                // If there's an error, ensure the modal is visible and show the correct form\n");
      out.write("                authModal.classList.add('is-visible');\n");
      out.write("                if (initialErrorMessage.includes(\"Invalid email or password\")) {\n");
      out.write("                    showLoginView();\n");
      out.write("                } else {\n");
      out.write("                    showRegisterView(); // Assume other errors might be from registration\n");
      out.write("                }\n");
      out.write("            }\n");
      out.write("            if (initialSuccessMessage) {\n");
      out.write("                successMessageElement.textContent = initialSuccessMessage;\n");
      out.write("                successMessageElement.classList.remove('hidden');\n");
      out.write("                // If there's a success, show the login view\n");
      out.write("                authModal.classList.add('is-visible');\n");
      out.write("                showLoginView();\n");
      out.write("            }\n");
      out.write("        });\n");
      out.write("    </script>\n");
      out.write("</body>\n");
      out.write("</html>");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
