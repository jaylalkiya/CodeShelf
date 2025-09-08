package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class iptracker_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      response.setContentType("text/html;charset=UTF-8");
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
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("    <title>IP Address Tracker</title>\n");
      out.write("    <script src=\"https://unpkg.com/leaflet/dist/leaflet.js\"></script>\n");
      out.write("    <link rel=\"stylesheet\" href=\"https://unpkg.com/leaflet/dist/leaflet.css\" />\n");
      out.write("\n");
      out.write("    <style>\n");
      out.write("        body {\n");
      out.write("            font-family: Arial, sans-serif;\n");
      out.write("            text-align: center;\n");
      out.write("            margin: 20px;\n");
      out.write("        }\n");
      out.write("        #map {\n");
      out.write("            height: 400px;\n");
      out.write("            width: 80%;\n");
      out.write("            margin: 20px auto;\n");
      out.write("            border: 1px solid #ccc;\n");
      out.write("            border-radius: 8px;\n");
      out.write("        }\n");
      out.write("        .info-box {\n");
      out.write("            margin-top: 15px;\n");
      out.write("            padding: 10px;\n");
      out.write("            background: #f9f9f9;\n");
      out.write("            border: 1px solid #ddd;\n");
      out.write("            width: 60%;\n");
      out.write("            margin-left: auto;\n");
      out.write("            margin-right: auto;\n");
      out.write("            border-radius: 8px;\n");
      out.write("        }\n");
      out.write("        input {\n");
      out.write("            padding: 8px;\n");
      out.write("            width: 250px;\n");
      out.write("        }\n");
      out.write("        button {\n");
      out.write("            padding: 8px 12px;\n");
      out.write("            margin-left: 5px;\n");
      out.write("            cursor: pointer;\n");
      out.write("        }\n");
      out.write("    </style>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("    <h2>🔎 IP Address Tracker</h2>\n");
      out.write("    <form action=\"tracker.jsp\" method=\"get\">\n");
      out.write("        <input type=\"text\" name=\"ip\" placeholder=\"Enter IP address (e.g. 8.8.8.8)\" required />\n");
      out.write("        <button type=\"submit\">Track IP</button>\n");
      out.write("    </form>\n");
      out.write("\n");
      out.write("    <div class=\"info-box\">\n");
      out.write("        ");
 
            String ip = request.getParameter("ip");
            if (ip != null && !ip.isEmpty()) {
        
      out.write("\n");
      out.write("            <h3>Results for: ");
      out.print( ip );
      out.write("</h3>\n");
      out.write("            <iframe src=\"tracker.jsp?ip=");
      out.print( ip );
      out.write("\" style=\"width:100%; height:500px; border:none;\"></iframe>\n");
      out.write("        ");
 } else { 
      out.write("\n");
      out.write("            <p>Enter an IP address above to see details.</p>\n");
      out.write("        ");
 } 
      out.write("\n");
      out.write("    </div>\n");
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
