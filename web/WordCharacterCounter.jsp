<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
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
    <title>Word and Character Counter - CodeShelf</title>
   <link rel="shortcut icon" type="image/png" href="images/logo_circle.png">
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            background-color: #f8fafc;
        }
        .container {
            flex-grow: 1;
        }
    </style>
</head>
<body class="bg-gray-100">

    <header class="bg-white shadow-sm sticky top-0 z-50">
        <nav class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-3 flex justify-between items-center">
            <div class="flex items-center space-x-2">
                <svg class="h-8 w-8 text-blue-600" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                </svg>
                <a href="#" class="text-2xl font-bold">
  <span style="background: linear-gradient(to right, #7c3aed, #ec4899, #06b6d4);
               -webkit-background-clip: text;
               -webkit-text-fill-color: transparent;
               display: inline-block;">
    Word Counter
  </span>
</a>

            </div>
            <div class="flex items-center space-x-4">
                <span class="bg-blue-100 text-blue-800 text-sm font-semibold px-3 py-1 rounded-full hidden sm:inline-block">
                    Welcome, <%= fullname%>
                </span>
                <a href="index.jsp" class="nav-link text-white bg-blue-500 px-4 py-2 rounded-md hover:bg-blue-600 transition duration-200 shadow">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 inline-block" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-10v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
                    </svg>
                    <span class="ml-1 hidden md:inline">Dashboard</span>
                </a>
            </div>
        </nav>
    </header>

    <main class="container mx-auto px-4 sm:px-6 lg:px-8 py-12 flex flex-col items-center">
        <div class="w-full max-w-4xl bg-white p-8 rounded-lg shadow-xl border border-gray-200">
            <h1 class="text-3xl sm:text-4xl font-extrabold text-center text-gray-900 mb-6">
                📝 Real-Time Word & Character Counter
            </h1>
            <p class="text-center text-gray-600 mb-8">
                Paste your text below to get instant statistics.
            </p>

            <textarea
                id="text-input"
                class="w-full h-72 p-6 text-lg border-2 border-gray-300 rounded-lg focus:outline-none focus:border-blue-500 transition-colors resize-y"
                placeholder="Type or paste your text here..."
            ></textarea>

            <div class="mt-8 grid grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-4">
                <div class="stat-box bg-blue-50 border border-blue-200 rounded-lg p-4 text-center">
                    <div id="word-count" class="text-3xl font-bold text-blue-700">0</div>
                    <div class="text-gray-500 font-medium mt-1">Words</div>
                </div>
                <div class="stat-box bg-purple-50 border border-purple-200 rounded-lg p-4 text-center">
                    <div id="char-count" class="text-3xl font-bold text-purple-700">0</div>
                    <div class="text-gray-500 font-medium mt-1">Characters</div>
                </div>
                <div class="stat-box bg-green-50 border border-green-200 rounded-lg p-4 text-center">
                    <div id="line-count" class="text-3xl font-bold text-green-700">0</div>
                    <div class="text-gray-500 font-medium mt-1">Lines</div>
                </div>
                <div class="stat-box bg-yellow-50 border border-yellow-200 rounded-lg p-4 text-center">
                    <div id="paragraph-count" class="text-3xl font-bold text-yellow-700">0</div>
                    <div class="text-gray-500 font-medium mt-1">Paragraphs</div>
                </div>
                <div class="stat-box bg-red-50 border border-red-200 rounded-lg p-4 text-center">
                    <div id="read-time" class="text-3xl font-bold text-red-700">0</div>
                    <div class="text-gray-500 font-medium mt-1">Reading Time (min)</div>
                </div>
            </div>

            <div class="mt-8 flex justify-center">
                <button
                    id="clear-btn"
                    class="bg-gray-200 text-gray-700 font-semibold px-6 py-3 rounded-lg hover:bg-gray-300 transition-colors"
                >
                    Clear Text
                </button>
            </div>
        </div>
    </main>

    <footer class="bg-white shadow-sm py-4 mt-auto">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center text-sm text-gray-500">
            &copy; 2025 CodeShelf. All rights reserved.
        </div>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const textInput = document.getElementById('text-input');
            const clearBtn = document.getElementById('clear-btn');
            const wordCountDisplay = document.getElementById('word-count');
            const charCountDisplay = document.getElementById('char-count');
            const lineCountDisplay = document.getElementById('line-count');
            const paragraphCountDisplay = document.getElementById('paragraph-count');
            const readTimeDisplay = document.getElementById('read-time');

            function updateCounts() {
                const text = textInput.value.trim();
                
                // Character Count
                const charCount = text.length;

                // Word Count
                const words = text.length > 0 ? text.split(/\s+/).filter(word => word.length > 0) : [];
                const wordCount = words.length;

                // Line Count
                const lineCount = text.length > 0 ? text.split(/\n/).length : 0;

                // Paragraph Count
                const paragraphs = text.length > 0 ? text.split(/\n\s*\n/).filter(p => p.trim() !== '') : [];
                const paragraphCount = paragraphs.length;

                // Reading Time (based on 200 words per minute)
                const readTime = wordCount > 0 ? Math.ceil(wordCount / 200) : 0;

                wordCountDisplay.textContent = wordCount;
                charCountDisplay.textContent = charCount;
                lineCountDisplay.textContent = lineCount;
                paragraphCountDisplay.textContent = paragraphCount;
                readTimeDisplay.textContent = readTime;
            }

            function clearText() {
                textInput.value = '';
                updateCounts();
            }

            textInput.addEventListener('input', updateCounts);
            clearBtn.addEventListener('click', clearText);

            // Initial call to set counts on page load
            updateCounts();
        });
    </script>
</body>
</html>