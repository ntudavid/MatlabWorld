function ML_HW6_1()
    y=[ -1; -1; -1; 1; 1; 1; 1];
    x=[1 0; 0 1; 0 -1; -1 0; 0 2; 0 -2; -2 0];
    
    %6_1_1
    ph1=x(:,2).*x(:,2)-2*x(:,1)-ones(7,1);
    ph2=x(:,1).*x(:,1)-2*x(:,2)+ones(7,1);
    ph=[ph1 ph2];
    points2(ph,y);
    %large margin PLA
    H=[1 0 0;0 1 0;0 0 0];
    f=[0;0;0];
    A=[(-y.*ph1) (-y.*ph2) (-y)];
    b=-ones(7,1);
    w=quadprog(H,f,A,b);
    w(find(abs(w)<0.0000000001))=0;
    w
    u=w(1:(size(w)-1));
    L=1/(norm(u))
    plot_2D(w,'Blue','-');
    %find SV
    sv=zeros(7,1);
    for i=1:7
        pt=[ph1(i) ph2(i)];
        judge=(y(i)*([pt 1])*w);
        if(abs(judge-1)<0.0000000001)
            sv(i)=1;
            plot(pt(1),pt(2),'bs');
            hold on;
        end
    end
    %back to X domain
    figure,
    points2(x,y);
    id=find(sv==1);
    plot(x(id,1),x(id,2),'bs');
    hold on;
    h=ezplot('2*y^2-4*x-3=0');
    set(h,'Color','Blue','LineStyle','-');
    
    %6_1_2
    Q=zeros(7);
    for i=1:7
        for j=1:7
            Q(i,j)=y(i)*y(j)*(1+x(i,:)*x(j,:)')^2;
        end
    end
    f=-ones(7,1);
    Aeq=[y';y';y';y';y';y';y'];
    alpha=quadprog(Q,f,[],[],Aeq,zeros(7,1),zeros(7,1),[],ones(7,1));
    alpha(find(alpha<0.00000000001))=0
    alpha
    PH=[sqrt(2)*x(:,1) sqrt(2)*x(:,2) x(:,1).*x(:,1) sqrt(2)*(x(:,1).*x(:,2)) x(:,2).*x(:,2)]; %[x1 x2 x1^2 x1x2 x2^2]
    PH=PH';
    W=zeros(5,1);
    for i=1:7
        W=W+y(i)*alpha(i)*PH(:,i);
    end
    W
    fa=find(alpha>0);
    b=y(fa(1))-W'*PH(:,fa(1))
    SV=zeros(7,1);
    for i=1:7
        judge=y(i)*(W'*PH(:,i)+b)-1;
        if(abs(judge)<0.00000000001)
            SV(i)=1;
        end
    end
    figure,
    points2(x,y);
    id=find(SV==1);
    plot(x(id,1),x(id,2),'bs');
    hold on;
    Ea=num2str(W(1));
    Eb=num2str(W(2));
    Ec=num2str(W(3));
    Ed=num2str(W(4));
    Ef=num2str(W(5));
    Eg=num2str(b);
    Feq=[Ea '*x+' Eb '*y+' Ec '*x^2+' Ed '*x*y+' Ef '*y^2+' Eg '=0'];
    h=ezplot(Feq);
    set(h,'Color','Blue','LineStyle','-');
    
end

function points2(in,S)
    pointPx=in(find(S==1),1);
    pointPy=in(find(S==1),2);
    plot(pointPx,pointPy,'Og')
    axis([-4,4,-6,6]);
    hold on;
    pointNx=in(find(S==-1),1);
    pointNy=in(find(S==-1),2);
    plot(pointNx,pointNy,'xr')
    hold on;
end
function h=plot_2D(Eq,co,ls)
    Ea=num2str(Eq(1));
    Eb=num2str(Eq(2));
    Ec=num2str(Eq(3));
    Feq=[Ea '*x + ' Eb '*y + ' Ec '=0']
    h=ezplot(Feq);
    set(h,'Color',co,'LineStyle',ls);
    hold on;
end