


clear all; % clear all variables in workspace
close all; % close all figure windows.
clc;         % clear the command window.

% display a welcome message
disp('>> Welcome to the simulation of frequence reuse scheme for LTE networks.');   
disp('  ');
disp('Main program started.');
disp('  ');

LTE_configuration; % Matlab script file, configurating system and simulation parameters.

% calculate IFR1 performances against the distance of user to target base station.
for idx_alpha =1: Para.num_alpha
  alpha = Para.Set_alpha(idx_alpha); 
  % Para.Set_alpha store a vector of alpha, 
  % which is the path loss exponent used in signal propagation in space.

  disp(['   Path loss exponent alpha= ' num2str(alpha)]);  
  disp('    Calculate mean SIR of users with fixed distance from BS:');

  for idx_distance=1:Topo.num_distance
    % call function LTE_IFR1_sim_dist to calculate the SIR performance of users
    % located at fixed distanced away from the reference BS (cell 0).
    temp_distance = Topo.Set_distance(idx_distance);
    
    [Sir_IFR1_distance(idx_alpha, idx_distance), Sir_IFR1_db_distance(idx_alpha, idx_distance)] = ...
      LTE_IFR_sim_dist(temp_distance, Topo.Rc, Topo.num_tier, Topo.num_user_per_ring, alpha, Topo.post_bs);
  
    Cap_IFR1_distance(idx_alpha, idx_distance) = log(1 + Sir_IFR1_distance(idx_alpha, idx_distance)); 
  end
  
    for idx_distance=1:Topo.num_distance
    % call function LTE_IFR3_sim_dist to calculate the SIR performance of users
    % located at fixed distanced away from the reference BS (cell 0).
    temp_distance = Topo.Set_distance(idx_distance);
    
    [Sir_IFR3_distance(idx_alpha, idx_distance), Sir_IFR3_db_distance(idx_alpha, idx_distance)] = ...
      LTE_IFR3_sim_dist(temp_distance, Topo.Rc, Topo.num_tier, Topo.num_user_per_ring, alpha, Topo.post_bs,Topo.channel_bs_ifr3);
  
    Cap_IFR3_distance(idx_alpha, idx_distance) = log(1 + Sir_IFR3_distance(idx_alpha, idx_distance)); 
  end

  disp('   Calculate mean network wide SIR and capacity performance:');
  disp('  ');
     
  % call LTE_IFR_sim_netwide to calculate the SIR performance of users
  % located at fixed distanced away from the reference BS (cell 0).
  [Sir_IFR1_network(idx_alpha), Sir_IFR1_network_db(idx_alpha), Cap_IFR1_network(idx_alpha)] = ...
      LTE_IFR_sim_netwide(Topo.Rc, Topo.num_tier, alpha, Topo.post_bs, Topo.tier_bs, Topo.channel_bs_ifr3, Topo.post_user);    
  
  % call LTE_IFR3_sim_netwide to calculate the SIR performance of users
  % located at fixed distanced away from the reference BS (cell 0).
  [Sir_IFR3_network(idx_alpha), Sir_IFR3_network_db(idx_alpha), Cap_IFR3_network(idx_alpha)] = ...
      LTE_IFR3_sim_netwide(Topo.Rc, Topo.num_tier, alpha, Topo.post_bs, Topo.tier_bs, Topo.channel_bs_ifr3, Topo.post_user); 
end

% plot the results into figures.
LTE_IFR_plot(Para, Topo, Sir_IFR1_distance, Sir_IFR1_db_distance, Cap_IFR1_distance, ...
  Sir_IFR1_network, Sir_IFR1_network_db, Sir_IFR1_network_db);
LTE_IFR3_plot(Para, Topo, Sir_IFR3_distance, Sir_IFR3_db_distance, Cap_IFR3_distance, ...
  Sir_IFR3_network, Sir_IFR3_network_db, Sir_IFR3_network_db);


disp('Main program end.');