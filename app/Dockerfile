FROM python:3.9-slim

COPY ./app/src /app/src
COPY ./app/src/main.py /app/src/main.py
COPY ./app/requirements.txt /app/requirements.txt

WORKDIR /app


ARG OPENAI_API_KEY
ENV OPENAI_API_KEY=$OPENAI_API_KEY
ENV PYTHONPATH=.

RUN pip install --upgrade pip

COPY app/requirements.txt ./requirements.txt
RUN  pip install -r requirements.txt

COPY ./dist/llm-inference-apps-0.0.0.1.tar.gz ./llm-inference-apps-0.0.0.1.tar.gz
RUN  pip install llm-inference-apps-0.0.0.1.tar.gz --upgrade


ENV PORT=8000
EXPOSE 8000

CMD uvicorn --app-dir=src main:app --host 0.0.0.0 --port $PORT --log-level=debug
