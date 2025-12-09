<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*, java.util.logging.*, java.text.SimpleDateFormat, java.util.Date" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="CodeShelf offers innovative software solutions for real-world problems, including calculators, drawing tools, and more.">
        <meta name="keywords" content="software solutions, CodeShelf, calculator, drawing canvas, typing test, C compiler, IP tracker">
        <meta name="author" content="CodeShelf Team">
        <title>CodeShelf - Innovative Software Solutions</title>
        <link rel="shortcut icon" type="image/png" href="images/logo_circle.png">
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            body {
                font-family: 'Inter', sans-serif;
            }
            .smooth-scroll {
                scroll-behavior: smooth;
            }
            .project-card {
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }
            .project-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 12px 24px rgba(0, 0, 0, 0.2);
            }
            .nav-link {
                transition: color 0.3s ease, background-color 0.3s ease;
            }
            .nav-link:hover {
                color: #3b82f6;
            }
            .modal {
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0, 0, 0, 0.8);
                backdrop-filter: blur(10px);
                display: none;
                justify-content: center;
                align-items: center;
                opacity: 0;
                transition: opacity 0.5s ease-in-out;
            }
            .modal.is-visible {
                display: flex;
                opacity: 1;
            }
            .modal-content {
                background: white;
                padding: 2rem;
                border-radius: 16px;
                box-shadow: 0 25px 50px rgba(0, 0, 0, 0.35);
                max-width: 90%;
                width: 420px;
                position: relative;
                transform: scale(0.8);
                transition: transform 0.5s cubic-bezier(0.4, 0, 0.2, 1), opacity 0.5s ease;
            }
            .modal.is-visible .modal-content {
                transform: scale(1);
                opacity: 1;
            }
            .modal-content h2 {
                font-size: 1.8rem;
                font-weight: 700;
                color: #1f2937;
                text-align: center;
                margin-bottom: 0.5rem;
            }
            .modal-content p.subtitle {
                font-size: 1rem;
                color: #6b7280;
                text-align: center;
                margin-bottom: 1.5rem;
            }
            .form-group {
                position: relative;
                margin-bottom: 1.5rem;
            }
            .form-group input {
                width: 100%;
                padding: 0.75rem;
                border: 1px solid #d1d5db;
                border-radius: 8px;
                font-size: 1rem;
                background: #f9fafb;
                transition: border-color 0.3s ease, box-shadow 0.3s ease;
            }
            .form-group input:focus {
                border-color: #3b82f6;
                box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
                outline: none;
            }
            .form-group label {
                position: absolute;
                top: 0.75rem;
                left: 0.75rem;
                font-size: 1rem;
                color: #6b7280;
                transition: all 0.2s ease;
                pointer-events: none;
            }
            .form-group input:focus + label,
            .form-group input:not(:placeholder-shown) + label {
                top: -0.75rem;
                left: 0.5rem;
                font-size: 0.75rem;
                color: #3b82f6;
                background: white;
                padding: 0 0.25rem;
            }
            .modal-content button {
                background: linear-gradient(90deg, #3b82f6, #60a5fa);
                border-radius: 8px;
                padding: 0.75rem;
                font-size: 1rem;
                font-weight: 600;
                color: white;
                width: 100%;
                transition: all 0.3s ease;
            }
            .modal-content button:hover {
                background: linear-gradient(90deg, #2563eb, #3b82f6);
                transform: translateY(-2px);
                box-shadow: 0 6px 12px rgba(59, 130, 246, 0.3);
            }
            .toggle-link {
                font-size: 0.9rem;
                color: #6b7280;
                text-align: center;
                margin-top: 1.25rem;
            }
            .toggle-link a {
                color: #3b82f6;
                font-weight: 500;
                transition: color 0.3s ease;
            }
            .toggle-link a:hover {
                color: #2563eb;
            }
            .main-content-blur {
                filter: blur(5px);
                pointer-events: none;
            }
            .hamburger {
                display: none;
            }
            @media (max-width: 768px) {
                .hamburger {
                    display: block;
                }
                .nav-links {
                    display: none;
                    flex-direction: column;
                    position: absolute;
                    top: 60px;
                    left: 0;
                    width: 100%;
                    background-color: white;
                    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
                    padding: 1rem;
                    z-index: 10;
                }
                .nav-links.active {
                    display: flex;
                }
                .nav-links a {
                    margin-bottom: 1rem;
                    width: 100%;
                    text-align: left;
                    padding: 0.5rem 0;
                }
                .nav-links .user-info {
                    margin-bottom: 1rem;
                }
                .modal-content {
                    width: 90%;
                    padding: 1.5rem;
                }
            }
        </style>
    </head>
    <body class="bg-gray-50 smooth-scroll">
        <%
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
        %>

        <div id="authModal" class="modal <%= isLoggedIn ? "" : "is-visible"%>" aria-labelledby="authModalTitle">
            <div class="modal-content">
                <h2 id="authModalTitle" class="mb-4"></h2>
                <p class="subtitle"></p>

                <form id="loginForm" action="index.jsp" method="post" class="space-y-4">
                    <input type="hidden" name="action" value="login">
                    <input type="hidden" name="csrfToken" value="<%= csrfToken%>">
                    <div class="form-group">
                        <input type="email" id="loginEmail" name="email" placeholder=" " required aria-required="true">
                        <label for="loginEmail">Email address</label>
                    </div>
                    <div class="form-group">
                        <input type="password" id="loginPassword" name="password" placeholder=" " required aria-required="true">
                        <label for="loginPassword">Password</label>
                    </div>
                    <button type="submit" class="w-full">Log In</button>
                </form>

                <form id="registerForm" action="index.jsp" method="post" class="hidden space-y-4">
                    <input type="hidden" name="action" value="register">
                    <input type="hidden" name="csrfToken" value="<%= csrfToken%>">
                    <div class="form-group">
                        <input type="text" id="registerFullname" name="fullname" placeholder=" " required aria-required="true">
                        <label for="registerFullname">Full Name</label>
                    </div>
                    <div class="form-group">
                        <input type="email" id="registerEmail" name="email" placeholder=" " required aria-required="true">
                        <label for="registerEmail">Email address</label>
                    </div>
                    <div class="form-group">
                        <input type="password" id="registerPassword" name="password" placeholder=" " required aria-required="true">
                        <label for="registerPassword">Password</label>
                    </div>
                    <button type="submit" class="w-full">Register</button>
                </form>

                <div id="modalMessageContainer" class="mt-4">
                    <p id="errorMessage" class="text-red-500 text-sm <%= errorMessage.isEmpty() ? "hidden" : "block"%>"><%= errorMessage%></p>
                    <p id="successMessage" class="text-green-500 text-sm <%= successMessage.isEmpty() ? "hidden" : "block"%>"><%= successMessage%></p>
                </div>

                <p id="toggleAuthLink" class="toggle-link"></p>
            </div>
        </div>

        <div id="mainContent" class="<%= isLoggedIn ? "block" : "block main-content-blur"%>">
            <header class="bg-white shadow-lg sticky top-0 z-50">
                <nav class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4 flex justify-between items-center">
                    <div class="flex items-center space-x-20">
                        <a href="index.jsp" class="flex items-center space-x-2">
                            <img src="images/logo.jpeg" alt="CodeShelf Logo" class="h-[90px] w-auto object-contain">
                            <h1 class="text-4xl font-extrabold">
                                <span class="bg-gradient-to-r from-purple-600 to-pink-500 bg-clip-text text-transparent">CODE</span>
                                <span class="bg-gradient-to-r from-blue-500 to-cyan-400 bg-clip-text text-transparent">SHELF</span>
                            </h1>
                        </a>
                    </div>
                    <div class="hamburger md:hidden">
                        <i class="fas fa-bars text-2xl text-gray-600 cursor-pointer"></i>
                    </div>
                    <div class="nav-links flex items-center space-x-6">
                        <a href="#about" class="nav-link text-2xl font-bold">
                            <span class="bg-gradient-to-r from-purple-600 to-pink-500 bg-clip-text text-transparent">About</span>
                        </a>
                        <a href="#projects" class="nav-link text-2xl font-bold">
                            <span class="bg-gradient-to-r from-purple-600 to-pink-500 bg-clip-text text-transparent">Projects</span>
                        </a>
                        <a href="#contact" class="nav-link text-2xl font-bold">
                            <span class="bg-gradient-to-r from-purple-600 to-pink-500 bg-clip-text text-transparent">Contact</span>
                        </a>
                        <% if (session.getAttribute("fullname") != null) {%>
                        <div class="flex items-center space-x-4 py-2 md:py-0 user-info">
                            <span class="text-sm font-extrabold px-2 py-2">
                                <span class="bg-gradient-to-r from-purple-600 to-pink-500 bg-clip-text text-transparent">Welcome,</span>
                                <span class="bg-gradient-to-r from-blue-500 to-cyan-400 bg-clip-text text-transparent">
                                    <%= session.getAttribute("fullname")%>
                                </span>
                            </span>
                            <a href="logout.jsp" class="nav-link text-white bg-blue-600 px-4 py-2 rounded-lg hover:bg-blue-700 transition">Logout</a>
                        </div>
                        <% } %>
                    </div>
                </nav>
            </header>

            <section class="bg-gradient-to-br from-blue-700 to-indigo-600 text-white py-24">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
                    <h1 class="text-4xl md:text-5xl font-bold mb-6">Innovate with CodeShelf</h1>
                    <p class="text-lg md:text-xl max-w-3xl mx-auto">Discover cutting-edge software solutions designed to solve real-world challenges with creativity and precision.</p>
                    <a href="#projects" class="mt-8 inline-block bg-white text-blue-600 px-8 py-3 rounded-lg font-semibold hover:bg-gray-100 transition">Explore Projects</a>
                </div>
            </section>

            <section id="about" class="scroll-mt-32 py-16 bg-gray-50">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <h2 class="text-4xl font-extrabold text-center mb-12">
                        <span class="bg-gradient-to-r from-purple-600 to-pink-500 bg-clip-text text-transparent">About</span>
                        <span class="bg-gradient-to-r from-blue-500 to-cyan-400 bg-clip-text text-transparent"> Us</span>
                    </h2>
                    <p class="text-gray-600 text-lg max-w-4xl mx-auto leading-relaxed">
                        At CodeShelf, we believe technology should be practical, creative, and accessible to everyone. 
                        Our projects are designed to solve real-world problems while also offering interactive and engaging experiences. 
                        <br><br>
                        We build <span class="font-semibold">utility tools</span> such as the <span class="font-semibold">Calculator</span> for quick problem-solving, 
                        a <span class="font-semibold">C Compiler</span> to support coding and learning, and an <span class="font-semibold">IP Address Finder</span> 
                        for simple yet essential networking tasks. 
                        <br><br>
                        Alongside these, we create <span class="font-semibold">creative and learning-focused apps</span> like the <span class="font-semibold">Drawing Canvas</span> 
                        for imagination and design, the <span class="font-semibold">Typing Test</span> to improve speed and accuracy, and the <span class="font-semibold">Word Counter</span> 
                        to support writing and productivity. 
                        <br><br>
                        Together, these projects reflect our mission: to deliver software that is <span class="font-semibold text-indigo-600">simple, smart, and impactful</span>, 
                        empowering users in both work and play.
                    </p>
                </div>
            </section>

            <section id="projects" class="scroll-mt-24 py-10">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <h2 class="text-4xl font-extrabold text-center mb-12">
                        <span class="bg-gradient-to-r from-purple-600 to-pink-500 bg-clip-text text-transparent">Our</span>
                        <span class="bg-gradient-to-r from-blue-500 to-cyan-400 bg-clip-text text-transparent"> Projects</span>
                    </h2>
                    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
                        <div class="project-card bg-gray-50 rounded-xl shadow-lg p-6 flex flex-col space-y-4">
                            <div class="flex items-center space-x-4">
                                <div class="p-3 rounded-full bg-blue-100 text-blue-600">
                                    <i class="fas fa-calculator h-6 w-6"></i>
                                </div>
                                <h3 class="text-xl font-bold text-gray-900">Calculator</h3>
                            </div>
                            <p class="text-gray-600 flex-grow">A powerful calculator for basic and scientific operations, designed for speed and ease of use.</p>
                            <a href="Calculator.jsp" class="inline-flex items-center justify-center px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition">Launch App <i class="fas fa-arrow-right ml-2"></i></a>
                        </div>
                        <div class="project-card bg-gray-50 rounded-xl shadow-lg p-6 flex flex-col space-y-4">
                            <div class="flex items-center space-x-4">
                                <div class="p-3 rounded-full bg-green-100 text-green-600">
                                    <i class="fas fa-paint-brush h-6 w-6"></i>
                                </div>
                                <h3 class="text-xl font-bold text-gray-900">Drawing Canvas</h3>
                            </div>
                            <p class="text-gray-600 flex-grow">Unleash your creativity with our intuitive drawing tool featuring customizable brushes and colors.</p>
                            <a href="DrawingCanvas.jsp" class="inline-flex items-center justify-center px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition">Launch App <i class="fas fa-arrow-right ml-2"></i></a>
                        </div>
                        <div class="project-card bg-gray-50 rounded-xl shadow-lg p-6 flex flex-col space-y-4">
                            <div class="flex items-center space-x-4">
                                <div class="p-3 rounded-full bg-yellow-100 text-yellow-600">
                                    <i class="fas fa-keyboard h-6 w-6"></i>
                                </div>
                                <h3 class="text-xl font-bold text-gray-900">Typing Test</h3>
                            </div>
                            <p class="text-gray-600 flex-grow">Test and improve your typing skills with engaging challenges and detailed analytics.</p>
                            <a href="typingtest.jsp" class="inline-flex items-center justify-center px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition">Launch App <i class="fas fa-arrow-right ml-2"></i></a>
                        </div>
                        <div class="project-card bg-gray-50 rounded-xl shadow-lg p-6 flex flex-col space-y-4">
                            <div class="flex items-center space-x-4">
                                <div class="p-3 rounded-full bg-purple-100 text-purple-600">
                                    <i class="fas fa-code h-6 w-6"></i>
                                </div>
                                <h3 class="text-xl font-bold text-gray-900">C Compiler</h3>
                            </div>
                            <p class="text-gray-600 flex-grow">Write and run C code online with real-time syntax checking and execution.</p>
                            <a href="onlineEditor.jsp" class="inline-flex items-center justify-center px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition">Launch App <i class="fas fa-arrow-right ml-2"></i></a>
                        </div>
                        <div class="project-card bg-gray-50 rounded-xl shadow-lg p-6 flex flex-col space-y-4">
                            <div class="flex items-center space-x-4">
                                <div class="p-3 rounded-full bg-red-100 text-red-600">
                                    <i class="fas fa-map-marker-alt h-6 w-6"></i>
                                </div>
                                <h3 class="text-xl font-bold text-gray-900">IP Address Finder</h3>
                            </div>
                            <p class="text-gray-600 flex-grow">Locate any IP address with detailed geolocation data and a real-time map.</p>
                            <a href="IPAddressTracker.jsp" class="inline-flex items-center justify-center px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition">Launch App <i class="fas fa-arrow-right ml-2"></i></a>
                        </div>
                        <div class="project-card bg-gray-50 rounded-xl shadow-lg p-6 flex flex-col space-y-4">
                            <div class="flex items-center space-x-4">
                                <div class="p-3 rounded-full bg-orange-100 text-orange-600">
                                    <i class="fas fa-file-alt h-6 w-6"></i>
                                </div>
                                <h3 class="text-xl font-bold text-gray-900">Word Counter</h3>
                            </div>
                            <p class="text-gray-600 flex-grow">Analyze text with detailed word, character, and sentence counts.</p>
                            <a href="WordCharacterCounter.jsp" class="inline-flex items-center justify-center px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition">Launch App <i class="fas fa-arrow-right ml-2"></i></a>
                        </div>
                    </div>
                </div>
            </section>

            <section id="contact" class="py-20 bg-gray-100">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
                    <h2 class="text-4xl font-extrabold text-center mb-6">
                        <span class="bg-gradient-to-r from-purple-600 to-pink-500 bg-clip-text text-transparent">Contact</span>
                        <span class="bg-gradient-to-r from-blue-500 to-cyan-400 bg-clip-text text-transparent"> Us</span>
                    </h2>
                    <p class="text-lg text-gray-600 mb-4">Have a question or a problem? Feel free to reach out to us at:</p>
                    <a href="mailto:jaylalkiya02@gmail.com" class="text-blue-600 font-semibold hover:underline text-xl">jaylalkiya02@gmail.com</a>
                </div>
            </section>

            <footer class="bg-gray-900 text-white py-8">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
                    <p>&copy; 2025 CodeShelf. All rights reserved.</p>
                    <%
                        Date now = new Date();
                        SimpleDateFormat dateFormat = new SimpleDateFormat("MMMM dd, yyyy");
                        SimpleDateFormat dayFormat = new SimpleDateFormat("EEEE");
                        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
                        String currentDate = dateFormat.format(now);
                        String currentDay = dayFormat.format(now);
                        String currentTime = timeFormat.format(now);
                    %>
                    <p class="mt-2 text-sm">Date: <%= currentDate%> | Day: <%= currentDay%> | Time: <%= currentTime%></p>
                    <div class="mt-4 flex justify-center space-x-4">
                        <a href="https://www.linkedin.com/in/jay-lalkiya-527149302/" class="text-gray-400 hover:text-white" target="_blank">
                            <i class="fab fa-linkedin"></i>
                        </a>
                        <a href="https://github.com/jaylalkiya" class="text-gray-400 hover:text-white" target="_blank">
                            <i class="fab fa-github"></i>
                        </a>
                        <a href="https://wa.me/918200411490" class="text-gray-400 hover:text-white" target="_blank">
                            <i class="fab fa-whatsapp"></i>
                        </a>
                    </div>
                </div>
            </footer>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', () => {
                const authModal = document.getElementById('authModal');
                const loginForm = document.getElementById('loginForm');
                const registerForm = document.getElementById('registerForm');
                const modalTitle = authModal.querySelector('#authModalTitle');
                const modalSubtitle = authModal.querySelector('.subtitle');
                const toggleAuthLink = document.getElementById('toggleAuthLink');
                const errorMessageElement = document.getElementById('errorMessage');
                const successMessageElement = document.getElementById('successMessage');
                const mainContent = document.getElementById('mainContent');
                const hamburger = document.querySelector('.hamburger');
                const navLinks = document.querySelector('.nav-links');
                const isLoggedIn = <%= isLoggedIn%>;

                function showLoginView() {
                   modalTitle.innerHTML = `
    <span>Welcome</span><br>
    <span class="bg-gradient-to-r from-purple-600 via-pink-500 to-cyan-400 bg-clip-text text-transparent font-extrabold text-2xl">
        CodeShelf : MultiCode Projects
    </span>
`;

                    modalSubtitle.textContent = 'Log in to access CodeShelf’s innovative tools.';
                    loginForm.classList.remove('hidden');
                    registerForm.classList.add('hidden');
                    toggleAuthLink.innerHTML = 'New to CodeShelf? <a href="#" id="showRegister" class="text-blue-500 hover:underline">Create an account</a>';
                    errorMessageElement.classList.add('hidden');
                    successMessageElement.classList.add('hidden');
                }

                function showRegisterView() {
                    modalTitle.innerHTML = `
    <span>Join</span><br>
    <span class="bg-gradient-to-r from-purple-600 via-pink-500 to-cyan-400 bg-clip-text text-transparent font-extrabold text-2xl">
        CodeShelf : MultiCode Projects
    </span>
`;

                    modalSubtitle.textContent = 'Sign up to unlock a world of creative tools.';
                    registerForm.classList.remove('hidden');
                    loginForm.classList.add('hidden');
                    toggleAuthLink.innerHTML = 'Already have an account? <a href="#" id="showLogin" class="text-blue-500 hover:underline">Log In</a>';
                    errorMessageElement.classList.add('hidden');
                    successMessageElement.classList.add('hidden');
                }

                if (!isLoggedIn) {
                    authModal.classList.add('is-visible');
                    mainContent.classList.add('main-content-blur');
                    showLoginView();
                } else {
                    authModal.classList.remove('is-visible');
                    mainContent.classList.remove('main-content-blur');
                }

                if (hamburger && navLinks) {
                    hamburger.addEventListener('click', () => {
                        navLinks.classList.toggle('active');
                        hamburger.querySelector('i').classList.toggle('fa-bars');
                        hamburger.querySelector('i').classList.toggle('fa-times');
                    });
                }

                authModal.addEventListener('click', (e) => {
                    if (e.target.id === 'showRegister') {
                        e.preventDefault();
                        showRegisterView();
                    } else if (e.target.id === 'showLogin') {
                        e.preventDefault();
                        showLoginView();
                    }
                });

                loginForm.addEventListener('submit', (e) => {
                    const email = loginForm.querySelector('#loginEmail').value;
                    const password = loginForm.querySelector('#loginPassword').value;
                    if (!email || !password) {
                        e.preventDefault();
                        errorMessageElement.textContent = 'Please fill in both email and password.';
                        errorMessageElement.classList.remove('hidden');
                        successMessageElement.classList.add('hidden');
                    } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
                        e.preventDefault();
                        errorMessageElement.textContent = 'Please enter a valid email address.';
                        errorMessageElement.classList.remove('hidden');
                        successMessageElement.classList.add('hidden');
                    } else {
                        errorMessageElement.classList.add('hidden');
                        successMessageElement.classList.add('hidden');
                    }
                });

                registerForm.addEventListener('submit', (e) => {
                    const fullname = registerForm.querySelector('#registerFullname').value;
                    const email = registerForm.querySelector('#registerEmail').value;
                    const password = registerForm.querySelector('#registerPassword').value;
                    if (!fullname || !email || !password) {
                        e.preventDefault();
                        errorMessageElement.textContent = 'Please fill in all fields.';
                        errorMessageElement.classList.remove('hidden');
                        successMessageElement.classList.add('hidden');
                    } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
                        e.preventDefault();
                        errorMessageElement.textContent = 'Please enter a valid email address.';
                        errorMessageElement.classList.remove('hidden');
                        successMessageElement.classList.add('hidden');
                    } else if (password.length < 6) {
                        e.preventDefault();
                        errorMessageElement.textContent = 'Password must be at least 6 characters long.';
                        errorMessageElement.classList.remove('hidden');
                        successMessageElement.classList.add('hidden');
                    } else {
                        errorMessageElement.classList.add('hidden');
                        successMessageElement.classList.add('hidden');
                    }
                });

                authModal.addEventListener('click', (e) => {
                    if (e.target === authModal && !isLoggedIn) {
                        e.preventDefault(); // Prevent closing modal if not logged in
                    }
                });

                const initialErrorMessage = "<%= errorMessage%>";
                const initialSuccessMessage = "<%= successMessage%>";
                if (initialErrorMessage) {
                    errorMessageElement.textContent = initialErrorMessage;
                    errorMessageElement.classList.remove('hidden');
                    authModal.classList.add('is-visible');
                    mainContent.classList.add('main-content-blur');
                    if (initialErrorMessage.includes("Invalid email or password")) {
                        showLoginView();
                    } else {
                        showRegisterView();
                    }
                }
                if (initialSuccessMessage) {
                    successMessageElement.textContent = initialSuccessMessage;
                    successMessageElement.classList.remove('hidden');
                    authModal.classList.add('is-visible');
                    mainContent.classList.add('main-content-blur');
                    showLoginView();
                }
            });
        </script>
    </body>
</html>