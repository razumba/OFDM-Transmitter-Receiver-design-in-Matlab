function[x]=tx_hardware(s,par_txthresh,switch_graph)

R=abs(s);
theta=angle(s);
if par_txthresh>1;
    R(R>=par_txthresh)=1;
    r=R;
else 
    R(R>1)=1;
    r=R;
end
[a,b]=pol2cart(theta,r); % to plot we need cartesian form 
x=a+b*1i;

if switch_graph==1;
    figure;
    subplot(2,1,1)
    plot(real(s),'g');
    title('Non clipped signal')
    grid on
    subplot(2,1,2)
    plot(real(x),'r');
    grid on
    title('output of tx hardware')
end
end



