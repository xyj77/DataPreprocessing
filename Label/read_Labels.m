clear;clc;
if exist('img_info.txt','file')
    fid = fopen('img_info.txt','w');
%     fprintf(fid, '�ļ��� ���˱�� ���к� ��λ ���� �� �� ��� ����λ��[l,u,r,d] ���\n');
    fprintf(fid, '');
    fclose(fid);
end

%% ��ȡͼƬ�еı�ע��Ϣ������img_info.txt
path = 'label_img\';
file=dir( path );
for i=3:length(file)
     read_text(path, file(i).name);
     pause(0.02);
end

%% �ϲ���ǩ��Ϣ
labels = merge_info('img_info.txt', 'excel_info.txt');
save('../labels.mat', 'labels');
%% ��ȡ���ͼ����������
% read_Region('label_img\', 'label.txt');

%% �������ͼ���б�
avail;



