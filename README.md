# Docling FastAPI Docker Setup

## Build the Docker image

```sh
docker build -t docling-fastapi .
```

## Run the Docker container

```sh
docker run -p 8000:8000 docling-fastapi
```

The FastAPI server will be available at http://localhost:8000

## Live Code Sync in Docker (Development)

To automatically sync code changes with the running container, use a bind mount:

```sh
docker run -p 8000:8000 -v $(pwd):/app docling-fastapi
```

- `-v $(pwd):/app` mounts your local project folder to `/app` in the container.
- Restart the container if you add new dependencies.

## API Usage
- POST `/markdown` with a file to get markdown output using Docling.

## Sample POST Request to /markdown

You can use `curl` to test the API:

```sh
curl -X POST "http://localhost:8000/markdown" \
  -H "accept: text/plain" \
  -H "Content-Type: multipart/form-data" \
  -F "file=@yourfile.pdf"
```

Replace `yourfile.pdf` with the path to your document.

