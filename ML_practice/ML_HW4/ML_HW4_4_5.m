function ML_HW4_4_5()
    a=0.5*sind(1);
    b=0.5*cosd(1);
    min=exp(a)+exp(2*b)+exp(a*b)+a^2-3*a*b+4*b^2-3*a-5*b;
    th=1;
   for t=2:360
       a=0.5*sind(t);
       b=0.5*cosd(t);
       E=exp(a)+exp(2*b)+exp(a*b)+a^2-3*a*b+4*b^2-3*a-5*b;
       if(E<min)
           min=E;
           th=t;
       end
   end
   min
   th
end