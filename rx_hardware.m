function s_tilde=rx_hardware(y,par_rxthresh,switch_graph)

R=abs(y);
theta=angle(y);
if par_rxthresh>1;
    R(R>=par_txthresh)=1;
    r=R;
else 
    R(R>1)=1;
    r=R;
end
[a,b]=pol2cart(theta,r);
s_tilde=a+b*1i;

if switch_graph==1;
    figure;
    subplot(2,1,1)
    plot(real(y),'g');
    title('recieved signal')
    grid on
    subplot(2,1,2)
    plot(real(s_tilde),'r');
    grid on
    title('output of rx_hardware')
end 
