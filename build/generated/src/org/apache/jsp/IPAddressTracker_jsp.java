package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.io.*;
import java.net.*;
import org.json.*;

public final class IPAddressTracker_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write('\n');
      out.write('\n');

    // ✅ Session check
    String fullname = (String) session.getAttribute("fullname");
    if (fullname == null) {
        response.sendRedirect("index.jsp");
        return;
    }

      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\">\n");
      out.write("<head>\n");
      out.write("    <meta charset=\"UTF-8\">\n");
      out.write("    <title>🌍 IP Address Tracker | CodeShelf</title>\n");
      out.write("    <link rel=\"stylesheet\" href=\"https://unpkg.com/leaflet/dist/leaflet.css\" />\n");
      out.write("    <script src=\"https://cdn.tailwindcss.com\"></script>\n");
      out.write("    <link href=\"https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap\" rel=\"stylesheet\">\n");
      out.write("    <style>\n");
      out.write("        body {\n");
      out.write("            font-family: 'Roboto', sans-serif;\n");
      out.write("            margin: 0;\n");
      out.write("            padding: 0;\n");
      out.write("            background: #f0f2f5;\n");
      out.write("        }\n");
      out.write("        .container {\n");
      out.write("            margin: 30px auto;\n");
      out.write("            width: 90%;\n");
      out.write("            max-width: 700px;\n");
      out.write("            text-align: center;\n");
      out.write("        }\n");
      out.write("        .search-box {\n");
      out.write("            display: flex;\n");
      out.write("            gap: 10px;\n");
      out.write("            margin-bottom: 10px;\n");
      out.write("        }\n");
      out.write("        input {\n");
      out.write("            flex: 1;\n");
      out.write("            padding: 12px;\n");
      out.write("            font-size: 16px;\n");
      out.write("            border: 1px solid #ccc;\n");
      out.write("            border-radius: 6px;\n");
      out.write("        }\n");
      out.write("        button {\n");
      out.write("            padding: 12px 18px;\n");
      out.write("            background: #4a90e2;\n");
      out.write("            color: white;\n");
      out.write("            border: none;\n");
      out.write("            border-radius: 6px;\n");
      out.write("            font-size: 16px;\n");
      out.write("            cursor: pointer;\n");
      out.write("            transition: background 0.3s;\n");
      out.write("        }\n");
      out.write("        button:hover {\n");
      out.write("            background: #357ab7;\n");
      out.write("        }\n");
      out.write("        .hint {\n");
      out.write("            font-size: 14px;\n");
      out.write("            margin-bottom: 20px;\n");
      out.write("            color: #444;\n");
      out.write("        }\n");
      out.write("        .hint a {\n");
      out.write("            color: #4a90e2;\n");
      out.write("            text-decoration: none;\n");
      out.write("            font-weight: bold;\n");
      out.write("        }\n");
      out.write("        .info {\n");
      out.write("            margin-top: 15px;\n");
      out.write("            background: white;\n");
      out.write("            padding: 15px;\n");
      out.write("            border-radius: 8px;\n");
      out.write("            box-shadow: 0 2px 6px rgba(0,0,0,0.15);\n");
      out.write("            text-align: left;\n");
      out.write("        }\n");
      out.write("        #map {\n");
      out.write("            height: 400px;\n");
      out.write("            margin-top: 20px;\n");
      out.write("            border-radius: 10px;\n");
      out.write("            overflow: hidden;\n");
      out.write("            box-shadow: 0 2px 10px rgba(0,0,0,0.2);\n");
      out.write("        }\n");
      out.write("    </style>\n");
      out.write("</head>\n");
      out.write("<body class=\"bg-gray-100 min-h-screen\">\n");
      out.write("    <header class=\"bg-white shadow-md sticky top-0 z-50\">\n");
      out.write("        <nav class=\"max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-3 flex justify-between items-center\">\n");
      out.write("            <div class=\"flex items-center space-x-2\">\n");
      out.write("                <svg class=\"h-8 w-8 text-blue-600\" fill=\"none\" viewBox=\"0 0 24 24\" stroke=\"currentColor\" stroke-width=\"2\">\n");
      out.write("                    <path stroke-linecap=\"round\" stroke-linejoin=\"round\" d=\"M3.055 11H5a2 2 0 012 2v2.102M19 11H9a2 2 0 00-2 2v2m7 12l-7-7m7 7l-7-7m7 7V5c0-1.121-.879-2-2-2S9 3.879 9 5v3m-3 9l3 3m0-3l-3 3m3-3V5a3.993 3.993 0 00-2.32-.732m.002 8.079a4.975 4.975 0 01-1.332-.016m2.592-2.126l-7.535-7.535\" />\n");
      out.write("                </svg>\n");
      out.write("                <a href=\"#\" class=\"text-2xl font-bold text-gray-900\">IP Tracker</a>\n");
      out.write("            </div>\n");
      out.write("            <div class=\"flex items-center space-x-4\">\n");
      out.write("                <span class=\"bg-blue-100 text-blue-800 text-sm font-semibold px-3 py-1 rounded-full hidden sm:inline-block\">\n");
      out.write("                    Welcome, ");
      out.print( fullname);
      out.write("\n");
      out.write("                </span>\n");
      out.write("                <a href=\"index.jsp\" class=\"nav-link text-white bg-blue-500 px-4 py-2 rounded-md hover:bg-blue-600 transition duration-200 shadow\">\n");
      out.write("                    <svg xmlns=\"http://www.w3.org/2000/svg\" class=\"h-5 w-5 inline-block\" fill=\"none\" viewBox=\"0 0 24 24\" stroke=\"currentColor\" stroke-width=\"2\">\n");
      out.write("                        <path stroke-linecap=\"round\" stroke-linejoin=\"round\" d=\"M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-10v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6\" />\n");
      out.write("                    </svg>\n");
      out.write("                    <span class=\"ml-1 hidden md:inline\">Dashboard</span>\n");
      out.write("                </a>\n");
      out.write("            </div>\n");
      out.write("        </nav>\n");
      out.write("    </header>\n");
      out.write("\n");
      out.write("    <div class=\"container\">\n");
      out.write("        <form method=\"get\">\n");
      out.write("            <div class=\"search-box\">\n");
      out.write("                <input type=\"text\" name=\"ip\" placeholder=\"Enter IP Address (e.g., 8.8.8.8)\">\n");
      out.write("                <button type=\"submit\">Track</button>\n");
      out.write("            </div>\n");
      out.write("        </form>\n");
      out.write("\n");
      out.write("        <p class=\"hint\">\n");
      out.write("            💡 Don’t know your IP? Find it here 👉\n");
      out.write("            <a href=\"https://www.whatismyip.com/\" target=\"_blank\">WhatIsMyIP.com</a>\n");
      out.write("        </p>\n");
      out.write("\n");
      out.write("        <p class=\"hint\">\n");
      out.write("            🔑 Need an API Token? Get a free one here 👉\n");
      out.write("            <a href=\"https://ipinfo.io/dashboard/token\" target=\"_blank\">ipinfo.io Token Dashboard</a>\n");
      out.write("        </p>\n");
      out.write("\n");
      out.write("        <div class=\"info\">\n");
      out.write("            ");

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

                        out.println("<b>IP:</b> " + ip + "<br>");
                        out.println("<b>Location:</b> " + city + ", " + region + ", " + country + "<br>");
                        out.println("<b>ISP:</b> " + org + "<br>");
                        out.println("<b>Timezone:</b> " + timezone + "<br>");
                        out.println("<b>Coordinates:</b> " + loc + "<br>");

                        request.setAttribute("coords", loc);
                        request.setAttribute("ip", ip);
                        request.setAttribute("location", city + ", " + region + ", " + country);
                    } catch (Exception e) {
                        out.println("❌ Error fetching data. Please check the IP address or API token.");
                    }
                } else {
                    out.println("Enter an IP address above to track.");
                }
            
      out.write("\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        <div id=\"map\"></div>\n");
      out.write("    </div>\n");
      out.write("\n");
      out.write("    <script src=\"https://unpkg.com/leaflet/dist/leaflet.js\"></script>\n");
      out.write("    <script>\n");
      out.write("        let map = L.map('map').setView([20, 0], 2);\n");
      out.write("        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {\n");
      out.write("            attribution: '© OpenStreetMap contributors'\n");
      out.write("        }).addTo(map);\n");
      out.write("\n");
      out.write("        ");
 if (request.getAttribute("coords") != null) {
            String coords = (String) request.getAttribute("coords");
            String ipAddr = (String) request.getAttribute("ip");
            String location = (String) request.getAttribute("location");
            String[] parts = coords.split(",");
        
      out.write("\n");
      out.write("            let lat = ");
      out.print( parts[0] );
      out.write(";\n");
      out.write("            let lon = ");
      out.print( parts[1] );
      out.write(";\n");
      out.write("            let marker = L.marker([lat, lon]).addTo(map)\n");
      out.write("                .bindPopup(\"<b>");
      out.print( ipAddr );
      out.write("</b><br>");
      out.print( location );
      out.write("\")\n");
      out.write("                .openPopup();\n");
      out.write("            map.setView([lat, lon], 10);\n");
      out.write("        ");
 } 
      out.write("\n");
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
