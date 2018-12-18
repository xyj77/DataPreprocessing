function data_structure(savePath, type)
%DATA_STRUCTURE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
if strcmp('original', type)
    data_path = '/Bbox/';
    save_path = [savePath 'Bbox/'];
elseif strcmp('resize', type)
    data_path = 'Resize/';
    save_path = [savePath 'Resize/'];
elseif strcmp('core', type)
    data_path = 'Core/';
    save_path = [savePath 'Core/'];
end
if ~exist(save_path,'dir') 
   mkdir(save_path);  % �������ڣ��ڵ�ǰĿ¼�в���һ����Ŀ¼
end

% structure0_pic(savePath, path, Info, type); %��0�����ݽṹ����ģ̬ͼƬ
% structure1_pic(savePath, path, Info, type); %��1�����ݽṹ����ģ̬ͼƬ----64x64x3

% structure2(savePath, path, Info, type);   %��2�����ݽṹ����ģ̬��Ƭ----64x64x6  ͨ��>3 
structure([data_path 'Cube/'], save_path); %��3�����ݽṹ����ģ̬����----64x64x5x4  

end

function structure(dataPath, savePath)
M = {['E' num2str(info.tumourNo)], ['F' num2str(info.tumourNo)], ['G' num2str(info.tumourNo)],...
    ['H' num2str(info.tumourNo)], ['I' num2str(info.tumourNo)], ['J' num2str(info.tumourNo)]}; %(1)
% M = {['E' num2str(info.tumourNo)], ['G' num2str(info.tumourNo)], ['H' num2str(info.tumourNo)], ['I' num2str(info.tumourNo)]};%(2)
% M = {['E' num2str(info.tumourNo)], ['F' num2str(info.tumourNo)]}; %(3)
% M = {['E' num2str(info.tumourNo)], ['F' num2str(info.tumourNo)], ['G' num2str(info.tumourNo)]}; %(4)
% M = {['H' num2str(info.tumourNo)], ['I' num2str(info.tumourNo)]}; %(5)
% M = {['H' num2str(info.tumourNo)], ['I' num2str(info.tumourNo)], ['J' num2str(info.tumourNo)]}; % (6)




end


