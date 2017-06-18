function ML_HW3_4(Eout) % data_set_number / Eout rate  / showOrNot     R98922081
    %target function
    F =rand(1,3)*20-10;
    %plot_2D(F,'Red','--');
    EinRecord=zeros(1,1000);
    EoutRecord=zeros(1,1000);
    EinRecordS=zeros(1,1000);
    EoutRecordS=zeros(1,1000);
    starCNT=zeros(1,20);
    %for it=1:20
        %generating TRAINING data set
        input =rand(2,100)*20-10; % training poits
        inputC=ones(1,100);
        M=[input;inputC];
        %iner product
        inerP=F*M;
        label=zeros(1,100);
        label(find(inerP>=0))=1;
        label(find(inerP<0))=-1;
        %unlinear
        sel=randperm(100);
        if(Eout>1)
             error('Eout can not be greater than 1.');
        else
            eNum=round(100*Eout);
        end
        for i=1:eNum
            sid=sel(1,i);
            label(sid)=-1*label(sid);
        end
        %plot
        %points2(input,label);
        %pause(10);
        %generating TESTING data set
        inputT =rand(2,1000)*100-50; % training poits
        inputCT=ones(1,1000);
        MT=[inputT;inputCT];
        %iner product
        inerPT=F*MT;
        labelT=zeros(1,1000);
        labelT(find(inerPT>=0))=1;
        labelT(find(inerPT<0))=-1;
        %unlinear
        selT=randperm(1000);
        if(Eout>1)
            error('Eout can not be greater than 1.');
        else
           eNum=round(1000*Eout);
        end
        for i=1:eNum
           sid=selT(1,i);
           labelT(sid)=-1*labelT(sid);
        end
    for it=1:20
        % 1000 iterations / randomly choose
        starEin=1;
        starEout=1;
        W =zeros(1,3);
        cnt=1;
        while(1)
            %Ein
            inerPW=W*M;
            misClass=find((inerPW>=0 & label==-1) | (inerPW<0 & label==1));
            len=length(misClass);
            tEin=len/100;
            inerPWT=W*MT;
            misClassT=find((inerPWT>=0 & labelT==-1) | (inerPWT<0 & labelT==1));
            lenT=length(misClassT);
            tEout=lenT/1000; 
            if(tEin<starEin)
               starEin=tEin;
               starEout=tEout;
               starCNT(it)=cnt;
               Wstar=W; % W*(t) in
            end
            EinRecord(1,cnt)= EinRecord(1,cnt)+tEin;
            EoutRecord(1,cnt)= EoutRecord(1,cnt)+tEout;
            EinRecordS(1,cnt)= EinRecordS(1,cnt)+starEin;
            EoutRecordS(1,cnt)= EoutRecordS(1,cnt)+starEout;
            
            % if linearly separable
            if (len==0)
                break;
            end
           %random choose
           rP=randperm(len);
           randNum=rP(1,1);
           id=misClass(1,randNum);
           vec=input(1:2,id);
           vecT=vec';
           W=W+label(1,id)*[vecT 1];
           cnt=cnt+1;
           if(cnt>1000)
               break;
           end
        end
    end
    %plot_2D(Wstar,'Blue','-');
    %find error
    %inerWstar=Wstar*M;
    %mis=find((inerWstar>=0 & label==-1) | (inerWstar<0 & label==1));
    %mm=mis;
    %starX=input(1,mm);
    %starY=input(2,mm);
    %plot(starX,starY,'bs')
    %plot testing data
    %figure,
    %plot_2D(F,'Red','--');
    %plot_2D(Wstar,'Blue','-');
    %points2(inputT,labelT);
    %inerWstarT=Wstar*MT;
    %misT=find((inerWstarT>=0 & labelT==-1) | (inerWstarT<0 & labelT==1));
    %mmT=misT;
    %starXT=inputT(1,mmT);
    %starYT=inputT(2,mmT);
    %plot(starXT,starYT,'bs')
    %show data
    %cnt
    %starEin
    %starEout
    EinRecord=EinRecord/20;
    EoutRecord=EoutRecord/20;
    EinRecordS=EinRecordS/20;
    EoutRecordS=EoutRecordS/20;
    %figure,
    %bar(EinRecord)
    %figure,
    %bar(EoutRecord)
    %figure,
    %bar(EinRecordS)
    %figure,
    %bar(EoutRecordS)
    figure
    plot(EinRecord)
    hold on,
    bar(EinRecordS)
    %plot(EinRecordS,'--r')
    figure,
    plot(EoutRecord)
    hold on,
    bar(EoutRecordS)
    %plot(EoutRecordS,'--r')
    
    starCNT
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