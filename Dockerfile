FROM python:3.9-slim

# Install system dependencies including Qt and XCB dependencies
RUN apt-get update && apt-get install -y \
    libxcb-cursor0 \
    libxcb-xinerama0 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-randr0 \
    libxcb-render-util0 \
    libxcb-xkb1 \
    libxkbcommon-x11-0 \
    qt5-default \
    && rm -rf /var/lib/apt/lists/*

# Set environment variable to use offscreen rendering
ENV QT_QPA_PLATFORM=offscreen

# Set working directory
WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Command to run the application
CMD ["python", "piranha.py"]

