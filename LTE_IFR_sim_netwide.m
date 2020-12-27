% LTE_IFR_sim_netwide
% function used to calculate the average network wide performance SIR

function [Sir_ifr1_avg, Sir_ifr1_db_avg, Cap_ifr1_avg] ...
  = LTE_IFR_sim_netwide(Rc, num_tier, alpha, post_bs_all, tier_bs, channel_bs_ifr3, post_user)

num_bs = sum(1:num_tier)*6; % calculate the total number of interfering base stations. 
post_bs = post_bs_all(1:num_bs); 
% R: radius of a cell serviced by a base station. 
% Rc: half distance between two neighboring  base stations.
R = Rc/(sqrt(3)/2);  

num_user = length(post_user); % the total number of users in user database.

for ii=1:num_user
  % calculate the distance  between a give location user ii and all the interfering BS.
  temp_dist_ifr1 = abs(post_user(ii) - post_bs(:)); 
  % calculate the overall interference for the fixed location user ii.
  Iext_ifr1(ii) = sum(temp_dist_ifr1.^(-alpha));    
  % calculate the SIR.
  Sir_ifr1(ii) =  (abs(post_user(ii)))^(-alpha)/Iext_ifr1(ii); 
  Sir_ifr1_db(ii) = 10*log(Sir_ifr1(ii))/log(10);
  % calculate the spectrum efficiency (capacity) by the classic Shannon formula.
  Cap_ifr1(ii) = log(1+Sir_ifr1(ii))/log(2);             
end

Sir_ifr1_avg = mean(Sir_ifr1);
Sir_ifr1_db_avg = mean(Sir_ifr1_db);
Cap_ifr1_avg = mean(Cap_ifr1);

return;




