function read_text(path, imgName)
%% �ӽ�������ȡ��ǩ����
I = imread([path, imgName]);
imshow(I),title(imgName(1:21));
%% ��ȡ��ǿ�λ��
I(:,:,1) = 1.2 .* I(:,:,1);
P = zeros(size(I));
% rectangle('Position',[30,90,450,350],'EdgeColor','r','LineWidth',1);
Rect = [440,480,90,30];
for i=90:440
    for j=30:480
        if((I(i,j,2)-I(i,j,1)-I(i,j,3))>50 || (I(i,j,1)-I(i,j,2)-I(i,j,3))>50)
            P(i,j,:) = I(i,j,:);
        end
    end
end
P = rgb2gray(P);
P = bwareaopen(P,15);
for i=90:440
    for j=30:480
        if(P(i,j))
            if(i<Rect(1)) Rect(1)=i;end
            if(i>Rect(3)) Rect(3)=i;end
            if(j<Rect(2)) Rect(2)=j;end
            if(j>Rect(4)) Rect(4)=j;end
        end
    end
end
thresh = 2;
Rect(1) = Rect(1)+thresh;Rect(2) = Rect(2)+thresh;
Rect(3) = Rect(3)-thresh;Rect(4) = Rect(4)-thresh;
Hight = Rect(3) - Rect(1) + 1; Width = Rect(4) - Rect(2) + 1;

% figure,imshow(P),hold on;
rectangle('Position',[Rect(2),Rect(1),Rect(4)-Rect(2),Rect(3)-Rect(1)],...
            'EdgeColor','b','LineWidth',1);
% hold off;

%% ��ȡͼƬ��������Ϣ
% �Ŵ�
J = [I(8:40,1:160,:); I(480:505, 1:160, :)];
J = imresize(J, 4);

ocrResult = ocr(J);
% ocrResult(J,'CharacterSet','0123456789');
display(ocrResult.Text);

% չʾ��ȡ���
% Iocr = insertObjectAnnotation(J,'rectangle',ocrResult.WordBoundingBoxes,...
%     ocrResult.WordConfidences);
% figure; imshow(Iocr);

%% ����OCR�õ�������
ser = regexp(ocrResult.Words{2},'/','split');
serNo = str2double(ser{1});
% serTotal = str2double(ser{2});
WL = str2double(ocrResult.Words{4});
WW = str2double(ocrResult.Words{6});
patientNo = ocrResult.Words{length(ocrResult.Words)-4};
if strcmp(ocrResult.Words{9}, 'T:')
    T = ocrResult.Words{10};
else
    T = ocrResult.Words{9};
end

%% ����ȡ����Ϣд�뵽�ı���
fid = fopen('img_info.txt','a+');
if strcmp(patientNo, imgName(1:8))
    fprintf(fid,'%s %d %d %d %s %d %d %d [%d %d %d %d]\n',strrep(imgName(1:12),'-',' '), serNo, WL, WW, T,...
                            Hight, Width, Hight*Width, Rect(1), Rect(2), Rect(3), Rect(4));
else
    fprintf([imgName ' ���˱�Ų�ƥ�䣡\n']);
    pause();
end
fclose(fid);

end