%% this M-file evaluate the fitness function of KDW model
function f = fitness(pos,u,u1,t1,h,tu,n)
sum = 0;
%[qq]=size(t1);
for ii=2:length(t1)
    j = floor(t1(ii)/tu)+1 ;
    a1=(pos(1)-1)/pos(1);
    a2=pos(1)*pos(2);
    a3=pos(2)^a1;
    a4=a2/a3;
    b1=u(n,j)+u(n+1,j-1);
    b2=b1/2;
    b3=b2^a1;
    c = a4*b3; 
    teta(ii) =((tu*pos(3)*c)/(h^2))*((u(n+1,j-1)-2*u(n,j-1)+u(n-1,j-1))) - ((c*tu)/(h))*(u(n+1,j-1)-u(n,j-1))+u(n+1,j-1);
end
sum = norm(u1-teta)/sqrt(length(t1));
f =sum;

            
            
            
            