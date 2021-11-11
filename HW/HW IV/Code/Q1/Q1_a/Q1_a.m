s = tf('s');
G = (s + 1) * (s + 4) * (s + 8) / (s^3 * (s^2 + 0.2 * s + 100));
K = [.5 1 5]; % plot chart for this gain
for i = 1:length(K)
    nichols(K(i) * G); % plot nichols
    fig_dir_name = append('../../../Figure/Q1/Q1_a/Q1_aK_', string(K(i)), ...
                          '.png'); % figure name and directory
%     print(fig_dir_name,'-dpng','-r400');
end
    