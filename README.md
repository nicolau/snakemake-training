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

### 3.1 What should you expect to learn?
Imagine you are on an airplane falling toward the ground and the pilot can't fly the plane. You are the only one who can save it, and you have to learn how to fly in 30 minutes with no prior experience. You don't need to know all the possible controls and features to fly the plane using its full aerodynamic potential.

![alt text](resources/images/airplane_controls.png)

Instead, you need to know the basic controls to keep the plane flying and land it safely. This is what we will do with Snakemake, we will learn the basic controls to keep our workflow flying and land it safely.

### 3.2 Reproducibility challenges in bioinformatics
- **Complex dependencies**
Bioinformatics analyses often rely on multiple software tools, libraries, and databases that must work together correctly. Each tool may require specific versions of programming languages, packages, or operating system components. Managing these dependencies manually can be difficult and error-prone, making it challenging to recreate the same computational environment across different machines or over time.

- **Software versions**
Results can vary depending on the version of the software used during the analysis. New releases may introduce bug fixes, algorithmic changes, or different default parameters that affect outputs. Without recording and controlling software versions, it can be impossible for researchers or collaborators to reproduce published results exactly, even when using the same data and workflow.

- **Data management**
Modern biological datasets are often large, complex, and generated from multiple sources. Keeping track of raw data, intermediate files, processed results, and metadata can become difficult as projects grow. Poor data organization increases the risk of using incorrect files, losing important information, or being unable to retrace the steps that led to a particular result.

- **Scalability**
Bioinformatics workflows frequently begin with a small number of samples but later expand to hundreds or thousands. Analyses that work well for a few files may become inefficient, time-consuming, or impossible to manage manually at larger scales. Reproducible workflows must be designed to handle increasing data volumes while maintaining consistency and minimizing manual intervention.

- **Collaboration**
Research projects often involve multiple researchers working across different institutions, operating systems, and computing environments. Differences in software installations, file structures, and analysis procedures can lead to inconsistent results and communication challenges. Reproducible workflows provide a standardized framework that allows collaborators to share, understand, and execute analyses in a consistent and transparent manner.

### 3.3 Introduction to workflow management with Snakemake
- **What is Snakemake?**
Snakemake is a workflow management system designed to create reproducible and scalable data analysis pipelines. It allows users to define analysis steps as a series of rules that specify input files, output files, and commands to be executed. Based on these rules, Snakemake automatically determines the order of execution, manages dependencies between tasks, and ensures that only the necessary steps are run. Originally developed for bioinformatics, Snakemake is now widely used across many scientific disciplines for automating complex computational workflows.

- **Benefits of using Snakemake**
Snakemake provides several advantages over manually executing analysis steps. It automatically tracks dependencies between files and only reruns tasks when inputs have changed, saving both time and computational resources. Workflows are written in a clear and modular format, making them easier to understand, maintain, and share with collaborators. Snakemake also integrates with software management tools such as Conda, Docker, and Singularity, helping ensure reproducibility across different computing environments. Furthermore, it can scale seamlessly from a personal laptop to high-performance computing clusters and cloud platforms.

- **Snakemake vs traditional scripting**
Traditional analysis pipelines are often implemented as shell scripts where commands are executed sequentially. While this approach may work for simple analyses, it becomes difficult to maintain as workflows grow in complexity. Scripts typically require manual tracking of dependencies, rerunning of failed steps, and management of intermediate files. In contrast, Snakemake models workflows as a directed acyclic graph (DAG) of interconnected tasks. This allows the workflow engine to automatically determine which steps need to be executed, parallelize independent tasks, handle failures gracefully, and provide a transparent and reproducible record of the entire analysis process. As a result, Snakemake workflows are generally more robust, scalable, and easier to reproduce than traditional scripting approaches.

### 3.4 Basic Snakemake Concepts
- What is a **rule**
![alt text](resources/images/rule_anatomy.png)
A rule is the fundamental building block of a Snakemake workflow. Each rule represents a single step in the analysis pipeline and describes how to transform one or more input files into one or more output files. A rule typically consists of three main components: the input files required for the analysis step, the output files that will be generated, and the command or script used to perform the transformation. By combining multiple rules, users can define complex workflows while keeping each analysis step modular and easy to understand.

- How `input` and `output` work
- How dependencies are inferred
- Introduction to **wildcards**

Example:

- Concatenating two files into one output

---

### 3.3 Different Execution Modes

We will explore:

- `shell:` → simple commands
- `script:` → Python/R scripts
- `wrapper:` → reusable tools

