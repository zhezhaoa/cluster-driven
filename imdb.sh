echo The script is used to illustrate the effectiveness of global information on IMDB dataset, one of the most popular benchmark of sentiment analysis

cd word2vec
gcc word2vec.c -o word2vec -lm -pthread -O3 -march=native -funroll-loops

cat ../data/full-train-pos.txt ../data/full-train-neg.txt ../data/test-pos.txt ../data/test-neg.txt > alldata.txt
awk 'BEGIN{a=0;}{print "_*" a " " $0; a++;}' < alldata.txt > alldata-id.txt
shuf alldata-id.txt > alldata-id-shuf.txt


#As global proportion increases, higher accuracies are obtained
#cbow + pairwise with different global proportions
echo pairwise model
for global in 0.0 0.5 1.0; do
    echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    echo global proportion: $global
    time ./word2vec -train alldata-id-shuf.txt -output vectors.txt -cbow 1 -size 100 -window 5 -negative 5 -positive 30 -hs 0 -sample 1e-3 -threads 4 -binary 0 -iter 30 -min-count 1 -global $global -centric 0 -pairwise 1

    head sentence_vectors.txt -n 25000 | awk 'BEGIN{a=0;}{if (a<12500) printf "1 "; else printf "-1 "; for (b=1; b<NF; b++) printf b ":" $(b+1) " "; print ""; a++;}' > full-train.txt
    head sentence_vectors.txt -n 50000 | tail -n 25000 | awk 'BEGIN{a=0;}{if (a<12500) printf "1 "; else printf "-1 "; for (b=1; b<NF; b++) printf b ":" $(b+1) " "; print ""; a++;}' > test.txt
    ../liblinear-1.96/train -s 0 full-train.txt model.logreg
    ../liblinear-1.96/predict -b 1 test.txt model.logreg out.logreg
done

#cbow + centric with different global proportions
echo centric model
for global in 0.0 0.5 1.0; do
    echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    echo global proportion: $global
    time ./word2vec -train alldata-id-shuf.txt -output vectors.txt -cbow 1 -size 100 -window 5 -negative 5 -hs 0 -sample 1e-3 -threads 4 -binary 0 -iter 20 -min-count 1 -global $global -centric 1 -pairwise 0

    head sentence_vectors.txt -n 25000 | awk 'BEGIN{a=0;}{if (a<12500) printf "1 "; else printf "-1 "; for (b=1; b<NF; b++) printf b ":" $(b+1) " "; print ""; a++;}' > full-train.txt
    head sentence_vectors.txt -n 50000 | tail -n 25000 | awk 'BEGIN{a=0;}{if (a<12500) printf "1 "; else printf "-1 "; for (b=1; b<NF; b++) printf b ":" $(b+1) " "; print ""; a++;}' > test.txt
    ../liblinear-1.96/train -s 0 full-train.txt model.logreg
    ../liblinear-1.96/predict -b 1 test.txt model.logreg out.logreg
done

