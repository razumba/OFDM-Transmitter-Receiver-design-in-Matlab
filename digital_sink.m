function BER=digital_sink(b,b_hat)

e=abs(b-b_hat);
BER=sum(e)/length(b);