---

### 3.4 Key Concepts

- Rule dependencies
- Wildcards
- Config files
- Logs and resources

[Return to Index](#index)

---

## 4. RNA-seq Pipeline

You will build a simplified RNA-seq workflow:

1. **Quality Control**
   - FastQC

2. **Read Trimming**
   - Trimmomatic

3. **Quantification**
   - Salmon

4. **Aggregation**
   - Combine results into a count matrix

5. **Reporting**
   - MultiQC

[Return to Index](#index)

---

## 5. Exercises

### Exercise 1
Replace **Trimmomatic** with **fastp**

### Exercise 2
Add:
- FastQC
- MultiQC

### Optional Challenges

- Add new samples
- Use a `config.yaml`
- Add threads/resources
- Convert a rule to a script

[Return to Index](#index)

---

## 6. Docker Containers

This section covers the minimum you need to start a container from an existing image, mount your project files, and run a Snakemake pipeline inside it.

### 6.1 Pull the miniconda3 Image

```bash
docker pull continuumio/miniconda3
```

### 6.2 Start a Container with a Mounted Volume

The `-v` flag mounts a local directory into the container so your files are accessible inside it.

```bash
docker run -itd \
  -v "$(pwd):/workspace" \
  -w "/workspace" \
  --name snakemake_container \
  continuumio/miniconda3 /bin/bash
```

| Flag | Description |
|------|-------------|
| `-it` | Interactive terminal |
| `-d` | Run in the background (detached) |
| `-v "$(pwd):/workspace"` | Mount the current directory to `/workspace` inside the container |
| `-w "/workspace"` | Set the working directory inside the container |
| `--name` | Assign a name to the container |

### 6.3 Enter the Container

```bash
docker exec -it snakemake_container /bin/bash
```

You are now inside the container. Any changes to files under `/workspace` are reflected in your local directory.

### 6.4 Install Snakemake

Inside the container, install Snakemake:

```bash
conda install -n base -c conda-forge -c bioconda snakemake -y
```

Verify the installation:

```bash
snakemake --version
```

### 6.5 Run a Snakemake Pipeline

With your project files available under `/workspace`, run the pipeline:

```bash
# Dry run first to check the workflow
snakemake -n

# Execute the pipeline
snakemake -j 1
```

### 6.6 Stop and Remove the Container

When you are done:

```bash
# Stop the container
docker stop snakemake_container

# Remove the container
docker rm snakemake_container
```

[Return to Index](#index)

---

## 7. Useful Commands

```bash
# Dry run
snakemake -n

# Run workflow
snakemake -j 4

# Print commands
snakemake -p

# Generate DAG
snakemake --dag | dot -Tpdf > dag.pdf

# Force rerun
snakemake -F
```

[Return to Index](#index)

---

## 8. Repository Structure

```
.
├── pre_training/
├── basic_examples/
├── rnaseq_pipeline/
├── config/
├── data/
└── README.md
```

[Return to Index](#index)

---

## Troubleshooting

### Snakemake not found
→ Activate environment:

```bash
micromamba activate snakemake
```

### DAG command fails
→ Install graphviz:

```bash
micromamba install graphviz
```

### Permission issues (Docker)
→ Try:

```bash
chmod -R 777 .
```

[Return to Index](#index)

---

## 👨‍🏫 Instructor Notes

- Start simple: one rule, one output
- Let students run something early
- Build complexity gradually
- Encourage experimentation

[Return to Index](#index)

---

## Glossary

Conda environment command lines:

```bash
# List the conda environment available
conda env list
# Create a new conda environment from a YAML file
conda env create -f environment.yaml
# Activate the conda environment
conda activate snakemake_training
# Deactivate the conda environment
conda deactivate
# Install a package in the current conda environment
conda install package_name
# List installed packages in the current conda environment
conda list
# Remove a conda environment
conda env remove -n snakemake_training
# Update an existing conda environment with a YAML file
conda env update -f environment.yaml
```

[Return to Index](#index)

---

## 📚 Resources

- Snakemake docs: https://snakemake.readthedocs.io
- Snakemake wrappers: https://snakemake-wrappers.readthedocs.io
- Bioconda: https://bioconda.github.io

[Return to Index](#index)

---

## 🙌 Acknowledgments

This training is designed to introduce reproducible bioinformatics workflows using modern tooling such as:

- Snakemake
- Conda/Mamba
- Docker
- GitHub Codespaces

[Return to Index](#index)

Test