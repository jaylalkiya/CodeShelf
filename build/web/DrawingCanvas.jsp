<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    <meta name="description" content="CodeShelf's Advanced Drawing Canvas for creating and editing drawings with intuitive tools.">
    <meta name="keywords" content="drawing canvas, CodeShelf, sketch tool, digital art">
    <meta name="author" content="CodeShelf Team">
    <title>CodeShelf - Advanced Drawing Canvas</title>
    <link rel="icon" href='data:image/svg+xml;utf8,
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="blue" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4"/>
              </svg>'>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            transition: background-color 0.3s ease;
        }
        canvas {
            border: 1px solid #e5e7eb;
            background-color: #fff;
            transition: background-color 0.3s ease;
            cursor: crosshair;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            max-width: 100%;
            max-height: 100%;
        }
        .dark canvas {
            border: 1px solid #4b5563;
            background-color: #1f2937;
        }
        [data-tooltip] {
            position: relative;
        }
        [data-tooltip]:hover:after {
            content: attr(data-tooltip);
            position: absolute;
            background-color: #374151;
            color: #fff;
            font-size: 0.75rem;
            border-radius: 0.25rem;
            padding: 0.25rem 0.5rem;
            top: -2.5rem;
            left: 50%;
            transform: translateX(-50%);
            z-index: 10;
            white-space: nowrap;
        }
        .tool-button {
            transition: background-color 0.2s ease, transform 0.2s ease;
        }
        .tool-button:hover {
            transform: scale(1.05);
        }
        .tool-button.active {
            box-shadow: 0 0 0 3px #3b82f6;
            outline: none;
            position: relative;
        }
        .tool-button.active:after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 50%;
            transform: translateX(-50%);
            width: 10px;
            height: 5px;
            background-color: #3b82f6;
            border-radius: 50%;
        }
        @media (max-width: 640px) {
            .sidebar {
                width: 100%;
            }
            .grid-cols-3 {
                grid-template-columns: repeat(auto-fit, minmax(60px, 1fr));
            }
        }
    </style>
