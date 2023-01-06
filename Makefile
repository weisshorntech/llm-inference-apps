SHELL := /usr/bin/env bash

IMAGE := openai-quickstart-fastapi
VERSION := latest


install:
	pip install --upgrade pip
	pip install -r requirements.txt
	
format:
	black $$(git ls-files '*.py')

lint:
	pylint --disable=R,C src/${IMAGE}/*.py

test:
	python -m pytest -vv --cov=$(IMAGE) tests/*.py

all:
	make install format lint test
