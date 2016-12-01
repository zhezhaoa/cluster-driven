# cluster-driven
  This is the source code that can reproduce the results reported in the paper 'Cluster-Driven Model for Better Word and Text Embedding', which is accepted by ECAI2016 (http://ebooks.iospress.nl/volumearticle/44747). The publication of the paper is not the end. We will continue updating the code and other contents about the paper in the following months.
  
  
  The project includes following parts:
  
  
  (1)
  the first part is about sentiment classification tasks. Over 4 percents improvements are witnessed with the introduction of the global information. Our experimental results also shed some light on the Paragraph Vector (PV) models[Le and Mikolov, 2014]. We show that the superiority of PV comes from global information, which is introduced indirectly by paragraph vector, rather than the way of training paragraph vectors. (PV trains paragraph vectors in predict way, which is the same with models in word2vec toolkit.)
    
    run go.sh to observe the effectiveness of global information on sentiment analysis.
    chmod +x go.sh
    sudo ./go.sh
  
  
  (2)
  Theoretical analysis is provided in this paper to unveil the relationsips among PV-DBOW (a variant in PV), SPPMI matrix of term-document type and our centric model. In fact, their relationships are also noticed in [Sun et al, 2015]'s work. However, we are the first to use the SPPMI matrix to obtain text representations. The experimental results show that our novel co-occurrence matrix can still generate near state-of-the-art results on sentiment classification.
    
    
  (3)
  The third part is about the word analogy tasks. Experimental results show that global information can improve accuracy in semantic questions significantly.
  
  
Zhe Zhao, Renmin university of China. 
Thanks for the help from Shen Li and his contributions to this project 
If you have any questions about the project please contact me: 1152543959@qq.com


[Le and Mikolov, 2014]  Distributed representations of sentences and documents </br>
[Sun et al, 2015]  Learning word representations by jointly modeling syntagmatic and paradigmatic relations
  
