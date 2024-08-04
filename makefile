default:
	cat Makefile

setup: 
	python3 -m venv env 
	./env/bin/pip install --upgrade pip 
	./env/bin/pip install -r requirements.txt

jupyterlab: setup
	source env/bin/activate && jupyter lab
