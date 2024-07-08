FROM iszagh/cmdstan_python:2

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# Update apt and install curl to fetch get-pip.py
RUN apt update && apt install -y curl

# Install pip using get-pip.py
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python get-pip.py \
    && rm get-pip.py

# Upgrade pip and setuptools
RUN python -m pip install --upgrade pip setuptools

# Copy the requirements.txt file and print its contents
COPY requirements.txt .
RUN echo "Contents of requirements.txt:" && cat requirements.txt

# Print pip version to ensure it is installed correctly
RUN python -m pip --version

# Install pip requirements
RUN python -m pip install -r requirements.txt

WORKDIR /project
COPY . /project

ENV PROJECT_ROOT=/project
