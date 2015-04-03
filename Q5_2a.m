% k-means
% 5.2a

len_x1=length(x1_new);
len_x2=length(x2_new);

K=[2,3,5];
% calculate distance
for k=1:3
    mu=randi([1 500],K(k),1);
    m=zeros(K(k),2);
    dis=zeros(len_x1,K(k));
    L=0;
    r=zeros(len_x1,K(k));
    
    for k1=1:K(k)
    m(k1,1)=x1_new(mu(k1));
    m(k1,2)=x2_new(mu(k1));
    dis(:,k1)=(x1_new-repmat(m(k1,1),len_x1,1)).^2+(x2_new-repmat(m(k1,2),len_x1,1)).^2;
    end
    
    r_old=r;
    r_new=ones(len_x1,K(k));
    while ((min(min(r_new==r_old)))==0)
        r_old=r;
        r=zeros(len_x1,K(k));
    for n=1:len_x1
        t=find(min(dis(n,:))==dis(n,:));
        r(n,t)=1;
    end
    
    L=sum(sum(dis.*r));
    r_new=r;
    
    for k1=1:K(k)
    m(k1,1)=sum(x1_new.*r(:,k1))/sum(r(:,k1));
    m(k1,2)=sum(x2_new.*r(:,k1))/sum(r(:,k1));
    dis(:,k1)=(x1_new-repmat(m(k1,1),len_x1,1)).^2+(x2_new-repmat(m(k1,2),len_x1,1)).^2;
    end
    
    end
    
    if k==1
        R1=r;
    end
    if k==2
        R2=r;
    end
    if k==3
        R3=r;
    end
end 
figure
plot(x1.*R1(:,1),x2.*R1(:,1),'.b',x1.*R1(:,2),x2.*R1(:,2),'ro');
figure
plot(x1.*R2(:,1),x2.*R2(:,1),'.b',x1.*R2(:,2),x2.*R2(:,2),'ro',x1.*R2(:,3),x2.*R2(:,3),'m*');
figure
plot(x1.*R3(:,1),x2.*R3(:,1),'.b',x1.*R3(:,2),x2.*R3(:,2),'ro',x1.*R3(:,3),x2.*R3(:,3),'m*',x1.*R3(:,4),x2.*R3(:,4),'k+',x1.*R3(:,5),x2.*R3(:,5),'gx');

