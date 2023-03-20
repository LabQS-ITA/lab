FROM docker.io/continuumio/miniconda3 AS dvcbase

RUN conda install -c conda-forge mamba && \
    mamba install -c conda-forge dvc dvc-ssh
