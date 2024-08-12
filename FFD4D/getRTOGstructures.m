function ROI = getRTOGstructures(fullpath)

fid = fopen(fullpath);
    i = 0;
    while 1
        i = i+1;
        line(i) = {fgetl(fid)};
        if (line{i}==-1)
            break
        end;
    end
    fclose(fid);
    
 % Clear the white spaces in front of some field names
    for (i=1:length(line))
        text = line{i};
        if (text(1)==char(0))
            blankInd = max(find(text==char(0)));
            line{i} = text(blankInd+1:length(text));
        end
    end
    res = [1,2];
    for (i=1:length(line))
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
    ROI = {};
        % Read the header information relevant to the contour slice
    for (i=1:length(line))
        contText = line{i};
        % Look for IMAGE TYPE := STRUCTURE
        if strcmpi(contText(find(contText=='=')+2:length(contText)),'STRUCTURE')
            text = line{i+3};
            ROI = [ROI; {text(find(text=='=')+2:length(text))}];
        end
    end
    