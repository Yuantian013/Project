%% 0.1 Clear Screen
close all
clc
clear all
%% 0.2 Load images
[im1,num1]=loadimage_MIL('sival_apple_banana/banana');
[im2,num2]=loadimage_MIL('sival_apple_banana/apple');
%% 1.0 Test
imagesc(lab2{55});
colormap(gray);
%% 1.1 Extract instances
width=35;
[part1,lab1]=extractinstances(im1,width);
%% 1.2 Extract instances
[part2,lab2]=extractinstances(im2,width);
%% 1.3 Average RGB
[info1]=extractinfo(part1,im1);
[info2]=extractinfo(part2,im2);
%% 2.0 DATA & LABEL
bags=info1';
bags(61:120)=info2';
baglabel=ones(120,1);
baglabel(61:120)=2;
%% 2.1  Bags2Dateset
data = bags2dataset(bags,baglabel);
%% 2.2  Show bag id
bagidm = getident(data,'milbag');
%% 2.3  Plot
figure(1)
plotinfo(data);
%% 3.1 Label=combineinstlabels(labels)
a = [1 2 2 2 2 2 3 3 3 4 5 6 7 8 8 4 5 6 8 9 9 0 7 6 5 7 7 7 7 7 7 7];
Label=combineinstlabels(a);
%% 4.1 Train
w=fisherc(data);
%% 4.2.1 Test
BAGLABELS=BAGTEST(w,data,bagidm);
%% 4.2.1 Error
[E,C]=testc(data*w)
%% 4.3 Assessment
Overall_Error_rate=sum(baglabel~=BAGLABELS)/120
Banana_Error_rate=sum(baglabel(1:60)~=BAGLABELS(1:60))/60
Apple_Error_rate=sum(baglabel(61:120)~=BAGLABELS(61:120))/60
%% 5.1 Improvement 1 background subtraction
[part_imp1]=part_imp(part1);
[part_imp2]=part_imp(part2);
%% 5.2 Average RGB
[info1_imp]=extractinfo(part_imp1,im1);
[info2_imp]=extractinfo(part_imp2,im2);
%% 5.3 DATA & LABEL
bags_imp=info1_imp';
bags_imp(61:120)=info2_imp';
data_imp = bags2dataset(bags_imp,baglabel);
%% 5.4  Plot
figure(2)
plotinfo(data_imp);
%% 5.5 Train 
w_imp=fisherc(data_imp);
%% 5.5 Test
bagid_imp = getident(data_imp,'milbag');
BAGLABELS_imp=BAGTEST(w_imp,data_imp,bagid_imp);
%% 5.7 Assessment
Overall_Error_rate=sum(baglabel~=BAGLABELS_imp)/120
Banana_Error_rate=sum(baglabel(1:60)~=BAGLABELS_imp(1:60))/60
Apple_Error_rate=sum(baglabel(61:120)~=BAGLABELS_imp(61:120))/60
%% 6.1 Improvement 2 
imagesc(lab2{15});
colormap(gray);
%% 