FROM python:3.9-slim

RUN useradd -d /home/docker_user -m -s /bin/bash docker_user
USER docker_user

RUN mkdir -p /home/docker_user/workspace
WORKDIR /home/docker_user/workspace

# WORKDIR /app
ARG OPENAI_API_KEY
ENV PATH="${PATH}:/home/docker_user/.local/bin"
ENV IS_DOCKERIZED true
ENV OPENAI_API_KEY=$OPENAI_API_KEY
RUN python3 -m venv ./venv
RUN . ./venv/bin/activate && python3 -m pip install --upgrade pip

COPY app/requirements.txt ./requirements.txt
RUN . ./venv/bin/activate && pip install -r requirements.txt

COPY ./dist/llm-inference-apps-0.0.0.1.tar.gz ./llm-inference-apps-0.0.0.1.tar.gz
RUN  . ./venv/bin/activate && pip install llm-inference-apps-0.0.0.1.tar.gz --upgrade

COPY ./ .
# CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]
CMD  . ./venv/bin/activate && uvicorn --app-dir=app/src main:app --host 0.0.0.0 --port 80
