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

#COPY environment.yaml /temp/environment.yaml
#RUN conda create -n snakemake -f /tmp/environment.yaml
#RUN conda activate snakemake
