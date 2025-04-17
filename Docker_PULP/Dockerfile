# Container for running Vivado on M1/M2 macs
# though it should work equally on Intel macs
FROM ubuntu:22.04
SHELL ["/bin/bash", "-c"]

# Setting values for tzdata
ENV TZ=Europe/Rome
ENV DEBIAN_FRONTEND=noninteractive

# General
RUN apt update && apt upgrade -y
RUN apt-get update
# utility
RUN apt install -y vim git wget unzip

# pulp-sdk installation
# pulp-sdk system dependencies
RUN apt install -y build-essential libftdi-dev libftdi1 doxygen python3-pip libsdl2-dev curl cmake libusb-1.0-0-dev scons gtkwave libsndfile1-dev rsync autoconf automake texinfo libtool pkg-config libsdl2-ttf-dev

# pulp-sdk python dependencies
RUN pip3 install argcomplete pyelftools netron
RUN pip3 install pandas matplotlib seaborn torch torcheval torchinfo torchvision tqdm jupyterlab ipynb onnx git+https://github.com/eml-eda/plinio.git@main#egg=plinio git+https://github.com/eml-eda/pytorch-benchmarks.git@main#egg=pytorch_benchmarks

WORKDIR /
RUN wget https://github.com/pulp-platform/pulp-riscv-gnu-toolchain/releases/download/v1.0.16/v1.0.16-pulp-riscv-gcc-ubuntu-18.tar.bz2
 
RUN tar -xf v1.0.16-pulp-riscv-gcc-ubuntu-18.tar.bz2
RUN rm v1.0.16-pulp-riscv-gcc-ubuntu-18.tar.bz2
RUN mv /v1.0.16-pulp-riscv-gcc-ubuntu-18 /pulp_toolchain
WORKDIR /pulp_toolchain

# Make the sourceme.sh file executable
RUN chmod +x sourceme.sh 
# Source the sourceme.sh file
RUN /bin/bash -c "source sourceme.sh"
WORKDIR /
RUN git clone --recursive https://github.com/pulp-platform/pulp-sdk.git
WORKDIR /pulp-sdk
RUN git submodule update --remote --recursive
RUN rm -r tools/gvsoc
WORKDIR /pulp-sdk/tools
RUN git clone --recursive https://github.com/eml-eda/gvsoc.git
WORKDIR /pulp-sdk
RUN pip3 install argcomplete pyelftools prettytable six mako rich
ENV PULP_RISCV_GCC_TOOLCHAIN=/pulp_toolchain
RUN /bin/bash -c "source configs/pulp-open.sh"
RUN chmod +x configs/pulp-open.sh
 
# build pulp-sdk
RUN pip3 install -r /pulp-sdk/tools/gvsoc/requirements.txt
RUN pip3 install -r /pulp-sdk/tools/gvsoc/gapy/requirements.txt
RUN pip3 install -r /pulp-sdk/tools/gvsoc/core/requirements.txt
RUN cd /pulp_toolchain; source sourceme.sh; cd /pulp-sdk; source configs/pulp-open.sh; make build -j 4
RUN echo "source /pulp-sdk/configs/pulp-open.sh" >> ~/.bashrc

## Match Docker file depencies 
RUN apt install -y python3 python3-pip python3-dev python3-setuptools gcc-11 libtinfo-dev zlib1g-dev build-essential cmake libedit-dev libxml2-dev llvm-14
 
RUN pip3 install "setuptools>=65.5" pyyaml "numpy<2.0" mako typing-extensions psutil scipy decorator attrs pybind11 networkx sympy matplotlib onnx tqdm multiprocessing_on_dill notebook
 
# Setting TVM and Python path environment variables
ENV TVM_HOME=/match_pulp_env/match/match-tvm
ENV PYTHONPATH="/match_pulp_env/match:/match_pulp_env/match/match-tvm/python:/match_pulp_env/match/zigzag"
ENV TVM_NCORES_INSTALL=4

RUN echo 'source /pulp-sdk/configs/pulp-open.sh' >> ~/.bashrc


