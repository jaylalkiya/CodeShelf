<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String fullname = (String) session.getAttribute("fullname");
    if (fullname == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Online C Compiler - CodeShelf</title>
    <link rel="icon" href='data:image/svg+xml;utf8,
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="blue" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4"/>
              </svg>'>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.12/codemirror.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.12/theme/dracula.min.css">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background: #f5f7fb;
            color: #333;
        }
        header {
            background: #fff;
            padding: 15px 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        header h1 {
            margin: 0;
            font-size: 20px;
            font-weight: 600;
        }
        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .welcome-message {
            font-weight: 600;
            color: #555;
            font-size: 16px;
        }
        .btn {
            background: #fff;
            color: #4a90e2;
            border: none;
            padding: 8px 15px;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            transition: 0.3s;
            text-decoration: none;
            display: inline-block;
        }
        .btn:hover {
            background: #e3f0ff;
        }
        main {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 20px;
            padding: 20px;
        }
        .editor-box, .io-box {
            background: white;
            border-radius: 12px;
            padding: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }
        .CodeMirror {
            border-radius: 8px;
            height: 400px;
            font-size: 14px;
        }
        textarea {
            width: 100%;
            border-radius: 8px;
            border: 1px solid #ccc;
            padding: 10px;
            font-family: monospace;
            font-size: 14px;
            resize: vertical;
        }
        button.run-btn {
            background: #4a90e2;
            color: white;
            border: none;
            padding: 10px 18px;
            border-radius: 8px;
            font-size: 15px;
            cursor: pointer;
            transition: 0.3s;
            margin-top: 10px;
        }
        button.run-btn:hover {
            background: #357abd;
        }
        pre {
            background: #1e1e1e;
            color: #00ff9d;
            padding: 12px;
            border-radius: 8px;
            font-size: 14px;
            overflow-x: auto;
            white-space: pre-wrap;
            word-wrap: break-word;
        }
        h3 {
            margin-top: 10px;
            font-size: 16px;
        }
    </style>
</head>
<body>
<header>
    <h1>💻 Online C Compiler - CodeShelf</h1>
    <div class="user-info">
        <span class="welcome-message">Welcome, <%= fullname %></span>
        <a href="index.jsp" class="btn">🏠 Dashboard</a>
    </div>
</header>

<main>
    <div class="editor-box">
        <h3>Write Your C Code</h3>
        <textarea id="code">#include <stdio.h>
int main() {
    printf("Hello, World!\n");
    return 0;
}</textarea>
        <button class="run-btn" onclick="runCode()">▶ Run</button>
    </div>

    <div class="io-box">
        <h3>Input</h3>
        <textarea id="input" rows="5" placeholder="Enter program input here..."></textarea>

        <h3>Output</h3>
        <pre id="output">⚡ Output will appear here...</pre>
    </div>
</main>

<script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.12/codemirror.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.12/mode/clike/clike.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.12/addon/edit/closebrackets.min.js"></script>

<script>
    var editor = CodeMirror.fromTextArea(document.getElementById("code"), {
        mode: "text/x-csrc",
        theme: "dracula",
        lineNumbers: true,
        autoCloseBrackets: true,
        matchBrackets: true,
        indentUnit: 4,
        smartIndent: true
    });

    function runCode() {
        const code = editor.getValue();
        const input = document.getElementById("input").value;
        const outputEl = document.getElementById("output");

        outputEl.textContent = "⏳ Running...";

        fetch("<%= request.getContextPath() %>/RunCServlet", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ code: code, input: input })
        })
        .then(res => {
            if (!res.ok) {
                throw new Error("Server returned " + res.status);
            }
            return res.json();
        })
        .then(data => {
            if (data.error) {
                outputEl.textContent = "⚠ Error:\n" + data.error;
            } else {
                outputEl.textContent = data.output;
            }
        })
        .catch(err => {
            outputEl.textContent = "❌ Request failed: " + err.message;
        });
    }
</script>
</body>
</html>
