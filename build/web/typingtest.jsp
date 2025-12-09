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
    <title>Typing Test - CodeShelf</title>
    <link rel="shortcut icon" type="image/png" href="images/logo_circle.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Inter', sans-serif;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .container {
            max-width: 800px;
            margin-top: 50px;
            flex-grow: 1;
        }
        #text-to-type {
            background-color: #fff;
            border: 1px solid #ced4da;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
            font-size: 18px;
            line-height: 1.5;
            white-space: pre-wrap;
            min-height: 150px;
        }
        #typing-area {
            width: 100%;
            height: 150px;
            font-size: 18px;
            resize: none;
            transition: all 0.3s ease;
        }
        .stats {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        .stat {
            font-size: 20px;
            font-weight: bold;
        }
        .correct {
            color: green;
        }
        .incorrect {
            color: red;
            background-color: #ffdddd;
        }
        .active-char {
            background-color: #e2e6ea;
            border-radius: 2px;
        }
        .active-word {
            border-bottom: 2px solid #007bff;
        }
        #restart-btn {
            margin-top: 20px;
        }
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 2rem;
            background-color: #ffffff;
            border-bottom: 1px solid #e0e0e0;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        }
        .top-bar .logo-title {
            font-weight: 700;
            font-size: 1.5rem;
            color: #343a40;
            text-decoration: none;
        }
        .top-bar .welcome-text {
            color: #495057;
            font-size: 1rem;
        }
        .options-container {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
        }
        .progress-bar-container {
            width: 100%;
            height: 10px;
            background-color: #e9ecef;
            border-radius: 5px;
            margin-bottom: 1rem;
        }
        .progress-bar {
            height: 100%;
            width: 0;
            background-color: #007bff;
            border-radius: 5px;
            transition: width 0.3s ease;
        }
    </style>
</head>
<body>
    <!-- Updated Header -->
    <div class="top-bar">
        <h3 class="text-2xl font-bold">
    <i class="fas fa-keyboard text-blue-400"></i>
    <span style="background: linear-gradient(to right, #7c3aed, #ec4899, #06b6d4); 
                 -webkit-background-clip: text; 
                 -webkit-text-fill-color: transparent; 
                 display: inline-block;">
        CodeShelf Typing Test
    </span>
