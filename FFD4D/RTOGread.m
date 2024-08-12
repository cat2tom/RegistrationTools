function imageslice = RTOGread(fullpath)

fid = fopen(fullpath);
%     i = 0;
%     while 1
%         i = i+1;
%         line(i) = {fgetl(fid)};
%         if (line{i}==-1)
%             break
%         end;
%     end
%     fclose(fid);
%     
%  % Clear the white spaces in front of some field names
% slice = zeros(length(line{i}));
%     for (i=1:length(line))
%         text = line{i};
%         blankind = find(text == char(0));
%         slice(blankind) = 0;
%         ind = find(text ~=0);
%         slice(ind) = str2num(text(ind));
%     end
imV = fscanf(fid, '%o')
buffer = length(imV) - 512 * 512;
                im = reshape(imV(1 : length(imV) - buffer), 512, 512)';
                d = 1;
                close

 