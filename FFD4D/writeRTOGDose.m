function [doses3D,sizeDose,xCoord,yCoord,zCoord,params] = readRTOGDose(fullPath)
% READRTOGDOSE M-file
% - Subroutine that retrieves calculated doses from a RTOG plan
% - The correct dose file is selected by reading the RTOG header file (0000)
% - Note: format of doses3D is (y,x,z)
%         same output format as readDoseFile

% -------------------------------
% readDoseFile.m
% - Written by Michael K.K. Leung
% - August 11, 2006
% -------------------------------
% To do...
% - Improve robustness of reading dose files (own version)
% - Now using CERR version
%   -> Author: J. O. Deasy, deasy@radonc.wustl.edu

%**************************************************************************
% Format of RTOG dose File
% See: http://itc.wustl.edu/exchange_files/tapeexch400.htm#ch10.1

% "Number of planes is "  101
%    "Z-coordinate is  " -15.200
%       0.000,  0.000,  0.000,  0.000,  0.012,  0.012,  0.013,  0.013
%       0.014,  0.015,  0.016,  0.016,  0.017,  0.018,  0.019,  0.019
%       0.020,  0.021,  0.022,  0.022,  0.023,  0.024,  0.024,  0.025
%       0.026,  0.026,  0.027,  0.028,  0.028,  0.029,  0.029,  0.030
%       0.030,  0.031,  0.031,  0.032,  0.032,  0.032,  0.033,  0.033
%       0.033,  0.033,  0.033,  0.033,  0.033,  0.033,  0.033,  0.033
%       0.033,  0.032,  0.032,  0.032,  0.031,  0.031,  0.031,  0.030
%         .       .       .       .       .       .       .       .
% 
% Numbers listed in this order: Fix y, list all x coordinates, repeat
% - Assume convention (x,y), then:
%   (1,1) first,  (2,1) second,  (3,1) third...
%   ...
%   (n,1),  (n,2),  (n,3) ...
%   ...
%
% The output of function in MATLAB is also of the same form:
%   first   second   third ...

%**************************************************************************

try
    fid = fopen(fullPath);
catch
    [sFileName,sFolder] =  uigetfile('*.*','Browse for the RTOG 0000 header file...');
    fullPath = [sFolder sFileName];
    if (fullPath~=0)
        fid = fopen(fullPath)
    else
        doses3D = [];
        sizeDose = [];
        xCoord = [];
        yCoord = [];
        zCoord = [];
        return;
    end
end

