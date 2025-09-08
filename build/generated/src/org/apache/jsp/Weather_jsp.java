package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class Weather_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("    <title>Weather Dashboard</title>\n");
      out.write("    <link rel=\"preconnect\" href=\"https://fonts.googleapis.com\">\n");
      out.write("    <link rel=\"preconnect\" href=\"https://fonts.gstatic.com\" crossorigin>\n");
      out.write("    <link href=\"https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap\" rel=\"stylesheet\">\n");
      out.write("    <script src=\"https://cdn.tailwindcss.com\"></script>\n");
      out.write("    <style>\n");
      out.write("        body {\n");
      out.write("            font-family: 'Inter', sans-serif;\n");
      out.write("            transition: background-color 0.3s ease, color 0.3s ease;\n");
      out.write("        }\n");
      out.write("        .weather-card, .forecast-card {\n");
      out.write("            background-color: #ffffff;\n");
      out.write("            border-radius: 1rem;\n");
      out.write("            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);\n");
      out.write("            transition: background-color 0.3s ease;\n");
      out.write("        }\n");
      out.write("        .dark .weather-card, .dark .forecast-card {\n");
      out.write("            background-color: #1f2937;\n");
      out.write("        }\n");
      out.write("    </style>\n");
      out.write("</head>\n");
      out.write("<body class=\"bg-gray-100 dark:bg-gray-900 text-gray-900 dark:text-gray-100\">\n");
      out.write("\n");
      out.write("    <div class=\"container mx-auto p-4 md:p-8 max-w-4xl\">\n");
      out.write("        <!-- Header Section -->\n");
      out.write("        <header class=\"text-center mb-8\">\n");
      out.write("            <h1 class=\"text-4xl font-bold mb-2\">Weather Dashboard</h1>\n");
      out.write("            <p class=\"text-lg text-gray-600 dark:text-gray-400\">Get current weather and a 5-day forecast</p>\n");
      out.write("        </header>\n");
      out.write("\n");
      out.write("        <!-- Search Input Section -->\n");
      out.write("        <div class=\"flex flex-col md:flex-row gap-4 mb-8\">\n");
      out.write("            <input type=\"text\" id=\"cityInput\" placeholder=\"Enter a city name...\" class=\"flex-grow p-3 rounded-xl border border-gray-300 dark:border-gray-600 dark:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 transition-colors\">\n");
      out.write("            <button id=\"searchBtn\" class=\"bg-indigo-600 hover:bg-indigo-700 text-white font-semibold py-3 px-6 rounded-xl shadow-md transition-all transform hover:scale-105\">\n");
      out.write("                Search\n");
      out.write("            </button>\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        <!-- Weather Display Section -->\n");
      out.write("        <main id=\"weather-container\" class=\"space-y-8\">\n");
      out.write("            <div id=\"weather-display\" class=\"hidden weather-card p-6 text-center\">\n");
      out.write("                <!-- Current weather data will be dynamically inserted here -->\n");
      out.write("            </div>\n");
      out.write("            <div id=\"forecast-display\" class=\"hidden\">\n");
      out.write("                <h2 class=\"text-2xl font-bold mb-4\">5-Day Forecast</h2>\n");
      out.write("                <div id=\"forecast-grid\" class=\"grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-4\">\n");
      out.write("                    <!-- Forecast data will be dynamically inserted here -->\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("            \n");
      out.write("            <!-- Message/Error Box -->\n");
      out.write("            <div id=\"message-box\" class=\"p-4 rounded-xl text-center bg-blue-100 dark:bg-blue-900 text-blue-800 dark:text-blue-200\">\n");
      out.write("                Enter a city to view its weather.\n");
      out.write("            </div>\n");
      out.write("        </main>\n");
      out.write("    </div>\n");
      out.write("\n");
      out.write("    <script>\n");
      out.write("        const apiKey = 'd48246321a17b5aa15a620ff9b006c7b'; // Your API key\n");
      out.write("        const cityInput = document.getElementById('cityInput');\n");
      out.write("        const searchBtn = document.getElementById('searchBtn');\n");
      out.write("        const weatherDisplay = document.getElementById('weather-display');\n");
      out.write("        const forecastDisplay = document.getElementById('forecast-display');\n");
      out.write("        const forecastGrid = document.getElementById('forecast-grid');\n");
      out.write("        const messageBox = document.getElementById('message-box');\n");
      out.write("        \n");
      out.write("        // Asynchronous function to fetch weather data\n");
      out.write("        async function getWeatherData(city) {\n");
      out.write("            if (!city) {\n");
      out.write("                showMessage('Please enter a city name.', 'bg-yellow-100 dark:bg-yellow-900 text-yellow-800 dark:text-yellow-200');\n");
      out.write("                return;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            const currentWeatherUrl = `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${apiKey}&units=metric`;\n");
      out.write("            const forecastUrl = `https://api.openweathermap.org/data/2.5/forecast?q=${city}&appid=${apiKey}&units=metric`;\n");
      out.write("\n");
      out.write("            showMessage('Fetching weather data...', 'bg-blue-100 dark:bg-blue-900 text-blue-800 dark:text-blue-200');\n");
      out.write("            weatherDisplay.classList.add('hidden');\n");
      out.write("            forecastDisplay.classList.add('hidden');\n");
      out.write("\n");
      out.write("            try {\n");
      out.write("                // Fetch current weather\n");
      out.write("                const weatherResponse = await fetch(currentWeatherUrl);\n");
      out.write("                const weatherData = await weatherResponse.json();\n");
      out.write("                if (weatherData.cod !== 200) {\n");
      out.write("                    throw new Error(weatherData.message);\n");
      out.write("                }\n");
      out.write("                \n");
      out.write("                // Fetch 5-day forecast\n");
      out.write("                const forecastResponse = await fetch(forecastUrl);\n");
      out.write("                const forecastData = await forecastResponse.json();\n");
      out.write("                if (forecastData.cod !== '200') {\n");
      out.write("                    throw new Error(forecastData.message);\n");
      out.write("                }\n");
      out.write("\n");
      out.write("                renderCurrentWeather(weatherData);\n");
      out.write("                renderForecast(forecastData);\n");
      out.write("                \n");
      out.write("                weatherDisplay.classList.remove('hidden');\n");
      out.write("                forecastDisplay.classList.remove('hidden');\n");
      out.write("                messageBox.classList.add('hidden');\n");
      out.write("\n");
      out.write("            } catch (error) {\n");
      out.write("                renderError(`Error: ${error.message}. Please try again.`);\n");
      out.write("            }\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        // Renders the current weather data\n");
      out.write("        function renderCurrentWeather(data) {\n");
      out.write("            const iconCode = data.weather[0].icon;\n");
      out.write("            const iconUrl = `https://openweathermap.org/img/wn/${iconCode}@4x.png`;\n");
      out.write("            \n");
      out.write("            weatherDisplay.innerHTML = `\n");
      out.write("                <div class=\"flex items-center justify-center space-x-4 mb-4\">\n");
      out.write("                    <h3 class=\"text-3xl font-bold\">${data.name}</h3>\n");
      out.write("                    <img src=\"${iconUrl}\" alt=\"${data.weather[0].description}\" class=\"w-16 h-16\">\n");
      out.write("                </div>\n");
      out.write("                <p class=\"text-6xl font-extralight mb-2\">${Math.round(data.main.temp)}°C</p>\n");
      out.write("                <p class=\"text-xl capitalize mb-4\">${data.weather[0].description}</p>\n");
      out.write("                <div class=\"flex justify-center space-x-8 text-sm text-gray-700 dark:text-gray-300\">\n");
      out.write("                    <div>Humidity: ${data.main.humidity}%</div>\n");
      out.write("                    <div>Wind: ${data.wind.speed} m/s</div>\n");
      out.write("                </div>\n");
      out.write("            `;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        // Renders the 5-day forecast data\n");
      out.write("        function renderForecast(data) {\n");
      out.write("            forecastGrid.innerHTML = '';\n");
      out.write("            const dailyData = data.list.filter(item => item.dt_txt.includes('12:00:00'));\n");
      out.write("\n");
      out.write("            dailyData.forEach(day => {\n");
      out.write("                const iconCode = day.weather[0].icon;\n");
      out.write("                const iconUrl = `https://openweathermap.org/img/wn/${iconCode}.png`;\n");
      out.write("                const date = new Date(day.dt * 1000).toLocaleDateString('en-US', { weekday: 'short', month: 'short', day: 'numeric' });\n");
      out.write("\n");
      out.write("                const forecastCard = document.createElement('div');\n");
      out.write("                forecastCard.className = 'forecast-card p-4 text-center';\n");
      out.write("                forecastCard.innerHTML = `\n");
      out.write("                    <h4 class=\"font-bold text-lg\">${date}</h4>\n");
      out.write("                    <img src=\"${iconUrl}\" alt=\"${day.weather[0].description}\" class=\"mx-auto my-2 w-12 h-12\">\n");
      out.write("                    <p class=\"text-2xl font-light\">${Math.round(day.main.temp)}°C</p>\n");
      out.write("                    <p class=\"text-sm capitalize text-gray-600 dark:text-gray-400\">${day.weather[0].description}</p>\n");
      out.write("                `;\n");
      out.write("                forecastGrid.appendChild(forecastCard);\n");
      out.write("            });\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        // Handles displaying messages (e.g., errors, loading)\n");
      out.write("        function showMessage(message, className) {\n");
      out.write("            messageBox.textContent = message;\n");
      out.write("            messageBox.className = `p-4 rounded-xl text-center ${className || 'bg-blue-100 dark:bg-blue-900 text-blue-800 dark:text-blue-200'}`;\n");
      out.write("            messageBox.classList.remove('hidden');\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        // Handles rendering errors\n");
      out.write("        function renderError(message) {\n");
      out.write("            showMessage(message, 'bg-red-100 dark:bg-red-900 text-red-800 dark:text-red-200');\n");
      out.write("            weatherDisplay.classList.add('hidden');\n");
      out.write("            forecastDisplay.classList.add('hidden');\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        // Event listeners\n");
      out.write("        searchBtn.addEventListener('click', () => getWeatherData(cityInput.value));\n");
      out.write("        cityInput.addEventListener('keydown', (e) => {\n");
      out.write("            if (e.key === 'Enter') {\n");
      out.write("                getWeatherData(cityInput.value);\n");
      out.write("            }\n");
      out.write("        });\n");
      out.write("    </script>\n");
      out.write("</body>\n");
      out.write("</html>\n");
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
