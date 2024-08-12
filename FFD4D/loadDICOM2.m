function [s_Images,Imgdata] = loadDICOM2(sFolder)
% LOADDICOM M-file
% - Subroutine that loads a DICOM directory containing a set of images
% - Images are sorted in ascending order based on slice location (z)

% -------------------------------
% loadDICOM.m
% - Written by Michael K.K. Leung
% - July 04, 2006
% -------------------------------
% To do...
% - Resetting of program?
% - With confirmation
% - Better error checking
% - Shrink file size by keeping only fields that are required (significant)
% --------------------------------
%loadDICOM2.m
%  Modified Aug. 10th by Daniel A. Markel
% -Program now outputs images seperately in a stacked 3D matrix rest of data
%  outputted as Imgdata.
%**************************************************************************

warning off;

s_FileNames = dir(fullfile(sFolder,'*.*'));
s_FileNames = s_FileNames(3:end);       % excludes '..' and '...'
iFileNum = length(s_FileNames);
sCurFName = s_FileNames(1).name;
sz = size(dicomread([sFolder '\' sCurFName]));
s_Images = uint16(zeros(sz(1),sz(2),iFileNum));
% Read original DICOM files
h = waitbar(0,'Loading DICOM Files...','WindowStyle','modal');
for i=1:iFileNum
    sCurFName = s_FileNames(i).name;
    % Grab images and header info
    try
        curImage = dicominfo([sFolder '\' sCurFName]);
        % Grab relevant fields only (not used)
        % curImage = filterFields(curImage);
        % Grab image
        s_Images(:,:,i) = dicomread([sFolder '\' sCurFName]);
        Imgdata(i) = uint6(curImage);
    catch
        disp (['Invalid DICOM file: ' sFolder '\' sCurFName]);
    end

    waitbar(i/iFileNum,h);
end
waitbar(1,h);
close(h);

warning on;

if (~exist('Imgdata'))
    Imgdata = [];      % return empty variable
    return
end

% Sort the images by slice number (insertion)
for i=2:size(Imgdata,2)
    index = Imgdata(i).SliceLocation;
    temp = Imgdata(i);
    j = i;
    while ( (j>1) && (Imgdata(j-1).SliceLocation > index) )
        Imgdata(j) = Imgdata(j-1);
        j = j-1;
    end
    % Bring along everything else
    Imgdata(j) = temp;
end


% Insertion Sort in C
% http://linux.wku.edu/~lamonml/algor/sort/insertion.html
% void insertionSort(int numbers[], int array_size)
% {
%   int i, j, index;
% 
%   for (i=1; i < array_size; i++)
%   {
%     index = numbers[i];
%     j = i;
%     while ((j > 0) && (numbers[j-1] > index))
%     {
%       numbers[j] = numbers[j-1];
%       j = j - 1;
%     }
%     numbers[j] = index;
%   }
% }

% --------------------------------------------------------------------
                    % ------ HELPER FUNCTIONS ------ % 
% --------------------------------------------------------------------

function dFilterHeader = filterFields(dHeader)

fieldNames = {'Filename','FileModDate','Width','Height','PatientName.FamilyName', ...
              'SliceThickness','ImagePositionPatient','SliceLocation','Rows','Columns', ...
              'PixelSpacing','WindowCenter','WindowWidth','RescaleIntercept'};

for (i=1:length(fieldNames))
    if (i==5)
        dFilterHeader.PatientName.FamilyName = dHeader.PatientName.FamilyName;
    else
        dFilterHeader.(fieldNames{i}) = dHeader.(fieldNames{i});
    end
end
              
% ------------------ Relevant Header Information ---------------------
% .Filename                 Ex) 'C:\CT_img\02_Original\file.-227_63'
% .FileModDate              Ex) '09-Feb-2006 09:19:06'
% .Width                    Ex) 512
% .Height                   Ex) 512
% .PatientName.FamilyName   Ex) 'Some, One'
% .SliceThickness           Ex) 2.5     <-- mm
% .ImagePositionPatient     Ex) [-211.0000; -211.0000; -227.6325]
% .SliceLocation            Ex) -227.63
% .Rows                     Ex) 512
% .Columns                  Ex) 512
% .PixelSpacing             Ex) [0.8242;0.8242]
% .WindowCenter             Ex) 1024
% .WindowWidth              Ex) 400
% .RescaleIntercept         Ex) -2000
% .ImgData                  Ex) <512x512 int16>
