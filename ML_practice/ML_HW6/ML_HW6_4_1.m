%function [alpha err svn errT]=ML_HW_6_4_1(d,C)
function alpha=ML_HW6_4_1(d,C)
    %train
    load hw6_4_train.dat;
    y=hw6_4_train(:,3);
    x=hw6_4_train(:,1:2);
    s=size(x);
    N=s(1);
    %plot
    points2(x,y);
    %quardratic prog
    Q=zeros(N);
    for i=1:N
        for j=1:N
            Q(i,j)=y(i)*y(j)*(1+x(i,:)*x(j,:)')^d;
        end
    end
    f=-ones(N,1);
    %alpha=quadprog(Q,f,[],[],y',0,zeros(N,1),C*ones(N,1),ones(N,1));
    alpha=quadprog(Q,f,[],[],y',0,zeros(N,1),C*ones(N,1));
    alpha(find(alpha<0.0000000001))=0;
    alpha;
    % find free-sv
    fa=find(alpha>0 & alpha<C-0.0000000001); 
    fas=size(fa)
    if(fas(1)==0)
        fa=find(alpha>0 & alpha<C);
    end
    xN=[x(fa(1),:)];
    h=0;
    for m=1:N
        h=h+y(m)*alpha(m)*((1+x(m,:)*xN')^d);
    end
    % compute b
    b=y(fa(1))-h
    % compute Ein
    err=0;
    FSV=zeros(N,1); %free-sv
    for i=1:N
        xN=[x(i,:)];
        h=b;
        for m=1:N
            h=h+y(m)*alpha(m)*((1+x(m,:)*xN')^d);
        end
        if(abs(y(i)*h-1)<0.000000001)
            FSV(i)=1;
        end
        if(h>=0 && y(i)==-1)
            plot(xN(1),xN(2),'bs');
            hold on;
            err=err+1;
        end
        if(h<0 && y(i)==1)
            plot(xN(1),xN(2),'bs');
            hold on;
            err=err+1;
        end
    end
    % #free-sv
    sum(FSV)
    % sv rate
    f=find(alpha>0);
    fs=size(f);
    svrate=fs(1)/N
    %Ein
    err=err/N
    %testing
    load hw6_4_test.dat;
    yT=hw6_4_test(:,3);
    xT=hw6_4_test(:,1:2);
    sT=size(yT);
    NT=sT(1);
    errT=0;
    for i=1:NT
        xN=[xT(i,:)];
        h=b;
        for m=1:N
            h=h+y(m)*alpha(m)*((1+x(m,:)*xN')^d);
        end
        if(h>=0 && yT(i)==-1)
            errT=errT+1;
        end
        if(h<0 && yT(i)==1)
            errT=errT+1;
        end
    end
    errT=errT/NT
end

function points2(in,S)
    pointPx=in(find(S==1),1);
    pointPy=in(find(S==1),2);
    plot(pointPx,pointPy,'Og')
    axis([-0.1,1.1,-0.1,1.1]);
    hold on;
    pointNx=in(find(S==-1),1);
    pointNy=in(find(S==-1),2);
    plot(pointNx,pointNy,'xr')
    hold on;
end
