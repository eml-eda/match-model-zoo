# Container for running Vivado on M1/M2 macs
# though it should work equally on Intel macs
FROM ubuntu:22.04
SHELL ["/bin/bash", "-c"]
# Setting values for tzdata
ENV DEBIAN_FRONTEND=noninteractive
# General
RUN apt update && apt upgrade -y
# utility
RUN apt install -y vim
ENV TZ=Europe/Rome

## PULP-toolchain installation
# install gui
RUN DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends --allow-unauthenticated \
autoconf \
automake \
bison \
build-essential \
cmake \
curl \
device-tree-compiler \
doxygen \
flex \
git \
graphicsmagick-libmagick-dev-compat \
graphviz \
gtkwave \
libfdt-dev \
libftdi-dev \
libftdi1 \
libjpeg-dev \
libsamplerate-dev \
libsdl2-dev \
libsdl2-ttf-dev \
libsndfile1-dev \
libtool \
libusb-1.0-0-dev \
ninja-build \
pkg-config \
python3-pip \
qtbase5-dev \
libqt5charts5-dev \
rsync \
sox \
texinfo \
wget \
qt6-base-dev \
libqt6serialport6-dev \
libgl1-mesa-dev \
telnet

# create user "user" with password "pass"
RUN useradd --create-home --shell /bin/bash --user-group --groups adm,sudo user
RUN sh -c 'echo "user:pass" | chpasswd'
# RUN cp -r /root/{.config,.gtkrc-2.0,.asoundrc} /home/user
RUN chown -R user:user /home/user

# Set the locale, because Vivado crashes otherwise
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Without this, XQuartz doesn't display the window correctly
# if it doesn't work, add -Dsun.java2d.pmoffscreen=false, but this breaks something else
ENV JAVA_TOOL_OPTIONS=-Dsun.java2d.xrender=false
ENV JAVA_OPTS=-Dsun.java2d.xrender=false
ENV DISPLAY=host.docker.internal:0

# Set Python to 3.10
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 10

# Clone toolchain
RUN git clone https://github.com/GreenWaves-Technologies/gap_riscv_toolchain_ubuntu.git
RUN apt install -y sudo
RUN mv gap_riscv_toolchain_ubuntu/ gap_riscv_toolchain 
RUN cp -r gap_riscv_toolchain/ /usr/lib/

# Install Python deps (from gap_sdk/install_python_deps.sh)
RUN pip3 install --force-reinstall -v "pip==22.0.3"
RUN pip3 install "markupsafe<2.1"
RUN pip3 install "Jinja2>=2.10.3"
RUN pip3 install "types-Jinja2"
RUN pip3 install "pyelftools>=0.24"
RUN pip3 install "prettytable==0.7.2"
RUN pip3 install "pexpect>=4.0.0,<5"
RUN pip3 install "configparser"
RUN pip3 install "argcomplete"
RUN pip3 install "requests"
RUN pip3 install "six"
RUN pip3 install "kconfiglib"
RUN pip3 install "fdt"
RUN pip3 install "pyserial"
RUN pip3 install "pycryptodome"
RUN pip3 install "protobuf>=3.20.2,<4"
RUN pip3 install "tabulate"
RUN pip3 install "prometheus_client"
RUN pip3 install "tqdm"
RUN pip3 install "pyyaml"
RUN pip3 install "gitlint"
RUN pip3 install "shell_source"
RUN pip3 install "tabulate"
RUN pip3 install "beautifulsoup4>=4.11.1"
RUN pip3 install "hjson>=3.1.0"
RUN pip3 install "html2text>=2020.1.16"
RUN pip3 install "Mako>=1.1.3"
RUN pip3 install "marko>=2.0.3"
RUN pip3 install "matplotlib>=3.8.2"
RUN pip3 install "mistune>=3.0.2"
RUN pip3 install "pandas>=2.2.2"
RUN pip3 install "pexpect>=4.9.0"
RUN pip3 install "prettytable>=0.7.2"
RUN pip3 install "pyelftools>=0.29"
RUN pip3 install "pytablewriter>=1.2.0"
RUN pip3 install "PyYAML>=5.4.1"
RUN pip3 install "PyYAML>=6.0.1"
RUN pip3 install "rich>=13.7.1"
RUN pip3 install "setuptools>=59.6.0"
RUN pip3 install "six>=1.16.0"
RUN pip3 install "pyelftools>=0.24"
RUN pip3 install "argparse>=1.4"
RUN pip3 install "prettytable"
RUN pip3 install "pexpect"
RUN pip3 install "lz4"
RUN pip3 install "pycryptodome"
RUN pip3 install "ppk2_api"
RUN pip3 install "twisted"
RUN pip3 install "prettytable"
RUN pip3 install "psutil"
RUN pip3 install "openpyxl"
RUN pip3 install "xlsxwriter"
RUN pip3 install "Sphinx>=3.0.0,<7.2.0"
RUN pip3 install "sphinx_rtd_theme>=0.5.0"
RUN pip3 install "breathe>=4.13.0"
RUN pip3 install "sphinx-tabs>=3.0.0"
RUN pip3 install "sphinxcontrib-napoleon"
RUN pip3 install "xxhash"
RUN pip3 install "shell_source"
RUN pip3 install "scons"

# fix locale
RUN apt install locales
RUN locale-gen en_US.UTF-8

RUN apt install -y udev
# RUN systemctl restart udev 
# RUN udevadm control --reload-rules || echo "done"
# RUN udevadm trigger
RUN usermod -a -G dialout user

COPY 60-openocd.rules /etc/udev/rules.d/

RUN pip3 install "deprecation"
RUN pip3 install "IPython"
RUN pip3 install "numpy<=1.26.4"
RUN pip3 install "scipy"
RUN pip3 install "scikit-learn"
RUN pip3 install "cmd2"
RUN pip3 install "dataclasses_json"
RUN pip3 install "bitstring"
RUN pip3 install "texttable"

## Match Docker file depencies 
RUN apt install -y python3 python3-pip python3-dev python3-setuptools gcc-11 libtinfo-dev zlib1g-dev build-essential cmake libedit-dev libxml2-dev llvm-14
 
RUN pip3 install "setuptools>=65.5" pyyaml "numpy<2.0" mako typing-extensions psutil scipy decorator attrs pybind11 networkx sympy matplotlib onnx tqdm multiprocessing_on_dill notebook
 
# Setting TVM and Python path environment variables
ENV TVM_HOME=/match/match-tvm
ENV PYTHONPATH="/match:/match/match-tvm/python:/match/zigzag"
ENV TVM_NCORES_INSTALL=4
 
# Create a non-root user with same UID/GID as host user
ARG USER_ID=1000
ARG GROUP_ID=1000
RUN if getent group ${GROUP_ID}; then \
        echo "Group with ID ${GROUP_ID} already exists"; \
        existing_group=$(getent group ${GROUP_ID} | cut -d: -f1); \
        useradd -m -u ${USER_ID} -g ${existing_group} -s /bin/bash matchuser && \
        export USER_GROUP=${existing_group}; \
    else \
        groupadd -g ${GROUP_ID} matchuser && \
        useradd -m -u ${USER_ID} -g matchuser -s /bin/bash matchuser && \
        export USER_GROUP=matchuser; \
    fi && \
    mkdir -p /match /date25-workshop && \
    chown -R matchuser:$(getent group ${GROUP_ID} | cut -d: -f1) /match /date25-workshop

# Set USER command to use the new user
USER matchuser