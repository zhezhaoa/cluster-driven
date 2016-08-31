# cluster-driven
  This is the code that can reproduce the results reported in the paper 'Cluster-Driven Model for Better Word and Text Embedding', which is accepted by ECAI2016. The publication of paper is not the end. We will continue updating the codes, turotials about the paper in the following three to six months.
  
  The project includes three parts:
  
  (1)The first part is about the word analogy tasks. Experimental results show that global information can improve accuracy in semantic questions significantly.
  
  (2)The second part is about sentiment classification tasks. Over 4 percents improvements are witnessed with the introduction of the global information. Our experimental results also shed some light on the Paragraph Vector (PV) models[Le and Mikolov, 2014]. We show that the superiority of PV comes from global information, which is introduced indirectly by paragraph vector, rather than the way of training paragraph vectors. (PV trains paragraph vectors in predict way, which is the same with models in word2vec toolkit.)
  
  (3)Theoretical analysis is provided in this paper to unveil the relationsips between our centric cluster model, PV-DBOW (a variant in PV) and SPMI matrix of term-document type. In fact, their relationships are also noticed in [Sun et al, 2015]'s work. However, we are the first to use this SPMI matrix to obtain text representations. The experimental results show that our novel co-occurrence matrix can still generate near state-of-the-art results on sentiment classification.
  
  
