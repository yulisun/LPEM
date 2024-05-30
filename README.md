# LPEM
Locality Preservation for Unsupervised Multimodal Change Detection. 

## Introduction

LPEM is an energy based model for unsupervised multimodal change detection. LPEM constructs the links between relationships (same/different) and labels (changed/unchanged) of pairwise superpixels, which are domain-invariant. LPEM consists of three types of constrains: the structure consistency based on feature similarity, the label consistency based on spatial continuity, and the sparse penalty based on a change priori. LPEM is a new paradigm that outputs the change map directly without the need to generate intermediate difference image as other algorithms have done.

Please refer to the paper for details. You are more than welcome to use the code! 

===================================================

## Datasets and Energy minimization algorithms

dataset#1 is download from Professor Michele Volpi's webpage at https://sites.google.com/site/michelevolpiresearch/home.

dataset#5 is download from Dr. Luigi Tommaso Luppino's webpage (https://sites.google.com/view/luppino/data) and it was downsampled to 875*500 as shown in our paper.

QPBO energy minimization algorithm is download from Professor Anton Osokin's webpage at https://github.com/aosokin/qpboMex.

LSA energy minimization algorithm is download from https://vision.cs.uwaterloo.ca/code/.

If you use these resources, please cite their relevant papers.

===================================================

## Citation

If you use this code for your research, please cite our paper. Thank you!

@ARTICLE{10540635,    
  author={Sun, Yuli and Lei, Lin and Guan, Dongdong and Kuang, Gangyao and Li, Zhang and Liu, Li},  
  journal={IEEE Transactions on Neural Networks and Learning Systems},   
  title={Locality Preservation for Unsupervised Multimodal Change Detection in Remote Sensing Imagery},   
  year={2024},  
  volume={},  
  number={},  
  pages={1-15},  
 doi={10.1109/TNNLS.2024.3401696}}

===================================================

## Running

Unzip the Zip files (QPBO, LSA) and run the LPEM demo file (tested in Matlab 2016a)! 

If you have any queries, please do not hesitate to contact me (sunyuli@mail.ustc.edu.cn).
