function data_structure(savePath, type)
%DATA_STRUCTURE 此处显示有关此函数的摘要
%   此处显示详细说明
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
   mkdir(save_path);  % 若不存在，在当前目录中产生一个子目录
end

% structure0_pic(savePath, path, Info, type); %第0种数据结构：单模态图片
% structure1_pic(savePath, path, Info, type); %第1种数据结构：多模态图片----64x64x3

% structure2(savePath, path, Info, type);   %第2种数据结构：多模态单片----64x64x6  通道>3 
structure([data_path 'Cube/'], save_path); %第3种数据结构：多模态立体----64x64x5x4  

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


