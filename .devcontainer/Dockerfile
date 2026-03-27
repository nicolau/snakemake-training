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
    cmake \
    graphviz

RUN rm -rf /var/lib/apt/lists/*

COPY environment.yaml /tmp/environment.yaml
RUN conda env create -n snakemake_training -f /tmp/environment.yaml
RUN conda init