</head>
<body class="bg-gray-100 dark:bg-gray-900 text-gray-900 dark:text-gray-100 transition-colors duration-300 min-h-screen flex flex-col">
    <header class="bg-white shadow-sm sticky top-0 z-50 dark:bg-gray-800">
        <nav class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-3 flex justify-between items-center">
            <div class="flex items-center space-x-2">
                <i class="fas fa-paint-brush h-8 w-8 text-blue-600"></i>
                <a href="index.jsp" class="text-2xl font-bold text-gray-900 dark:text-gray-200">Drawing Canvas</a>
            </div>
            <div class="flex items-center space-x-4">
                <span class="bg-blue-100 text-blue-800 text-sm font-semibold px-3 py-1 rounded-full hidden sm:inline-block dark:bg-blue-900 dark:text-blue-300">
                    Welcome, <%= fullname %>
                </span>
                <a href="index.jsp" class="nav-link text-white bg-blue-500 px-4 py-2 rounded-md hover:bg-blue-600 transition duration-200 shadow" aria-label="Back to Dashboard">
                    <i class="fas fa-home h-5 w-5 inline-block"></i>
                    <span class="ml-1 hidden md:inline">Dashboard</span>
                </a>
            </div>
        </nav>
    </header>

    <main class="flex-grow flex flex-col lg:flex-row p-4 sm:p-6 lg:p-8 space-y-6 lg:space-y-0 lg:space-x-6 max-w-7xl mx-auto w-full">
        <div class="sidebar w-full lg:w-64 flex-shrink-0 bg-white dark:bg-gray-800 rounded-lg shadow-lg p-6 flex flex-col space-y-6">
            <h2 class="text-xl font-bold text-gray-800 dark:text-gray-200 mb-2">Drawing Tools</h2>
            <div class="grid grid-cols-3 gap-3">
                <button class="tool-button p-3 rounded-md bg-blue-500 text-white hover:bg-blue-600 flex items-center justify-center" data-tool="brush" data-tooltip="Freehand Brush" aria-label="Freehand Brush" tabindex="0">
                    <i class="fas fa-paint-brush w-6 h-6"></i>
                </button>
                <button class="tool-button p-3 rounded-md bg-red-500 text-white hover:bg-red-600 flex items-center justify-center" data-tool="eraser" data-tooltip="Erase Drawings" aria-label="Erase Drawings" tabindex="0">
                    <i class="fas fa-eraser w-6 h-6"></i>
                </button>
                <button class="tool-button p-3 rounded-md bg-orange-500 text-white hover:bg-orange-600 flex items-center justify-center" data-tool="line" data-tooltip="Draw Line" aria-label="Draw Line" tabindex="0">
                    <i class="fas fa-minus w-6 h-6"></i>
                </button>
                <button class="tool-button p-3 rounded-md bg-green-500 text-white hover:bg-green-600 flex items-center justify-center" data-tool="circle" data-tooltip="Draw Circle" aria-label="Draw Circle" tabindex="0">
                    <i class="fas fa-circle w-6 h-6"></i>
                </button>
                <button class="tool-button p-3 rounded-md bg-purple-500 text-white hover:bg-purple-600 flex items-center justify-center" data-tool="rectangle" data-tooltip="Draw Rectangle" aria-label="Draw Rectangle" tabindex="0">
                    <i class="fas fa-square w-6 h-6"></i>
                </button>
                <button class="tool-button p-3 rounded-md bg-pink-500 text-white hover:bg-pink-600 flex items-center justify-center" data-tool="fill" data-tooltip="Bucket Fill" aria-label="Bucket Fill" tabindex="0">
                    <i class="fas fa-fill-drip w-6 h-6"></i>
                </button>
                <button class="tool-button p-3 rounded-md bg-cyan-500 text-white hover:bg-cyan-600 flex items-center justify-center" data-tool="eyedropper" data-tooltip="Color Picker" aria-label="Color Picker" tabindex="0">
                    <i class="fas fa-eye-dropper w-6 h-6"></i>
                </button>
                <button id="darkModeBtn" class="p-3 rounded-md bg-gray-700 text-white hover:bg-gray-800 flex items-center justify-center" data-tooltip="Toggle Dark Mode" aria-label="Toggle Dark Mode" tabindex="0">
                    <i class="fas fa-moon w-6 h-6"></i>
                </button>
            </div>
            <div class="space-y-4">
                <div class="flex flex-col space-y-2">
                    <label for="colorPicker" class="text-sm font-medium text-gray-700 dark:text-gray-300">Color</label>
                    <input type="color" id="colorPicker" value="#000000" class="w-full h-10 rounded-md border border-gray-300 dark:border-gray-600" aria-label="Select Drawing Color">
                </div>
                <div class="flex flex-col space-y-2">
                    <label for="lineWidth" class="text-sm font-medium text-gray-700 dark:text-gray-300">Brush Size: <span id="brushSizeLabel">5</span>px</label>
                    <input type="range" id="lineWidth" min="1" max="50" value="5" class="w-full" aria-label="Adjust Brush Size">
                    <div id="brushPreview" class="w-8 h-8 rounded-full bg-black mx-auto"></div>
                </div>
                <div class="flex flex-col space-y-2">
                    <label for="brushShape" class="text-sm font-medium text-gray-700 dark:text-gray-300">Brush Shape</label>
                    <select id="brushShape" class="border rounded-md p-2 dark:bg-gray-700 dark:border-gray-600" aria-label="Select Brush Shape">
                        <option value="round">Round</option>
                        <option value="square">Square</option>
                    </select>
                </div>
                <div class="flex flex-col space-y-2">
                    <label for="lineStyle" class="text-sm font-medium text-gray-700 dark:text-gray-300">Line Style</label>
                    <select id="lineStyle" class="border rounded-md p-2 dark:bg-gray-700 dark:border-gray-600" aria-label="Select Line Style">
                        <option value="solid">Solid</option>
                        <option value="dashed">Dashed</option>
                    </select>
                </div>
            </div>
            <div class="flex flex-col space-y-3 pt-4 border-t border-gray-200 dark:border-gray-700">
                <div class="grid grid-cols-2 gap-2">
                    <button onclick="undo()" data-tooltip="Undo Last Action" class="bg-indigo-500 text-white p-3 rounded-md hover:bg-indigo-600 flex items-center justify-center transition-all duration-200" aria-label="Undo Last Action" tabindex="0">
                        <i class="fas fa-undo w-6 h-6"></i>
                    </button>
                    <button onclick="redo()" data-tooltip="Redo Last Action" class="bg-indigo-500 text-white p-3 rounded-md hover:bg-indigo-600 flex items-center justify-center transition-all duration-200" aria-label="Redo Last Action" tabindex="0">
                        <i class="fas fa-redo w-6 h-6"></i>
                    </button>
                </div>
                <button onclick="clearCanvas()" data-tooltip="Clear Canvas" class="bg-gray-500 text-white font-semibold py-3 rounded-md hover:bg-gray-600 transition-colors duration-200" aria-label="Clear Canvas" tabindex="0">Clear Canvas</button>
                <button onclick="saveCanvas()" data-tooltip="Save as PNG" class="bg-blue-600 text-white font-semibold py-3 rounded-md hover:bg-blue-700 transition-colors duration-200" aria-label="Save as PNG" tabindex="0">Save Drawing</button>
            </div>
        </div>
        <div class="flex-grow flex justify-center items-center p-4">
            <div class="relative w-full h-full max-w-full max-h-full">
                <canvas id="drawingCanvas" aria-label="Drawing Canvas"></canvas>
            </div>
        </div>
    </main>

    <footer class="bg-white shadow-sm py-4 mt-auto dark:bg-gray-800">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center text-sm text-gray-500 dark:text-gray-400">
            &copy; 2025 CodeShelf. All rights reserved.
        </div>
    </footer>

                <script>
        const body = document.body;
