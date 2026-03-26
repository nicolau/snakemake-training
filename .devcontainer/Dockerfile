FROM continuumio/miniconda3

RUN apt update && apt upgrade -y && apt install -y --no-install-recomends \
    curl bzip2 ca-certificates git vim htop \
    && rm -rf /var/lib/apt/lists/*

COPY environment.yaml /temp/environment.yaml
RUN conda create -n snakemake -f /tmp/envirnment.yaml
RUN conda activate snakemake
