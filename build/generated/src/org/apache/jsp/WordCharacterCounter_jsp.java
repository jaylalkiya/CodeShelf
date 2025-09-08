package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class WordCharacterCounter_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("    <title>Word and Character Counter - CodeShelf</title>\n");
      out.write("    <script src=\"https://cdn.tailwindcss.com\"></script>\n");
      out.write("    <link href=\"https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap\" rel=\"stylesheet\">\n");
      out.write("    <style>\n");
      out.write("        body {\n");
      out.write("            font-family: 'Inter', sans-serif;\n");
      out.write("            min-height: 100vh;\n");
      out.write("            display: flex;\n");
      out.write("            flex-direction: column;\n");
      out.write("            background-color: #f8fafc;\n");
      out.write("        }\n");
      out.write("        .container {\n");
      out.write("            flex-grow: 1;\n");
      out.write("        }\n");
      out.write("    </style>\n");
      out.write("</head>\n");
      out.write("<body class=\"bg-gray-100\">\n");
      out.write("\n");
      out.write("    <header class=\"bg-white shadow-sm sticky top-0 z-50\">\n");
      out.write("        <nav class=\"max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-3 flex justify-between items-center\">\n");
      out.write("            <div class=\"flex items-center space-x-2\">\n");
      out.write("                <svg class=\"h-8 w-8 text-blue-600\" fill=\"none\" viewBox=\"0 0 24 24\" stroke=\"currentColor\" stroke-width=\"2\">\n");
      out.write("                    <path stroke-linecap=\"round\" stroke-linejoin=\"round\" d=\"M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z\" />\n");
      out.write("                </svg>\n");
      out.write("                <a href=\"#\" class=\"text-2xl font-bold text-gray-900\">Word Counter</a>\n");
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
      out.write("    <main class=\"container mx-auto px-4 sm:px-6 lg:px-8 py-12 flex flex-col items-center\">\n");
      out.write("        <div class=\"w-full max-w-4xl bg-white p-8 rounded-lg shadow-xl border border-gray-200\">\n");
      out.write("            <h1 class=\"text-3xl sm:text-4xl font-extrabold text-center text-gray-900 mb-6\">\n");
      out.write("                📝 Real-Time Word & Character Counter\n");
      out.write("            </h1>\n");
      out.write("            <p class=\"text-center text-gray-600 mb-8\">\n");
      out.write("                Paste your text below to get instant statistics.\n");
      out.write("            </p>\n");
      out.write("\n");
      out.write("            <textarea\n");
      out.write("                id=\"text-input\"\n");
      out.write("                class=\"w-full h-72 p-6 text-lg border-2 border-gray-300 rounded-lg focus:outline-none focus:border-blue-500 transition-colors resize-y\"\n");
      out.write("                placeholder=\"Type or paste your text here...\"\n");
      out.write("            ></textarea>\n");
      out.write("\n");
      out.write("            <div class=\"mt-8 grid grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-4\">\n");
      out.write("                <div class=\"stat-box bg-blue-50 border border-blue-200 rounded-lg p-4 text-center\">\n");
      out.write("                    <div id=\"word-count\" class=\"text-3xl font-bold text-blue-700\">0</div>\n");
      out.write("                    <div class=\"text-gray-500 font-medium mt-1\">Words</div>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"stat-box bg-purple-50 border border-purple-200 rounded-lg p-4 text-center\">\n");
      out.write("                    <div id=\"char-count\" class=\"text-3xl font-bold text-purple-700\">0</div>\n");
      out.write("                    <div class=\"text-gray-500 font-medium mt-1\">Characters</div>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"stat-box bg-green-50 border border-green-200 rounded-lg p-4 text-center\">\n");
      out.write("                    <div id=\"line-count\" class=\"text-3xl font-bold text-green-700\">0</div>\n");
      out.write("                    <div class=\"text-gray-500 font-medium mt-1\">Lines</div>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"stat-box bg-yellow-50 border border-yellow-200 rounded-lg p-4 text-center\">\n");
      out.write("                    <div id=\"paragraph-count\" class=\"text-3xl font-bold text-yellow-700\">0</div>\n");
      out.write("                    <div class=\"text-gray-500 font-medium mt-1\">Paragraphs</div>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"stat-box bg-red-50 border border-red-200 rounded-lg p-4 text-center\">\n");
      out.write("                    <div id=\"read-time\" class=\"text-3xl font-bold text-red-700\">0</div>\n");
      out.write("                    <div class=\"text-gray-500 font-medium mt-1\">Reading Time (min)</div>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("            <div class=\"mt-8 flex justify-center\">\n");
      out.write("                <button\n");
      out.write("                    id=\"clear-btn\"\n");
      out.write("                    class=\"bg-gray-200 text-gray-700 font-semibold px-6 py-3 rounded-lg hover:bg-gray-300 transition-colors\"\n");
      out.write("                >\n");
      out.write("                    Clear Text\n");
      out.write("                </button>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("    </main>\n");
      out.write("\n");
      out.write("    <footer class=\"bg-white shadow-sm py-4 mt-auto\">\n");
      out.write("        <div class=\"max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center text-sm text-gray-500\">\n");
      out.write("            &copy; 2025 CodeShelf. All rights reserved.\n");
      out.write("        </div>\n");
      out.write("    </footer>\n");
      out.write("\n");
      out.write("    <script>\n");
      out.write("        document.addEventListener('DOMContentLoaded', () => {\n");
      out.write("            const textInput = document.getElementById('text-input');\n");
      out.write("            const clearBtn = document.getElementById('clear-btn');\n");
      out.write("            const wordCountDisplay = document.getElementById('word-count');\n");
      out.write("            const charCountDisplay = document.getElementById('char-count');\n");
      out.write("            const lineCountDisplay = document.getElementById('line-count');\n");
      out.write("            const paragraphCountDisplay = document.getElementById('paragraph-count');\n");
      out.write("            const readTimeDisplay = document.getElementById('read-time');\n");
      out.write("\n");
      out.write("            function updateCounts() {\n");
      out.write("                const text = textInput.value.trim();\n");
      out.write("                \n");
      out.write("                // Character Count\n");
      out.write("                const charCount = text.length;\n");
      out.write("\n");
      out.write("                // Word Count\n");
      out.write("                const words = text.length > 0 ? text.split(/\\s+/).filter(word => word.length > 0) : [];\n");
      out.write("                const wordCount = words.length;\n");
      out.write("\n");
      out.write("                // Line Count\n");
      out.write("                const lineCount = text.length > 0 ? text.split(/\\n/).length : 0;\n");
      out.write("\n");
      out.write("                // Paragraph Count\n");
      out.write("                const paragraphs = text.length > 0 ? text.split(/\\n\\s*\\n/).filter(p => p.trim() !== '') : [];\n");
      out.write("                const paragraphCount = paragraphs.length;\n");
      out.write("\n");
      out.write("                // Reading Time (based on 200 words per minute)\n");
      out.write("                const readTime = wordCount > 0 ? Math.ceil(wordCount / 200) : 0;\n");
      out.write("\n");
      out.write("                wordCountDisplay.textContent = wordCount;\n");
      out.write("                charCountDisplay.textContent = charCount;\n");
      out.write("                lineCountDisplay.textContent = lineCount;\n");
      out.write("                paragraphCountDisplay.textContent = paragraphCount;\n");
      out.write("                readTimeDisplay.textContent = readTime;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            function clearText() {\n");
      out.write("                textInput.value = '';\n");
      out.write("                updateCounts();\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            textInput.addEventListener('input', updateCounts);\n");
      out.write("            clearBtn.addEventListener('click', clearText);\n");
      out.write("\n");
      out.write("            // Initial call to set counts on page load\n");
      out.write("            updateCounts();\n");
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
