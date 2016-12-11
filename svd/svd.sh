cat ../data/full-train-pos.txt ../data/full-train-neg.txt ../data/test-pos.txt ../data/test-neg.txt > ../data/alldata.txt

python svd.py --size 100 --thr 100 --ns 2 --sppmi 1 --f_in ../data/alldata.txt --f_out svd_vectors.txt

head svd_vectors.txt -n 25000 | awk 'BEGIN{a=0;}{if (a<12500) printf "1 "; else printf "-1 "; for (b=1; b<NF; b++) printf b ":" $(b+1) " "; print ""; a++;}' > full-train.txt
head svd_vectors.txt -n 50000 | tail -n 25000 | awk 'BEGIN{a=0;}{if (a<12500) printf "1 "; else printf "-1 "; for (b=1; b<NF; b++) printf b ":" $(b+1) " "; print ""; a++;}' > test.txt

../liblinear-1.96/train -s 0 full-train.txt model.logreg
../liblinear-1.96/predict -b 1 test.txt model.logreg out.logreg
