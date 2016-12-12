head svd_vectors.txt -n 900 | awk 'BEGIN{a=0;}{printf "1 ";for (b=1; b<NF; b++) printf b ":" $(b+1) " "; print ""; a++;}' > full-train1.txt
head svd_vectors.txt -n 1900 | tail -n 900 | awk 'BEGIN{a=0;}{ printf "-1 "; for (b=1; b<NF; b++) printf b ":" $(b+1) " "; print ""; a++;}' > full-train2.txt
cat full-train1.txt full-train2.txt > full-train.txt
head svd_vectors.txt -n 1000 | tail -n 100 | awk 'BEGIN{a=0;}{printf "1 ";  for (b=1; b<NF; b++) printf b ":" $(b+1) " "; print ""; a++;}' > test1.txt
head svd_vectors.txt -n 2000 | tail -n 100 | awk 'BEGIN{a=0;}{printf "-1 ";  for (b=1; b<NF; b++) printf b ":" $(b+1) " "; print ""; a++;}' > test2.txt
cat test1.txt test2.txt > test.txt
../liblinear-1.96/train -s 0 full-train.txt model.logreg
../liblinear-1.96/predict -b 1 test.txt model.logreg out.logreg


head svd_vectors.txt -n 1000 | tail -n 900 | awk 'BEGIN{a=0;}{ printf "1 "; for (b=1; b<NF; b++) printf b ":" $(b+1) " "; print ""; a++;}' > full-train1.txt
head svd_vectors.txt -n 2000 | tail -n 900 | awk 'BEGIN{a=0;}{ printf "-1 "; for (b=1; b<NF; b++) printf b ":" $(b+1) " "; print ""; a++;}' > full-train2.txt
cat full-train1.txt full-train2.txt > full-train.txt
head svd_vectors.txt -n 100 | awk 'BEGIN{a=0;}{printf "1 ";for (b=1; b<NF; b++) printf b ":" $(b+1) " "; print ""; a++;}' > test1.txt
head svd_vectors.txt -n 1100 | tail -n 100 | awk 'BEGIN{a=0;}{printf "-1 ";  for (b=1; b<NF; b++) printf b ":" $(b+1) " "; print ""; a++;}' > test2.txt
cat test1.txt test2.txt > test.txt
../liblinear-1.96/train -s 0 full-train.txt model.logreg
../liblinear-1.96/predict -b 1 test.txt model.logreg out.logreg


for pos in 100 200 300 400 500 600 700 800
do
head svd_vectors.txt -n $pos | awk 'BEGIN{a=0;}{ printf "1 "; for (b=1; b<NF; b++) printf b ":" $(b+1) " "; print ""; a++;}' > full-train1.txt
head svd_vectors.txt -n 1000 | tail -n $((900-$pos)) | awk 'BEGIN{a=0;}{ printf "1 "; for (b=1; b<NF; b++) printf b ":" $(b+1) " "; print ""; a++;}' > full-train2.txt
head svd_vectors.txt -n $((1100+$pos)) | tail -n $pos | awk 'BEGIN{a=0;}{ printf "-1 "; for (b=1; b<NF; b++) printf b ":" $(b+1) " "; print ""; a++;}' > full-train3.txt
head svd_vectors.txt -n 2000 | tail -n $((900-$pos)) | awk 'BEGIN{a=0;}{ printf "-1 "; for (b=1; b<NF; b++) printf b ":" $(b+1) " "; print ""; a++;}' > full-train4.txt
cat full-train1.txt full-train2.txt full-train3.txt full-train4.txt > full-train.txt
head svd_vectors.txt -n $((100+$pos)) | tail -n 100 | awk 'BEGIN{a=0;}{printf "1 ";for (b=1; b<NF; b++) printf b ":" $(b+1) " "; print ""; a++;}' > test1.txt
head svd_vectors.txt -n $((1100+$pos)) | tail -n 100 | awk 'BEGIN{a=0;}{printf "-1 ";  for (b=1; b<NF; b++) printf b ":" $(b+1) " "; print ""; a++;}' > test2.txt
cat test1.txt test2.txt > test.txt
../liblinear-1.96/train -s 0 full-train.txt model.logreg
../liblinear-1.96/predict -b 1 test.txt model.logreg out.logreg
done

