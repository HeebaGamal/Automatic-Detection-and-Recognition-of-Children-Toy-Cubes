I=imread('TestCases\Case2\2.1.jpg');

figure , imshow(I);
I  = rgb2gray(I);
BW = imbinarize(I,0.3);

BW = imcomplement(BW);

BW = medfilt2(BW);

figure , imshow(BW);

s = regionprops(BW,'BoundingBox');
bboxes = vertcat(s(:).BoundingBox);

[~,ord] = sort(bboxes(:,2));
bboxes = bboxes(ord,:);

BW = imdilate(BW,strel('disk',1));

figure,imshow(BW);

ocrResults = ocr(BW,bboxes,'CharacterSet','T','TextLayout','word');
%ocrResults = ocr(BW);
disp(ocrResults);



function [img]=yep_yep(imgdouble)
   
    [L,N] = bwlabel(imgdouble);
    disp(N)
    %vislabels(L)
    prop = regionprops (L,'Area' , 'Perimeter');
    init_area = 10 ;

    for i=1:N
        if prop(i).Area > init_area
            init_area = prop(i).Area ;
            img =  imcrop(imgdouble, [1 0 200 0 ]);
            figure, imshow(img);
        end
    end
end