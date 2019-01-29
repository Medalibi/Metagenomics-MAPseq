# Metagenomics-MAPseq
Docker files for Metagenomics Bioinformatics MAPseq session.

## To run the container for the first time with generic graphics:
```
xhost +
docker run -it -v /tmp/.X11-unix:/tmp/.X11-unix:rw -e DISPLAY=unix$DISPLAY \
-v $HOME/:/home/training/ --device /dev/dri --privileged --name mapseq \
ebitraining/metagenomics:mapseq
```
## To run with Nvidia graphics, add the following option:
```
-v /usr/lib/nvidia-340:/usr/lib/nvidia-340 -v /usr/lib32/nvidia-340:/usr/lib32/nvidia-340
```
## To resume using an container:
```
docker exec -it mapseq /bin/bash
```
## To build the container:
```
docker build -f ./Dockerfile -t mapseq .
docker tag mapseq ebitraining/metagenomics:mapseq
docker push ebitraining/metagenomics:mapseq
