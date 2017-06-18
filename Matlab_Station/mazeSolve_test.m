
maze = [0 0 1 0 0 1; 
        0 1 0 0 0 1;
        0 0 0 1 0 0;
        1 0 0 0 0 1;
        0 0 0 1 1 0; 
        1 1 0 0 0 0]  

x =1; y =1;
[path solution] = mazeSol(maze, x, y);
if(path)
    solution
else
    disp('NO WAY OUT');
end

function [path maze] = mazeSol(maze, x, y)
    if(x==6 && y==6)
        path = 1;
        return
    else
        if(maze(x,y)==0)
            maze(x,y) = 8;
            if(y+1<=6) % check right boundary
                [path maze] = mazeSol(maze, x, y+1);
                if(path) % to right
                    path = 1;
                    return
                end
            end
            if(x+1<=6) % check down boundary
                [path maze] = mazeSol(maze, x+1, y);
                if(path) % to down
                    path = 1;
                    return
                end
            end
            if(x-1>0) % check up boundary
                [path maze] = mazeSol(maze, x-1, y);
                if(path) % to up
                    path = 1;
                    return
                end
            end
            if(y-1>0) % check left boundary
                [path maze]= mazeSol(maze, x, y-1);
                if(path) % to left
                    path = 1;
                    return
                end
            end
            maze(x,y) = 9;
            path = 0;
            return
        else
            path = 0;
            return
        end
    end
end