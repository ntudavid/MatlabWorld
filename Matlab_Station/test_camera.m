clear
cam = webcam('Logitech HD Webcam C525');
%cam = webcam;
while(1)
    frame = cam.snapshot;
    frame = imgaussfilt(frame,8);
    edges = edge(rgb2gray(frame), 'Sobel');
    imshow(edges);
    key = get(gcf,'CurrentCharacter');
    if(key=='q')
        break;
    end
    %image(edges);
    %drawnow;
end