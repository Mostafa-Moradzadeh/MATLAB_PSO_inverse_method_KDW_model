%% Solvin %%Calculating eigenvalues of a nonsymmetric matrix using Particle Swarm Optimization- KDW (inverse method)
%% Initialization
clear all
close all
clc
format long G; global zz;
global Rainfallduration Intensity
Rainfallduration=input('Rainfall duration(hr)=');
Intensity=input('Rainfall intensity(mm.hr-1)=');
tic
swarm_size = 200;            % Size of the swarm 
swich=0 ;
max_iter =1000;
              % Maximum number of iteration for every run

k = 3;
c2 = 2.4 ;            % PSO parameter C1 
c1 = 1.2 ;            % PSO parameter C2 
R1 = rand(k, swarm_size) ;
R2 = rand(k, swarm_size) ;
ww=1.1;
w1=1.2  ;
w2=0.2  ;
eps = 0.0001 ;
% Specifying the band and range of the coefficients.
ev=[2 .5;400000 5000;120 75];

%% **************************************************************************
                     %-------------------------------------------------------%
                     % Initializing swarm and velocities and position %
                     %-------------------------------------------------------%
for i=1:swarm_size                     
    position(1,i) = ev(1,2)+rand*( ev(1,1) - ev(1,2) );
    position(2,i) = ev(2,2)+rand*( ev(2,1) - ev(2,2) );
    position(3,i) = ev(3,2)+rand*( ev(3,1) - ev(3,2) );
end
% position(1,1:swarm_size) = ev(1,1);
% position(2,1:swarm_size) = ev(2,1);
% position(3,1:swarm_size) = ev(3,1);
% pp=rand(k,swarm_size);
% position=pp.*position;
        %for i = 1 : swarm_size
             %position_fitness(i) = faindif(position,swarm_size);
             position_fitness= faindif(position,swarm_size);
             if zz==1;
                 fprintf('**Warning**: Choose the appropriate "h" and "tu" in faindif mfile or initial values of coefficients in psoLIra mfile to avoid the complex numbers for "u"');
                 return;
             end;         
p_best_position  = position;
p_best_fitness = position_fitness;
[g_best_fitness,g] = min(p_best_fitness) ;
last_best_fitness = g_best_fitness ;

for i = 1 : swarm_size
    g_best_position(:,i) = p_best_position(:,g) ;
end
velocity = zeros(k,swarm_size);
    

%% ************************************************************************
%% Main Loop
sprintf(' start ...' );
    iter = 0 ;        % Iteration’s counter
while  ( iter < max_iter ) && (swich==0) 
%     (g_best_fitness > eps)
iter = iter + 1 ;
R1 = rand(k, swarm_size) ;
R2 = rand(k, swarm_size) ;
ww = w1 - (w1-w2)*(iter/max_iter) ;
 velocity = ww * velocity + c1*(R1.*(p_best_position - position)) + c2*(R2.*(g_best_position - position)) ;
 position1 = position + velocity ; 
for j=1:3
     for i=1:swarm_size
         if position1(j,i)<= ev(j,1) && position1(j,i) >=ev(j,2)
             position(j,i)= position1(j,i);           
         end
     end
 end

 position_fitness= faindif(position,swarm_size); if zz==1;return; end;
for i = 1 : swarm_size
        if position_fitness(i) < p_best_fitness(i)
           p_best_fitness(i) = position_fitness(i) ;  
           p_best_position(:,i) = position(:,i) ;             
        end   
end
 [global_best_fitness,g] = min(p_best_fitness) ; 
if global_best_fitness < g_best_fitness
   g_best_fitness = global_best_fitness ;
   for i = 1 : swarm_size
       g_best_position(:,i) = p_best_position(:,g) ; 
      if i==1;
      end
   end  
end
 rrr(iter) = g_best_fitness ;
 sprintf(' iteration  %3.0f  ...', iter )

 if abs(g_best_fitness)<=eps
     swich=1;
 end    
end      % end of while loop      
j=j+1 ;
% t/exe_step
 fprintf('Best position a = %f \n',g_best_position(1,1));
 fprintf('Best position b = %f\n',g_best_position(2,1));
 fprintf('Best position Vw = %f\n',g_best_position(3,1));
 fprintf('Best fitness = %f\n',g_best_fitness);
 
figure(3);plot(rrr);set(gca,'Xtick',0:100:1000);
xlabel('Number of iteration');ylabel('Cost function');box;
title('KDW (160.49)- Inverse sulotion- Cost function vs. Number of iteration')

save ('d')
load ('u')
% 
figure('name','Numerical 2','color','w');plot(t,u(end,:));hold on;
plot(t1,u1,'o');hold on;
xlabel('Time (h)');ylabel('u (mm/h)');box;
set(gca,'Xtick',0:0.02:.16);
set(gca,'Ytick',0:30:180);
title('KDW (160.49)- Inverse sulotion');

figure(2); plot(t,(u(end,:)),'*',t,real(u(end,:)),'.',t,imag(u(end,:)),'s');
xlabel('Time (h)');ylabel('u (mm/h)');box;
set(gca,'Xtick',0:0.02:.16);
set(gca,'Ytick',0:30:180);
title('KDW (160.49)- Inverse sulotion');

Time = toc
% hold on
%% ************************************************************************