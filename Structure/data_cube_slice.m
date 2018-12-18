function data_cube_slice(labels, available, type)
%DATA_CUBE_SLICE 此处显示有关此函数的摘要
%   此处显示详细说明
if strcmp('original', type)
    data_path = '../Data/Bbox/';
    save_path = 'Bbox/';
elseif strcmp('resize', type)
    data_path = '../Data/Resize/';
    save_path = 'Resize/';
elseif strcmp('core', type)
    data_path = '../Data/Core/';
    save_path = 'Core/';
end
patientNo = available.patientNo;
tumourNo = available.tumourNo;
Level = available.Level;
info = read_Info(patientNo, tumourNo, labels);
dataPath = [data_path patientNo];

%% 保存HCC
save_data(dataPath, Level, info, 'cube', save_path); %保存立体
save_data(dataPath, Level, info, 'slice', save_path);%保存单片

end

function info = read_Info(patientNo, tumourNo, labels)
% A:1 B:2 C:3 D:4 E:5 F:6 G:7 H:8 I:9 J:10 K:B2:11
for i=1:length(labels)
    if strcmp(labels(i).patientNo, patientNo) && labels(i).tumourNo == tumourNo
        Z = labels(i).modalNo;
        switch Z
          case 'A'
              info(1) = labels(i);
          case 'B'
              info(2) = labels(i);
              info(11) = labels(i);
          case 'C'
              info(3) = labels(i);
          case 'D'
              info(4) = labels(i);
          case 'E'
              info(5) = labels(i);
          case 'F'
              info(6) = labels(i);
          case 'G'
              info(7) = labels(i);
          case 'H'
              info(8) = labels(i);
          case 'I'
              info(9) = labels(i);
          case 'J'
              info(10) = labels(i);
        end
    end
end
end
function save_data(dataPath, Level, info, type, save_path)
if strcmp('cube', type)
    savePath = [save_path 'Cube/'];
elseif strcmp('slice', type)
    savePath = [save_path 'Slice/'];
end

data_dir = dir(dataPath);    %保存HCC区域
for i=3:length(data_dir)
    Z = data_dir(i).name(1);
    Center = info(Z-'A'+1).Center;
    Location = info(Z-'A'+1).Location;
    patientNo = info(Z-'A'+1).patientNo;
    tumourNo = info(Z-'A'+1).tumourNo;
    serNo = Center(3) - Location(5) + 1;
    if ~isempty(Center)
        load([dataPath '/' Z num2str(tumourNo) '.mat']);
        if strcmp('cube', type) && Z >= 'E' && Z <= 'J'
            P = T(:,:,serNo-2:serNo+2);
            path = [savePath Z '/' num2str(Level-1) '/'];
            if ~exist(path, 'dir')
                mkdir(path);  % 若不存在，在当前目录中产生一个子目录
            end
            save([path patientNo num2str(tumourNo) '.mat'], 'P');
        elseif strcmp('slice', type)
            P = T(:,:,serNo);
            imshow(P);
            path = [savePath Z '/' num2str(Level-1) '/'];
            if ~exist(path, 'dir')
                mkdir(path);  % 若不存在，在当前目录中产生一个子目录
            end
            save([path patientNo num2str(tumourNo) '.mat'], 'P');
            imwrite(P, [path patientNo num2str(tumourNo) '.png']);
        end
    end
end   

data_dir = dir([dataPath '_neg']); %保存背景区域
for i=3:length(data_dir)
    Z = data_dir(i).name(1);
    Center = info(Z-'A'+1).Center;
    Location = info(Z-'A'+1).Location;
    patientNo = info(Z-'A'+1).patientNo;
    tumourNo = info(Z-'A'+1).tumourNo;
    serNo = Center(3) - Location(5) + 1;
    if ~isempty(Center)
        load([dataPath '/' Z num2str(tumourNo) '.mat']);
        if strcmp('cube', type) && Z >= 'E' && Z <= 'J'
            P = T(:,:,serNo-2:serNo+2);
            path = [savePath Z '/3/'];
            if ~exist(path, 'dir')
                mkdir(path);  % 若不存在，在当前目录中产生一个子目录
            end
            save([path patientNo num2str(tumourNo) '.mat'], 'P');
        elseif strcmp('slice', type)
            P = T(:,:,serNo);
            path = [savePath Z '/3/'];
            if ~exist(path, 'dir')
                mkdir(path);  % 若不存在，在当前目录中产生一个子目录
            end
            save([path patientNo num2str(tumourNo) '.mat'], 'P');
            imwrite(P, [path patientNo num2str(tumourNo) '.png']);
        end
    end
end   

end
