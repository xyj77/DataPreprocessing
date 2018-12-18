function normal_data( data_path, save_path, patientNo)
%NORMAL_DATA �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% ��ȡDICOM����

data_dir = dir(data_path);
for i=3:length(data_dir)
    if strcmp(patientNo, data_dir(i).name(1:8)) && data_dir(i).isdir
        dataPath = [data_path data_dir(i).name];
        savePath = [save_path patientNo];
        save_data(dataPath, savePath, patientNo);
    end
end

end
function save_data(dataPath, savePath, patientNo)
thresh = 100;
% B�м�����������
tag = strcmp(patientNo, '01327800') || strcmp(patientNo, '00525849') ||...
    strcmp(patientNo, '13173262') || strcmp(patientNo, '13202169') || strcmp(patientNo, '13244170');
sub_dir = dir(dataPath);
for j=3:length(sub_dir)
    Z = sub_dir(j).name(1);
    if Z >= 'A' && Z <= 'Y'
        if Z == 'B' && ~tag %����ͼ��ͬ����λ��ͬһ�ļ����£��󲿷ֵ�B
            saveB([dataPath '/' sub_dir(j).name '/'], savePath, Z, thresh);
        else                %����ͬһ�ļ����£�ACDEFGHIJ��������B��K��
            saveOthers([dataPath '/' sub_dir(j).name '/'], savePath , Z, thresh);
        end
    end
end
end

function saveB(dataPath, savePath, Z, thresh)
if ~exist(savePath,'dir') 
   mkdir(savePath);
end
data_dir = dir(dataPath);
% ��������ͼ��
D = zeros(512, 512, (length(data_dir)-2)/2);
for i=3:2:length(data_dir)
    M = dicomread([dataPath data_dir(i).name]);     % ��ȡDICOM����
    M = imresize(M, [512,512], 'bicubic');          % ��һ��,�и���ͼ��Ϊ256*256
%     M = gaussian_denoise(M);                        % ��˹�˲���ȥ��        
    D(:, :, (i-1)/2) = M;
end
min_p = min(min(min(D)));
max_p = max(max(max(D)));
D = (D - min_p) ./ (max_p - min_p - thresh);

save([savePath '/' Z], 'D');
disp([Z ' ' num2str(max_p) ' ' num2str(min_p)]);

% ����ż��ͼ��
D = zeros(512, 512, (length(data_dir)-2)/2);
for i=4:2:length(data_dir)
    M = dicomread([dataPath data_dir(i).name]);     % ��ȡDICOM����
    M = imresize(M, [512,512], 'bicubic');          % ��һ��,�и���ͼ��Ϊ256*256
%     M = gaussian_denoise(M);                        % ��˹�˲���ȥ��        
    D(:, :, (i)/2-1) = M;
end
min_p = min(min(min(D)));
max_p = max(max(max(D)));
D = (D - min_p) ./ (max_p - min_p - thresh);

save([savePath '/' 'K'], 'D');
disp(['K ' num2str(max_p) ' ' num2str(min_p)]);

end
function saveOthers(dataPath, savePath, Z, thresh)
if ~exist(savePath,'dir') 
   mkdir(savePath);
end
data_dir = dir(dataPath);
D = zeros(512, 512, length(data_dir)-2);
for i=3:length(data_dir)
    M = dicomread([dataPath data_dir(i).name]);     % ��ȡDICOM����
    M = imresize(M, [512,512], 'bicubic');          % ��һ��,�и���ͼ��Ϊ256*256
%     M = gaussian_denoise(M);                        % ��˹�˲���ȥ��        
    D(:, :, i-2) = M;
end

min_p = min(min(min(D)));
max_p = max(max(max(D)));
D = (D - min_p) ./ (max_p - min_p - thresh);

save([savePath '/' Z], 'D');
disp([Z ' ' num2str(max_p) ' ' num2str(min_p)]);

end


function Y = gaussian_denoise(I)
gausFilter = fspecial('gaussian', [5 5], 1.6);
Y = imfilter(I, gausFilter, 'replicate');
end

