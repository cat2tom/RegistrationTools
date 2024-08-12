function image1 = loadRTOG(filename)


%-----------Get the file extension and root of the file names---------------------%
[rootStr, fname, fileExt] = fileparts(filename);
fname = [fname fileExt];


%-----------Define basic internal parameters---------------------%
delim = ':=';   %RTOG keyword delimiter


%-----read header file into cell array---%
% try
%     dirC = file2cell([rootStr fileExt]);
% catch
%     warning('No valid ''000'' header file!')
%     image1 = [];
%     imgdata = {};
%     return
% end
h = waitbar(0,'Loading RTOG Files...','WindowStyle','modal');
  
fid = fopen(filename);
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
    imagenumbers = [];
      for (i=1:length(line))
        text = line{i};
        % Look for SIZE OF DIMENSION 1
        if ~isempty(findstr(text,'CT SCAN'))
            text = line{i-1};
            imagenumbers(str2num(text(find(text=='=')+2:length(text)))) = str2num(text(find(text=='=')+2:length(text)));
            d = i;
        end
      end
     
      text =  line{d+10};
      dim1 = str2num(text(find(text=='=')+2:length(text)));
      text =  line{d+11};
      dim2 = str2num(text(find(text=='=')+2:length(text)));
      
      image1 = zeros(dim2,dim1,length(imagenumbers));
      for n = 1:length(imagenumbers);
           fullpath = [rootStr '\' fname(1:end-4) numbername(imagenumbers(n),4)];
          fid = fopen(fullpath);
        imV = fread(fid,'uint16', 'ieee-be');
        buffer = length(imV) - dim1 * dim2;
        imageslice = reshape(imV(1 : length(imV) - buffer), dim1, dim2)';
        image1(:,:,n) = imageslice;
        waitbar(n/length(imagenumbers),h);
        fclose(fid);
      end
      waitbar(1,h);
close(h);
      
