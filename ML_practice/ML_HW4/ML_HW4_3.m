function ML_HW4_3()
    x=[-0.1,0.2];
    y=[0.85,-0.9];
    z=[-0.6,0.7];
    w=[0.1,-0.2];
    plot(x,y,'xr');
    axis([-2,2,-2,2]);
    hold on;
    plot(z,w,'Og');
    hold on;
    ezplot('x^2+0.1*y^2-0.2=0');
   
    x2=x.^2;  
    y2=y.^2;
    z2=z.^2;  
    w2=w.^2;
    figure,
    plot(x2,y2,'Og');
    axis([0,1,0,1]);
    hold on;
    plot(z2,w2,'xr');
    hold on;
    ezplot('x+0.1*y-0.2=0');
end