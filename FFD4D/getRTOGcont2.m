function contour = getRTOGcont2(fullpath,segname)

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
    
        % Read the header information relevant to the contour slice
    for (i=1:length(line))
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
    contour = cell(str2double(text(find(text=='=')+1:length(text))),1);
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
                            contslice = zeros(100,100);
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
                                              if ~isempty(layer{i})
                                      [C(i,1),C(i,2),C(i,3)] = strread(layer{i},'%n %n %n', 'delimiter',',');
                                            
                                              end
                                            
                                                end
                                                                 
                                end
%                                    if isempty(C)
%                                                         break;
%                                    end
%                             C = textscan(fid, '%n %n
%                             %n',points,'Delimiter',',');
                           if ~isempty(C) && ~isnan(points)
                             
                                
                             C = C(1:points,:);
                          
                          

                            X = round((C(:,1)-xoff)./res(2)+(dim1/2))+0.5;
                            Y = round(-(C(:,2)-yoff)./res(1)+(dim2/2))+0.5;                         
                            if length(X) > 2 && ~isempty(C)
%                             sz = [375-50,460-30];    
%                             X2 = round((interp1(1:length(X),X,1:0.25:length(X))-30)*(99/sz(2)));                   
%                             Y2 = round((interp1(1:length(Y),Y,1:0.25:length(Y))-50)*(99/sz(1)));
%                             try
%                             IND = sub2ind([100,100],Y2,X2);
%                             catch
%                                IND = sub2ind([100,100],Y2,X2);
%                             end
%                             contslice = zeros(100,100);
%                             contslice(IND) = 1;
%                             contslice = contslice(50:375,30:460);
%                             res1 = size(contslice);
%                             res2 = [100,100];
%                             contslice = interp2(repmat(1:res1(2),[res1(1),1]),repmat((1:res1(1))',[1,res1(2)]),contslice,repmat(1:(res1(2)-1)/(res2(2)-1):res1(2),[res2(1),1]),repmat((1:(res1(1)-1)/(res2(1)-1):res1(1))',[1,res2(2)]),'nearest');
if ~isnan(n) && ~isnan(m)

contour{n}{m} = [X,Y];

end

                            C = [];
                       
                            points = points2;
                            %I hate this code
                            end
                            end
                           end
                            end
            end
        end
 
                       