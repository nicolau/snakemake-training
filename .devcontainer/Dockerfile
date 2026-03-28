FROM continuumio/miniconda3:latest

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
    graphviz \
    zsh

RUN rm -rf /var/lib/apt/lists/*

COPY environment.yaml /tmp/environment.yaml
RUN conda env create -n snakemake_training -f /tmp/environment.yaml
RUN conda init

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Set theme
RUN sed -i 's/^ZSH_THEME=.*/ZSH_THEME="agnoster"/' ~/.zshrc

RUN chsh -s /bin/zsh vscode

RUN usermod --shell /bin/zsh vscode
