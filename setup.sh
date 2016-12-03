# Commands to setup docker container and push data
sudo docker kill opennmt
sudo docker rm opennmt
sudo nvidia-docker run  --name opennmt -d harvardnlp/opennmt:8.0  tail -f /dev/null
sudo docker cp data/de-val-clean.10K.txt opennmt:/root/de-val-clean.10K.txt
sudo docker cp data/en-val-clean.10K.txt opennmt:/root/en-val-clean.10K.txt
sudo docker cp data/de-train-clean.200K.txt opennmt:/root/de-train-clean.200K.txt
sudo docker cp data/en-train-clean.200K.txt opennmt:/root/en-train-clean.200K.txt
