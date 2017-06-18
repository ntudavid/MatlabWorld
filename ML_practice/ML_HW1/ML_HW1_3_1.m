function ML_HW1_3_1(dsN,showOrNot) % data_set_number / showOrNot     R98922081
    %target function
    F =rand(1,3)*100-50;
    plot_2D(F,'Red','--');
    %generating data set
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
    % deterministical
    W =zeros(1,3);
    cnt=0;
    while(1)
        inerPW=W*M;
        misClass=find((inerPW>=0 & label==-1) | (inerPW<=0 & label==1));
        len=length(misClass);
        if (len==0)
            break;
        end
        id=misClass(1,1);
        vec=input(1:2,id);
        vecT=vec';
        W=W+label(1,id)*[vecT 1];
        if(showOrNot==1)
           id
           p=plot(input(1,id),input(2,id),'o','MarkerFaceColor','b');
           h=plot_2D(W,'Blue','-');
           pause(0.5);
           delete(p);
           delete(h);
        end
        cnt=cnt+1; 
    end
    cnt
    plot_2D(W,'Blue','-');
    % random
    W =zeros(1,3);
    cnt=0;
    while(1)
        inerPW=W*M;
        misClass=find((inerPW>=0 & label==-1) | (inerPW<=0 & label==1));
        len=length(misClass);
        if (len==0)
            break;
        end
        rP=randperm(len);
        randNum=rP(1,1);
        id=misClass(1,randNum);
        vec=input(1:2,id);
        vecT=vec';
        W=W+label(1,id)*[vecT 1];
        %if(showOrNot==1)
        %   p=plot(input(1,id),input(2,id),'o','MarkerFaceColor','b');
        %   h=plot_2D(W,'Blue','-');
        %   pause(0.5);
        %   delete(p);
        %   delete(h);
        %end
        cnt=cnt+1; 
    end
    cnt
end

function h=plot_2D(Eq,co,ls)
    Ea=num2str(Eq(1,1));
    Eb=num2str(Eq(1,2));
    Ec=num2str(Eq(1,3));
    Feq=[Ea '*x + ' Eb '*y + ' Ec]
    h=ezplot(Feq,[-60,60,-60,60]);
    set(h,'Color',co,'LineStyle',ls);
    hold on;
end

function points2(in,S)
    pointPx=in(1,find(S==1));
    pointPy=in(2,find(S==1));
    plot(pointPx,pointPy,'Og')
    hold on;
    pointNx=in(1,find(S==-1));
    pointNy=in(2,find(S==-1));
    plot(pointNx,pointNy,'xr')
    hold on;
end