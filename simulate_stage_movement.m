%Simulate the movement of the eyes across a scene.  
%Load up a sample image in this case a scene of a marina
%into the workspace. 
degreeToPixelShift=size(marina,2)/150;
[Ycoor,Xcoor,Colors]=size(marina);
Ycoor=Ycoor/2;
Xcoor=Xcoor/2;

centerFrame=marina(Ycoor-200:Ycoor+200,...
Xcoor-400:Xcoor+400,:); %Get the center of the field of the view

imshow(centerFrame)

figure; plot(ThrSpeed)
%% High Speed 
%%Translate the speed into movements with 500 fps frame rate
Pos=zeros(1);
for i=2:1000
    Filt=Filtered(i)*166;
    if abs(Filt)>40
        Pos(i)=Filt/500+Pos(i-1);
    else
        Pos(i)=Pos(i-1);
    end
end



%%Apply the distance moved to the image.  
tic
for i=1:1000
    centerFrame=marina(Ycoor-200:Ycoor+200,Xcoor-400+Pos(i)*degreeToPixelShift:Xcoor+Pos(i)*degreeToPixelShift+400,:); %Get the center of the field of the view
    if mod(i,1)==0
        %imshow(centerFrame)
        imwrite(imresize(centerFrame,0.5),['marina_',num2str(i),'.png'])
    end
end
toc

%%

Filtered50fps=Filtered(1:10:100);
%%Translate the speed into movements with 50 fps
Pos50fps=zeros(1);
for i=2:size(Filtered50fps)
    Filt=Filtered50fps(i)*166;
    if abs(Filt)>100
        Pos50fps(i)=Filt/50+Pos50fps(i-1);
    else
        Pos50fps(i)=Pos50fps(i-1);
    end
end





tic
for i=1:100
    centerFrame=marina(Ycoor-200:Ycoor+200,Xcoor-400+Pos50fps(i)*degreeToPixelShift:Xcoor+Pos50fps(i)*degreeToPixelShift+400,:); %Get the center of the field of the view
    if mod(i,1)==0
        %imshow(centerFrame)
        imwrite(centerFrame,['marina50fps_',num2str(i),'.png'])
    end
end
toc
