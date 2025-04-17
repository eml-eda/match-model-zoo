The repository contains the Dockers and commands to install match together with the gap-sdk and pulp-sdk to run examples on PULP SoCs.

## PULP DOCKER
Steps to do to set-up the docker:

1. Clone the match repository into a new created repository.
```bash
cd Docker_PULP
mkdir match_pulp_env
cd match_pulp_env
git clone https://github.com/eml-eda/match.git
cd match
git submodule update --init --recursive
```

2. Build the workshop's docker image. There is already a working build script (build.sh) to lunch the Dockerfile build command that download the pulp_toolchain and pulp_sdk:
```bash
cd ../..
source build_{machine}.sh
```
(use build_mac or build_windows, depending on the platform)

3. Run the following command to lunch the docker:
```bash
source run.sh
```

5. Inside the docker, build match
```bash
cd match
make build_tvm_single_core
```

## LAUNCH A NOTEBOOK FROM OENNE REPOSITORY ATTACHED TO THIS DOCKER
1. Launch the Docker with the script:
```bash
source run_notebook.sh
```

2. Open the URL shown in the terminal in your browser (the one with address `http://127.0.0.1:8888/?token=...`) and open the correct notebook


## GAP DOCKER (STILL NOT WORKING)
1. Clone the match repository and the pulp repository into a new created repository.
```bash
mkdir match_pulp_env
cd match_pulp_env
git clone https://github.com/GreenWaves-Technologies/gap_sdk.git
git clone https://github.com/eml-eda/match.git
cd match
git submodule update --init --recursive
```

2. Build the workshop's docker image. There is already a working build script (build.sh) to lunch the Dockerfile build command that download the gap_toolchain:
```bash
cd ../..
source build_{machine}.sh
```
(use build_mac or build_windows, depending on the platform)

3. Run the following command to lunch the docker:
```bash
source run.sh
```

4. Inside the docker, build the gap_sdk:
```bash
cd gap_sdk 
source sourceme.sh 3
make gvsoc
```

5. Inside the docker, build match
```bash
cd .. 
cd match
make build_tvm_single_core
```
