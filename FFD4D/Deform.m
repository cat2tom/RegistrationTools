function varargout = Deform(varargin)
% DEFORM M-file for Deform.fig
%      DEFORM, by itself, creates a new DEFORM or raises the existing
%      singleton*.
%
%      H = DEFORM returns the handle to a new DEFORM or the handle to
%      the existing singleton*.
%
%      DEFORM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEFORM.M with the given input arguments.
%
%      DEFORM('Property','Value',...) creates a new DEFORM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Deform_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Deform_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Deform

% Last Modified by GUIDE v2.5 12-Sep-2007 16:03:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Deform_OpeningFcn, ...
                   'gui_OutputFcn',  @Deform_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Deform is made visible.
function Deform_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Deform (see VARARGIN)

% Choose default command line output for Deform
handles.output = hObject;
handles.patient_path = getappdata(0,'pat_name');
handles.parentdir = getappdata(0,'parentdir');
handles.filenames = {};
handles.Imgfiles = {};
handles.deforms = {};
handles.deformpath = {};
files = dir([handles.parentdir '\' handles.patient_path]);
files(1:2) = [];
for n = 1:length(files)
    if isempty(strfind(files(n).name,'deform')) && isempty(strfind(files(n).name,'temp'))&& isempty(strfind(files(n).name,'dose'))
    handles.filenames= [handles.filenames; {strrep(files(n).name,'.m','')}];
    handles.Imgfiles = [handles.Imgfiles; {[handles.patient_path '\' handles.filenames{end} '_temp.m']}]; 
    elseif ~isempty(strfind(files(n).name,'deform')) && isempty(strfind(files(n).name,'temp')) && isempty(strfind(files(n).name,'dose'))
    handles.deforms = [handles.deforms; {strrep(files(n).name,'deform.m','')}];
    handles.deformpath = [handles.deformpath; {[handles.patient_path '\' files(n).name]}];
    elseif isempty(strfind(files(n).name,'deform')) && isempty(strfind(files(n).name,'temp')) && ~isempty(strfind(files(n).name,'dose'))
    handles.filenames= [handles.filenames; {strrep(files(n).name,'.m','')}];
    handles.Imgfiles = [handles.Imgfiles; {[handles.patient_path '\' handles.filenames{end} '.m']}];
    end
end
set(handles.Images_listbox,'String',handles.filenames);
set(handles.deformations_listbox,'String',handles.deforms);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Deform wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Deform_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in Images_listbox.
function Images_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to Images_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Images_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Images_listbox


% --- Executes during object creation, after setting all properties.
function Images_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Images_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in deformations_listbox.
function deformations_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to deformations_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns deformations_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from deformations_listbox


% --- Executes during object creation, after setting all properties.
function deformations_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to deformations_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in apply_deform.
function apply_deform_Callback(hObject, eventdata, handles)
% hObject    handle to apply_deform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[writefile,path,FilterIndex] = uiputfile( {'*.*','RTOG';'*.dcm','DICOM (.dcm)'},'Save Output');
switch FilterIndex
    case {1}
        % do nothing
    case {2}
        writefile = [writefile '.dcm'];
end
if writefile ~= 0
    file = handles.Imgfiles{get(handles.Images_listbox,'Value')};
    loc = find( file == '_');
    if ~isempty( findstr(file, 'dose'));
load([handles.parentdir '\' handles.Imgfiles{get(handles.Images_listbox,'Value')}],'doses3D','sz','xCoord','yCoord','zCoord','params','-mat');
load([handles.parentdir '\' handles.deformpath{get(handles.deformations_listbox,'Value')}],'dgridx','dgridy','dgridz','lim','-mat');
sz = size(doses3D);
if length(params) < 8
    params(8) = 0.3;
end
rez =[abs(yCoord(end)-yCoord(1))/sz(1),(xCoord(end)-xCoord(1))/sz(2),params(8)];
res1 = sz;
res2 = [lim(2)-lim(1)+1,lim(4)-lim(3)+1,lim(6)-lim(5)+1];
if length(params) < 8
    params(8) = 0.3;
end
[C1,I1] = min(abs(yCoord-(-(lim(1)-(params(2)/2))*params(4)+params(7))));
[C2,I2] = min(abs(yCoord-(-(lim(2)-(params(2)/2))*params(4)+params(7))));
[C3,I3] = min(abs(xCoord-((lim(3)-(params(1)/2))*params(3)+params(6))));
[C4,I4] = min(abs(xCoord-((lim(4)-(params(1)/2))*params(3)+params(6))));
[C5,I5] = min(abs(zCoord-((lim(5))*params(8)+params(5))));
[C6,I6] = min(abs(zCoord-((lim(6))*params(8)+params(5))));
C1 = yCoord(I1);
C2 = yCoord(I2);
C3 = xCoord(I3);
C4 = xCoord(I4);
C5 = zCoord(I5);
C6 = zCoord(I6);
crp = [I1,I2,I3,I4,I5,I6];

doses3D = doses3D(crp(1):crp(2),crp(3):crp(4),crp(5):crp(6));

% xi = params(6) - ((params(2)-1)*(params(3)/2)):params(3):params(6) + ((params(2)-1)*(params(3)/2));
% yi = fliplr(params(7) - ((params(1)-1)*(params(4)/2)):params(4):params(7) + ((params(1)-1)*(params(4)/2)));
% 
% xi = xi(lim(3)):params(3)*(res1(2)-1)/(res2(2)-1):xi(lim(4));
% yi = yi(lim(1)):-params(4)*(res1(1)-1)/(res2(1)-1):yi(lim(2));
% zi = zeros(1,1,lim(6)-lim(5)+1);
% zi(:) = params(5) + (edge1(3)-lim(5)+1)*params(8):-params(8):params(5) + (edge1(3)-lim(6)+1)*params(8);
% 
% zCoord2 = zCoord;
% zCoord = zeros(1,1,length(zCoord2));
% zCoord(:) = zCoord2;
% 
% 
% doses3D = interp3(repmat(xCoord,[sz(1),1,sz(3)]),repmat((yCoord)',[1,sz(2),sz(3)]),repmat(zCoord,[sz(1),sz(2),1]),doses3D,repmat(xi,[res2(1),1,res2(3)]),repmat(yi',[1,res2(2),res2(3)]),repmat(zi,[res2(1),res2(2),1]),'linear');

% crp2 = [-((lim(1)-(params(2)/2))*params(4)+params(7)),-((lim(2)-(params(2)/2))*params(4)+params(7)),((lim(3)-(params(1)/2))*params(3)+params(6)),((lim(4)-(params(1)/2))*params(3)+params(6)),((lim(5))*0.25+params(5)),((lim(6))*0.25+params(5))];
% sz = size(doses3D);
% xinterv = xCoord(2)-xCoord(1);
% yinterv = yCoord(2)-yCoord(1);
% zinterv = zCoord(2)-zCoord(1);
% res2 = [lim(2)-lim(1),lim(4)-lim(3),lim(6)-lim(5)];
% res1 = [100,100,res2(3)];
% zarray1 = zeros(1,1,sz(3));
% zarray2 = zeros(1,1,res1(3));
% zarray1(:) = zCoord(crp(5):crp(6));
% zarray2(:) = crp2(5):(0.25*(res2(3)-1)/(res1(3)-1)):crp2(6);
% doses3D = interp3(repmat(xCoord(crp(3):crp(4)),[sz(1),1,sz(3)]),repmat((yCoord(crp(1):crp(2)))',[1,sz(2),sz(3)]),repmat(zarray1,[sz(1),sz(2),1]),doses3D,repmat(crp2(3):(params(4)*(res2(2)-1)/(res1(2)-1)):crp2(4),[res1(1),1,res1(3)]),repmat((crp2(1):-(params(3)*(res2(1)-1)/(res1(1)-1)):crp2(2))',[1,res1(2),res1(3)]),repmat(zarray2,[res1(1),res1(2),1]),'linear');
[doses3D,imagedist] = imrecreate3D(doses3D,dgridx,dgridy,dgridz);
clear dgridx dgridy dgridz imagedist
res2 = size(doses3D);
doses3D = uint16(doses3D);
if ~isempty(findstr(writefile,'dcm'))
       load('metadata.m','-mat');
  
    for n = 1:res2(3)
   lengx = length(xCoord(I3:I4));
        lengy = length(yCoord(I1:I2));
        lengz = length(zCoord(I5:I6));
        metadata.ImagePositionPatient = [params,lengx,lengy,lengz];
        metadata.ImageOrientationPatient = [xCoord(I3:I4),yCoord(I1:I2),zCoord(I5:I6)];
        writefile2 = strrep(writefile,'.dcm',[numbername(n-1,4) '.dcm']);
        warning off;
        dicomwrite(doses3D(:,:,n), [path writefile2], metadata,'CreateMode','Copy');
    end
else
    errordlg('Cannot write to RTOG yet');
end
    else
        load([handles.parentdir '\' handles.Imgfiles{get(handles.Images_listbox,'Value')}],'image1','-mat');
        load([handles.parentdir '\' handles.deformpath{get(handles.deformations_listbox,'Value')}],'dgridx','dgridy','dgridz','lim','-mat');
%         save('temp_rec.m','image1','dgridx','dgridy','dgridz');    
%         clear image1 dgridx dgridy dgridz
%         save('temp_rec2.m');
%         clear all
        [image1,imagedist] = imrecreate3D3(image1,dgridx,dgridy,dgridz);
        clear dgridx dgridy dgridz imagedist
        image1 = uint16(image1);
        if ~isempty(findstr('dcm',writefile))
              load('metadata.m','-mat');
              res2 = size(image1);
    for n = 1:res2(3)
%        lengx = length(xCoord(I3:I4));
%         lengy = length(yCoord(I1:I2));
%         lengz = length(zCoord(I5:I6));
%         metadata.ImagePositionPatient = [params,lengx,lengy,lengz];
%         metadata.ImageOrientationPatient = [xCoord(I3:I4),yCoord(I1:I2),zCoord(I5:I6)];
        writefile2 = strrep(writefile,'.dcm',[numbername(n-1,4) '.dcm']);
        dicomwrite(image1(:,:,n), [path writefile2],metadata,'CreateMode','Copy');
    end
else
    errordlg('Cannot write to RTOG yet');
        end
    end
end      

% --- Executes on button press in cancel.
function cancel_Callback(hObject, eventdata, handles)
% hObject    handle to cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close Deform;

% --- Executes on button press in load_dose_profile.
function load_dose_profile_Callback(hObject, eventdata, handles)
% hObject    handle to load_dose_profile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile( {'*.*',  'All Files (*.*)'},'Select header file/First file in folder');
if isempty(findstr(filename,'.dcm'))
[doses3D,sz,xCoord,yCoord,zCoord,params] = readRTOGDose([pathname filename]);
else
    [imgdata,doses3D] = loadDICOM4(pathname);
%     clear Imgdata
try
params = imgdata(1).ImagePositionPatient;
sz = size(doses3D);
if length(params) ~= 11
    params = [512,512,1,1,0,0,0];
    xCoord = [1:sz(2)]';
    yCoord = [1:sz(1)]';
    zCoord = [1:sz(3)];
else
lengx = params(end-2);
lengy = params(end-1);
lengz = params(end);
params(end-2:end) = [];
xCoord = imgdata(1).ImageOrientationPatient(1:lengx)';
yCoord = imgdata(1).ImageOrientationPatient(lengx+1:(lengy+lengx))';
zCoord = imgdata(1).ImageOrientationPatient((lengy+lengx)+1:(lengy+lengx+lengz));
clear imgdata;
end
end
end
naming = name_dose;
waitfor(naming);
dosename  = getappdata(0,'dosename');
if dosename ~= 0
save([handles.parentdir '\' handles.patient_path '\' dosename '_dose.m'],'doses3D','sz','xCoord','yCoord','zCoord','params','-mat');

handles.filenames = [handles.filenames; {dosename}];
handles.Imgfiles = [handles.Imgfiles; {[ handles.patient_path '\' dosename  '_dose.m']}]; 
set(handles.Images_listbox,'String',handles.filenames);
guidata(hObject,handles);
end



% --- Executes on button press in calc_dvh.
function calc_dvh_Callback(hObject, eventdata, handles)
% hObject    handle to calc_dvh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load([handles.parentdir '\' handles.Imgfiles{get(handles.Images_listbox,'Value')}],'doses3D','sz','xCoord','yCoord','zCoord','params','-mat');
load([handles.parentdir '\' handles.deformpath{get(handles.deformations_listbox,'Value')}],'dgridx','dgridy','dgridz','lim','-mat');

sz = size(doses3D);

res1 = [lim(2)-lim(1)+1,lim(4)-lim(3)+1,lim(6)-lim(5)+1];
res2 = [150,150,res1(3)];
loadc = load_cont;
waitfor(loadc);
segname = getappdata(0,'segname');
fname = getappdata(0,'filepath');
contour = zeros(res2(1),res2(2),res2(3));
if length(params) ~= 8
    params(8) = 0.3;
end
    for p = 1:length(segname)
    cont = getRTOGcont3(fname{p},segname{p},lim,size(contour),'Yes');
    contour = contour + cont;
    contour(contour == 2) = 1; %clean up overlaps
    end
    rez2 = [params(4)*(res1(1)-1)/(res2(1)-1),params(3)*(res1(2)-1)/(res2(2)-1),params(8)*(res1(3)-1)/(res2(3)-1)];
    if length(segname) ~= 1
    edge1 = getRTOGcont3(fname{p},segname{p},[],size(contour),'Yes');
    else
        edge1 = getRTOGcont3(fname{1},segname{1},[],size(contour),'Yes');
    end
xi = params(6) - ((params(2)-1)*(params(3)/2)):params(3):params(6) + ((params(2)-1)*(params(3)/2));
yi = fliplr(params(7) - ((params(1)-1)*(params(4)/2)):params(4):params(7) + ((params(1)-1)*(params(4)/2)));

xi = xi(lim(3)):params(3)*(res1(2)-1)/(res2(2)-1):xi(lim(4));
yi = yi(lim(1)):-params(4)*(res1(1)-1)/(res2(1)-1):yi(lim(2));
zi = zeros(1,1,lim(6)-lim(5)+1);
zi(:) = params(5) + (edge1(3)-lim(5)+1)*params(8):-params(8):params(5) + (edge1(3)-lim(6)+1)*params(8);

zCoord2 = zCoord;
zCoord = zeros(1,1,length(zCoord2));
zCoord(:) = zCoord2;


doses3D = interp3(repmat(xCoord,[sz(1),1,sz(3)]),repmat((yCoord)',[1,sz(2),sz(3)]),repmat(zCoord,[sz(1),sz(2),1]),doses3D,repmat(xi,[res2(1),1,res2(3)]),repmat(yi',[1,res2(2),res2(3)]),repmat(zi,[res2(1),res2(2),1]),'linear');

    [doses3D,imagedist] = imrecreate3D(doses3D,dgridx,dgridy,dgridz);
clear imagedist;
    
    
 [DVH,max_vol] = calcDVH(doses3D,contour,rez2);
 DVH(:,2) = DVH(:,2)*max_vol;
 [file,path] = uiputfile('*.xls','Save DVH as');
 xlswrite([path file], DVH);

 
