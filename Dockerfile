# 使用官方 Ubuntu 镜像作为基础
FROM ubuntu:latest

# 安装基本依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    clang \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# 安装poetry
RUN pip install poetry
