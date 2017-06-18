

tic 
fib_re(40)
toc

tic 
fib_it(40)
toc

function f = fib_re(n)
    if(n==0)
        f = 0;
    elseif(n==1)
        f = 1;
    else
        f = fib_re(n-1)+fib_re(n-2);
    end
end

function f = fib_it(n)
    a = 0;
    b = 1;
    if(n==0)
        f = 0;
    elseif(n==1)
        f = 1;
    else
        for i = 2:n
            f = a+b;
            a = b;
            b = f;
        end    
    end  
end