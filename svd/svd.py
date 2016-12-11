import os
import pdb
import numpy as np
import argparse
from collections import Counter
import scipy.sparse
from sparsesvd import sparsesvd
import argparse


def build_dict(f, thr):
    dic = Counter()
    text_num = 0 # the number of texts (or lines)
    for sentence in open(f).xreadlines():
        dic.update(sentence.split())
        text_num += 1
    alltokens = dic.keys()
    for i in alltokens:
        if dic[i]<thr:
            del dic[i]
    return dic, text_num


def main(size, thr, ns, sppmi, f_in, f_out):
    size = int(size)
    thr = int(thr)
    ns = float(ns)
    sppmi = int(sppmi) #1: sppmi 0: raw
    print "Input text file: ", f_in
    print "Building dict..."
    vocab_count, text_num = build_dict(f_in, thr)              
    alltokens = vocab_count.keys()
    vocab_id = dict((t, i) for i, t in enumerate(alltokens))
    vocab_size = len(vocab_id)
    print "the number of texts: ", text_num
    print "vocabulary size: ", vocab_size
    train_num=sum(vocab_count.values())
    print "The number of tokens: ", train_num
    i = 0
    row = []
    col = []
    data = []
    for l in open(f_in).readlines():
        tokens = l.split()
        indexes = list(np.zeros(vocab_size))
        for t in tokens:
            try:
                if sppmi == 1:
                    indexes[vocab_id[t]] += train_num/ns/(len(tokens)*vocab_count[t])
                else:
                    indexes[vocab_id[t]] += 1
            except KeyError:
                pass
        if sppmi == 1:
            for j in range(len(indexes)): 
                if indexes[j] > 1: # only positive values are retained
                    row.append(i)
                    col.append(j)
                    data.append(np.log(indexes[j]))
        else:
            for j in range(len(indexes)): 
                if indexes[j] > 0:
                    row.append(i)
                    col.append(j)
                    data.append(indexes[j])
        i += 1
    print "the size of the co-occurrence matrix of term-document type doc_num, vocab_size:", text_num, vocab_size
    s_co_mat = scipy.sparse.csc_matrix((np.array(data), (np.array(row), np.array(col))), shape = (text_num, vocab_size))
    ut, s, vt = sparsesvd(s_co_mat, size)
    ut = ut.transpose()
    f=open(f_out, "w")
    for i in range(ut.shape[0]):
        f.write(str(i) + " ")
        for j in range(ut.shape[1]):  
            f.write(str(ut[i,j]) + " ")
        f.write("\n")  




       
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='')
    parser.add_argument('--size', help='word vectors dimension')
    parser.add_argument('--thr', help='threshold for removing low-frequency words, also called min-count in word2vec toolkit ')
    parser.add_argument('--ns', help='shift value (S in SPPMI) , corresponds to the number of words negatively sampled in word2vec')
    parser.add_argument('--sppmi', help='1:sppmi 0:raw')
    parser.add_argument('--f_in', help='')
    parser.add_argument('--f_out', help='')
    args = vars(parser.parse_args())
    main(**args)
