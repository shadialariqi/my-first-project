% LTE_IFR_plot
% function to plot performance results, SIR and capacity versus path loss  exponent alpha

function LTE_IFR3_plot(Para, Topo, Sir_IFR3_distance, Sir_IFR3_db_distance, Cap_IFR3_distance, ...
   Sir_IFR3_network, Sir_IFR3_network_db, Cap_IFR3_network)

% a number of options for symbols which can be used in plotting curves.
plot_style = 'sd+x^vsd+x^v'; 

% plot distance specific SIR and spectrum efficiency results
for idx_alpha =1:Para.num_alpha
  alpha = Para.Set_alpha(idx_alpha);

  figure(5);
  % plot  log(y) versus x,
  semilogy(Topo.Set_distance, Sir_IFR3_distance(idx_alpha,:), ['k-' plot_style(idx_alpha)]);  
  hold on;  % to add more curves in the same figure.
  grid on;  
  xlabel('Distance away from base station (m)'); % x-axis label.
  ylabel('SIR');
  title('IFR3');
  if idx_alpha==4 & Para.num_alpha==4
    legend(['alpha=' num2str(Para.Set_alpha(1))], ['alpha=' num2str(Para.Set_alpha(2))], ...
      ['alpha=' num2str(Para.Set_alpha(3))], ['alpha=' num2str(Para.Set_alpha(4))]); % create a legend.
  end

  figure(6);
  hold on;  
  semilogy(Topo.Set_distance, Sir_IFR3_db_distance(idx_alpha,:), ['k-' plot_style(idx_alpha)]);  
  xlabel('Distance away from base station (m)');
  ylabel('SIR (dB)');
  title('IFR3');
  grid on;
  if idx_alpha==4 & Para.num_alpha==4
    legend(['alpha=' num2str(Para.Set_alpha(1))], ['alpha=' num2str(Para.Set_alpha(2))], ...
      ['alpha=' num2str(Para.Set_alpha(3))], ['alpha=' num2str(Para.Set_alpha(4))]);
  end
  
  
  figure(7);
  hold on;
  plot(Topo.Set_distance, Cap_IFR3_distance(idx_alpha,:), ['k-' plot_style(idx_alpha)]);    
  grid on;
  xlabel('Distance away from base station (m)');
  ylabel('Spectrum efficiency (bps/Hz');
  title('IFR3');
  if idx_alpha==4 & Para.num_alpha==4
    legend(['alpha=' num2str(Para.Set_alpha(1))], ['alpha=' num2str(Para.Set_alpha(2))], ...
      ['alpha=' num2str(Para.Set_alpha(3))], ['alpha=' num2str(Para.Set_alpha(4))]);
  end
 
end

% plot network wide SIR and spectrum efficiency results
  figure(103);
  plot(Para.Set_alpha, Sir_IFR3_network, 'k-s');  
  grid on;
  xlabel('Path loss exponent');
  ylabel('Average SINR');
  title('IFR3');

  figure(104);
  plot(Para.Set_alpha, Sir_IFR3_network_db, 'k-s');  
  grid on;
  xlabel('Path loss exponent');
  ylabel('Average SINR (dB)');
  title('IFR3');

  
  figure(105);
  plot(Para.Set_alpha, Cap_IFR3_network, 'k-s');  
  grid on;
  xlabel('Path loss exponent');
  ylabel('Spectrum efficiency (bps/Hz)');
  title('IFR3');
