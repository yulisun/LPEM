function [Esc_edgeWeights,Elc_edgeWeights] = EnergyConstruction(Cosup,alpha,beta,t1_feature,t2_feature,Kmat_xy)
[h,w]   = size(Cosup);
nbr_sp  = max(Cosup(:));
idx_t1 = label2idx(Cosup);
for i = 1:nbr_sp
    index_vector = idx_t1{i};
    [location_x, location_y] = ind2sub(size(Cosup),index_vector);
    location_center(i,:) = [round(mean(location_x)) round(mean(location_y))];
end
%%  Spatially-adjacent
adj_mat = zeros(nbr_sp);
for i=2:h-1
    for j=2:w-1
        label = Cosup(i,j);
        if (label ~= Cosup(i+1,j-1))
            adj_mat(label, Cosup(i+1,j-1)) = 1;
        end
        if (label ~= Cosup(i,j+1))
            adj_mat(label, Cosup(i,j+1)) = 1;
        end
        if (label ~= Cosup(i+1,j))
            adj_mat(label, Cosup(i+1,j)) = 1;
        end
        if (label ~= Cosup(i+1,j+1))
            adj_mat(label, Cosup(i+1,j+1)) = 1;
        end
    end
end
adj_mat_1 = double((adj_mat + adj_mat')>0);

R = 2*round(sqrt(h*w/nbr_sp));
adj_mat = zeros(nbr_sp);
for i=1:nbr_sp
    for j = i:nbr_sp
        if ((location_center(i,1) - location_center(j,1))^2 + (location_center(i,2) - location_center(j,2))^2 < R^2)
            adj_mat (i,j) = 1;
        end
    end
end
adj_mat = double((adj_mat + adj_mat')>0);
adj_mat_2 = adj_mat - eye(nbr_sp);
adj_mat = adj_mat_1|adj_mat_2;
%% Elc
Elc_edgeWeights = zeros(sum(adj_mat(:)),6);
[node_x, node_y] = find(adj_mat ==1);
Elc_edgeWeights(:,1) = node_x; % index of node 1
Elc_edgeWeights(:,2) = node_y; % index of node 2
for i = 1:sum(adj_mat(:))
    index_node_x = Elc_edgeWeights(i,1);
    index_node_y = Elc_edgeWeights(i,2);
    feature_t1_x = t1_feature(:,index_node_x);
    feature_t1_y = t1_feature(:,index_node_y);
    feature_t2_x = t2_feature(:,index_node_x);
    feature_t2_y = t2_feature(:,index_node_y);
    Dxy_t1(i) = norm(feature_t1_x-feature_t1_y,2)^2;
    Dxy_t2(i) = norm(feature_t2_x-feature_t2_y,2)^2;
    dist(i) = max(norm(location_center(index_node_x,:)-location_center(index_node_y,:),2),1);
end
rho_t1 = mean(Dxy_t1);
rho_t2 = mean(Dxy_t2);

for i =  1:sum(adj_mat(:))
    if Dxy_t1(i) > rho_t1 && Dxy_t2(i) > rho_t2
        Vxy(i) = 1/2;
    else
        sig_temp = 2*(Dxy_t1(i)-rho_t1)*(Dxy_t2(i) - rho_t2)/rho_t1/rho_t2;
        Vxy(i) = sigmoid(sig_temp);
    end
    Wxy(i) = 0;
end
Vxy = Vxy ./dist;
Elc_edgeWeights(:,3) = Wxy;                  % node 1 ---> node 2
Elc_edgeWeights(:,6) = Wxy;                  % node 2 ---> node 1
Elc_edgeWeights(:,4) = Vxy;                  % node 1 ---> node 2
Elc_edgeWeights(:,5) = Vxy;                  % node 2 ---> node 1
%% KNN
X = t1_feature';
Y = t2_feature';
kmax = max(Kmat_xy(:))+1;
Kadj_matx = zeros(nbr_sp);
Kadj_maty = zeros(nbr_sp);
[idx_org, ~] = knnsearch(X,X,'k',kmax);
[idy_org, ~] = knnsearch(Y,Y,'k',kmax);
for i = 1: nbr_sp
    kx = Kmat_xy(i,1);
    ky = Kmat_xy(i,2);
    idx_org_k = idx_org(i,2:kx);
    idy_org_k = idy_org(i,2:ky);
    sigma_x(i) = max(pdist2(X(idx_org_k,:),X(i,:)).^2);
    sigma_y(i) = max(pdist2(Y(idy_org_k,:),Y(i,:)).^2);
    Kadj_matx(i,idx_org_k) = 1;
    Kadj_maty(i,idy_org_k) = 1;
end
%% Esc
KedgeWeights_x = zeros(sum(Kadj_matx(:)),6);
[Knodex_i Knodex_j] = find(Kadj_matx ==1);
KedgeWeights_x(:,1) = Knodex_i; % index of node 1
KedgeWeights_x(:,2) = Knodex_j; % index of node 2

KedgeWeights_y = zeros(sum(Kadj_maty(:)),6);
[Knodey_i Knodey_j] = find(Kadj_maty ==1);
KedgeWeights_y(:,1) = Knodey_i; % index of node 1
KedgeWeights_y(:,2) = Knodey_j; % index of node 2
for i = 1:sum(Kadj_matx(:)) % KNN of X
    index_node_i = KedgeWeights_x(i,1);
    index_node_j = KedgeWeights_x(i,2);
    feature_t2_i = t2_feature(:,index_node_i);
    feature_t2_j = t2_feature(:,index_node_j);
    feature_t2_distance(i) = (norm(feature_t2_i-feature_t2_j,2)^2);
    dist_t2(i) =  feature_t2_distance(i)- sigma_y(index_node_i); % d - sigma_y
end
for i = 1:sum(Kadj_maty(:)) % KNN of X
    index_node_i = KedgeWeights_y(i,1);
    index_node_j = KedgeWeights_y(i,2);
    feature_t1_i = t1_feature(:,index_node_i);
    feature_t1_j = t1_feature(:,index_node_j);
    feature_t1_distance(i) = (norm(feature_t1_i-feature_t1_j,2)^2);
    dist_t1(i) =  feature_t1_distance(i)- sigma_x(index_node_i); % d - sigma_x
end
KedgeWeights_x(:,6) = dist_t2;
KedgeWeights_y(:,6) = dist_t1;
KedgeWeights_x(:,3) = min(dist_t2,0);
KedgeWeights_y(:,3) = min(dist_t1,0);
%% alpha, beta
alpha = alpha*nbr_sp/(sum(KedgeWeights_x(:,3))+sum(KedgeWeights_y(:,3))+sum(KedgeWeights_x(:,6))+sum(KedgeWeights_y(:,6)));
beta = beta*nbr_sp/(sum(Elc_edgeWeights(:,4))+sum(Elc_edgeWeights(:,5)));
%% Elc and Esc
Elc_edgeWeights(:,3:6) = beta*Elc_edgeWeights(:,3:6);
KedgeWeights_x(:,3:6) = alpha*KedgeWeights_x(:,3:6);
KedgeWeights_y(:,3:6) = alpha*KedgeWeights_y(:,3:6);
Esc_edgeWeights =  [KedgeWeights_x;KedgeWeights_y];
