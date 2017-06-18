function ML_ML7_6()
    clear
    load hw7_train.dat;
    [N D]=size(hw7_train);
    d=D-1;
    x=hw7_train(:,1:d);
    y=hw7_train(:,D);
    
    for i=0:0.001:1
        for j=0:0.001:1
            %DT
            if(-1*(j-0.626233)>=0)
                if(-1*(i-0.22444)>=0)
                    if(-1*(j-0.115153)>=0)
                        plot(i,j,'c.');
                        hold on;
                    else
                        plot(i,j,'y.');
                        hold on;
                    end
                else % -1*(i-0.22444)<0
                    if(-1*(i-0.541508)>=0)
                        if(-1*(j-0.35862)>=0)
                            if(-1*(i-0.501625)>=0)
                                plot(i,j,'c.');
                                hold on;
                            else % -1*(i-0.501625)<0
                               plot(i,j,'y.');
                               hold on;
                            end
                        else % -1*(j-0.35862)<0
                            if(-1*(i-0.260752)>=0)
                               plot(i,j,'c.');
                               hold on;
                            else % -1*(i-0.260752)<0
                               plot(i,j,'y.');
                               hold on;
                            end
                        end
                    else % -1*(i-0.541508)<0
                        if((j-0.285925)>=0)
                            plot(i,j,'c.');
                            hold on;
                        else % (j-0.285925)<0
                            if(-1*(j-0.266039)>=0)
                                plot(i,j,'c.');
                                hold on;
                            else % -1*(j-0.266039)<0
                                plot(i,j,'y.');
                                hold on;
                            end
                        end
                    end                    
                end
            else % -1*(j-0.626233)<0
                if((i-0.878171)>=0)
                    plot(i,j,'c.');
                    hold on;
                else % (i-0.878171)<0
                    plot(i,j,'y.');
                    hold on;
                end
            end
        end
    end
        
    thita=[0.626233 0.22444 0.115153 0.541508 0.35862 0.501625 0.260752 0.285925 0.266039 0.878171];
    d=[2 1 2 1 2 1 1 2 2 1];
    for i=1:10
        if(d(1,i)==1)
             thi=num2str(thita(1,i));
             Feq=['x + 0*y =' thi ];
             h=ezplot(Feq,[0,1,0,1]);
             set(h,'Color','Black','LineStyle','-');
        else
             thi=num2str(thita(1,i));
             Feq=['0*x + y =' thi ];
             h=ezplot(Feq,[0,1,0,1]);
             set(h,'Color','Blue','LineStyle','-');
        end
    end
    
    points2(x,y);
    
end

function points2(in,S)
    pointPx=in(find(S==1),1);
    pointPy=in(find(S==1),2);
    plot(pointPx,pointPy,'Ok')
    axis([0,1,0,1]);
    hold on;
    pointNx=in(find(S==-1),1);
    pointNy=in(find(S==-1),2);
    plot(pointNx,pointNy,'xr')
    hold on;
end
