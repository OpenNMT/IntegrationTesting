# Commands run in the raw docker container.
git clone "http://github.com/opennmt/opennmt" && cd opennmt && th preprocess.lua -train_src_file ../../de-train-clean.200K.txt -train_targ_file ../../en-train-clean.200K.txt  -valid_src_file ../../de-val-clean.10K.txt -valid_targ_file ../../en-val-clean.10K.txt -output_file data/demo && th train.lua -data data/demo-train.t7 -save_file demo-model -gpuid 1 -print_every 50 -epochs 8