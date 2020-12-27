% LTE_IFR_sim_dist.m
% function to be used for computing mean SIR for users located 
% at a fixed distance away from the reference BS (BS 0) 

function [SIR_avg, SIR_db_avg] = ...
    LTE_IFR_sim_dist(r, Rc, num_tier, num_user, alpha, total_post_bs, channel_bs_ifr3)

% calculate the total number of interfering base stations.
num_bs = sum(1:num_tier)*6; 

post_bs = total_post_bs(1:num_bs); % the positions of the interfering base stations.

user_vector = 1:num_user; % number of users simulated for a fixed distance r away from the reference BS.

% calculate the relative positions of the users at the fixed locations 
% with regard to the target base station at the origin (0,0).
% note that complex number (x + i*y) is used to denote the user locations  (x, y)
% and we assume the users are uniformly distributed along the ring with radius r.
post_user(user_vector) = complex( r*cos(2*pi*(user_vector-1)/(num_user)), r*sin(2*pi*(user_vector-1)/(num_user))); 

for ii=1:num_user
  % calculate the distance for a given user ii to the interfereing base stations.
  % note that temp_dist is a vector with length of num_bs;
  temp_dist = abs(post_user(ii) - post_bs); 
                                                                  
  % calculate the overall interference generated to the given user ii.
  Iext(ii) = sum(temp_dist.^(-alpha));        
  % calculate the signal to interference ratio. here the noise is not considered for simplicity.
  SIR(ii) =  (r)^(-alpha)./Iext(ii); 
  % calculate the signal to interference ratio in dB.
  SIR_db(ii) = 10*log(SIR(ii))/log(10);        
end 

% calculate the average SIR for all the users located at a given distance r from the reference BS.
SIR_avg= mean(SIR);        
SIR_db_avg= mean(SIR_db);

return;