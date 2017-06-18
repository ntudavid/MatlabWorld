%function ML_HW6_5_2()
   clear
   load hw6_5_train.dat;
   [N D]=size(hw6_5_train);
   d=D-1;
   xO=hw6_5_train(:,1:d);
   yO=hw6_5_train(:,D);

   load hw6_5_test.dat;
   [NT DT]=size(hw6_5_test);
   dT=DT-1;
   xT=hw6_5_test(:,1:dT);
   yT=hw6_5_test(:,DT);
   
   %bootstrap
   recordHL=zeros(N,100); %record label for each iteration
   recordHLT=zeros(NT,100);
   recordEin=zeros(1,100); %record Ein for each iteration
   recordEout=zeros(1,100);
   for t=1:100
       %Dt
       for i=1:N
           rp=randperm(N);
           id=rp(1);
           x(i,1:d)=hw6_5_train(id,1:d);
           y(i,1)=hw6_5_train(id,D);
       end
       pp=find(y==1); % positive points
       ps=size(pp);
       recordE=zeros(2*d,2);
       it=0;
       for i=1:d
           for s=-1:2:1
               err=zeros(N,1);
               for j=1:N
                   thita=s*x(j,i); % choose i dimension , example j as thita
                   for k=1:N
                       if((s*x(k,i)-thita)>=0 && y(k)==-1) %wrong
                          err(j)=err(j)+1;
                       end
                       if((s*x(k,i)-thita)<0 && y(k)==1) %wrong
                          err(j)=err(j)+1;
                       end
                   end
               end 
               me=min(err);
               fm=find(err==me);
               it=it+1;
               recordE(it,1)=me;
               recordE(it,2)=fm(1);
           end
       end
       mE=min(recordE(:,1));
       if(mE>ps(1))
          NN=1;
       else
          NN=0;
       end
       
       %recordE
       id=find(recordE(:,1)==mE);
       hp=recordE(id(1),2); % hypothesis point
       hi=ceil(id(1)/2);  % hypothesis dimension
       if(rem(id(1),2)==0)
          hs=1;  % hypothesis s
       else
          hs=-1;
       end
       hthita=hs*x(hp,hi);
       
       %recordHL
       if(NN==1)
           for m=1:N
               recordHL(m,t)=-1;
           end
       else
          for m=1:N
              if((hs*xO(m,hi)-hthita)>=0)
                  recordHL(m,t)=1;
              else
                  recordHL(m,t)=-1;
              end
          end
       end
       
       %Ein
       Ein=0;
       for m=1:N
           if(sum(recordHL(m,:))>=0 && yO(m)==-1)
               Ein=Ein+1;
           end
           if(sum(recordHL(m,:))<0 && yO(m)==1)
               Ein=Ein+1;
           end
       end
       recordEin(t)=Ein/N;
       
       %test
       %recordHL
       if(NN==1)
           for m=1:NT
               recordHLT(m,t)=-1;
           end
       else
          for m=1:NT
              if((hs*xT(m,hi)-hthita)>=0)
                  recordHLT(m,t)=1;
              else
                  recordHLT(m,t)=-1;
              end
          end
       end
       
       %Eout
       Eout=0;
       for m=1:NT
           if(sum(recordHLT(m,:))>=0 && yT(m)==-1)
               Eout=Eout+1;
           end
           if(sum(recordHLT(m,:))<0 && yT(m)==1)
               Eout=Eout+1;
           end
       end
       recordEout(t)=Eout/NT;
   end
   px=1:100;
   plot(px,recordEin,'b-');
   hold on;
   plot(px,recordEout,'r-');

%end