try
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

    for (i=1:length(line))
         text = line{i};

        if strcmpi(text(1:find(text=='S')), 'GRID 1 UNITS')
             dim1_unit = str2num(text(find(text=='=')+1:length(text)));
             text = line{i+1};
             dim2_unit = str2num(text(find(text=='=')+1:length(text)));
             text = line{i+5};
             dim1 = str2num(text(find(text=='=')+1:length(text)));
             text = line{i+6};
             dim2 = str2num(text(find(text=='=')+1:length(text)));
             text = line{i+7};
             z_off = str2num(text(find(text=='=')+1:length(text)));
             text = line{i+8};
             x_off = str2num(text(find(text=='=')+1:length(text)));
             text = line{i+9};
             y_off = str2num(text(find(text=='=')+1:length(text)));
             params = [dim1,dim2,dim1_unit,dim2_unit,z_off,x_off,y_off];
             break
        end
    end
    % Read the header information relevant to the DOSE slice
    for (i=1:length(line))
        doseText = line{i};
        % Look for IMAGE TYPE := DOSE
        if strcmpi(doseText(find(doseText=='=')+2:length(doseText)),'DOSE')
            text = line{i-1};
            % Store the slice number dose is stored in
            doseSlice = str2num(text(find(text=='=')+1:length(text)));

            % Find the line where the information of this slice ends
            j = 0;
            while 1
                doseText = line{i+j};
                if (doseText~=-1)         % Haven't reached EOF
                    % Look for IMAGE # := n
                    if strcmpi(doseText(1:7),'IMAGE #')
                        endInterval = i+j;
                        break
                    end
                else
                    endInterval = i+j;
                    break;
                end
                j = j+1;
            end
            % Retrieve all the information in this dose slice
            sliceInfo = {line{(i-1):(endInterval-1)}};
            break;
        end
    end

    % Get the x,y coordinates of the doses
    text = sliceInfo{11};
    xDim = str2num(text(find(text=='=')+1:length(text)));
    text = sliceInfo{12};
    yDim = str2num(text(find(text=='=')+1:length(text)));
    text = sliceInfo{13};
    zDim = str2num(text(find(text=='=')+1:length(text)));
    text = sliceInfo{14};
    xCoord = str2num(text(find(text=='=')+1:length(text)));
    text = sliceInfo{15};
    yCoord = str2num(text(find(text=='=')+1:length(text)));
    text = sliceInfo{16};
    xGridInt = str2num(text(find(text=='=')+1:length(text)));
    text = sliceInfo{17};
    yGridInt = str2num(text(find(text=='=')+1:length(text)));

    xCoord = xCoord:xGridInt:((xDim-1)*xGridInt+xCoord);
    yCoord = yCoord:yGridInt:((yDim-1)*yGridInt+yCoord);

    % Set up before reading dose file
    % - dimension of doses
    sizeDose = [xDim, yDim, zDim];

    % Find the directory of the header file
    k = max(findstr(fullPath,'\'));
    dirName = fullPath( 1:k );
    baseFilename = fullPath(k+1:length(fullPath)-4);

catch
    warning(['Failed to read RTOG header file:' fullPath])
    doses3D = [];
    sizeDose = [];
    xCoord = [];
    yCoord = [];
    zCoord = [];
    return;
end

fid = fopen([dirName baseFilename num2str(doseSlice,'%.4i')],'r');
% -------------------------------------------
% Author: J. O. Deasy, deasy@radonc.wustl.edu
% - Code from importDose.m found in CERR,
%   with some modifications
%   -> http://radium.wustl.edu/CERR/
% ----------------- BEGIN -------------------
textV = fread(fid,'uchar=>uchar');    %8-bit unsigned character vector
      
%First get the Z-values:
indZV = find([textV == 90] | [textV == 122]); %Z or z.

indV = find( textV == 13);   %endofline = 13

for i = 1 : length(indZV)
    ind = 1;
    while textV(indZV(i)+ind)~=13 %Locate EOL
        ind = ind +1;
    end
    tmpV = textV(indZV(i):indZV(i)+ind);
    tmpV(tmpV==34) = 32;  %Replace last '"' with a blank
    str = char(tmpV');    %Convert to a string
    tmp2 = str(find(str=='s')+1:length(str));
    zValuesV(i) = str2num(tmp2);
end

%Now process the dose values:

delV = [];
if any([textV(1:indV(1)) == 34])  %First line is a comment ( '"' = 34)
    delV = [1:indV(1)];
end
for i = 1 : length(indV) - 1
    if any([textV(indV(i)+1:indV(i+1)) == 34])
        delV = [delV, indV(i)+1:indV(i+1)];
    end
end

textV(delV) = [];
textV(textV == 13) = 32;    %Replace EOLs with spaces
textV(textV<32) = []; %Delete non-printing characters

textV(textV == 44) = []; %commas
textV = char(textV');   %Inplace to reduce memory usage.
doses3D = sscanf(textV','%f');  %convert to numbers

clear textV

doses3D = reshape(doses3D, sizeDose);

len = size(doses3D,3);
for i = 1 : len
    % Re-orient the doses
    % Also exchange the order of the dose slices
    tmp(:,:,len-i+1) = doses3D(:,:,i)';
end
doses3D = tmp;

fclose(fid);

% ------------------ END --------------------
zCoord = zValuesV;

% -------------------------------------------
% Own code with the same function, but much
% slower for large doses
% ----------------- BEGIN -------------------
% % Read the dose file
% fid = fopen([dirName baseFilename num2str(doseSlice,'%.4i')]);
% % - Skip the first line
% dummy = fgetl(fid);
% % - Read in ASCII text file
% i = 0;
% while 1
%     i = i+1;
%     dLine(i) = {fgetl(fid)};
%     if (dLine{i}==-1)
%         break
%     end;
% end
% fclose(fid);
% 
% % Clear the white spaces in front of some field names
% for (i=1:length(dLine))
%     text = dLine{i};
%     try
%         if (text(1)==char(0))
%             blankInd = max(find(text==char(0)));
%             dLine{i} = text(blankInd+1:length(text));
%         end
%     end
% end
% 
% % Get the Z-Coordinates of Doses
% j = 0;
% k = 0;
% for (i=1:length(dLine)-1)   % last line is EOF character -1
%     % copy dose file without empty lines, and text lines
%     if (~isempty(dLine{i}))
%         k = k+1;
%         dText{k} = dLine{i};
% 
%         if strcmpi('"Z-coordinate is "',dText{k}(1:18))
%             j = j+1;
%             text = dText{k};
%             zCoord(j) = str2num(text(19:length(text)));
%             k = k-1;
%         end
% 
%         if (k>0)
%             % Add an extra comma at the end
%             dText{k} = [dText{k} ','];
%         end
%     end
% end
% 
% % Convert to character array
% dString =  cell2mat(dText);
% % - replace commas
% ind = find(dString==',');
% dString(ind) = '';
% % Convert to string
% doses = sscanf(dString,'%f');
% 
% % Reshape into correct orientation
% doses = reshape(doses, sizeDose);
% % - Convert to MATLAB (y,z) format
% for (i=1:size(doses,3))
%     doses3D(:,:,i) = doses(:,:,i)';
% end

% ------------------ END --------------------

% -------------------------------------------------
