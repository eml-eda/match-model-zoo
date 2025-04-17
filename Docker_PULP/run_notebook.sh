#!/bin/zsh
docker run -it --rm -p 8888:8888 -v ./match_pulp_env:/match_pulp_env -v "$(realpath ../../oenne)":/oenne  -w /oenne match_pulp bash -c "jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root"
