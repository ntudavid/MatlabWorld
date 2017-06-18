% function ML_HW7_5()
   clear
   load hw7_train.dat;
   [N D]=size(hw7_train);
   d=D-1;
   x=hw7_train(:,1:d);
   y=hw7_train(:,D);

   load hw7_test.dat;
   [NT DT]=size(hw7_test);
   dT=DT-1;
   xT=hw7_test(:,1:dT);
   yT=hw7_test(:,DT);

   Ein=zeros(300,1);
   Eout=zeros(300,1);
   U=zeros(300,1);
   un=1/N*ones(N,1);
   Hx=zeros(N,1);
   HxT=zeros(NT,1);
   for t=1:300
       recordE=zeros(2*d,2);
       it=0;
       for i=1:d
           for s=-1:2:1
               Hun=zeros(N,1); % for thita
               if(s==-1)
                   for j=1:N
                       thita=s*x(j,i); % example j and in i dimension
                       % test
                       for k=1:N
                          if((s*x(k,i)-thita)>0 && y(k)==-1) % wrong  [yn!=h(xn)]
                              Hun(j)=Hun(j)+un(k);
                          end
                          if((s*x(k,i)-thita)<=0 && y(k)==1) % wrong  [yn!=h(xn)]
                              Hun(j)=Hun(j)+un(k);
                          end
                       end
                   end
               else % s==1
                  for j=1:N
                       thita=s*x(j,i); % example j and in i dimension
                       % test
                       for k=1:N
                          if((s*x(k,i)-thita)>=0 && y(k)==-1) % wrong  [yn!=h(xn)]
                              Hun(j)=Hun(j)+un(k);
                          end
                          if((s*x(k,i)-thita)<0 && y(k)==1) % wrong  [yn!=h(xn)]
                              Hun(j)=Hun(j)+un(k);
                          end
                       end
                  end
               end
               it=it+1;
               me=min(Hun);
               recordE(it,1)=me;
               fme=find(Hun==me);
               recordE(it,2)=fme(1);
           end
       end
       mE=min(recordE(:,1));
       id=find(recordE(:,1)==mE);
       hp=recordE(id(1),2); % hypothesis point
       hi=ceil(id(1)/2);  % hypothesis dimension
       if(rem(id,2)==0)
          hs=1;  % hypothesis s
       else
          hs=-1;
       end
       hthita=hs*x(hp,hi);
       % compute epson
       htx=ones(N,1);
       for i=1:N
           if(hs==-1)
              if((hs*x(i,hi)-hthita)>0)
                  htx(i)=1;
              else
                  htx(i)=-1;
              end
           else % hs==1
              if((hs*x(i,hi)-hthita)>=0)
                  htx(i)=1;
              else
                  htx(i)=-1;
              end
           end
       end
       Ut=sum(un);
       U(t)=Ut;
       epson=sum(un(find(htx~=y)))/Ut;
       alphat=0.5*log((1-epson)/epson);
       un=un.*exp(-alphat*(y.*htx));
       Hx=Hx+alphat*htx;   
       %Ein
       yH=ones(N,1);
       yH(find(Hx<0))=-1;
       dif=find(y~=yH);
       ds=size(dif);
       Ein(t)=ds(1)/N;
       %Eout
       htxT=ones(NT,1);
       for i=1:NT
           if(hs==-1)
              if((hs*xT(i,hi)-hthita)>0)
                  htxT(i)=1;
              else
                  htxT(i)=-1;
              end
           else % hs==1
              if((hs*xT(i,hi)-hthita)>=0)
                  htxT(i)=1;
              else
                  htxT(i)=-1;
              end
           end
       end
       HxT=HxT+alphat*htxT; 
       yHT=ones(NT,1);
       yHT(find(HxT<0))=-1;
       difT=find(yT~=yHT);
       dsT=size(difT);
       Eout(t)=dsT(1)/NT;
   end
   px=1:300;
   plot(px,Ein,'b-');
   hold on;
   plot(px,Eout,'r-');
   hold on;
   plot(px,U,'k:');
  