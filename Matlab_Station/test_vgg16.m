clear
net = vgg16;
cam = webcam('Logitech HD Webcam C525');
s = [224 224];
while(1)
    frame1 = cam.snapshot;
    frame2 = imresize(frame1, s);
    label = classify(net, frame2);
    image(frame1);
    title(char(label));
    drawnow;
    key = get(gcf,'CurrentCharacter');
    if(key=='q')
        break;
    end
end
close all