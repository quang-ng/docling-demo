# Use official Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy requirements.txt if exists
COPY requirements.txt ./

# Install Python dependencies
RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir --timeout=300 --retries=15 -r requirements.txt

# Install FastAPI, Uvicorn, Docling
RUN pip install --no-cache-dir --timeout=300 --retries=15 fastapi uvicorn docling

# Copy app code
COPY . .

# Expose port
EXPOSE 8000

# Start FastAPI server
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
