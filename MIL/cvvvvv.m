%% MILES
%% b

bags_a=info2';
bags_b=info1';
% bags = {bags_a{1:60,1}, bags_b{1:60,1}}';
% labels = [ones(60,1); 2*ones(60,1)];
% concepts = bags2dataset(bags, labels);
% concepts = concepts.data;
final_labels = zeros(120,1);
labels_ori = [ones(60,1);2*ones(60,1)];
wwww=[10,25,50,75,100,150];
for kk = 1:5
    k=wwww(kk);
    %m_all = zeros(length(concepts), 120);
    parfor i = 1:120
        baga_tem = bags_a;
        bagb_tem = bags_b;
        if i < 61
            baga_tem(i) = [];
            test = bags_a{i};
            labels = [ones(59,1); 2*ones(60,1)];
            bags = {baga_tem{1:59,1}, bagb_tem{1:60,1}}';
        else
            bagb_tem(i-60) = [];
            test = bags_b{i-60};
            labels = [ones(60,1); 2*ones(59,1)];
            bags = {baga_tem{1:60,1}, bagb_tem{1:59,1}}';
        end
        concepts = bags2dataset(bags, labels);
        concepts = concepts.data;
        for j = 1:119
            m_all(:,j) = bagembed(concepts, bags{j}(:,:), k);
        end
        m_all = m_all';
        training_data = prdataset(m_all, labels);
        w = liknonc(training_data);
        m_test = bagembed(concepts, test(:,:), k);
        final_labels(i) = labeld(m_test', w);
    end
%     m_all = m_all';
%     training_data = prdataset(m_all, labels);
    
    %[~,~,final_labels] = prcrossval(training_data, liknonc);
    %final_labels = labeld(training_data, w);
    diffe = abs(labels_ori - final_labels);
    error_rate(kk) = sum(diffe)/120;
end
%% 
figure
plot(wwww,error_rate);
grid
title('Error rate of different sigma')
xlabel('sigma')
ylabel('Error rate')
