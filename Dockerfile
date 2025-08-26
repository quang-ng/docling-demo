# Use official Python image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Copy requirements.txt if exists
COPY requirements.txt ./

# Install Python dependencies and FastAPI, Uvicorn, Docling in one layer
RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple \
    && pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir --timeout=300 --retries=15 -r requirements.txt \
    && pip install --no-cache-dir --timeout=300 --retries=15 --upgrade fastapi uvicorn docling \
    && rm -rf /root/.cache/pip

# Copy app code
COPY . .

# Expose port
EXPOSE 8000

# Start FastAPI server
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]