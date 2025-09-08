import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import org.json.JSONObject;

public class RunCServlet extends HttpServlet {

    // Helper method to read InputStream into String
    private String readStream(InputStream is) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        byte[] buffer = new byte[1024];
        int len;
        while ((len = is.read(buffer)) != -1) {
            baos.write(buffer, 0, len);
        }
        return baos.toString("UTF-8");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        JSONObject jsonResponse = new JSONObject();

        try {
            // 1. Read request body
            StringBuilder sb = new StringBuilder();
            BufferedReader reader = request.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }

            JSONObject inputJson = new JSONObject(sb.toString());
            String code = inputJson.getString("code");
            String input = inputJson.optString("input", "");

            // 2. Create temp C file
            File tempFile = File.createTempFile("program", ".c");
            try (FileWriter fw = new FileWriter(tempFile)) {
                fw.write(code);
            }

            // 3. Compile with gcc
            String exePath = tempFile.getAbsolutePath() + ".exe"; // for Windows (MinGW)
            ProcessBuilder pbCompile = new ProcessBuilder("gcc", tempFile.getAbsolutePath(), "-o", exePath);
            Process compileProcess = pbCompile.start();
            compileProcess.waitFor();

            if (compileProcess.exitValue() != 0) {
                String error = readStream(compileProcess.getErrorStream());
                jsonResponse.put("error", "Compilation failed:\n" + error);
                out.print(jsonResponse.toString());
                return;
            }

            // 4. Run the program
            ProcessBuilder pbRun = new ProcessBuilder(exePath);
            Process runProcess = pbRun.start();

            // Write input (if any)
            if (!input.isEmpty()) {
                try (OutputStream stdin = runProcess.getOutputStream()) {
                    stdin.write(input.getBytes());
                    stdin.flush();
                }
            }

            runProcess.waitFor();

            // Capture output and errors
            String programOutput = readStream(runProcess.getInputStream());
            String programError = readStream(runProcess.getErrorStream());

            if (!programError.isEmpty()) {
                jsonResponse.put("error", programError);
            } else {
                jsonResponse.put("output", programOutput.isEmpty() ? "No output" : programOutput);
            }

            // 5. Send JSON back
            out.print(jsonResponse.toString());

            // 6. Cleanup
            tempFile.delete();
            new File(exePath).delete();

        } catch (Exception e) {
            try {
                jsonResponse.put("error", "Server error: " + e.getMessage());
            } catch (Exception ignore) {}
            out.print(jsonResponse.toString());
        } finally {
            out.flush();
        }
    }
}