const canvas = document.getElementById('drawingCanvas');
const ctx = canvas.getContext('2d');
const colorPicker = document.getElementById('colorPicker');
const lineWidthInput = document.getElementById('lineWidth');
const brushSizeLabel = document.getElementById('brushSizeLabel');
const brushPreview = document.getElementById('brushPreview');
const toolButtons = document.querySelectorAll('.tool-button');
const brushShapeSelect = document.getElementById('brushShape');
const lineStyleSelect = document.getElementById('lineStyle');

let isDrawing = false;
let currentTool = 'brush';
let startX, startY;
let undoStack = [];
let redoStack = [];
let drawingData = null;

function init() {
    resizeCanvas();
    ctx.lineCap = 'round';
    ctx.lineJoin = 'round';
    updateDrawingProperties();
    saveState();

    canvas.addEventListener('mousedown', handleMouseDown);
    canvas.addEventListener('mousemove', handleMouseMove);
    canvas.addEventListener('mouseup', handleMouseUp);
    canvas.addEventListener('mouseout', handleMouseUp);
    colorPicker.addEventListener('input', updateDrawingProperties);
    lineWidthInput.addEventListener('input', updateDrawingProperties);
    brushShapeSelect.addEventListener('change', updateDrawingProperties);
    lineStyleSelect.addEventListener('change', updateDrawingProperties);
    document.getElementById('darkModeBtn').addEventListener('click', toggleDarkMode);
    toolButtons.forEach(button => {
        button.addEventListener('click', () => setTool(button.dataset.tool));
        button.addEventListener('keydown', (e) => {
            if (e.key === 'Enter' || e.key === ' ') {
                setTool(button.dataset.tool);
            }
        });
    });
    window.addEventListener('resize', resizeCanvas);

    setTool('brush');
}

