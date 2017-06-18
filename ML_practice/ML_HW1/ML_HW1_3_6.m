function ML_HW1_3_6(dsN,diN,itN) %data_set_number dimention_number iteration_number
    Uk=zeros(1,itN);  %random record
    %target function
    F =rand(1,diN+1)*100-50;
    %generating data set
    input =rand(diN,dsN)*100-50;
    inputC=ones(1,dsN);
    M=[input;inputC];
    %iner product
    inerP=F*M;
    %set label
    label=zeros(1,dsN);
    label(find(inerP>=0))=1;
    label(find(inerP<0))=-1;
    % deterministical
    W =zeros(1,diN+1);
    cnt=0;
    while(1)
        inerPW=W*M;
        misClass=find((inerPW>=0 & label==-1) | (inerPW<=0 & label==1));
        len=length(misClass);
        if (len==0)
            break;
        end
        id=misClass(1,1);
        vec=input(1:diN,id);
        vecT=vec';
        W=W+label(1,id)*[vecT 1];
        cnt=cnt+1; 
    end
    cnt
    %random
    for i=1:itN
        W =zeros(1,diN+1);
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
           vec=input(1:diN,id);
           vecT=vec';
           W=W+label(1,id)*[vecT 1];
           cnt=cnt+1; 
        end
        Uk(1,i)=cnt;
    end
    mean(Uk)
    bar(Uk)
    figure
    hist(Uk)
end