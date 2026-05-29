# Snakemake Training

![GitHub Codespaces](https://img.shields.io/badge/Codespaces-ready-blue?logo=github)
![Docker](https://img.shields.io/badge/Docker-supported-2496ED?logo=docker&logoColor=white)
![Snakemake](https://img.shields.io/badge/Snakemake-workflow-brightgreen)
![License](https://img.shields.io/badge/license-MIT-green)

Welcome to the **Snakemake training course**!  
This repository contains all materials needed to learn how to build reproducible bioinformatics workflows using Snakemake.

---

## Index:
- [1. Getting Started](#1-getting-started)
- [2. Pre-training Check](#-2-pre-training-check)
- [3. Training Content](#3-training-content)
- [4. RNA-seq Pipeline](#4-rna-seq-pipeline)
- [5. Exercises](#5-exercises)
- [6. Docker Containers](#6-docker-containers)
- [7. Useful Commands](#7-useful-commands)
- [8. Repository Structure](#8-repository-structure)
- [Troubleshooting](#troubleshooting)
- [Instructor Notes](#-instructor-notes)
- [Glossary](#glossary)
- [Resources](#-resources)

---

## 1. Getting Started

You have two options to run this training:

### Option A (Recommended): GitHub Codespaces

No installation required — everything runs in your browser.

#### 1. Access the repository on GitHub:
https://github.com/nicolau/snakemake-training

#### 2. Click **Code** → **Codespaces** → **Create codespace on main branch**
![alt text](resources/images/start_codespace.png)

#### 3. Wait for the environment to build
![alt text](resources/images/ready_to_use.png)

#### 4. In the terminal run:

```bash
conda activate snakemake_training
snakemake --version
```

#### 5. What result is expected:

```bash
9.16.2
```

If this works, you're ready to go.

---

### Option B: Local Docker Setup

Use this if you prefer running locally.

#### 1. Install Docker

- Install Docker Desktop (Windows/Mac) or Docker Engine (Linux) following the instructions at https://www.docker.com/.

#### 2. Clone this repository

In your local machine terminal (MacOS/Linux) or PowerShell (Windows), run:
```bash
git clone https://github.com/nicolau/snakemake-training.git
ls
```

expected result to find snakemake-training folder:
```bash
snakemake-training
```

If you have any problems with permissions to clone the repository, try:
```bash
git config --global --unset credential.helper
```
Then try cloning again.

#### 3. Build a Docker image

```bash
cd snakemake-training/.devcontainer
docker build -t snakemake_image .
```

#### 4. List of Docker images to confirm build

```bash
docker images
```

#### 5. Start a Docker container

```bash
cd ../

docker run -itd -v "$(pwd):/workspace" -w "/workspace" --name snakemake_container snakemake_image:latest /bin/bash
```

#### 6. Access terminal from Docker container
```bash
docker exec -it snakemake_container /bin/bash
```

#### 7. Activate and test Snakemake environment

```bash
conda activate snakemake_training
snakemake --version
```

#### 8. What result is expected:

```bash
9.16.2
```

[Return to Index](#index)

---

## 🧪 2. Pre-training Check

Before starting, make sure everything works.

### Run a test workflow

```bash
cd 01-pre-training-tutorial

cd 01-first-step

snakemake -n results/output.txt
```

Expected result
```bash
host: codespaces-9c361c
Building DAG of jobs...
Job stats:
job           count
----------  -------
first_step        1
total             1


[Fri Apr  3 11:41:43 2026]
rule first_step:
    output: results/output.txt
    jobid: 0
    reason: Missing output files: results/output.txt
    resources: tmpdir=<TBD>
Job stats:
job           count
----------  -------
first_step        1
total             1

Reasons:
    (check individual jobs above for details)
    output files have to be generated:
        first_step
This was a dry-run (flag -n). The order of jobs does not reflect the order of execution.
```

Then execute
```bash
snakemake -j 1 results/output.txt
```
`-j` option is used to specify the number of cores to use for parallel execution. In this case, we set it to 1 to run the workflow sequentially. For local execution this is alias for `--cores` option, so you can also use `--cores 1` or `-c 1` instead of `-j 1`.

Expected result
```bash
Assuming unrestricted shared filesystem usage.
host: codespaces-9c361c
Building DAG of jobs...
Using shell: /usr/bin/bash
Provided cores: 1 (use --cores to define parallelism)
Rules claiming more threads will be scaled down.
Job stats:
job           count
----------  -------
first_step        1
total             1

Select jobs to execute...
Execute 1 jobs...

[Fri Apr  3 11:45:13 2026]
localrule first_step:
    output: results/output.txt
    jobid: 0
    reason: Missing output files: results/output.txt
    resources: tmpdir=/tmp
[Fri Apr  3 11:45:13 2026]
Finished jobid: 0 (Rule: first_step)
1 of 1 steps (100%) done
Complete log(s): /workspaces/snakemake-training/01-pre-training-tutorial/01-first-step/.snakemake/log/2026-04-03T114513.043293.snakemake.log
```

### Generate DAG

```bash
snakemake --dag | dot -Tpdf > dag.pdf
```

👉 Check:
- No errors
- Output files are created
- DAG looks correct

[Return to Index](#index)

---

## 3. Training Content

It will released soon, stay tuned!