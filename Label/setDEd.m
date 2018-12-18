function labels = setDEd(available, labels)
%FINDD 此处显示有关此函数的摘要
%   此处显示详细说明
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

