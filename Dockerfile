FROM iszagh/cmdstan_python:2

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

RUN apt update && apt install python3-pip -y 

# Install pip requirements
COPY requirements.txt .
RUN /usr/bin/python3 -m pip install -r requirements.txt --break-system-packages

WORKDIR /project
COPY . /project

ENV PROJECT_ROOT=/project