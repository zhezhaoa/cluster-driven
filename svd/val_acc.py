import sys 

correct_num=0
f=open( sys.argv[1])
for i in f.readlines():
    if i.find("Accuracy")>=0:
        correct_num+=float(i[i.find("/")-3:i.find("/")])

print correct_num/2000
