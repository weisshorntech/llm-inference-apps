import os

import openai
from fastapi import FastAPI, Form, Request
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates
from models.davinci import davinci_completion
from prompts.mountains import HEIGHT

openai.api_key = os.environ["OPENAI_API_KEY"]

app = FastAPI()
templates = Jinja2Templates(directory="templates")
app.mount("/static", StaticFiles(directory="static"), name="static")


@app.get("/", response_class=HTMLResponse)
def index(request: Request):
    return templates.TemplateResponse("index.html", {"request": request})


@app.post("/", response_class=HTMLResponse)
async def completion(request: Request, prompt: str = Form(...)):
    response = davinci_completion(prompt=generate_prompt(prompt))
    result = response.choices[0].text
    return templates.TemplateResponse(
        "index.html", {"request": request, "result": result}
    )


def generate_prompt(prompt):
    return HEIGHT.format(prompt.capitalize())


# if __name__ == "__main__":
#     uvicorn.run("main:app", host="127.0.0.1", port=5001, reload=True)
