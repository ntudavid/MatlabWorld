%function ML_HW6_5_1()
   clear
   load hw6_5_train.dat;
   [N D]=size(hw6_5_train);
   d=D-1;
   x=hw6_5_train(:,1:d);
   y=hw6_5_train(:,D);
   pp=find(y==1); % positive points
   ps=size(pp)
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
           %recordE
       end
   end
   mE=min(recordE(:,1))
   if(mE>ps(1))
       NN=1;
       Ein=ps(1)/N;
   else
       NN=0;
       Ein=mE/N;
   end
   
   NN
   %recordE
   id=find(recordE(:,1)==mE)
   hp=recordE(id(1),2) % hypothesis point
   hi=ceil(id(1)/2)  % hypothesis dimension
   if(rem(id(1),2)==0)
       hs=1  % hypothesis s
   else
       hs=-1
   end
   Ein
   %test
   load hw6_5_test.dat;
   [NT DT]=size(hw6_5_test);
   dT=DT-1;
   xT=hw6_5_test(:,1:dT);
   yT=hw6_5_test(:,DT);
   hthita=hs*x(hp,hi);
   Eout=0;
   if(NN==1)
       ppT=size(find(yT==1));
       Eout=ppT(1)/NT
   else
      for k=1:NT
          if((hs*xT(k,hi)-hthita)>=0 && yT(k)==-1) %wrong
               Eout=Eout+1;
          end
          if((hs*xT(k,hi)-hthita)<0 && yT(k)==1) %wrong
               Eout=Eout+1;
          end
      end
      Eout=Eout/NT
   end
   
   
   

   
%end