function resizeCanvas() {
    const container = canvas.parentElement;
    const maxWidth = container.clientWidth;
    const maxHeight = window.innerHeight - 200; // Account for header/footer
    canvas.width = Math.min(maxWidth, 1000);
    canvas.height = Math.min(maxHeight, 600);
    restoreState(undoStack[undoStack.length - 1]);
}

function setTool(tool) {
    currentTool = tool;
    toolButtons.forEach(btn => btn.classList.remove('active'));
    document.querySelector(`[data-tool="${tool}"]`)?.classList.add('active');

    switch (tool) {
        case 'brush':
        case 'eraser':
        case 'line':
        case 'circle':
        case 'rectangle':
        case 'fill':
        case 'eyedropper':
            canvas.style.cursor = 'crosshair';
            break;
        default:
            canvas.style.cursor = 'default';
    }
    updateDrawingProperties();
}

function updateDrawingProperties() {
    const isDark = body.classList.contains('dark');
    ctx.strokeStyle = currentTool === 'eraser' ? (isDark ? '#1f2937' : '#ffffff') : colorPicker.value;
    ctx.fillStyle = colorPicker.value;
    ctx.lineWidth = lineWidthInput.value;
    ctx.lineCap = brushShapeSelect.value;
    ctx.setLineDash(lineStyleSelect.value === 'dashed' ? [5, 5] : []);

    brushSizeLabel.textContent = lineWidthInput.value;
    brushPreview.style.backgroundColor = colorPicker.value;
    brushPreview.style.width = lineWidthInput.value + 'px';
    brushPreview.style.height = lineWidthInput.value + 'px';
    brushPreview.style.borderRadius = brushShapeSelect.value === 'round' ? '50%' : '0%';
}

function saveState() {
    if (undoStack.length > 50) undoStack.shift();
    undoStack.push(canvas.toDataURL());
    redoStack = [];
}

function restoreState(state) {
    if (!state) return;
    const img = new Image();
    img.src = state;
    img.onload = () => {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        if (body.classList.contains('dark')) {
            ctx.fillStyle = '#1f2937';
            ctx.fillRect(0, 0, canvas.width, canvas.height);
        }
        ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
    };
}

function getAdjustedCoords(e) {
    const rect = canvas.getBoundingClientRect();
    const scaleX = canvas.width / rect.width;
    const scaleY = canvas.height / rect.height;
    return {
        x: (e.clientX - rect.left) * scaleX,
        y: (e.clientY - rect.top) * scaleY
    };
}

function handleMouseDown(e) {
    const { x, y } = getAdjustedCoords(e);
    startX = x;
    startY = y;
    isDrawing = true;

    if (currentTool === 'brush' || currentTool === 'eraser') {
        ctx.beginPath();
        ctx.moveTo(x, y);
    } else if (currentTool === 'eyedropper') {
        pickColor(x, y);
        isDrawing = false;
    } else if (currentTool === 'fill') {
        floodFill(Math.floor(x), Math.floor(y), hexToRgba(colorPicker.value));
        saveState();
        isDrawing = false;
    } else if (['line', 'circle', 'rectangle'].includes(currentTool)) {
        drawingData = ctx.getImageData(0, 0, canvas.width, canvas.height);
    }
}

function handleMouseMove(e) {
    if (!isDrawing) return;
    const { x, y } = getAdjustedCoords(e);

    requestAnimationFrame(() => {
        if (currentTool === 'brush' || currentTool === 'eraser') {
            ctx.lineTo(x, y);
            ctx.stroke();
        } else if (['line', 'circle', 'rectangle'].includes(currentTool)) {
            ctx.putImageData(drawingData, 0, 0);
            ctx.beginPath();
            ctx.strokeStyle = colorPicker.value;
            ctx.lineWidth = lineWidthInput.value;
            ctx.setLineDash(lineStyleSelect.value === 'dashed' ? [5, 5] : []);

            if (currentTool === 'line') {
                ctx.moveTo(startX, startY);
                ctx.lineTo(x, y);
                ctx.stroke();
            } else if (currentTool === 'circle') {
                const radius = Math.sqrt(Math.pow(x - startX, 2) + Math.pow(y - startY, 2));
                ctx.arc(startX, startY, radius, 0, 2 * Math.PI);
                ctx.stroke();
            } else if (currentTool === 'rectangle') {
                ctx.rect(startX, startY, x - startX, y - startY);
                ctx.stroke();
            }
        }
    });
}

