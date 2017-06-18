function ML_HW4_5()
    load hw4_train.dat;
    x1=hw4_train(:,1);
    x2=hw4_train(:,2);
    y=hw4_train(:,3);
    s=size(y);
    x0=ones(s(1),1);
    A=[x0 x1 x2];
    B=(A'*A)^(-1);
    w=B*(A')*y
    points2(A,y);
    plot_2D(w,'Blue','-');
    T=A*w;
    sT=ones(s(1),1);
    sT(find(T<0))=-1;
    errP=find(sT~=y);
    eN=size(errP);
    Ein=eN(1)/s(1)
    errPx=A(errP,2);
    errPy=A(errP,3);
    plot(errPx,errPy,'bs')
    axis([-0.1,1.1,-0.1,1.1]);
    test(w);
end

function test(h)
    load hw4_test.dat;
    x1=hw4_test(:,1);
    x2=hw4_test(:,2);
    y=hw4_test(:,3);
    s=size(y);
    x0=ones(s(1),1);
    A=[x0 x1 x2];
    hold off;
    figure,
    points2(A,y);
    plot_2D(h,'Blue','-');
    T=A*h;
    sT=ones(s(1),1);
    sT(find(T<0))=-1;
    errP=find(sT~=y);
    eN=size(errP);
    Eout=eN(1)/s(1)
    errPx=A(errP,2);
    errPy=A(errP,3);
    plot(errPx,errPy,'bs')
    axis([-0.1,1.1,-0.1,1.1]);
end

function h=plot_2D(Eq,co,ls)
    Ea=num2str(Eq(2));
    Eb=num2str(Eq(3));
    Ec=num2str(Eq(1));
    Feq=[Ea '*x + ' Eb '*y + ' Ec '=0']
    h=ezplot(Feq,[-0.1,1.1,-0.1,1.1]);
    set(h,'Color',co,'LineStyle',ls);
    hold on;
end

function points2(in,S)
    pointPx=in(find(S==1),2);
    pointPy=in(find(S==1),3);
    plot(pointPx,pointPy,'Og')
    axis([-0.1,1.1,-0.1,1.1]);
    hold on;
    pointNx=in(find(S==-1),2);
    pointNy=in(find(S==-1),3);
    plot(pointNx,pointNy,'xr')
    hold on;
end