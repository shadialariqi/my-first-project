% LTE_configuration.m

% network bandwidth in Hz 
Para.W = 5*10^6; 
% transmitted power per subcarrier.
Para.Pts = 10/1000; 
% A set of path loss exponent.
Para.Set_alpha = 2.5:0.5:4;  
Para.num_alpha = length(Para.Set_alpha);

% single cell radius;
Topo.R = 1000; 
% half distance between two adjacent base stations.
Topo.Rc = Topo.R * sin(pi/3); 

% configure number of different distances considered for distance based SIR performance calculation.
Topo.num_distance = 50;  
Topo.step_distance = Topo.R/ Topo.num_distance; 
Topo.start_distance = Topo.step_distance;
Topo.end_distance = Topo.R;
Topo.Set_distance = Topo.start_distance: Topo.step_distance: Topo.end_distance;

% total number of tiers considered in this simulation.
Topo.num_tier = 2; 
% number of user locations considered in distance based performance calculation.
Topo.num_user_per_ring = 100; 

% load the data file storing the positions of base stations and users, and channel allocation.
load bs_user_position.mat; 
% positions of the base stations. 
Topo.post_bs = post_bs; 
% store the information which tier a specific BS belongs to. 
Topo.tier_bs = tier_bs; 
% ID of frequency sub-bands used by the base stations. not used by the IFR-1 scheme, but can be useful for the IFR-3 scheme.
Topo.channel_bs_ifr3 = channel_bs_ifr3; 
% positions of the users;
Topo.post_user = post_user; 