function handleMouseUp() {
    if (!isDrawing) return;
    isDrawing = false;
    if (currentTool === 'brush' || currentTool === 'eraser') {
        ctx.closePath();
    }
    saveState();
}

function undo() {
    if (undoStack.length > 1) {
        const state = undoStack.pop();
        redoStack.push(state);
        restoreState(undoStack[undoStack.length - 1]);
    }
}

function redo() {
    if (redoStack.length > 0) {
        const state = redoStack.pop();
        undoStack.push(state);
        restoreState(state);
    }
}

function clearCanvas() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    if (body.classList.contains('dark')) {
        ctx.fillStyle = '#1f2937';
        ctx.fillRect(0, 0, canvas.width, canvas.height);
    }
    saveState();
}

function saveCanvas() {
    const link = document.createElement('a');
    link.download = 'codeshelf_drawing.png';
    link.href = canvas.toDataURL('image/png');
    link.click();
}

function toggleDarkMode() {
    body.classList.toggle('dark');
    clearCanvas();
    restoreState(undoStack[undoStack.length - 1]);
}

function pickColor(x, y) {
    const pixel = ctx.getImageData(x, y, 1, 1).data;
    const hex = '#' + ((1 << 24) + (pixel[0] << 16) + (pixel[1] << 8) + pixel[2]).toString(16).slice(1);
    colorPicker.value = hex;
    updateDrawingProperties();
    setTool('brush');
}

function hexToRgba(hex) {
    const shorthandRegex = /^#?([a-f\d])([a-f\d])([a-f\d])$/i;
    hex = hex.replace(shorthandRegex, (m, r, g, b) => r + r + g + g + b + b);
    const result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
    return result ? {
        r: parseInt(result[1], 16),
        g: parseInt(result[2], 16),
        b: parseInt(result[3], 16),
        a: 255
    } : null;
}

function floodFill(x, y, fillColor) {
    const imageData = ctx.getImageData(0, 0, canvas.width, canvas.height);
    const data = imageData.data;
    const targetColor = getPixel(data, x, y, canvas.width);
    const visited = new Set();
    const stack = [[x, y]];

    if (targetColor.r === fillColor.r && targetColor.g === fillColor.g && targetColor.b === fillColor.b) {
        return;
    }

    while (stack.length) {
        const [cx, cy] = stack.pop();
        const key = `${cx},${cy}`;
        if (visited.has(key) || cx < 0 || cx >= canvas.width || cy < 0 || cy >= canvas.height) {
            continue;
        }
        visited.add(key);

        const currentColor = getPixel(data, cx, cy, canvas.width);
        if (currentColor.r === targetColor.r && currentColor.g === targetColor.g && currentColor.b === targetColor.b) {
            setPixel(data, cx, cy, fillColor, canvas.width);
            stack.push([cx + 1, cy], [cx - 1, cy], [cx, cy + 1], [cx, cy - 1]);
        }
    }
    ctx.putImageData(imageData, 0, 0);
}

function getPixel(data, x, y, width) {
    const index = (y * width + x) * 4;
    return {
        r: data[index],
        g: data[index + 1],
        b: data[index + 2],
        a: data[index + 3]
    };
}

function setPixel(data, x, y, color, width) {
    const index = (y * width + x) * 4;
    data[index] = color.r;
    data[index + 1] = color.g;
    data[index + 2] = color.b;
    data[index + 3] = color.a;
}

window.onload = init;
                </script>
</body>
</html>