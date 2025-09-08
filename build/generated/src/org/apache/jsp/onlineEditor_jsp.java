package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class onlineEditor_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("    <meta charset=\"UTF-8\">\n");
      out.write("    <title>Online C Compiler - CodeShelf</title>\n");
      out.write("    <link rel=\"icon\" href='data:image/svg+xml;utf8,\n");
      out.write("              <svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"blue\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\">\n");
      out.write("              <path d=\"M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4\"/>\n");
      out.write("              </svg>'>\n");
      out.write("    <link rel=\"preconnect\" href=\"https://fonts.googleapis.com\">\n");
      out.write("    <link rel=\"preconnect\" href=\"https://fonts.gstatic.com\" crossorigin>\n");
      out.write("    <link href=\"https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap\" rel=\"stylesheet\">\n");
      out.write("    <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.12/codemirror.min.css\">\n");
      out.write("    <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.12/theme/dracula.min.css\">\n");
      out.write("\n");
      out.write("    <style>\n");
      out.write("        body {\n");
      out.write("            font-family: 'Poppins', sans-serif;\n");
      out.write("            margin: 0;\n");
      out.write("            padding: 0;\n");
      out.write("            background: #f5f7fb;\n");
      out.write("            color: #333;\n");
      out.write("        }\n");
      out.write("        header {\n");
      out.write("            background: #fff;\n");
      out.write("            padding: 15px 20px;\n");
      out.write("            box-shadow: 0 2px 8px rgba(0,0,0,0.1);\n");
      out.write("            display: flex;\n");
      out.write("            align-items: center;\n");
      out.write("            justify-content: space-between;\n");
      out.write("        }\n");
      out.write("        header h1 {\n");
      out.write("            margin: 0;\n");
      out.write("            font-size: 20px;\n");
      out.write("            font-weight: 600;\n");
      out.write("        }\n");
      out.write("        .user-info {\n");
      out.write("            display: flex;\n");
      out.write("            align-items: center;\n");
      out.write("            gap: 15px;\n");
      out.write("        }\n");
      out.write("        .welcome-message {\n");
      out.write("            font-weight: 600;\n");
      out.write("            color: #555;\n");
      out.write("            font-size: 16px;\n");
      out.write("        }\n");
      out.write("        .btn {\n");
      out.write("            background: #fff;\n");
      out.write("            color: #4a90e2;\n");
      out.write("            border: none;\n");
      out.write("            padding: 8px 15px;\n");
      out.write("            border-radius: 6px;\n");
      out.write("            font-weight: 600;\n");
      out.write("            cursor: pointer;\n");
      out.write("            transition: 0.3s;\n");
      out.write("            text-decoration: none;\n");
      out.write("            display: inline-block;\n");
      out.write("        }\n");
      out.write("        .btn:hover {\n");
      out.write("            background: #e3f0ff;\n");
      out.write("        }\n");
      out.write("        main {\n");
      out.write("            display: grid;\n");
      out.write("            grid-template-columns: 2fr 1fr;\n");
      out.write("            gap: 20px;\n");
      out.write("            padding: 20px;\n");
      out.write("        }\n");
      out.write("        .editor-box, .io-box {\n");
      out.write("            background: white;\n");
      out.write("            border-radius: 12px;\n");
      out.write("            padding: 15px;\n");
      out.write("            box-shadow: 0 4px 12px rgba(0,0,0,0.08);\n");
      out.write("        }\n");
      out.write("        .CodeMirror {\n");
      out.write("            border-radius: 8px;\n");
      out.write("            height: 400px;\n");
      out.write("            font-size: 14px;\n");
      out.write("        }\n");
      out.write("        textarea {\n");
      out.write("            width: 100%;\n");
      out.write("            border-radius: 8px;\n");
      out.write("            border: 1px solid #ccc;\n");
      out.write("            padding: 10px;\n");
      out.write("            font-family: monospace;\n");
      out.write("            font-size: 14px;\n");
      out.write("            resize: vertical;\n");
      out.write("        }\n");
      out.write("        button.run-btn {\n");
      out.write("            background: #4a90e2;\n");
      out.write("            color: white;\n");
      out.write("            border: none;\n");
      out.write("            padding: 10px 18px;\n");
      out.write("            border-radius: 8px;\n");
      out.write("            font-size: 15px;\n");
      out.write("            cursor: pointer;\n");
      out.write("            transition: 0.3s;\n");
      out.write("            margin-top: 10px;\n");
      out.write("        }\n");
      out.write("        button.run-btn:hover {\n");
      out.write("            background: #357abd;\n");
      out.write("        }\n");
      out.write("        pre {\n");
      out.write("            background: #1e1e1e;\n");
      out.write("            color: #00ff9d;\n");
      out.write("            padding: 12px;\n");
      out.write("            border-radius: 8px;\n");
      out.write("            font-size: 14px;\n");
      out.write("            overflow-x: auto;\n");
      out.write("            white-space: pre-wrap;\n");
      out.write("            word-wrap: break-word;\n");
      out.write("        }\n");
      out.write("        h3 {\n");
      out.write("            margin-top: 10px;\n");
      out.write("            font-size: 16px;\n");
      out.write("        }\n");
      out.write("    </style>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("<header>\n");
      out.write("    <h1>💻 Online C Compiler - CodeShelf</h1>\n");
      out.write("    <div class=\"user-info\">\n");
      out.write("        <span class=\"welcome-message\">Welcome, ");
      out.print( fullname );
      out.write("</span>\n");
      out.write("        <a href=\"index.jsp\" class=\"btn\">🏠 Dashboard</a>\n");
      out.write("    </div>\n");
      out.write("</header>\n");
      out.write("\n");
      out.write("<main>\n");
      out.write("    <div class=\"editor-box\">\n");
      out.write("        <h3>Write Your C Code</h3>\n");
      out.write("        <textarea id=\"code\">#include <stdio.h>\n");
      out.write("int main() {\n");
      out.write("    printf(\"Hello, World!\\n\");\n");
      out.write("    return 0;\n");
      out.write("}</textarea>\n");
      out.write("        <button class=\"run-btn\" onclick=\"runCode()\">▶ Run</button>\n");
      out.write("    </div>\n");
      out.write("\n");
      out.write("    <div class=\"io-box\">\n");
      out.write("        <h3>Input</h3>\n");
      out.write("        <textarea id=\"input\" rows=\"5\" placeholder=\"Enter program input here...\"></textarea>\n");
      out.write("\n");
      out.write("        <h3>Output</h3>\n");
      out.write("        <pre id=\"output\">⚡ Output will appear here...</pre>\n");
      out.write("    </div>\n");
      out.write("</main>\n");
      out.write("\n");
      out.write("<script src=\"https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.12/codemirror.min.js\"></script>\n");
      out.write("<script src=\"https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.12/mode/clike/clike.min.js\"></script>\n");
      out.write("<script src=\"https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.12/addon/edit/closebrackets.min.js\"></script>\n");
      out.write("\n");
      out.write("<script>\n");
      out.write("    var editor = CodeMirror.fromTextArea(document.getElementById(\"code\"), {\n");
      out.write("        mode: \"text/x-csrc\",\n");
      out.write("        theme: \"dracula\",\n");
      out.write("        lineNumbers: true,\n");
      out.write("        autoCloseBrackets: true,\n");
      out.write("        matchBrackets: true,\n");
      out.write("        indentUnit: 4,\n");
      out.write("        smartIndent: true\n");
      out.write("    });\n");
      out.write("\n");
      out.write("    function runCode() {\n");
      out.write("        const code = editor.getValue();\n");
      out.write("        const input = document.getElementById(\"input\").value;\n");
      out.write("        const outputEl = document.getElementById(\"output\");\n");
      out.write("\n");
      out.write("        outputEl.textContent = \"⏳ Running...\";\n");
      out.write("\n");
      out.write("        fetch(\"");
      out.print( request.getContextPath() );
      out.write("/RunCServlet\", {\n");
      out.write("            method: \"POST\",\n");
      out.write("            headers: { \"Content-Type\": \"application/json\" },\n");
      out.write("            body: JSON.stringify({ code: code, input: input })\n");
      out.write("        })\n");
      out.write("        .then(res => {\n");
      out.write("            if (!res.ok) {\n");
      out.write("                throw new Error(\"Server returned \" + res.status);\n");
      out.write("            }\n");
      out.write("            return res.json();\n");
      out.write("        })\n");
      out.write("        .then(data => {\n");
      out.write("            if (data.error) {\n");
      out.write("                outputEl.textContent = \"⚠ Error:\\n\" + data.error;\n");
      out.write("            } else {\n");
      out.write("                outputEl.textContent = data.output;\n");
      out.write("            }\n");
      out.write("        })\n");
      out.write("        .catch(err => {\n");
      out.write("            outputEl.textContent = \"❌ Request failed: \" + err.message;\n");
      out.write("        });\n");
      out.write("    }\n");
      out.write("</script>\n");
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
