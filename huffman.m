close all 
clear all
parblock=4
symbols=[1 2 3 4 5];
p=[.1 .2 .3 .25 .15];
sig=[1 2 4 3 1 3 4 1 3 1 4 1];
[dict,avglen] = huffmandict(symbols,p)

comp = huffmanenco(sig,dict)


