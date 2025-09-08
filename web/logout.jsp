<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logging Out...</title>
    <link rel="icon" href='data:image/svg+xml;utf8,
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="blue" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4"/>
              </svg>'>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
        }
        .modal {
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.85);
            backdrop-filter: blur(10px);
            display: flex;
            justify-content: center;
            align-items: center;
            opacity: 0;
            transition: opacity 0.3s ease;
        }
        .modal.is-visible {
            opacity: 1;
        }
        .modal-content {
            background-color: #ffffff;
            padding: 2rem;
            border-radius: 1rem;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            max-width: 90%;
            width: 450px;
            text-align: center;
            transform: scale(0.7);
            transition: transform 0.3s ease;
        }
        .modal.is-visible .modal-content {
            transform: scale(1);
        }
    </style>
</head>
<body class="bg-gray-50">

    <%
        // Invalidate the session to log the user out
        session.invalidate();
    %>

    <div id="logoutConfirmationModal" class="modal is-visible" aria-labelledby="logoutConfirmationTitle">
        <div class="modal-content">
            <h2 id="logoutConfirmationTitle" class="text-2xl font-bold text-gray-900 mb-4">You've been logged out</h2>
            <p class="text-gray-600 mb-6">Thank you for visiting CodeShelf. Come back soon!</p>
            <button onclick="window.location.href='index.jsp';" class="w-full bg-blue-600 text-white py-3 rounded-lg font-semibold hover:bg-blue-700 transition">Go to Homepage</button>
        </div>
    </div>

    <script>
        // The modal is already set to be visible by default.
        // If you wanted to add a delay before redirecting, you could use setTimeout here.
        // For example, to redirect after 5 seconds:
        // setTimeout(function() {
        //     window.location.href = 'index.jsp';
        // }, 5000);
    </script>
</body>
</html>