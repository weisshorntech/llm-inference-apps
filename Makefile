
# IMAGE := llm-inference-apps
APP := app
# VERSION := latest
# IMAGE:= test

install:
	pip install --upgrade pip
	pip install -r requirements-test.txt
	pip install -r ${APP}/requirements.txt

lint:
	pylint --disable=C,E0611,R0903,E1136,W1203 $$(git ls-files '*.py')

format:
	black $$(git ls-files '*.py')

sort:
	isort $$(git ls-files '*.py')

mypy:
	mypy $$(git ls-files '*.py')

testing:
	python -m pytest -vv --cov=${APP}/src tests/*.py

profile-test:
	python -m pytest -vv --durations=1 --durations-min=1.0 --cov=${APP}/src tests/*.py

parallel-test:
	python -m pytest -vv -n auto --dist loadgroup tests/*.py

test: install sort format lint testing

build-pypi:
	pip install --upgrade pip
	pip install build
	python3 -m build 

.PHONY: run-app
run-app:
	uvicorn --app-dir=app/src main:app --host 127.0.0.1 --port 5001 

# Docker
.PHONY: docker
docker:
	@echo Building docker $(IMAGE):$(VERSION) ...
	docker build --build-arg OPENAI_API_KEY=$(OPENAI_API_KEY) \
		-t $(IMAGE):$(VERSION) . \
		-f ./${APP}/Dockerfile


.PHONY: clean_docker
clean_docker:
	@echo Removing docker $(IMAGE):$(VERSION) ...
	docker rmi -f $(IMAGE):$(VERSION)

.PHONY: clean_build
clean_build:
	rm -rf build/

.PHONY: clean
clean: clean_build clean_docker