</h3>

        <div class="welcome-text">
            <span>Welcome, </span>
            <span class="fw-bold text-primary"><%= fullname %></span>
        </div>
        <a href="index.jsp" class="btn btn-primary btn-sm">
            <i class="fas fa-sign-in-alt"></i> Dashboard 
        </a>
        
    </div>

    <div class="container">
        <h1 class="text-center mb-4">Typing Test</h1>
        <p class="text-center text-muted">Type the text below as fast and accurately as possible.</p>
        
        <div class="options-container">
            <select id="duration-select" class="form-select w-auto">
                <option value="60">60s Test</option>
                <option value="30">30s Test</option>
                <option value="120">120s Test</option>
                <option value="0">Text Completion</option>
            </select>
        </div>

        <div class="progress-bar-container">
            <div id="progress-bar" class="progress-bar"></div>
        </div>
        
        <div id="text-to-type" class="text-muted">Loading new text...</div>
        
        <textarea id="typing-area" class="form-control" placeholder="Start typing here..." disabled></textarea>
        
        <div class="stats">
            <div class="stat">Time: <span id="time">0</span>s</div>
            <div class="stat">WPM: <span id="wpm">0</span></div>
            <div class="stat">Accuracy: <span id="accuracy">100</span>%</div>
        </div>
        
        <button id="restart-btn" class="btn btn-primary d-block mx-auto">Restart Test</button>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const staticTexts = [
                "The quick brown fox jumps over the lazy dog.",
                "Programming is the art of telling another human what one wants the computer to do.",
                "In code we trust, but always verify with tests.",
                "Java is to JavaScript what car is to carpet.",
                "public static void main(String[] args) { System.out.println(\"Hello, World!\"); }",
                "Success is not final, failure is not fatal: It is the courage to continue that counts."
            ];

            let currentText = '';
            let typedText = '';
            let startTime = null;
            let timerInterval = null;
            let isTestRunning = false;
            let totalDuration = 60;

            const textDisplay = document.getElementById('text-to-type');
            const typingArea = document.getElementById('typing-area');
            const timeEl = document.getElementById('time');
            const wpmEl = document.getElementById('wpm');
            const accuracyEl = document.getElementById('accuracy');
            const restartBtn = document.getElementById('restart-btn');
            const durationSelect = document.getElementById('duration-select');
            const progressBar = document.getElementById('progress-bar');
            
            function fetchNewText() {
                return staticTexts[Math.floor(Math.random() * staticTexts.length)];
            }

            function initTest() {
                clearInterval(timerInterval);
                typingArea.value = '';
                typingArea.disabled = true;
                typedText = '';
                startTime = null;
                isTestRunning = false;
                
                currentText = fetchNewText();
                
                var htmlContent = '';
                for (var i = 0; i < currentText.length; i++) {
                    var char = currentText.charAt(i);
                    if (char === '<') char = '&lt;';
                    if (char === '>') char = '&gt;';
                    htmlContent += '<span>' + char + '</span>';
                }
                textDisplay.innerHTML = htmlContent;
                
                typingArea.disabled = false;
                typingArea.focus();
                
                updateStats(0, 0, 100);
                highlightText();
                progressBar.style.width = '0%';
            }

            function startTimer() {
                if (!startTime) {
                    startTime = new Date();
                    isTestRunning = true;
                    if (totalDuration > 0) {
                        const endTime = new Date(startTime.getTime() + totalDuration * 1000);
                        timerInterval = setInterval(function() {
                            const now = new Date();
                            const timeElapsed = Math.floor((now - startTime) / 1000);
                            const timeLeft = totalDuration - timeElapsed;
                            timeEl.textContent = timeLeft > 0 ? timeLeft : 0;
                            calculateStats();
                            if (timeLeft <= 0) {
                                endTest();
                            }
                        }, 1000);
                    } else {
                        timerInterval = setInterval(function() {
                            timeEl.textContent = Math.floor((new Date() - startTime) / 1000);
                            calculateStats();
                        }, 1000);
                    }
                }
            }
            
            function endTest() {
                clearInterval(timerInterval);
                typingArea.disabled = true;
                isTestRunning = false;
                calculateStats();
                console.log('Test completed! WPM: ' + wpmEl.textContent + ', Accuracy: ' + accuracyEl.textContent + '%');
            }

            function calculateStats() {
                const elapsedSeconds = Math.floor((new Date() - startTime) / 1000);
                const elapsedMinutes = elapsedSeconds / 60;
                
                let correctChars = 0;
                let typedChars = typedText.length;
                let wordCount = 0;

                for (let i = 0; i < typedChars; i++) {
                    if (currentText[i] === typedText[i]) {
                        correctChars++;
                    }
                    if (typedText[i] === ' ' && currentText[i] === ' ') {
                        wordCount++;
                    }
                }
                
                if (typedChars > 0 && currentText[typedChars - 1] === ' ') {
                    wordCount++;
                }

                const wpm = elapsedMinutes > 0 ? Math.round(wordCount / elapsedMinutes) : 0;
                const accuracy = typedChars > 0 ? Math.round((correctChars / typedChars) * 100) : 100;
                
                wpmEl.textContent = wpm;
                accuracyEl.textContent = accuracy;
                
                const progress = (typedChars / currentText.length) * 100;
                progressBar.style.width = progress + '%';
            }

            function updateStats(time, wpm, accuracy) {
                timeEl.textContent = time;
                wpmEl.textContent = wpm;
                accuracyEl.textContent = accuracy;
            }

            function highlightText() {
                const spans = textDisplay.querySelectorAll('span');
                let wordStart = 0;

                for (let i = 0; i < spans.length; i++) {
                    const span = spans[i];
                    span.classList.remove('correct', 'incorrect', 'active-char');
                    if (i < typedText.length) {
                        if (typedText[i] === currentText[i]) {
                            span.classList.add('correct');
                        } else {
                            span.classList.add('incorrect');
                        }
                    }

                    if (i === typedText.length) {
                        span.classList.add('active-char');
                    }
                }
            }
            
            function checkCompletion() {
                if (typedText === currentText) {
                    endTest();
                }
            }
            
            durationSelect.addEventListener('change', function(e) {
                totalDuration = parseInt(e.target.value);
                initTest();
            });

            typingArea.addEventListener('input', function() {
                if (!isTestRunning) startTimer();
                typedText = typingArea.value;
                highlightText();
                calculateStats();
                checkCompletion();
            });
            
            restartBtn.addEventListener('click', initTest);

            initTest();
        });
    </script>
</body>
</html>
