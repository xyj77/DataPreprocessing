function labels = setDEd(available, labels)
%FINDD �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
patientNo = available.patientNo;
tumourNo = available.tumourNo;
for i=1:length(labels)
    if(strcmp(labels(i).patientNo, patientNo) && labels(i).tumourNo == tumourNo)
         labels(i).d = available.d;
         labels(i).offset = [];
         labels(i).Edmondson = available.Edmondson;
     end
end
end

