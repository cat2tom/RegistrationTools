function contour = getRTOGcont3(fullpath,segname,lim,rez,cap)
%fullpath is the path including filename and extension to the RTOG header
%file (ie. file designated 0000). 

%segname is a case-sensitive string of the contour being extracted.

% lim is an array of the form  [ymin, ymax,xmin,xmax,zmin,zmax] designating
% the boundaries at which to crop the final contour. leave them at
% [-inf,+inf,..etc.] to avoid cropping.

%rez is the final size of the image being outputted by the program. ie.
%[Ysize,Xsize,Zsize]

%cap is a string either 'yes' or 'no' which determines whether or not to
%cap the ends of the contour. ie. fill the first and final contour layers solid, ensuring a
%full 3D surface. 

IND = [];
n2 = [];
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
        if strcmpi(contText(find(contText=='=')+2:length(contText)),'STRUCTURE')
            text = line{i+3};
            if strcmpi(text(find(text=='=')+2:length(text)),segname)
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
    text = sliceInfo{8};
%     contour = cell(str2double(text(find(text=='=')+1:length(text))),1);
contour = zeros(rez(1),rez(2),str2num(text(find(text=='=')+1:length(text))));
% contour = zeros(rez(2),rez(1),rez(3));
 if isempty(lim)
    contour = size(contour);
 else
    n_lim = str2double(text(find(text=='=')+2:length(text)));  
%     n = 0;
    k = max(findstr(fullpath,'\'));
    dirName = fullpath( 1:k );
    baseFilename = fullpath(k+1:length(fullpath)-4);
    fid = fopen([dirName baseFilename num2str(contSlice,'%.4i')],'r');
    text = fgetl(fid);
    levels = str2double(text(find(text==':')+2:length(text)));
    
  
    
    while 1
       while 1 
           
                        if ~isempty(findstr('Scan Number',text)) || isempty(text)
                            n = str2double(text(find(text==':')+2:length(text)));
                             text = fgetl(fid);
                           
                            if str2num(text(find(text==':')+2:length(text))) == 0
                              continue;
                            else
%                              text = fgetl(fid);
                            break;
                            end
                        end
                        if (text ==-1)
                            break;
                        end
                         text = fgetl(fid);
       end
        if (text ==-1)
                            break;
        end
            if (text~=-1)         % Haven't reached EOF
                % Look for IMAGE # := n
                C = [];
                            segments = str2double(text(find(text==':')+2:length(text)));
                            if segments ~= 0
                            contslice = zeros(rez(1),rez(2));
                            text = fgetl(fid);
                            points = str2num(text(find(text==':')+2:length(text)));

                            for m = 1:segments 
                            i = 0;
                            while 1 
                                i = i+1;
                                layer{i} = fgetl(fid); 
                                if ~isempty(findstr('Points:"',layer{i}))                               
                                    points2 = str2double(layer{i}(find(layer{i}==':')+2:length(layer{i})));
                                    layer{i} = [];
                                    break;
                                elseif ~isempty(findstr('Scan Number',layer{i}))
                                    text = layer{i};
                                    layer{i} = [];
                                    break;
                                end
                                if (layer{i}==-1)
                                    layer{i} = [];
                                    break;
                                end
                            end
                            
                                for (i=1:length(layer))
                                    if ~isempty(layer{i})
                                                if (layer{i}(1)==char(0))
                                                    blankInd = max(find(layer{i}==char(0)));
                                                    layer{i} = layer{i}(blankInd+1:length(layer{i}));
                                                end
%                                                     if ~isempty(layer{i})
%                                                         break
%                                                     end
try
                                               if ~isempty(layer{i})
                                      [C(i,1),C(i,2),C(i,3)] = strread(layer{i},'%n %n %n', 'delimiter',',');
                                               end
end
                                                end
                                                                 
                                end
%                                    if isempty(C)
%                                                         break;
%                                    end
%                             C = textscan(fid, '%n %n
%                             %n',points,'Delimiter',',');
                           if ~isempty(C) && ~isnan(points)
                             
                                 try
                             C = C(1:points,:);
                                 catch
                                     d = 1;
                                 end
                                  
                          
                            X = (C(:,1)-xoff)./res(2)+(dim1/2)-lim(3)+1.5;
                            Y = -(C(:,2)-yoff)./res(1)+(dim2/2)-lim(1)+1.5;                         
                            if length(X) > 2 && ~isempty(C)
                            sz = [lim(2)-lim(1)+1,lim(4)-lim(3)+1];    
                            X2 = round(interp1(1:length(X),X,1:0.1:length(X)).*((rez(2)-1)/(sz(2)-1)));                   
                            Y2 = round(interp1(1:length(Y),Y,1:0.1:length(Y)).*((rez(1)-1)/(sz(1)-1)));
%                             X2 = round(interp1(1:length(X),X,1:0.1:length(X)));                   
%                             Y2 = round(interp1(1:length(Y),Y,1:0.1:length(Y)));

                            X3 = X2;
                            Y3 = Y2;
                            X3(X2 <= 0 | X2 > rez(2) | Y2 <= 0 | Y2 > rez(1)) = [];
                            Y3(X2 <= 0 | X2 > rez(2) | Y2 <= 0 | Y2 > rez(1)) = [];
                            Y2 = Y3;
                            X2 = X3;
                            clear X3 Y3
                   
                  IND = sub2ind([rez(1),rez(2)],Y2,X2);
                   
             
           
                            contslice(IND) = 1;
              
                  
%                             contslice = contslice(50:375,30:460);
%                             res1 = size(contslice);
%                             res2 = [100,100];
%                             contslice =
%                             interp2(repmat(1:res1(2),[res1(1),1]),repmat((1:res1(1))',[1,res1(2)]),contslice,repmat(1:(res1(2)-1)/(res2(2)-1):res1(2),[res2(1),1]),repmat((1:(res1(1)-1)/(res2(1)-1):res1(1))',[1,res2(2)]),'nearest');
if strcmp(cap,'Yes') 
    if ~isnan(n) && n == 1 && ~isempty(IND)
        contslice = bwmorph(contslice,'bridge');
        contour(:,:,n) = imfill(contslice,'holes');
    elseif ~isnan(n) && max(max(contour(:,:,n-1))) == 0 && ~isempty(IND)                         
        contslice = bwmorph(contslice,'bridge');
        
        contour(:,:,n) = imfill(contslice,'holes');
       
    elseif ~isnan(n)
        contour(:,:,n) = bwmorph(contslice,'bridge');
    end
elseif ~isnan(n)                           
contour(:,:,n) = bwmorph(contslice,'bridge');
end                  
         if ~isnan(n) && ~isempty(IND)
             n2 = n;
         end

IND = [];
         C = [];
                       
                            points = points2;
                            %I hate this code
                            end
                          
                            end
                            end
                           
                            end
                           
            end
        end
    if strcmp(cap,'Yes') && ~isempty(n2)
    contour(:,:,n2) = imfill(contour(:,:,n2),'holes');
    end
   
    contour = contour(:,:,lim(5):lim(6));
 end
                       