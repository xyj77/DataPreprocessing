clear,clc;
load '../labels.mat';
load '../available.mat';

%% ������ģ̬���ݵ�������
for i=1:length(available)
    disp(available(i).patientNo);    
    data_cube_slice(labels, available(i), 'resize');
    data_cube_slice(labels, available(i), 'core');
%     data_cube_slice(labels, available(i), 'original');
end

%% ���ģ̬����???????????
% save_path = '../Input/';
% data_structure(save_path, 'resize');
% % data_structure(save_path, 'core');
% % data_structure(save_path, 'original');
