<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.net.*,org.json.*" %>
<%
    // ✅ Session check
    String fullname = (String) session.getAttribute("fullname");
    if (fullname == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>🌍 IP Address Tracker | CodeShelf</title>
    <link rel="icon" href='data:image/svg+xml;utf8,
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="blue" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4"/>
              </svg>'>
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
        }
    </style>
</head>
<body class="bg-gray-100 min-h-screen antialiased">
    <!-- ✅ Redesigned Header -->
    <header class="bg-white text-gray-800 shadow-lg sticky top-0 z-50">
        <nav class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4 flex justify-between items-center">
            <!-- Logo and Brand Name -->
            <div class="flex items-center space-x-3">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-9 w-9 text-blue-600" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"></path>
                </svg>
                <a href="#" class="text-3xl font-bold text-gray-800 tracking-wide">IP Tracker</a>
            </div>
            <!-- Navigation and User Info -->
            <div class="flex items-center space-x-5">
                <span class="text-sm font-medium text-gray-500 hidden sm:inline-block">
                    Welcome, <%= fullname%>
                </span>
                <a href="index.jsp" class="nav-link bg-blue-600 text-white px-5 py-2.5 rounded-full hover:bg-blue-700 transition duration-300 shadow-md">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 inline-block" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-10v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
                    </svg>
                    <span class="ml-2 hidden md:inline">Dashboard</span>
                </a>
            </div>
        </nav>
    </header>

    <div class="container mx-auto px-4 py-8">
        <!-- Search Card -->
        <div class="bg-white rounded-xl shadow-lg p-6 mb-6">
            <h1 class="text-2xl font-bold text-gray-800 mb-4">Track an IP Address</h1>
            <form method="get">
                <div class="flex flex-col sm:flex-row gap-4">
                    <input type="text" name="ip" placeholder="Enter IP Address (e.g., 8.8.8.8)" class="flex-1 p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-200">
                    <button type="submit" class="bg-blue-600 text-white font-semibold py-3 px-6 rounded-lg shadow-md hover:bg-blue-700 transition duration-300">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 inline-block mr-2" viewBox="0 0 20 20" fill="currentColor">
                          <path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd" />
                        </svg>
                        Track
                    </button>
                </div>
            </form>
            <div class="mt-4 text-sm text-gray-500 text-left">
                💡 Don’t know your IP? Find it <a href="https://www.whatismyip.com/" target="_blank" class="text-blue-500 hover:underline">here</a>.
                <br>
                🔑 Need an API Token? Get a free one <a href="https://ipinfo.io/dashboard/token" target="_blank" class="text-blue-500 hover:underline">here</a>.
            </div>
        </div>
        
        <!-- Info & Map Card -->
        <div class="bg-white rounded-xl shadow-lg p-6">
            <h2 class="text-xl font-bold text-gray-800 mb-4">IP Details</h2>
            <div class="info text-gray-700 text-left mb-6">
                <%
                    String ip = request.getParameter("ip");
                    if (ip != null && !ip.trim().isEmpty()) {
                        try {
                            String token = "3e245c63b4ff1a"; // replace with your ipinfo token
                            String apiUrl = "https://ipinfo.io/" + ip + "/json?token=" + token;

                            URL url = new URL(apiUrl);
                            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                            conn.setRequestMethod("GET");

                            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                            StringBuilder sb = new StringBuilder();
                            String line;
                            while ((line = in.readLine()) != null) sb.append(line);
                            in.close();

                            JSONObject json = new JSONObject(sb.toString());

                            String city = json.optString("city", "");
                            String region = json.optString("region", "");
                            String country = json.optString("country", "");
                            String org = json.optString("org", "");
                            String timezone = json.optString("timezone", "");
                            String loc = json.optString("loc", "0,0");

                            out.println("<p class='mb-2'><b>IP:</b> " + ip + "</p>");
                            out.println("<p class='mb-2'><b>Location:</b> " + city + ", " + region + ", " + country + "</p>");
                            out.println("<p class='mb-2'><b>ISP:</b> " + org + "</p>");
                            out.println("<p class='mb-2'><b>Timezone:</b> " + timezone + "</p>");
                            out.println("<p><b>Coordinates:</b> " + loc + "</p>");

                            request.setAttribute("coords", loc);
                            request.setAttribute("ip", ip);
                            request.setAttribute("location", city + ", " + region + ", " + country);
                        } catch (Exception e) {
                            out.println("❌ <p class='text-red-500'>Error fetching data. Please check the IP address or API token.</p>");
                        }
                    } else {
                        out.println("<p class='text-gray-500'>Enter an IP address above to track.</p>");
                    }
                %>
            </div>
            <div id="map" class="w-full rounded-lg shadow-inner overflow-hidden" style="height: 400px;"></div>
        </div>
    </div>

    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
    <script>
        let map = L.map('map').setView([20, 0], 2);
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '© OpenStreetMap contributors'
        }).addTo(map);

        <% if (request.getAttribute("coords") != null) {
            String coords = (String) request.getAttribute("coords");
            String ipAddr = (String) request.getAttribute("ip");
            String location = (String) request.getAttribute("location");
            String[] parts = coords.split(",");
        %>
            let lat = <%= parts[0] %>;
            let lon = <%= parts[1] %>;
            let marker = L.marker([lat, lon]).addTo(map)
                .bindPopup("<b><%= ipAddr %></b><br><%= location %>")
                .openPopup();
            map.setView([lat, lon], 10);
        <% } %>
    </script>
</body>
</html>
