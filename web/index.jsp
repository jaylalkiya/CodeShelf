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
   <link rel="icon" href='data:image/svg+xml;utf8,
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="blue" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4"/>
              </svg>'>
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
            background-color: rgba(0, 0, 0, 0.85);
            backdrop-filter: blur(10px);
            display: none;
            justify-content: center;
            align-items: center;
            opacity: 0;
            transition: opacity 0.3s ease, display 0.3s ease;
        }
        .modal.is-visible {
            display: flex;
            opacity: 1;
        }
        .modal-content {
            background-color: #ffffff;
            padding: 2rem;
            border-radius: 1rem;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            max-width: 90%;
            width: 450px;
            text-align: center;
            transform: scale(0.7);
            transition: transform 0.3s ease;
        }
        .modal.is-visible .modal-content {
            transform: scale(1);
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
                top: 60px; /* Adjust based on header height */
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
            <h2 id="authModalTitle" class="text-2xl font-bold text-gray-900 mb-4"></h2>
            <p class="text-gray-600 mb-6"></p>

            <form id="loginForm" action="index.jsp" method="post" class="space-y-4">
                <input type="hidden" name="action" value="login">
                <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                <div>
                    <label for="loginEmail" class="sr-only">Email</label>
                    <input type="email" id="loginEmail" name="email" placeholder="Email" required class="w-full border border-gray-300 rounded-lg p-3 focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-300" aria-required="true">
                </div>
                <div>
                    <label for="loginPassword" class="sr-only">Password</label>
                    <input type="password" id="loginPassword" name="password" placeholder="Password" required class="w-full border border-gray-300 rounded-lg p-3 focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-300" aria-required="true">
                </div>
                <button type="submit" class="w-full bg-blue-600 text-white py-3 rounded-lg font-semibold hover:bg-blue-700 transition duration-300">Log In</button>
            </form>

            <form id="registerForm" action="index.jsp" method="post" class="hidden space-y-4">
                <input type="hidden" name="action" value="register">
                <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                <div>
                    <label for="registerFullname" class="sr-only">Full Name</label>
                    <input type="text" id="registerFullname" name="fullname" placeholder="Full Name" required class="w-full border border-gray-300 rounded-lg p-3 focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-300" aria-required="true">
                </div>
                <div>
                    <label for="registerEmail" class="sr-only">Email</label>
                    <input type="email" id="registerEmail" name="email" placeholder="Email" required class="w-full border border-gray-300 rounded-lg p-3 focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-300" aria-required="true">
                </div>
                <div>
                    <label for="registerPassword" class="sr-only">Password</label>
                    <input type="password" id="registerPassword" name="password" placeholder="Password" required class="w-full border border-gray-300 rounded-lg p-3 focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-300" aria-required="true">
                </div>
                <button type="submit" class="w-full bg-blue-600 text-white py-3 rounded-lg font-semibold hover:bg-blue-700 transition duration-300">Register</button>
            </form>

            <div id="modalMessageContainer" class="mt-4">
                <p id="errorMessage" class="text-red-500 text-sm <%= errorMessage.isEmpty() ? "hidden" : "block"%>"><%= errorMessage %></p>
                <p id="successMessage" class="text-green-500 text-sm <%= successMessage.isEmpty() ? "hidden" : "block"%>"><%= successMessage %></p>
            </div>

            <p id="toggleAuthLink" class="text-gray-500 text-sm mt-4"></p>
        </div>
    </div>

    <div id="mainContent" class="<%= isLoggedIn ? "block" : "hidden"%>">
        <header class="bg-white shadow-lg sticky top-0 z-50">
            <nav class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4 flex justify-between items-center">
                <div class="flex items-center space-x-3">
                    <svg class="h-10 w-10 text-blue-600" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4" />
                    </svg>
                    <a href="index.jsp" class="text-2xl font-bold text-gray-900">CodeShelf</a>
                </div>
                <div class="hamburger md:hidden">
                    <i class="fas fa-bars text-2xl text-gray-600 cursor-pointer"></i>
                </div>
                <div class="nav-links flex items-center space-x-6">
                    <a href="#about" class="nav-link text-gray-600 hover:text-blue-500 font-medium py-2 md:py-0">About</a>
                    <a href="#projects" class="nav-link text-gray-600 hover:text-blue-500 font-medium py-2 md:py-0">Projects</a>
                    <a href="#contact" class="nav-link text-gray-600 hover:text-blue-500 font-medium py-2 md:py-0">Contact</a>
                    <% if (session.getAttribute("fullname") != null) { %>
                        <div class="flex items-center space-x-4 py-2 md:py-0 user-info">
                            <span class="bg-blue-100 text-blue-800 text-sm font-semibold px-3 py-1 rounded-full">
                                Welcome, <%= session.getAttribute("fullname") %>
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

        <section id="about" class="py-20 bg-gray-100">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <h2 class="text-3xl font-bold text-gray-900 text-center mb-12">About Us</h2>
                <p class="text-gray-600 text-lg max-w-3xl mx-auto text-center">CodeShelf is a technology hub dedicated to creating innovative software that empowers users. From productivity tools to creative platforms, our mission is to make technology accessible and impactful.</p>
            </div>
        </section>

        <section id="projects" class="py-20 bg-white">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <h2 class="text-3xl font-bold text-gray-900 text-center mb-12">Our Projects</h2>
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
                <h2 class="text-3xl font-bold text-gray-900 mb-6">Contact Us</h2>
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
                <p class="mt-2 text-sm">Date: <%= currentDate %> | Day: <%= currentDay %> | Time: <%= currentTime %></p>
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
            const loginButton = loginForm.querySelector('button[type="submit"]');
            const registerButton = registerForm.querySelector('button[type="submit"]');
            const modalTitle = authModal.querySelector('#authModalTitle');
            const modalDescription = authModal.querySelector('p:not(#toggleAuthLink, #errorMessage, #successMessage)');
            const toggleAuthLink = document.getElementById('toggleAuthLink');
            const errorMessageElement = document.getElementById('errorMessage');
            const successMessageElement = document.getElementById('successMessage');
            const modalMessageContainer = document.getElementById('modalMessageContainer');
            const hamburger = document.querySelector('.hamburger');
            const navLinks = document.querySelector('.nav-links');
            const isLoggedIn = <%= isLoggedIn %>; // Get login status from JSP

            // Function to show the correct modal content
            function showLoginView() {
                modalTitle.textContent = 'Welcome to CodeShelf';
                modalDescription.textContent = 'Log in to explore our innovative solutions.';
                loginForm.classList.remove('hidden');
                registerForm.classList.add('hidden');
                toggleAuthLink.innerHTML = 'No account? <a href="#" id="showRegister" class="text-blue-500 hover:underline">Create one</a>';
                // Clear messages when switching views
                errorMessageElement.classList.add('hidden');
                successMessageElement.classList.add('hidden');
            }

            function showRegisterView() {
                modalTitle.textContent = 'Join CodeShelf';
                modalDescription.textContent = 'Create an account to get started.';
                registerForm.classList.remove('hidden');
                loginForm.classList.add('hidden');
                toggleAuthLink.innerHTML = 'Have an account? <a href="#" id="showLogin" class="text-blue-500 hover:underline">Log In</a>';
                // Clear messages when switching views
                errorMessageElement.classList.add('hidden');
                successMessageElement.classList.add('hidden');
            }

            // Initial modal state
            if (!isLoggedIn) {
                authModal.classList.add('is-visible');
                showLoginView(); // Default to login view
            }

            // Toggle mobile menu
            if (hamburger && navLinks) {
                hamburger.addEventListener('click', () => {
                    navLinks.classList.toggle('active');
                    hamburger.querySelector('i').classList.toggle('fa-bars');
                    hamburger.querySelector('i').classList.toggle('fa-times');
                });
            }

            // Modal toggling via links within the modal
            authModal.addEventListener('click', (e) => {
                if (e.target.id === 'showRegister') {
                    e.preventDefault();
                    showRegisterView();
                } else if (e.target.id === 'showLogin') {
                    e.preventDefault();
                    showLoginView();
                }
            });

            // Form submission handling
            loginForm.addEventListener('submit', (e) => {
                const email = loginForm.querySelector('#loginEmail').value;
                const password = loginForm.querySelector('#loginPassword').value;
                if (!email || !password) {
                    e.preventDefault();
                    errorMessageElement.textContent = 'Please fill in both email and password fields.';
                    errorMessageElement.classList.remove('hidden');
                    successMessageElement.classList.add('hidden');
                } else {
                    // If fields are filled, let the form submit and server handle validation
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
                } else {
                    // If fields are filled, let the form submit and server handle validation
                    errorMessageElement.classList.add('hidden');
                    successMessageElement.classList.add('hidden');
                }
            });

            // Close modal when clicking outside of content
            authModal.addEventListener('click', (e) => {
                if (e.target === authModal) {
                    // Only close if the user is NOT logged in and the modal is visible
                    if (!isLoggedIn && authModal.classList.contains('is-visible')) {
                         authModal.classList.remove('is-visible');
                    }
                }
            });

            // Show appropriate messages if they exist from server-side processing
            const initialErrorMessage = "<%= errorMessage %>";
            const initialSuccessMessage = "<%= successMessage %>";
            if (initialErrorMessage) {
                errorMessageElement.textContent = initialErrorMessage;
                errorMessageElement.classList.remove('hidden');
                // If there's an error, ensure the modal is visible and show the correct form
                authModal.classList.add('is-visible');
                if (initialErrorMessage.includes("Invalid email or password")) {
                    showLoginView();
                } else {
                    showRegisterView(); // Assume other errors might be from registration
                }
            }
            if (initialSuccessMessage) {
                successMessageElement.textContent = initialSuccessMessage;
                successMessageElement.classList.remove('hidden');
                // If there's a success, show the login view
                authModal.classList.add('is-visible');
                showLoginView();
            }
        });
    </script>
</body>
</html>