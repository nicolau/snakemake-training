# Snakemake Training

![GitHub Codespaces](https://img.shields.io/badge/Codespaces-ready-blue?logo=github)
![Docker](https://img.shields.io/badge/Docker-supported-2496ED?logo=docker&logoColor=white)
![Snakemake](https://img.shields.io/badge/Snakemake-workflow-brightgreen)
![License](https://img.shields.io/badge/license-MIT-green)

Welcome to the **Snakemake training course**!  
This repository contains all materials needed to learn how to build reproducible bioinformatics workflows using Snakemake.

---

## 1. Getting Started

You have two options to run this training:

### Option A (Recommended): GitHub Codespaces

No installation required — everything runs in your browser.

1. Click **Code** → **Codespaces** → **Create codespace on main**
2. Wait for the environment to build
3. Open a terminal
4. Run:

```bash
conda activate snakemake_training
snakemake --version
```

5. What result is expected:

```bash
9.16.2
```

If this works, you're ready to go.

---

### Option B: Local Docker Setup

Use this if you prefer running locally.

#### 1. Install Docker
- Install Docker Desktop (Windows/Mac) or Docker Engine (Linux) following https://www.docker.com/.

#### 2. Clone this repository

```bash
git clone https://github.com/nicolau/snakemake_training.git
cd snakemake_training
```

#### 3. Start the container

```bash
docker build -f .devcontainer/Dockerfile -t snakemake_image .
```

```bash
docker run -itd \
  -v $(pwd):/workspace \
  -w /workspace \
  --name snakemake_container \
  snakemake_image:latest /bin/bash
```

```bash
docker exec -it snakemake_container /bin/bash
```

#### 4. Create Snakemake environment

```bash
conda activate snakemake_training
```

#### 5. Verify installation

```bash
snakemake --version
```

---

## 🧪 2. Pre-training Check

Before starting, make sure everything works.

### Run a test workflow

```bash
cd 01-pre-training-tutorial
snakemake -n results/output.txt
snakemake -j 1 results/output.txt
```

### Generate DAG

```bash
snakemake --dag | dot -Tpdf > dag.pdf
```

👉 Check:
- No errors
- Output files are created
- DAG looks correct

---

## 3. Training Content

### 3.1 Basic Snakemake Concepts

You will learn:

- What is a **rule**
- How `input` and `output` work
- How dependencies are inferred
- Introduction to **wildcards**

Example:

- Concatenating two files into one output

---

### 3.2 Different Execution Modes

We will explore:

- `shell:` → simple commands
- `script:` → Python/R scripts
- `wrapper:` → reusable tools

---

### 3.3 Key Concepts

- Rule dependencies
- Wildcards
- Config files
- Logs and resources

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

---

## 6. Useful Commands

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

---

## 7. Repository Structure

```
.
├── pre_training/
├── basic_examples/
├── rnaseq_pipeline/
├── config/
├── data/
└── README.md
```

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

---

## 👨‍🏫 Instructor Notes

- Start simple: one rule, one output
- Let students run something early
- Build complexity gradually
- Encourage experimentation

---

## 📚 Resources

- Snakemake docs: https://snakemake.readthedocs.io
- Snakemake wrappers: https://snakemake-wrappers.readthedocs.io
- Bioconda: https://bioconda.github.io

---

## 🙌 Acknowledgments

This training is designed to introduce reproducible bioinformatics workflows using modern tooling such as:

- Snakemake
- Conda/Mamba
- Docker
- GitHub Codespaces
