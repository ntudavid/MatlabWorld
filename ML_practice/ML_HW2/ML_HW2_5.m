function ML_HW2_5(dsN,showOrNot) % data_set_number / showOrNot     R98922081
    %target function
    F =rand(1,3)*100-50;
    %F=[Fr(1,1) Fr(1,2) 0];
    plot_2D(F,'Red','--');
    %generating training data set
    input =rand(2,dsN)*100-50; %points set
    inputC=ones(1,dsN);
    M=[input;inputC];
    %iner product
    inerP=F*M;
    label=zeros(1,dsN);
    label(find(inerP>=0))=1;
    label(find(inerP<0))=-1;
    %plot
    points2(input,label);
    %pause(10);
    %generating testing data set
    inputT =rand(2,10000)*100-50; %points set
    inputCT=ones(1,10000);
    MT=[inputT;inputCT];
    %iner product
    inerPT=F*MT;
    labelT=zeros(1,10000);
    labelT(find(inerPT>=0))=1;
    labelT(find(inerPT<0))=-1;
    
    cnt=zeros(1,3);
    errnum=zeros(1,3);
    for i=1:3
       if(i==1)
           param=100;
       elseif(i==2)
           param=1;
       else
           param=0.01;
       end
       % random
       W =zeros(1,3);
       cnt(1,i)=0;
       while(1)
           inerPW=W*M;
           misClass=find((inerPW>=0 & label==-1) | (inerPW<=0 & label==1));
           len=length(misClass);
           if (len==0)
              break;
           end
           rP=randperm(len);
           next=1;
           while(1)
              randNum=rP(1,next);
              id=misClass(1,randNum);
              if(label(1,id)*inerPW(1,id)<=1)
                 vec=input(1:2,id);
                 vecT=vec';
                 W=W+param*(label(1,id)-inerPW(1,id))*[vecT 1];
                 %W=W/norm(W);
                 break;
              end
              next=next+1;
              if(next>len)
                 break;
              end
           end
           if(next>len)
              break;
           end
           if(showOrNot==1)
              p=plot(input(1,id),input(2,id),'o','MarkerFaceColor','b');
              h=plot_2D(W,'Blue','-');
              pause(0.5);
              delete(p);
              delete(h);
           end
           if(max(W)>1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000)
               W=W/norm(W);
           end
           cnt(1,i)=cnt(1,i)+1; 
           if(cnt(1,i)>1000)
              break;
           end
           %cnt
           %W
       end
       W

       inerPWT=W*MT;
       labelWT=zeros(1,10000);
       labelWT(find(inerPWT>=0))=1;
       labelWT(find(inerPWT<0))=-1;
       errorp=zeros(1,10000);
       errorp(find(labelWT~=labelT))=1;
       err=find(errorp==1);
       errnum(1,i)=length(err);
       figure,
       points2(inputT,labelT);
       h=plot_2D(F,'Red','--');
       W=W/norm(W);
       h=plot_2D(W,'Blue','-');
       EpointPx=inputT(1,find(errorp==1));
       EpointPy=inputT(2,find(errorp==1));
       plot(EpointPx,EpointPy,'bs')
       axis([-55,55,-55,55]);
    end
    cnt
    errnum
end

function h=plot_2D(Eq,co,ls)
    Ea=num2str(Eq(1,1));
    Eb=num2str(Eq(1,2));
    Ec=num2str(Eq(1,3));
    Feq=[Ea '*x + ' Eb '*y + ' Ec]
    h=ezplot(Feq,[-55,55,-55,55]);
    set(h,'Color',co,'LineStyle',ls);
    hold on;
end

function points2(in,S)
    pointPx=in(1,find(S==1));
    pointPy=in(2,find(S==1));
    plot(pointPx,pointPy,'Og')
    axis([-55,55,-55,55]);
    hold on;
    pointNx=in(1,find(S==-1));
    pointNy=in(2,find(S==-1));
    plot(pointNx,pointNy,'xr')
    hold on;
end