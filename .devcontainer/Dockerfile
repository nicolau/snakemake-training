FROM continuumio/miniconda3:26.1.1

RUN rm -rf /var/lib/apt/lists/*
RUN apt update -y && apt upgrade -y

RUN apt install -y --no-install-recommends \
    bzip2 \
    git \
    ca-certificates \
    vim \
    htop \
    curl \
    cmake

RUN rm -rf /var/lib/apt/lists/*

COPY environment.yaml /tmp/environment.yaml
#RUN conda create --name snakemake-training --file /tmp/environment.yaml
#RUN conda activate snakemake
