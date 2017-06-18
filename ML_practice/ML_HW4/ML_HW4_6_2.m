function ML_HW4_6_2()
    %training data
    load hw4_train.dat;
    x1=hw4_train(:,1);
    x2=hw4_train(:,2);
    y=hw4_train(:,3);
    s=size(y);
    N=s(1);
    x0=ones(N,1);
    A=[x0 x1 x2];
    %testing data
    load hw4_test.dat;
    xt1=hw4_test(:,1);
    xt2=hw4_test(:,2);
    yt=hw4_test(:,3);
    st=size(yt);
    Nt=st(1);
    xt0=ones(Nt,1);
    B=[xt0 xt1 xt2];
    %iterations
    W=[0;0;0];
    Ein=zeros(2000,1);
    Eout=zeros(2000,1);
    change=0;
    for i=1:2000
       r=A*W;
       G=[0;0;0];
       for j=1:N
          Xj=A(j,:);
          G=G+((-y(j)*exp(-y(j)*r(j)))/(1+exp(-y(j)*r(j)))*Xj');
       end
       G=G/N;
       W=W-0.001*G;
       Label=ones(N,1);
       Label(find(r<0))=-1;
       errP=find(Label~=y);
       Ein(i)=length(errP)/N;
       %Eout
       rt=B*W;
       LabelT=ones(Nt,1);
       LabelT(find(rt<0))=-1;
       errPT=find(LabelT~=yt);
       Eout(i)=length(errPT)/Nt;
       if(i>1)
           if(Eout(i)~=Eout(i-1))
               change=change+1;
           end
       end
    end
    points2(A,y);
    plot_2D(W,'Blue','-');
    errPx=A(errP,2);
    errPy=A(errP,3);
    plot(errPx,errPy,'bs')
    axis([-0.1,1.1,-0.1,1.1]);
    %testing
    figure,
    points2(B,yt);
    plot_2D(W,'Blue','-');
    errPTx=B(errPT,2);
    errPTy=B(errPT,3);
    plot(errPTx,errPTy,'bs');
    axis([-0.1,1.1,-0.1,1.1]);
    %plot
    figure,
    bar(Ein);
    figure,
    bar(Eout);
    change
end

function h=plot_2D(Eq,co,ls)
    Ea=num2str(Eq(2));
    Eb=num2str(Eq(3));
    Ec=num2str(Eq(1));
    Feq=[Ea '*x + ' Eb '*y + ' Ec '=0']
    h=ezplot(Feq,[0,1,0,1]);
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