% Q5_2b
% K=4
len_x1=length(x1_new);
L=zeros(50,5);

for i=1:5
    mu=randi([1 500],4,1);
    m=zeros(4,2);
    dis=zeros(len_x1,4);
    r=zeros(len_x1,4);
    
    for k1=1:4
        m(k1,1)=x1_new(mu(k1));
        m(k1,2)=x2_new(mu(k1));
        dis(:,k1)=(x1_new-repmat(m(k1,1),len_x1,1)).^2+(x2_new-repmat(m(k1,2),len_x1,1)).^2;
    end
    
    for a=1:50
        r=zeros(len_x1,4);
        for n=1:len_x1
            t=find(min(dis(n,:))==dis(n,:));
            r(n,t)=1;
        end
        for k1=1:4
            m(k1,1)=sum(x1_new.*r(:,k1))/sum(r(:,k1));
            m(k1,2)=sum(x2_new.*r(:,k1))/sum(r(:,k1));
            dis(:,k1)=(x1_new-repmat(m(k1,1),len_x1,1)).^2+(x2_new-repmat(m(k1,2),len_x1,1)).^2;
        end
        L(a,i)=sum(sum(dis.*r));
    end
end
b=1:50;
figure
plot(b,L(:,1),'-.b',b,L(:,2),'-ro',b,L(:,3),'m*-',b,L(:,4),'k+-',b,L(:,5),'gx-');