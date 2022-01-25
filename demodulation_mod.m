function c_hat=demodulation_mod(d_bar,switch_mod,switch_graph)

if switch_mod == 0 
    M = 2;
    MP=2;
elseif  switch_mod == 1
        M=4;
        MP=10;
    else 
        M=6;
        MP=42;
end
    
M1=2^M;
x=-sqrt(M1)+1;
y=x;
m1=[];
decision_point=[];
for i1=1:sqrt(M1)
    for j1=1:sqrt(M1)
        decision_point=[decision_point; x+y*1i];
        x=x+2;
    end
    x=-sqrt(M1)+1;
    
    y=y+2;
end
decision_points=decision_point/sqrt(MP); % wrong line try to change divisble by sqrt by MP
c_hat = [];

for j=1:length(d_bar)
    for index=1:length(decision_points)
        error(index) = d_bar(j) - decision_points(index);
    end
    final_decision(j) = find(error==min(error(:)))-1; % finding the minimum eorror
    c_hat = [c_hat; de2bi(final_decision(j) ,M, 'left-msb')'];
end

if switch_graph                                                   
    figure = scatterplot(d_bar,1,0,'r.');                                                          
    hold on
    scatterplot(decision_points,1,0,'k*',figure)
    title('Demodulation ouput')
    grid
end
end
