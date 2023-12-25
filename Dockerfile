# 默认使用Ubuntu 22.04镜像
ARG BASE_IMAGE=ubuntu:22.04
FROM ${BASE_IMAGE}

# 安装 wget 和其他依赖
RUN apt-get update && \
    apt-get install -y lsb-release wget software-properties-common gnupg && \
    rm -rf /var/lib/apt/lists/*

# 默认使用LLVM 17版本
ARG LLVM_VERSION=17

# 下载并运行 LLVM 安装脚本
# https://apt.llvm.org
RUN wget https://apt.llvm.org/llvm.sh && \
  chmod +x llvm.sh && \
  ./llvm.sh ${LLVM_VERSION} all

# 设置LLVM路径
ENV PATH "/usr/lib/llvm-${LLVM_VERSION}/bin:${PATH}"

# 设置 libclang 路径
RUN echo "/usr/lib/llvm-${LLVM_VERSION}/lib" > /etc/ld.so.conf.d/libclang.conf && ldconfig

# 检查是否存在 clang 可执行文件
RUN clang --version

# 检查是否存在 llvm-config 可执行文件
RUN llvm-config --version

# 输出一些信息以便调试
RUN echo "Checking installed files:" && ls -l /usr/bin && echo "Checking LLVM directory:" && ls -l /usr/lib/llvm-${LLVM_VERSION}/lib
