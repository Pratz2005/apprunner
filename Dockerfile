# Use the official Python 3.12 slim image for a smaller, faster build
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install system dependencies if needed (optional, but good to have)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy only requirements first to keep build times low
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of your FastAPI code
COPY . .

# Expose the port App Runner will use
EXPOSE 8080

# Run the app with Uvicorn
# main:app assumes your file is main.py and your FastAPI instance is named 'app'
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]