loadc = load_cont;
waitfor(loadc);
segname = getappdata(0,'segname');
fullpath = getappdata(0,'filepath');
fid = fopen(fullpath{1});
line = {};
    i = 0;
    while 1
        i = i+1;
        line(i) = {fgetl(fid)};
        if (line{i}==-1)
            break
        end;
    end
    fclose(fid);
                                points2 = [];
 % Clear the white spaces in front of some field names
    for i=1:length(line)
        text = line{i};
        if (text(1)==char(0))
            blankInd = max(find(text==char(0)));
            line{i} = text(blankInd+1:length(text));
        end
    end
    res = [1,2];
    for i=1:length(line)
        text = line{i};
        % Look for SIZE OF DIMENSION 1
        if ~isempty(findstr(text,'SIZE OF DIMENSION 1'))
                % Store the dimensions
                dim1 = str2num(text(find(text=='=')+1:length(text)));
                text = line{i+1};
                dim2 = str2num(text(find(text=='=')+1:length(text)));
                text = line{i+2};
                zoff = str2num(text(find(text=='=')+1:length(text)));
                text = line{i+3};
                xoff = str2num(text(find(text=='=')+1:length(text)));
                text = line{i+4};
                yoff = str2num(text(find(text=='=')+1:length(text)));
                text = line{i-4};
                res(1) = str2num(text(find(text=='=')+1:length(text)));
                text = line{i-5};
                res(2) = str2num(text(find(text=='=')+1:length(text)));
                % Find the line where the information of this slice ends            
                break;
        end
     end
    
        % Read the header information relevant to the contour slice
    for i=1:length(line)
        contText = line{i};
        % Look for IMAGE TYPE := STRUCTURE
        if strcmpi(contText(find(contText=='=')+2:length(contText)),'DOSE VOLUME HISTOGRAM')
            text = line{i+3};
            if strcmpi(text(find(text=='=')+2:length(text)),segname{1})
                text = line{i-1};
                % Store the slice number dose is stored in
                contSlice = str2num(text(find(text=='=')+1:length(text)));

                % Find the line where the information of this slice ends
                j = 0;
                while 1
                    contText = line{i+j};
                    if (contText~=-1)         % Haven't reached EOF
                        % Look for IMAGE # := n
                        if strcmpi(contText(1:7),'IMAGE #')
                            endInterval = i+j;
                            break
                        end
                    else
                        endInterval = i+j;
                        break;
                    end
                    j = j+1;
                end
                % Retrieve all the information in this contour slice
                sliceInfo = {line{(i-1):(endInterval-1)}};
                break;
            end
        end
    end
clear line
path = strrep(fullpath,'0000',['0' num2str(contSlice)]);
fid = fopen(path{1});
line = fgetl(fid);
line = fgetl(fid);
DVH = [];
while 1
    line = fgetl(fid);
       if line == -1
        break
    end
    [token, remain] = strtok(line,','); 

    DVH = [DVH; str2num(token),str2num(strrep(remain,',',''))];
 
    line = fgetl(fid);
 
end
cDVH = [];
for n = 1:length(DVH)
cDVH(n) = sum(DVH(n:end,2));
end
[file,path] = uiputfile('*.xls','Save DVH as');
 xlswrite([path file],[DVH(:,1),cDVH']);
% xlswrite('C:\Documents and
% Settings\markeld\Desktop\Kanagarathnam_DVH\Plan_GTV\0%.xls', [DVH(:,1),cDVH']);
