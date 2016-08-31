# This is the original version of the codes, which is based on the codes from https://github.com/mesnilgr/iclr15
# We demonstrate the effectiveness of global information on IMDB dataset
# More friendly codes will be released as soon as possible
# When lambda equals to 0, only local information is used. When lambda equals to 1, only global information is used
# Five results are obtained with different lambda (0, 0.25 0.5 0.75 1)
# They should be around 86.95, 88.46, 89.82, 90.39 and 90.65

unzip liblinear-1.96.zip
cd liblinear-1.96
make
cd ..

unzip alldata.txt.zip

gcc word2vec.c -o word2vec -lm -pthread -O3 -march=native -funroll-loops

awk 'BEGIN{a=0;}{print "_*" a " " $0; a++;}' < alldata.txt > alldata-id.txt
shuf alldata-id.txt > alldata-id-shuf.txt

#lambda=0
echo lambda=0
time ./word2vec -train alldata-id-shuf.txt -output vectors.txt -cbow 1 -size 100 -window 5 -negative 5 -hs 0 -sample 1e-3 -threads 8 -binary 0 -iter 20 -min-count 1 -sentence-vectors 0 -avg-vectors 1 -sentence-num 50000 -lambda 0

head avg_vectors.txt -n 25000 | awk 'BEGIN{a=0;}{if (a<12500) printf "1 "; else printf "-1 "; for (b=1; b<NF; b++) printf b ":" $(b+1) " "; print ""; a++;}' > full-train.txt
head avg_vectors.txt -n 50000 | tail -n 25000 | awk 'BEGIN{a=0;}{if (a<12500) printf "1 "; else printf "-1 "; for (b=1; b<NF; b++) printf b ":" $(b+1) " "; print ""; a++;}' > test.txt

./liblinear-1.96/train -s 0 full-train.txt model.logreg
./liblinear-1.96/predict -b 1 test.txt model.logreg out.logreg



#lambda=0.25
echo lambda=0.25
time ./word2vec -train alldata-id-shuf.txt -output vectors.txt -cbow 1 -size 100 -window 5 -negative 5 -hs 0 -sample 1e-3 -threads 8 -binary 0 -iter 20 -min-count 1 -sentence-vectors 0 -avg-vectors 1 -sentence-num 50000 -lambda 0.25

head avg_vectors.txt -n 25000 | awk 'BEGIN{a=0;}{if (a<12500) printf "1 "; else printf "-1 "; for (b=1; b<NF; b++) printf b ":" $(b+1) " "; print ""; a++;}' > full-train.txt
head avg_vectors.txt -n 50000 | tail -n 25000 | awk 'BEGIN{a=0;}{if (a<12500) printf "1 "; else printf "-1 "; for (b=1; b<NF; b++) printf b ":" $(b+1) " "; print ""; a++;}' > test.txt

./liblinear-1.96/train -s 0 full-train.txt model.logreg
./liblinear-1.96/predict -b 1 test.txt model.logreg out.logreg



#lambda=0.5
echo lambda=0.5
time ./word2vec -train alldata-id-shuf.txt -output vectors.txt -cbow 1 -size 100 -window 5 -negative 5 -hs 0 -sample 1e-3 -threads 8 -binary 0 -iter 20 -min-count 1 -sentence-vectors 0 -avg-vectors 1 -sentence-num 50000 -lambda 0.5


head avg_vectors.txt -n 25000 | awk 'BEGIN{a=0;}{if (a<12500) printf "1 "; else printf "-1 "; for (b=1; b<NF; b++) printf b ":" $(b+1) " "; print ""; a++;}' > full-train.txt
head avg_vectors.txt -n 50000 | tail -n 25000 | awk 'BEGIN{a=0;}{if (a<12500) printf "1 "; else printf "-1 "; for (b=1; b<NF; b++) printf b ":" $(b+1) " "; print ""; a++;}' > test.txt

./liblinear-1.96/train -s 0 full-train.txt model.logreg
./liblinear-1.96/predict -b 1 test.txt model.logreg out.logreg



#lambda=0.75
echo lambda=0.75
time ./word2vec -train alldata-id-shuf.txt -output vectors.txt -cbow 1 -size 100 -window 5 -negative 5 -hs 0 -sample 1e-3 -threads 8 -binary 0 -iter 20 -min-count 1 -sentence-vectors 0 -avg-vectors 1 -sentence-num 50000 -lambda 0.75

head avg_vectors.txt -n 25000 | awk 'BEGIN{a=0;}{if (a<12500) printf "1 "; else printf "-1 "; for (b=1; b<NF; b++) printf b ":" $(b+1) " "; print ""; a++;}' > full-train.txt
head avg_vectors.txt -n 50000 | tail -n 25000 | awk 'BEGIN{a=0;}{if (a<12500) printf "1 "; else printf "-1 "; for (b=1; b<NF; b++) printf b ":" $(b+1) " "; print ""; a++;}' > test.txt

./liblinear-1.96/train -s 0 full-train.txt model.logreg
./liblinear-1.96/predict -b 1 test.txt model.logreg out.logreg



#lambda=1
echo lambda=1
time ./word2vec -train alldata-id-shuf.txt -output vectors.txt -cbow 1 -size 100 -window 5 -negative 5 -hs 0 -sample 1e-3 -threads 8 -binary 0 -iter 20 -min-count 1 -sentence-vectors 0 -avg-vectors 1 -sentence-num 50000 -lambda 1

head avg_vectors.txt -n 25000 | awk 'BEGIN{a=0;}{if (a<12500) printf "1 "; else printf "-1 "; for (b=1; b<NF; b++) printf b ":" $(b+1) " "; print ""; a++;}' > full-train.txt
head avg_vectors.txt -n 50000 | tail -n 25000 | awk 'BEGIN{a=0;}{if (a<12500) printf "1 "; else printf "-1 "; for (b=1; b<NF; b++) printf b ":" $(b+1) " "; print ""; a++;}' > test.txt

./liblinear-1.96/train -s 0 full-train.txt model.logreg
./liblinear-1.96/predict -b 1 test.txt model.logreg out.logreg






