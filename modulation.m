function d=modulation(c,switch_mod,switch_graph)

if switch_mod == 0   % 4 QAM                                                     
    M = 2;        % modulation index ,M from 2^M  
    MP=2;         % MP is the value to get  average symbol power as 1 after normalization Using 2(m-1)/3
                  % m= 4,16,64
elseif switch_mod == 1 
        M=4;
        MP=10;
    else 
        M=6;
        MP=42;
end
%     rem = mod(length(c),M);                                       
%     if rem ~0                                                           
%         c = [c; zeros(M-rem,1)]; % zero padding
%     end
M1=2^M;
x=-sqrt(M1)+1; % To get the QAM points for each modulation scheme
y=x;
m1=[];
 QAM_point=[];
 
for i1=1:sqrt(M1)
    for j1=1:sqrt(M1)
        QAM_point=[QAM_point; x+y*1i];
        x=x+2;
    end
    x=-sqrt(M1)+1;

    y=y+2;
end
QAM_points=QAM_point/sqrt(MP);  %  Normalization                        
  d = [];  
  for index = 1:M:length(c) % pairing data bits into 2 for 4 qam
        modulated_index = bi2de(c(index:index+M-1)', 'left-msb');  % to define gray coding 
        d = [d; QAM_points(modulated_index+1)];   % symbol value
    end
if(switch_graph == 1)
    scatterplot(d)
    title('Modulation Output');
    grid on
    axis([-2 2 -2 2]);
end

end