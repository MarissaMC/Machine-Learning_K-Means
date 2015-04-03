% 5.3

img=imread('hw4.jpg');
[X,map]=rgb2ind(img,128);
%imshow(X,map);

% k-means
K=[3,8,15];

imgVec=[reshape(img(:,:,1),[],1) reshape(img(:,:,2),[],1) reshape(img(:,:,3),[],1)];
x1_new=double(imgVec(:,1));
x2_new=double(imgVec(:,2));
x3_new=double(imgVec(:,3));

len_x=length(x1_new);
for k=1:3

% k-means
    mu=randi([1 len_x],K(k),1);
    m=zeros(K(k),3);
    dis=zeros(len_x,K(k));
    r=zeros(len_x,K(k));
    
    for k1=1:K(k)
    m(k1,1)=x1_new(mu(k1));
    m(k1,2)=x2_new(mu(k1));
    m(k1,3)=x3_new(mu(k1));
    dis(:,k1)=(x1_new-repmat(m(k1,1),len_x,1)).^2+(x2_new-repmat(m(k1,2),len_x,1)).^2+(x3_new-repmat(m(k1,3),len_x,1)).^2;
    end
    
    r_old=r;
    r_new=ones(len_x,K(k));
    while ((min(min(r_new==r_old)))==0)
        r_old=r;
        r=zeros(len_x,K(k));
    for n=1:len_x
        t=find(min(dis(n,:))==dis(n,:));
        r(n,t)=1;
    end
    
    r_new=r;
    
    for k1=1:K(k)
    m(k1,1)=sum(x1_new.*r(:,k1))/sum(r(:,k1));
    m(k1,2)=sum(x2_new.*r(:,k1))/sum(r(:,k1));
    m(k1,3)=sum(x3_new.*r(:,k1))/sum(r(:,k1));
    dis(:,k1)=(x1_new-repmat(m(k1,1),len_x,1)).^2+(x2_new-repmat(m(k1,2),len_x,1)).^2+(x3_new-repmat(m(k1,3),len_x,1)).^2;
    end
    
    end

% end of k-means

imgVecC=m;
imgVecQK=pdist2(imgVec,imgVecC); %choosing the closest centroid to each pixel, 
[~,indMin]=min(imgVecQK,[],2);   %avoiding double for loop

imgVecNewQ=imgVecC(indMin,:);  %quantizing

imgNewQ=img;
imgNewQ(:,:,1)=reshape(imgVecNewQ(:,1),size(img(:,:,1))); %arranging back into image
imgNewQ(:,:,2)=reshape(imgVecNewQ(:,2),size(img(:,:,1)));
imgNewQ(:,:,3)=reshape(imgVecNewQ(:,3),size(img(:,:,1)));

figure,imshow(imgNewQ,[]);
str=sprintf('color value K=%d',K(k));
title(str);
end