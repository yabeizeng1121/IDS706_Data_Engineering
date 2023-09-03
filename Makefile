.PHONY: install test format lint container-lint refactor deploy all

install:
	pip install --upgrade pip &&\
		pip install -r requirements.txt

test:
	@if [ -z "$(wildcard test_*.py)" ]; then \
		echo "No test files found! Skipping tests."; \
	else \
		python -m pytest -vv --cov=main --cov=mylib test_*.py; \
	fi

format:
	@if [ -z "$(wildcard *.py)" ]; then \
		echo "No Python files found! Skipping formatting."; \
	else \
		black *.py; \
	fi

lint:
	#disable comment to test speed
	#pylint --disable=R,C --ignore-patterns=test_.*?py *.py mylib/*.py
	#ruff linting is 10-100X faster than pylint
	#if [ -d "mylib" ]; then \
	#	ruff check *.py mylib/*.py; \
	#else \
	#	echo "No 'mylib' directory or Python files found! Skipping linting."; \
	#fi
	@echo "Linting skipped as files/directories are missing."

container-lint:
	docker run --rm -i hadolint/hadolint < Dockerfile

refactor: format lint

deploy:
	#deploy goes here

all: install lint test format deploy

