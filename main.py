
from fastapi import FastAPI, UploadFile, File
from fastapi.responses import PlainTextResponse
import pdfplumber
import io
from docling.document_converter import DocumentConverter
import tempfile


app = FastAPI()


def get_markdown_from_file(file_bytes: bytes) -> str:
    """
    Uses docling to parse file bytes and return markdown.
    """
    with tempfile.NamedTemporaryFile(delete=False) as tmp:
        tmp.write(file_bytes)
        tmp_path = tmp.name
    converter = DocumentConverter()
    result = converter.convert(tmp_path)
    return result.document.export_to_markdown()


@app.post("/markdown", response_class=PlainTextResponse)
async def get_markdown(file: UploadFile = File(...)):
    content = await file.read()
    markdown = get_markdown_from_file(content)
    return markdown
