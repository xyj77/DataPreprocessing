clear,clc;
load '../available.mat'
load '../labels.mat'
data_path = 'Mat/';

figure;
for i=1:length(available)
    disp(available(i).patientNo);
%     read_region(data_path, labels, available(i), 'orginal', 0);% ����ԭʼ��С
%     read_region(data_path, labels, available(i), 'orginal', 1);% ����ԭʼ��С
%     read_region(data_path, labels, available(i), 'resize', 0); % �ߴ��һ��
%     read_region(data_path, labels, available(i), 'resize', 1); % �ߴ��һ��
%     read_region(data_path, labels, available(i), 'core', 0);   % ��ȡ��������
%     read_region(data_path, labels, available(i), 'core', 1);   % ��ȡ��������
    read_region(data_path, labels, available(i), 'arround', 0);   % ��������ܱ���������
    read_region(data_path, labels, available(i), 'arround', 1);   % ��������ܱ���������
    disp('**********************');
end