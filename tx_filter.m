function [s]=tx_filter(z,par_tx_w,switch_graph,switch_off)
if switch_off==1

%F=hann(64);
F=rcosine(1,par_tx_w,'fir/sqrt'); 

x1=[];
z_oversampled=[];
for i=1:length(z)
    x1=[z(i) zeros(1,par_tx_w-1)]; % each symbol is oversampled by 20 zeros in row form and concatinated with input data Z
    z_oversampled= [z_oversampled x1]; 
end
 %z_oversampled=upsample(z,par_tx_w);
F_out = conv(F,z_oversampled); % o/p from filter
                                 % include normalize of filter output 
size(F_out);
[m,n]=size(F_out) ;
s=reshape(F_out,n,1); % to make the filter ouptut as coulmn vector
size(s);

[H W] = freqz(s,1,512);
     if switch_graph==1
        figure;
        plot(W/pi,20*log10(abs(H)));
        xlabel('\omega/pi');
        ylabel('H in DB');
        title('Transmit filter output in normalize frequency domain');
        figure
        hold off
        subplot(2,1,1)
        
        plot(real(s),'b');
        ylabel('output of transmit filter(real)')
        grid on
        subplot(2,1,2)
        plot(imag(s),'r');
        grid on
        ylabel('output of transmit filter(imaginary)')
    end
else
    s=z;
end
