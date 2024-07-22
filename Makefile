# venv created with 'uv venv --python /Users/sanjaykapoor/.pyenv/shims/python3.12'
VENV = .venv
PIP = pip
PYTHON = $(VENV)/bin/python3

.PHONY: clean dev install

build:
	./scripts/utils build

dev:
	. $(VENV)/bin/activate
	./bin/app-server --port 9000

install: requirements.txt
	uv pip install -r requirements.txt

clean:
	rm -rf __pycache__
	rm -rf $(VENV)