FROM python:3.9.7-slim-bullseye

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

WORKDIR /usr/src

ENV PACKAGES="\
    dumb-init \
    make \
    libxml2-dev \
    libxslt-dev \
    libffi-dev \
    gcc \
    musl-dev \
    curl \
    bash \
    git \
    tk-dev \
    tcl-dev \
    g++ \
    gfortran \
    libblas-dev \
    liblapack-dev \
    zlib1g \
    libjpeg-dev \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    "

# Install applications
RUN apt-get update && \
    apt-get install -y ${PACKAGES}

# Install Docker
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN echo \
    "deb [arch=amd64] https://download.docker.com/linux/debian bullseye stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update && \
    apt-get install docker-ce docker-ce-cli containerd.io -y

# Add GCP SDK
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN apt-get install apt-transport-https ca-certificates gnupg curl -y
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add -

# ENV GOOGLE_PACKAGES = "\
#     google-cloud-sdk \
#     google-cloud-sdk-app-engine-python \
#     google-cloud-sdk-app-engine-python-extras \
#     kubectl \
#     "

RUN apt-get update && apt-get install google-cloud-sdk google-cloud-sdk-app-engine-python kubectl -y

ENV PYTHON_PACKAGES="\
    poetry==1.2.2 \
    keyring \
    "

RUN pip install --upgrade pip setuptools
RUN pip install ${PYTHON_PACKAGES}

CMD [ "/bin/bash", "-c" ]