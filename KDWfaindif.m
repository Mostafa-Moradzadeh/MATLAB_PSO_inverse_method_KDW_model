%Name: KDW-VG Finite difference- Inverse solution

function position_fitness = faindif(position,swarm_size)
format longG
swarm_size=200;
h=150;tu=.0002;
%In parentheses of 'xlsread,' the paths of the files should be entered, like ('E:\..\..\t.xlsx') and ('E:\..\..\u.xlsx')
t1=xlsread('E:\..\..\t.xlsx');
t1=t1';
u1=xlsread('E:\..\..\u.xlsx');
u1=u1';
l=300;T=t1(end);
t=0:tu:T;
m=length(t)-1;
x=0:h:l;
x(end)=l;
n=length(x)-1;
for q=1:swarm_size
        Vw=position(3,q);
        a=position(1,q);
        b=position(2,q);
        %--------------------------------------------------------------------------
        u=zeros(n+1,m+1);for i=1:n+1;u(i,1)=u0(x(i));end;
        for j=1:m+1;u(1,j)=Ui(t(j));end;
        %--------------------------------------------------------------------------
        a1=(a-1)/a;a2=a*b;a3=b^a1;a4=a2/a3; global zz; zz=0;
for j=2:m+1;
    if zz==1;break;end
    for i=2:n+1;
%         c=p*(u(i,j-1))^q;
        b1=u(i-1,j)+u(i,j-1);b2=b1/2;b3=b2^a1;
        c=a4*b3;
        if i==n+1
           u(i,j)=((tu*Vw*c)/(h^2))*((u(i,j-1)-2*u(i-1,j-1)+u(i-2,j-1)))- ...
                ((c*tu)/(h))*(u(i,j-1)-u(i-1,j-1))+u(i,j-1); 
        else
            u(i,j)=((tu*Vw*c)/(h^2))*((u(i-1,j-1)-2*u(i,j-1)+u(i+1,j-1)))- ...
                ((c*tu)/(2*h))*(u(i+1,j-1)-u(i-1,j-1))+u(i,j-1);
        end
         if imag(u(i,j))~=0
            zz=1;break;
         end 
    end
%     disp([j m]);
end
%--------------------------------------------------------------------------
       
save('u');
        position_fitness(q) = fitness(position(:,q),u,u1,t1,h,tu,n);
     
end


