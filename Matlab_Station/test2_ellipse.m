im = imread('ellipse.jpg');
im3(:,:,1) = im;
im3(:,:,2) = im;
im3(:,:,3) = im;
s = size(im); 
ss = round(s/10);
ims = imresize(im, ss);

%imbw = edge(img, 'Canny');
% edges define
edgeShreshold = 200;
imbw = zeros(ss(1),ss(2),'uint8');
for i = 1:ss(1)
    for j = 1:ss(2)
        if(ims(i,j)<edgeShreshold)
            imbw(i,j)=255;
        end
    end
end

cnt = zeros(ss(2), ss(1), 50, 50);

tic
% voting
for cx = 1:ss(2)
    for cy = 1:ss(1)
        for a = 5:2:50
            for b = 5:2:50
                for t = 1:360
                    x = cx + round(a*cosd(t));
                    y = cy + round(b*sind(t));
                    if( x<1 || y<1 || x>ss(2) || y>ss(1))
                    
                    else
                        if(imbw(y,x)==255)
                            cnt(cx, cy, a, b) = cnt(cx, cy, a, b) + 1;
                        end
                    end
                end
            end
        end
    end
end

%detection
voteShreshold = 155
candidates = [];
for cx = 1:ss(2)
    for cy = 1:ss(1)
        for a = 1:50
            for b = 1:50
                votes = cnt(cx, cy, a, b);
                if( votes > voteShreshold )
                    Cx = 10*cx;
                    Cy = 10*cy;
                    A = 10*a;
                    B = 10*b;
                    vec = [Cx Cy A B votes];
                    candidates = [candidates; vec];
                end
            end
        end
    end
end
toc

% screening
distanceThreshold = 100
n = size(candidates);
n = n(1);
dis = zeros(n,n);
for i = 1:n
    for j = i+1:n
        c1 = [candidates(i,1) candidates(i,2)];
        c2 = [candidates(j,1) candidates(j,2)];
        dis(i,j) = norm(c1-c2);
    end
end
removeList = zeros(1,n);
for i = 1:n
    for j = i+1:n
        if(dis(i,j)<distanceThreshold)
            % compare votes
            if(candidates(i,5)>candidates(j,5))
                % delete j
                removeList(1,j) = 1;
            else
                % delete i
                removeList(1,i) = 1;
            end 
        end
    end
end
%selection
selectList = 1 - removeList;
detection = [];
for i = 1:n
    if(selectList(1,i)==1)
        detection = [detection; candidates(i,:)];
    end
end

% drawing ellipses
n = size(detection);
n = n(1);
for i = 1:n
    Cx = detection(i,1);
    Cy = detection(i,2);
    A = detection(i,3);
    B = detection(i,4);
    for t = 1:360
        x = Cx + round(A*cosd(t));
        y = Cy + round(B*sind(t));
        if( x<1 || y<1 || x>s(2) || y>s(1))
                           
        else
            im3(y,x,1) = 255;
            im3(y,x,2) = 0;
            im3(y,x,3) = 0;
        end
    end
end
figure,
imshow(im3)
