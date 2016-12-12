cat ../data/rt2k.pos ../data/rt2k.neg > ../data/rt2k.txt

python svd.py --size 100 --thr 10 --ns 0.3 --sppmi 1 --f_in ../data/rt2k.txt --f_out svd_vectors.txt

./lr_rt2k.sh > output_temp.txt 
python val_acc.py output_temp.txt     

rm output_temp.txt
rm full-train* test*

