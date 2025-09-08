package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class VideoStreaming_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("    <title>Video Streaming</title>\n");
      out.write("    <link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\">\n");
      out.write("    <link href=\"https://vjs.zencdn.net/8.10.0/video-js.css\" rel=\"stylesheet\" />\n");
      out.write("    <style>\n");
      out.write("        .video-card {\n");
      out.write("            transition: transform 0.2s;\n");
      out.write("        }\n");
      out.write("        .video-card:hover {\n");
      out.write("            transform: scale(1.05);\n");
      out.write("        }\n");
      out.write("        .thumbnail {\n");
      out.write("            width: 100%;\n");
      out.write("            height: 150px;\n");
      out.write("            object-fit: cover;\n");
      out.write("        }\n");
      out.write("        .video-container {\n");
      out.write("            max-width: 800px;\n");
      out.write("            margin: 0 auto;\n");
      out.write("        }\n");
      out.write("    </style>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("    <div class=\"container my-5\">\n");
      out.write("        <h2 class=\"text-center mb-4\">Video Streaming</h2>\n");
      out.write("\n");
      out.write("        <!-- Choose File Section -->\n");
      out.write("        <div class=\"mb-4\">\n");
      out.write("            <h4>Upload and Play Local Video</h4>\n");
      out.write("            <input type=\"file\" id=\"videoFileInput\" accept=\"video/*\" class=\"form-control mb-2\" />\n");
      out.write("            <button onclick=\"playLocalVideo()\" class=\"btn btn-primary\">Play Selected Video</button>\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        <!-- Video Player Section -->\n");
      out.write("        <div class=\"video-container mb-4\">\n");
      out.write("            <video id=\"videoPlayer\" class=\"video-js vjs-default-skin\" controls preload=\"auto\" width=\"100%\" height=\"auto\">\n");
      out.write("                <source id=\"videoSource\" src=\"\" type=\"video/mp4\">\n");
      out.write("                Your browser does not support the video tag.\n");
      out.write("            </video>\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        <!-- Server-Side Video List Section -->\n");
      out.write("        <h4>Choose a Video from Server</h4>\n");
      out.write("        <div class=\"row\">\n");
      out.write("            <c:forEach var=\"video\" items=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${videoList}", java.lang.String.class, (PageContext)_jspx_page_context, null));
      out.write("\">\n");
      out.write("                <div class=\"col-md-4 mb-4\">\n");
      out.write("                    <div class=\"card video-card\">\n");
      out.write("                        <img src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${video.thumbnailUrl}", java.lang.String.class, (PageContext)_jspx_page_context, null));
      out.write("\" class=\"card-img-top thumbnail\" alt=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${video.title}", java.lang.String.class, (PageContext)_jspx_page_context, null));
      out.write("\">\n");
      out.write("                        <div class=\"card-body\">\n");
      out.write("                            <h5 class=\"card-title\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${video.title}", java.lang.String.class, (PageContext)_jspx_page_context, null));
      out.write("</h5>\n");
      out.write("                            <button onclick=\"playServerVideo('/stream/video?videoId=");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${video.id}", java.lang.String.class, (PageContext)_jspx_page_context, null));
      out.write("')\" class=\"btn btn-primary\">Play</button>\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("            </c:forEach>\n");
      out.write("        </div>\n");
      out.write("    </div>\n");
      out.write("\n");
      out.write("    <script src=\"https://vjs.zencdn.net/8.10.0/video.min.js\"></script>\n");
      out.write("    <script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js\"></script>\n");
      out.write("    <script>\n");
      out.write("        var player = videojs('videoPlayer');\n");
      out.write("        \n");
      out.write("        function playLocalVideo() {\n");
      out.write("            var fileInput = document.getElementById('videoFileInput');\n");
      out.write("            var file = fileInput.files[0];\n");
      out.write("            if (file) {\n");
      out.write("                var videoSource = document.getElementById('videoSource');\n");
      out.write("                videoSource.src = URL.createObjectURL(file);\n");
      out.write("                videoSource.type = file.type;\n");
      out.write("                player.src({ src: videoSource.src, type: videoSource.type });\n");
      out.write("                player.load();\n");
      out.write("                player.play();\n");
      out.write("            } else {\n");
      out.write("                alert('Please select a video file.');\n");
      out.write("            }\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        function playServerVideo(url) {\n");
      out.write("            var videoSource = document.getElementById('videoSource');\n");
      out.write("            videoSource.src = url;\n");
      out.write("            videoSource.type = 'video/mp4';\n");
      out.write("            player.src({ src: url, type: 'video/mp4' });\n");
      out.write("            player.load();\n");
      out.write("            player.play();\n");
      out.write("        }\n");
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
