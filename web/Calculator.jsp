<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Check if the user is logged in
    String fullname = (String) session.getAttribute("fullname");
    if (fullname == null) {
        // If not logged in, redirect to the index page
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CodeShelf - Advanced Calculator</title>
    <link rel="icon" href='data:image/svg+xml;utf8,
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="blue" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4"/>
              </svg>'>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            transition: background-color 0.3s ease;
        }
        .dark {
            background-color: #1a202c;
            color: #e2e8f0;
        }
        .calculator {
            background: #ffffff;
            border-radius: 1.5rem; /* Increased border radius for a softer look */
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
            padding: 2rem;
            max-width: 400px;
            width: 100%;
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        .dark .calculator {
            background: #2d3748;
        }
        .display {
            background: #f0f4f8;
            border-radius: 0.75rem;
            padding: 1.5rem;
            text-align: right;
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            overflow-x: auto;
            white-space: nowrap;
            color: #1f2937;
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        .dark .display {
            background: #4a5568;
            color: #e2e8f0;
        }
        .buttons {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1rem;
        }
        .btn-calc {
            background: #e2e8f0;
            border-radius: 0.75rem;
            padding: 1.5rem;
            font-size: 1.75rem;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.2s ease, transform 0.1s ease;
            text-align: center;
            color: #4a5568;
            user-select: none;
        }
        .dark .btn-calc {
            background: #4a5568;
            color: #e2e8f0;
        }
        .btn-calc:hover {
            background: #cbd5e0;
        }
        .dark .btn-calc:hover {
            background: #6a778e;
        }
        .btn-calc:active {
            transform: scale(0.95);
        }
        .operator {
            background: #4299e1;
            color: white;
        }
        .operator:hover {
            background: #3182ce;
        }
        .dark .operator {
            background: #4299e1;
            color: white;
        }
        .dark .operator:hover {
            background: #3182ce;
        }
        .equal {
            background: #48bb78;
            color: white;
        }
        .equal:hover {
            background: #38a169;
        }
        .dark .equal {
            background: #48bb78;
            color: white;
        }
        .dark .equal:hover {
            background: #38a169;
        }
        .clear {
            background: #f56565;
            color: white;
        }
        .clear:hover {
            background: #e53e3e;
        }
        .dark .clear {
            background: #f56565;
            color: white;
        }
        .dark .clear:hover {
            background: #e53e3e;
        }
        .zero {
            grid-column: span 2;
        }
        .message {
            margin-top: 1.5rem;
            text-align: center;
            font-weight: 600;
            font-size: 1rem;
            opacity: 1;
            transition: opacity 0.3s ease;
        }
        .success { color: #48bb78; }
        .error { color: #f56565; }
        .fade-out {
            opacity: 0;
        }
    </style>
</head>
<body class="bg-gray-100 dark:bg-gray-900 flex flex-col min-h-screen transition-colors duration-300">

    <header class="bg-white dark:bg-gray-800 shadow-sm py-4 px-6 flex justify-between items-center transition-colors duration-300">
        <h1 class="text-2xl font-bold text-gray-900 dark:text-gray-100">🔢 CodeShelf - Calculator</h1>
        <div class="user-info flex items-center space-x-4">
            <span class="text-gray-600 dark:text-gray-400 font-semibold hidden sm:inline">Welcome, <%= fullname %></span>
            <button id="darkModeToggle" class="p-2 rounded-full text-gray-600 dark:text-gray-400 hover:bg-gray-200 dark:hover:bg-gray-700 transition-colors duration-200">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z" />
                </svg>
            </button>
            <a href="index.jsp" class="btn bg-blue-500 hover:bg-blue-600 text-white font-semibold py-2 px-4 rounded-lg shadow-md transition-colors duration-200">
                🏠 Dashboard
            </a>
        </div>
    </header>

    <main class="flex-grow flex items-center justify-center py-12 px-4">
        <div class="calculator dark:text-gray-200">
            <div class="display" id="display">0</div>
            <div class="buttons">
                <div class="btn-calc clear" onclick="clearAll()">AC</div>
                <div class="btn-calc clear" onclick="clearEntry()">C</div>
                <div class="btn-calc operator" onclick="percent()">%</div>
                <div class="btn-calc operator" onclick="setOperator('/')">÷</div>

                <div class="btn-calc" onclick="appendNumber('7')">7</div>
                <div class="btn-calc" onclick="appendNumber('8')">8</div>
                <div class="btn-calc" onclick="appendNumber('9')">9</div>
                <div class="btn-calc operator" onclick="setOperator('*')">×</div>

                <div class="btn-calc" onclick="appendNumber('4')">4</div>
                <div class="btn-calc" onclick="appendNumber('5')">5</div>
                <div class="btn-calc" onclick="appendNumber('6')">6</div>
                <div class="btn-calc operator" onclick="setOperator('-')">-</div>

                <div class="btn-calc" onclick="appendNumber('1')">1</div>
                <div class="btn-calc" onclick="appendNumber('2')">2</div>
                <div class="btn-calc" onclick="appendNumber('3')">3</div>
                <div class="btn-calc operator" onclick="setOperator('+')">+</div>

                <div class="btn-calc zero" onclick="appendNumber('0')">0</div>
                <div class="btn-calc" onclick="appendDecimal('.')">.</div>
                <div class="btn-calc equal" onclick="calculate()">=</div>
            </div>
            <div id="message" class="message" style="display: none;"></div>
        </div>
    </main>

    <script>
        const body = document.body;
        const darkModeToggle = document.getElementById('darkModeToggle');
        const display = document.getElementById('display');
        const messageDiv = document.getElementById('message');

        let currentInput = '0';
        let firstNumber = null;
        let operator = null;
        let waitingForSecondNumber = false;
        let isCalculated = false;

        function updateDisplay() {
            display.textContent = currentInput;
        }

        function appendNumber(number) {
            if (isCalculated) {
                currentInput = number;
                isCalculated = false;
            } else if (waitingForSecondNumber) {
                currentInput = number;
                waitingForSecondNumber = false;
            } else {
                currentInput = currentInput === '0' ? number : currentInput + number;
            }
            updateDisplay();
        }

        function appendDecimal(dot) {
            if (isCalculated) {
                currentInput = '0' + dot;
                isCalculated = false;
            } else if (waitingForSecondNumber) {
                currentInput = '0' + dot;
                waitingForSecondNumber = false;
            } else if (!currentInput.includes(dot)) {
                currentInput += dot;
            }
            updateDisplay();
        }

        function setOperator(op) {
            if (firstNumber === null || waitingForSecondNumber) {
                firstNumber = parseFloat(currentInput);
            } else {
                calculate();
                firstNumber = parseFloat(currentInput);
            }
            operator = op;
            waitingForSecondNumber = true;
            isCalculated = false;
        }

        function calculate() {
            if (operator === null) return;
            const secondNumber = parseFloat(currentInput);
            let result = 0;

            switch (operator) {
                case '+':
                    result = firstNumber + secondNumber;
                    break;
                case '-':
                    result = firstNumber - secondNumber;
                    break;
                case '*':
                    result = firstNumber * secondNumber;
                    break;
                case '/':
                    if (secondNumber === 0) {
                        showMessage("Error: Division by zero", true);
                        currentInput = '0';
                        firstNumber = null;
                        operator = null;
                        waitingForSecondNumber = false;
                        updateDisplay();
                        return;
                    }
                    result = firstNumber / secondNumber;
                    break;
                default:
                    return;
            }

            currentInput = result.toString();
            operator = null;
            waitingForSecondNumber = false;
            isCalculated = true;
            updateDisplay();
            showMessage(`Result: ${result}`, false);
        }

        function clearAll() {
            currentInput = '0';
            firstNumber = null;
            operator = null;
            waitingForSecondNumber = false;
            isCalculated = false;
            updateDisplay();
            showMessage("Cleared!", false);
        }
        
        function clearEntry() {
            currentInput = '0';
            updateDisplay();
        }

        function percent() {
            if (currentInput === '0') return;
            currentInput = (parseFloat(currentInput) / 100).toString();
            updateDisplay();
        }

        function showMessage(text, isError) {
            messageDiv.textContent = text;
            messageDiv.className = `message ${isError ? 'error' : 'success'}`;
            messageDiv.style.display = 'block';
            setTimeout(() => {
                messageDiv.classList.add('fade-out');
                setTimeout(() => {
                    messageDiv.style.display = 'none';
                    messageDiv.classList.remove('fade-out');
                }, 300);
            }, 2000);
        }

        darkModeToggle.addEventListener('click', () => {
            body.classList.toggle('dark');
        });

        // Keyboard Support
        document.addEventListener('keydown', (e) => {
            if (e.key >= '0' && e.key <= '9') appendNumber(e.key);
            else if (e.key === '.') appendDecimal('.');
            else if (['+', '-', '*', '/'].includes(e.key)) setOperator(e.key);
            else if (e.key === 'Enter' || e.key === '=') calculate();
            else if (e.key === 'Escape' || e.key.toLowerCase() === 'ac') clearAll();
            else if (e.key === 'Backspace') clearEntry();
            else if (e.key === '%') percent();
        });

    </script>
</body>
</html>