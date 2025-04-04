This repository contains the docker to setup the match environment and the gap-sdk.
These are the steps to execute:

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
cd Docker
source build_mac.sh
```
(use build_mac or build_windows, depending on the platform)

3. Run the following command to lunch the docker:
```bash
cp run.sh ../
cd ..
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

## TO DO: STOP HERE FOR NOW
4. Run the following command to start the docker container while mounting the workshop folder and launching Jupyter.
```bash
docker run -it --rm -p 8888:8888 -v ./match:/match -v ./date25-workshop:/date25-workshop \
    -w /date25-workshop match_date25 bash -c " \
    export TVM_HOME=/match/match-tvm && \
    export PYTHONPATH="/match:/match/match-tvm/python:/match/zigzag"
    jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root"
```

5. Open the URL shown in the terminal in your browser (the one with address `http://127.0.0.1:8888/?token=...`) and open the `workshop.ipynb` notebook. If `http://127.0.0.1:8888/?token=...` does not work try ``localhost:8888/?token=...`
