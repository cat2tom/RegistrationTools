function varargout = FFD4D(varargin)
% FFD4D M-file for FFD4D.fig
%      FFD4D, by itself, creates a new FFD4D or raises the existing
%      singleton*.
%
%      H = FFD4D returns the handle to a new FFD4D or the handle to
%      the existing singleton*.
%
%      FFD4D('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FFD4D.M with the given input arguments.
%
%      FFD4D('Property','Value',...) creates a new FFD4D or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FFD4D_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FFD4D_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FFD4D

% Last Modified by GUIDE v2.5 23-May-2008 15:44:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FFD4D_OpeningFcn, ...
                   'gui_OutputFcn',  @FFD4D_OutputFcn, ...
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


% --- Executes just before FFD4D is made visible.
function FFD4D_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FFD4D (see VARARGIN)

% Choose default command line output for FFD4D
handles.output = hObject;
handles.parentdir = cd;
handles.parentdir = [handles.parentdir , '\Patient Files'];
handles.Imgfiles = {};
handles.filenames = {};
handles.contour = {};
handles.numFrames = [1,1,1];
handles.currentFramecor = 1;
handles.currentFrametran = 1;
handles.currentFramesag = 1;
handles.addFPCoords = [];
handles.FPcoordstran = {};
handles.FPcoordscor = {};
handles.FPcoordssag = {};
handles.tranind = [];
handles.sagind = [];
handles.corind = [];
handles.img = [];
handles.reg_params = [{1},{5},{4},{7},{1.5},{[22,22,22]},{[42,42,42]},{[100,100]}];
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FFD4D wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FFD4D_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function LoadP_Callback(hObject, eventdata, handles)
% hObject    handle to LoadP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Imgfiles ={};
handles.filenames = {};
setappdata(0,'parentdir',handles.parentdir);
loadp = load_patient;
waitfor(loadp);
pat_num = getappdata(0,'pat_name');
if ~ischar(pat_num)
    fid = fopen([handles.parentdir '\Patients.txt']);
    names = textscan(fid,'%s','Delimiter','\n');
    names = names{1};
    fclose(fid);
    handles.patient_name = names{pat_num};
    handles.patient_path = ['Patient_' numbername(pat_num,4)];
set(handles.pat_name,'String',handles.patient_name);
files = dir([handles.parentdir '\' handles.patient_path]);
if ~isempty(files)
files(1:2) = [];
for n = 1:length(files)
    if ~isempty(strfind(files(n).name,'temp'))
        delete([handles.parentdir '\' handles.patient_path '\' files(n).name]);
    end
end
files = dir([handles.parentdir '\' handles.patient_path]);
files(1:2) = [];
for n = 1:length(files)
    if isempty(strfind(files(n).name,'deform'))
    handles.filenames= [handles.filenames; {strrep(files(n).name,'.m','')}];
    handles.Imgfiles = [handles.Imgfiles; {[handles.patient_path '\' handles.filenames{end} '_temp.m']}];
        if isempty(strfind(files(n).name,'temp'))
         copyfile([handles.parentdir '\' handles.patient_path '\' strrep(files(n).name,'.m','') '.m'],[handles.parentdir '\' handles.patient_path '\' strrep(files(n).name,'.m','') '_temp.m']);
        end
    end
end
set(handles.listbox_images,'String',handles.filenames);
end
guidata(hObject,handles);
end

% --------------------------------------------------------------------
function SaveP_Callback(hObject, eventdata, handles)
% hObject    handle to SaveP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
files = dir([handles.parentdir '\' handles.patient_path]);
files(1:2) = [];
% for n = 1:length(files)
%     if isempty(strfind(files(n).name,'temp'))
%         delete([handles.parentdir '\' handles.patient_path '\' files(n).name]);
%     end
% end
for n = 1:length(files)
    if strfind(files(n).name,'temp')
        copyfile([handles.parentdir '\' handles.patient_path '\' files(n).name], [handles.parentdir '\' handles.patient_path '\' strrep(files(n).name, '_temp', '')]);
%         delete([handles.parentdir '\' handles.patient_path '\' files(n).name]);
    end
end

% --------------------------------------------------------------------
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
files = dir([handles.parentdir '\' handles.patient_path]);
files(1:2) = [];
for n = 1:length(files)
    if strfind(files(n).name,'temp')
        delete([handles.parentdir '\' handles.patient_path '\' files(n).name]);
    end
end
close FFD4D;

% --------------------------------------------------------------------
function patient_Callback(hObject, eventdata, handles)
% hObject    handle to patient (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function cyc_cons_Callback(hObject, eventdata, handles)
% hObject    handle to registration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function File_tab_Callback(hObject, eventdata, handles)
% hObject    handle to File_tab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function View_tab_Callback(hObject, eventdata, handles)
% hObject    handle to View_tab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function createp_Callback(hObject, eventdata, handles)
% hObject    handle to createp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
createp = createpatient;
waitfor(createp);
% handles = guihandles(handles.figure1);
pat_name = getappdata(0,'pat_name');

if ischar(pat_name)

fid = fopen([handles.parentdir '\patients.txt'],'r+');
names = textscan(fid,'%s','Delimiter','\n');
names = names{1};
numstring = numbername(length(names)+1,4);
mkdir(handles.parentdir,['Patient_' numstring]);
handles.patient_name = pat_name;
handles.patient_path = ['Patient_' numstring];
fseek(fid,0,'eof');
if ~isempty(names)
fprintf(fid, '\n%s', [pat_name]);
else
    fprintf(fid, '%s', [pat_name]);
end
fclose(fid);
end
set(handles.pat_name,'String',pat_name);
handles.Imgfiles = {};
handles.filenames = {};
handles.contour = {};
set(handles.listbox_images,'String',handles.filenames);
guidata(hObject,handles);
% --- Executes on slider movement.
function slider_transverse_Callback(hObject, eventdata, handles)
% hObject    handle to slider_transverse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
%displays frame selected by slider
handles.currentFrametran = handles.numFrames(3) + 1 - round(get(hObject,'Value'));
image (handles.img(:,:,handles.currentFrametran), 'CDataMapping','scaled','Parent', handles.axes1);
colormap bone
%plot transverse contours
if ~isempty(handles.contour)
if ~isempty(handles.contour{handles.currentFrametran}) 
    for m = 1:length(handles.contour{handles.currentFrametran})
patch(handles.contour{handles.currentFrametran}{m}(:,1)-handles.lim(3)+1,handles.contour{handles.currentFrametran}{m}(:,2)-handles.lim(1)+1,'r','EdgeColor','r','FaceColor','none','Parent',handles.axes1);
    end
end
end
if ~isempty(handles.FPcoordstran)
      if ~isempty(find(handles.tranind == handles.currentFrameTran))
          set(handles.axes1,'NextPlot', 'add');
%     for n = 1:length(handles.FPcoordstran{handles.currentFrametran}(:,1))
%         xin = handles.addFPCoords(locations(n),1);
%         yin = handles.addFPCoords(locations(n),1);
%     plot(handles.axes1, xin,yin,'r+'); %Point is plotted on the GUI
%     text (xin - 4, yin + 3, num2str(locations(n)), 'Color', 'r');
%     end
    plot(handles.axes1, handles.FPcoordstran{handles.currentFrametran}(:,1),handles.FPcoordstran{handles.currentFrametran}(:,2),'r+','Parent',handles.axes1); %Point is plotted on the GUI
    text (handles.FPcoordstran{handles.currentFrametran}(:,1) - 4, handles.FPcoordstran{handles.currentFrametran}(:,2) + 3, num2str(handles.FPcoordstran{handles.currentFrametran}(:,3)), 'Color', 'r','Parent',handles.axes1);
end
end
%updates infobar
set(handles.tran_info, 'String', strcat(num2str (handles.currentFrametran), ' of ', num2str(handles.numFrames(3))));
%updates handle with new values
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider_transverse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_transverse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_sagittal_Callback(hObject, eventdata, handles)
% hObject    handle to slider_sagittal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
%displays frame selected by slider
handles.currentFramesag = handles.numFrames(1) + 1 - round(get(hObject,'Value'));
image (reshape(handles.img(handles.currentFramesag,:,:),handles.numFrames(2),handles.numFrames(3))', 'CDataMapping','scaled','Parent', handles.axes3);
colormap bone
%updates infobar
set(handles.sag_info, 'String', strcat(num2str (handles.currentFramesag), ' of ', num2str(handles.numFrames(1))));
%updates handle with new values
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider_sagittal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_sagittal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_coronal_Callback(hObject, eventdata, handles)
% hObject    handle to slider_coronal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
%displays frame selected by slider
handles.currentFramecor = handles.numFrames(2) + 1 - round(get(hObject,'Value'));
image (reshape(handles.img(:,handles.currentFramecor,:),handles.numFrames(1),handles.numFrames(3))', 'CDataMapping','scaled','Parent', handles.axes2);
colormap bone
%updates infobar
set(handles.cor_info, 'String', strcat(num2str (handles.currentFramecor), ' of ', num2str(handles.numFrames(2))));
%updates handle with new values
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider_coronal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_coronal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in listbox_images.
function listbox_images_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_images (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox_images contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_images


% --- Executes during object creation, after setting all properties.
function listbox_images_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_images (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in add_image.
function add_image_Callback(hObject, eventdata, handles)
% hObject    handle to add_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
formsel = formatsel;
waitfor(formsel);
selection = getappdata(0,'formsel');
switch selection
    case{'DICOM'}
directory_name = uigetdir;
if ~isnumeric(directory_name)
[image1,imgData] = loadDICOM2(directory_name);
image1 = double(image1);
[pathstr, name, ext] = fileparts(directory_name);
end
sz = size(image1);
thumb = interp2(repmat(1:sz(2),[sz(1),1]),repmat((1:sz(1))',[1,sz(2)]),image1(:,:,round(sz(3)/2)),repmat(1:(sz(2)-1)/99:sz(2),[100,1]),repmat((1:(sz(1)-1)/99:sz(1))',[1,100]));
case{'RTOG'}
[name, pathname, filterindex] = uigetfile({'*.*',  'All Files (*.*)'},'Select RTOG header file 0000');
if filterindex ==0
    return
end
image1 = loadRTOG([pathname name]);
sz = size(image1);
thumb = interp2(repmat(1:sz(2),[sz(1),1]),repmat((1:sz(1))',[1,sz(2)]),image1(:,:,round(sz(3)/2)),repmat(1:(sz(2)-1)/99:sz(2),[100,1]),repmat((1:(sz(1)-1)/99:sz(1))',[1,100]));
imgData = [];
% name = strrep(name,'0000','');
namep = newimage;
waitfor(namep);
name = getappdata(0,'im_name');
case{'none'}
    return
end
if ~isempty(name)
i = length(handles.Imgfiles);
name = strrep(name,'.','_');
name = strrep(name,',','_');
name = strrep(name,'-','_');
if length(name) > 25
name = name(1:25);
end
handles.Imgfiles{i+1} = [handles.patient_path '\' name '_temp.m'];
handles.filenames{length(handles.filenames)+1} = name;
contours = {};
continfo = {};
FPcoords = [];
sz = size(image1);
lim = [1,sz(1),1,sz(2),1,sz(3)];
save([handles.parentdir '\' handles.patient_path '\' handles.filenames{end} '_temp.m'],'image1','imgData','thumb','contours','continfo','FPcoords','lim');
%
set(handles.listbox_images,'String',handles.filenames);
guidata(hObject,handles);
end

% --- Executes on button press in remove_image.
function remove_image_Callback(hObject, eventdata, handles)
% hObject    handle to remove_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n = get(handles.listbox_images,'Value');
delete([handles.parentdir '\' handles.Imgfiles{n}]);
handles.Imgfiles{n} = [];
handles.filenames{n} = [];
set(handles.listbox_images,'String',handles.filenames);
guidata(hObject,handles);

% --- Executes on button press in add_feature_point.
function add_feature_point_Callback(hObject, eventdata, handles)
% hObject    handle to add_feature_point (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.axes1,'NextPlot', 'add');
handles.addFPCoords = [];
 
b = 1;
sz = size(handles.addFPCoords);
n = sz(1)+1;
sz =  size(handles.img);
handles.FPcoordstran = cell(sz(3),1);
handles.FPcoordssag = cell(sz(2),1);
handles.FPcoordscor = cell(sz(1),1);
while 1
    
    axis(handles.axes1);
    [xin,yin,b] = ginput(1); %User selects a point on the GUI
    
    xin = round (xin);
    yin = round (yin);
    
    if b ~= 1
        break
    end
 
    plot(handles.axes1, xin,yin,'r+','Parent',handles.axes1); %Point is plotted on the GUI
    text (xin - 4, yin + 3, num2str (n), 'Color', 'r','Parent',handles.axes1);
    
     if yin == handles.currentFramecor
        set(handles.axes2,'NextPlot', 'add');
        plot (handles.axes2, handles.currentFrametran, xin, 'r+','Parent',handles.axes2);
        text (handles.currentFrametran + 3, xin - 4, num2str (n), 'Color', 'r', 'Parent', handles.axes2);
     end
    
     if xin == handles.currentFramesag
        set(handles.axes3,'NextPlot', 'add');
        plot (handles.axes3, yin, handles.currentFrametran, 'r+','PArent',handles.axes3);
        text (handles.currentFrametran + 3, yin - 4, num2str (n), 'Color', 'r', 'parent', handles.axes3);
     end
        
    
    handles.addFPCoords (n, :) = [round(xin), round(yin), handles.currentFrametran];
    handles.FPcoordstran{handles.currentFrametran} = [handles.FPcoordstran{handles.currentFrametran}; round(xin), round(yin), n];
    handles.tranind = [handles.tranind;handles.currentFrametran];
    handles.FPcoordssag{round(xin)} = [handles.FPcoordssag{round(xin)} ; handles.currentFrametran, round(yin), n];
    handles.sagind = [handles.sagind;round(xin)];
    handles.FPcoordscor{round(yin)} = [handles.FPcoordscor{round(yin)} ; handles.currentFrametran, round(xin), n];
    handles.corind = [handles.corind;round(yin)];
    n = n + 1;
end
FPcoords = handles.addFPCoords;
save([handles.parentdir '\' handles.patient_path '\' handles.filenames{end} '_temp.m'],'FPcoords','-append');    
guidata(hObject,handles);

% --- Executes on button press in remove_feat_point.
function remove_feat_point_Callback(hObject, eventdata, handles)
% hObject    handle to remove_feat_point (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in move_feature_point.
function move_feature_point_Callback(hObject, eventdata, handles)
% hObject    handle to move_feature_point (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Fill_points.
function Fill_points_Callback(hObject, eventdata, handles)
% hObject    handle to Fill_points (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in select_feature_points.
function select_feature_points_Callback(hObject, eventdata, handles)
% hObject    handle to select_feature_points (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function reg_param_Callback(hObject, eventdata, handles)
% hObject    handle to reg_param (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'reg_params',handles.reg_params);
regp = Registration_Parameters;
waitfor(regp);
handles.reg_params = getappdata(0,'reg_params');
guidata(hObject,handles);

% --- Executes on button press in registration.
function registration_Callback(hObject, eventdata, handles)
% hObject    handle to registration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% if ~isempty(handles.img)
% save([handles.parentdir '\' handles.patient_path '\temp.m'],'handles.img');
% d=1;
% end
cla(handles.axes1);
cla(handles.axes2);
cla(handles.axes2);
handles.img = [];
setappdata(0,'filenames',handles.Imgfiles);
setappdata(0,'parentdir',handles.parentdir);
setappdata(0,'filenames2',handles.filenames);
setappdata(0,'reg_params',handles.reg_params);
% setappdata(0,'limits',handles.lim);
save('tempf.m');
clear all
regp = registration;
waitfor(regp);
load('tempf.m','-mat');
guidata(hObject,handles);
% --- Executes on button press in deform_model.
function deform_model_Callback(hObject, eventdata, handles)
% hObject    handle to deform_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'pat_name',handles.patient_path);
defp = Deform;
waitfor(defp);

% --- Executes on button press in load_contour.
function load_contour_Callback(hObject, eventdata, handles)
% hObject    handle to load_contour (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
loadc = load_cont;
waitfor(loadc);
segname = getappdata(0,'segname');
if ~isempty(segname);
fname = getappdata(0,'filepath');
cap = getappdata(0,'cap');
continfo = [{fname},{segname},{cap}];
for n = 1:length(segname)
% try
    contour = getRTOGcont2(fname{n},segname{n});
% catch
%     errordlg('Could not extract contour');
% end
contour =contour(handles.lim(5):handles.lim(6));
if n == 1
    handles.contour = contour;
else
for i = 1:length(contour)
    handles.contour{i} = [handles.contour{i},contour{i}];
end
end
end
clear contour
%plot transverse contours

if ~isempty(handles.contour{handles.currentFrametran})
    for m = 1:length(handles.contour{handles.currentFrametran})
patch(handles.contour{handles.currentFrametran}{m}(:,1)-handles.lim(3)+1,handles.contour{handles.currentFrametran}{m}(:,2)-handles.lim(1)+1,'r','EdgeColor','r','FaceColor','none','Parent',handles.axes1);
    end
end
contours = handles.contour;
save([handles.parentdir '\' handles.Imgfiles{get(handles.listbox_images,'Value')}],'contours','continfo','-append'); 
guidata(hObject,handles);
end
% --------------------------------------------------------------------
function deform_image_Callback(hObject, eventdata, handles)
% hObject    handle to deform_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function pat_name_Callback(hObject, eventdata, handles)
% hObject    handle to pat_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pat_name as text
%        str2double(get(hObject,'String')) returns contents of pat_name as a double
set(handles.pat_name,'String',handles.patient_name);

% --- Executes during object creation, after setting all properties.
function pat_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pat_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function date_acquired_Callback(hObject, eventdata, handles)
% hObject    handle to date_acquired (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of date_acquired as text
%        str2double(get(hObject,'String')) returns contents of date_acquired as a double


% --- Executes during object creation, after setting all properties.
function date_acquired_CreateFcn(hObject, eventdata, handles)
% hObject    handle to date_acquired (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in crop_images.
function crop_images_Callback(hObject, eventdata, handles)
% hObject    handle to crop_images (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'limits',[1,handles.numFrames(1),1,handles.numFrames(2),1,handles.numFrames(3)]);
setappdata(0,'handle',hObject);
cropo = Crop_image;
% 
function apply_crop(hObject, eventdata, handles)

handles = guidata(getappdata(0,'handle'));
handles.lim2 = getappdata(0,'limits');
handles.lim = [handles.lim2(1)+handles.lim(1)-1,handles.lim2(2) + handles.lim(1)-1,handles.lim2(3)+handles.lim(3)-1,handles.lim2(4) + handles.lim(3)-1,handles.lim2(5)+handles.lim(5)-1,handles.lim2(6) + handles.lim(5)-1];
if ~isempty(handles.FPcoords)
handles.FPcoords(:,1) = handles.FPcoords(:,1) - handles.lim(2)+1; 
handles.FPcoords(:,2) = handles.FPcoords(:,2) - handles.lim(1)+1; 
handles.FPcoords(:,3) = handles.FPcoords(:,3) - handles.lim(3)+1; 
end
handles.img = handles.img(handles.lim2(1):handles.lim2(2),handles.lim2(3):handles.lim2(4),handles.lim2(5):handles.lim2(6));
handles.numFrames = size(handles.img);
handles.currentFrametran = handles.currentFrametran - handles.lim2(5)+1;
if handles.currentFrametran < 1
    handles.currentFrametran = 1;
elseif handles.currentFrametran > handles.numFrames(3);
    handles.currentFrametran = handles.numFrames(3);
end

handles.currentFramesag = handles.currentFramesag - handles.lim2(1)+1;
if handles.currentFramesag < 1
    handles.currentFramesag = 1;
elseif handles.currentFramesag > handles.numFrames(1);
    handles.currentFramesag = handles.numFrames(1);
end

handles.currentFramecor = handles.currentFramecor - handles.lim2(3)+1;
if handles.currentFramecor < 1
    handles.currentFramecor = 1;
elseif handles.currentFramecor > handles.numFrames(2);
    handles.currentFramecor = handles.numFrames(2);
end

%Reset sliders
    set (handles.slider_coronal, 'Enable', 'on');
    set(handles.slider_coronal, 'Min', 1);
    set(handles.slider_coronal, 'Max', handles.numFrames(2));
    set (handles.slider_coronal, 'Value', handles.currentFramecor);
    set (handles.slider_coronal, 'SliderStep', [1/handles.numFrames(2), 0.25]);
    
    set (handles.slider_sagittal, 'Enable', 'on');
    set(handles.slider_sagittal, 'Min', 1);
    set(handles.slider_sagittal, 'Max', handles.numFrames(1));
    set (handles.slider_sagittal, 'Value', handles.currentFramesag);
    set (handles.slider_sagittal, 'SliderStep', [1/handles.numFrames(1), 0.25]);
    
    set (handles.slider_transverse, 'Enable', 'on');
    set(handles.slider_transverse, 'Min', 1);
    set(handles.slider_transverse, 'Max', handles.numFrames(3));
    set (handles.slider_transverse, 'Value', handles.currentFrametran);
    set (handles.slider_transverse, 'SliderStep', [1/handles.numFrames(3), 0.25]);
    set(0,'CurrentFigure', handles.figure1);
    set(handles.axes1, 'NextPlot','Replace');
    imagesc(handles.img(:,:,handles.currentFrametran),'Parent', handles.axes1);
        set (handles.axes1, 'NextPlot', 'replacechildren');
    colormap gray;
       set(handles.axes2, 'NextPlot','Replace');
    imagesc(reshape(handles.img(:,handles.currentFramecor,:),handles.numFrames(1),handles.numFrames(3))','Parent', handles.axes2);
    set (handles.axes2, 'NextPlot', 'replacechildren');
    colormap gray;
 
           set(handles.axes3, 'NextPlot','Replace');
    imagesc(reshape(handles.img(handles.currentFramesag,:,:),handles.numFrames(2),handles.numFrames(3))','Parent', handles.axes3);
    set (handles.axes3, 'NextPlot', 'replacechildren');
    colormap gray;
    image1 = handles.img;
    lim = handles.lim;
   save([handles.parentdir '\' handles.Imgfiles{get(handles.listbox_images,'Value')}],'image1','lim','-append'); 
guidata(getappdata(0,'handle'),handles);
function preview_crop_Callback(hObject, eventdata, handles)
lim = getappdata(0,'limitspr');
handles = guidata(getappdata(0,'handle'));
    set(handles.axes1, 'NextPlot','Replace');
    image(handles.img(:,:,handles.currentFrametran), 'CDataMapping','scaled','Parent', handles.axes1);
        set (handles.axes1, 'NextPlot', 'replacechildren');
    colormap gray;
    hold on;
    rectangle('Position',[lim(3),lim(1),(lim(4)-lim(3)+1),(lim(2)-lim(1)+1)],'Parent',handles.axes1,'EdgeColor','g','LineStyle','--');
    
       set(handles.axes2, 'NextPlot','Replace');
    image(reshape(handles.img(:,handles.currentFramecor,:),handles.numFrames(1),handles.numFrames(3))', 'CDataMapping','scaled','Parent', handles.axes2);
%     axis image;
    set (handles.axes2, 'NextPlot', 'replacechildren');
    colormap gray;
    hold on;
    rectangle('Position',[lim(1),lim(5),(lim(2)-lim(1)+1),(lim(6)-lim(5))+1],'Parent',handles.axes2,'EdgeColor','g','LineStyle','--');
    
           set(handles.axes3, 'NextPlot','Replace');
    image(reshape(handles.img(handles.currentFramesag,:,:),handles.numFrames(2),handles.numFrames(3))', 'CDataMapping','scaled','Parent', handles.axes3);
%     axis image;
    set (handles.axes3, 'NextPlot', 'replacechildren');
    colormap gray;
    hold on;
    rectangle('Position',[lim(3),lim(5),(lim(4)-lim(3)+1),(lim(6)-lim(5)+1)],'Parent',handles.axes3,'EdgeColor','g','LineStyle','--');

function view_image_Callback(hObject, eventdata, handles)
% hObject    handle to crop_images (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imgData = [];
handles.img = [];
handles.imgData = [];
contours = [];

try
load([handles.parentdir '\' handles.Imgfiles{get(handles.listbox_images,'Value')}],'image1','imgData','lim','FPcoords','-mat');
handles.FPcoords = FPcoords;
catch
    try
     load([handles.parentdir '\' handles.Imgfiles{get(handles.listbox_images,'Value')}],'image1','imgData','lim','-mat');
     handles.FPcoords = [];
catch
    warning('Invalid Image data file');
    end
end
image1(image1 == -2000) = 0;
handles.imgData = imgData;
clear imgData;
sz = size(image1);
handles.lim = lim;
    %find out # of frames
    handles.numFrames = sz;
    handles.currentFrametran = round(handles.numFrames(3)/2);
    handles.currentFramecor = round(handles.numFrames(1)/2);
    handles.currentFramesag = round(handles.numFrames(2)/2);

    %shows the first frame.
    set(handles.axes1, 'NextPlot','Replace');
    image(image1(:,:,handles.currentFrametran), 'CDataMapping','scaled','Parent', handles.axes1);
%     axis image;
    set (handles.axes1, 'NextPlot', 'replacechildren');
    colormap bone;
    set(handles.tran_info, 'String', strcat(num2str (handles.currentFrametran), ' of ', num2str(handles.numFrames(3))));
    set(handles.axes2, 'NextPlot','Replace');
    image(reshape(image1(:,handles.currentFramecor,:),handles.numFrames(1),handles.numFrames(3))', 'CDataMapping','scaled','Parent', handles.axes2);
%     axis image;
    set (handles.axes2, 'NextPlot', 'replacechildren');
    colormap bone;
       set(handles.cor_info, 'String', strcat(num2str (handles.currentFramecor), ' of ', num2str(handles.numFrames(1))));
    set(handles.axes3, 'NextPlot','Replace');
    image(reshape(image1(handles.currentFramesag,:,:),handles.numFrames(2),handles.numFrames(3))', 'CDataMapping','scaled','Parent', handles.axes3);
%     axis image;
    set (handles.axes3, 'NextPlot', 'replacechildren');
    colormap bone;
    set(handles.sag_info, 'String', strcat(num2str (handles.currentFramesag), ' of ', num2str(handles.numFrames(2))));
    %displays image information
    try
    set(handles.date_acquired, 'String', Imgdata(1).Date);
    catch
    end

    %Sets up sliders
    set (handles.slider_coronal, 'Enable', 'on');
    set(handles.slider_coronal, 'Min', 1);
    set(handles.slider_coronal, 'Max', handles.numFrames(2));
    set (handles.slider_coronal, 'Value', handles.currentFramecor);
    set (handles.slider_coronal, 'SliderStep', [1/handles.numFrames(2), 0.25]);
    
    set (handles.slider_sagittal, 'Enable', 'on');
    set(handles.slider_sagittal, 'Min', 1);
    set(handles.slider_sagittal, 'Max', handles.numFrames(1));
    set (handles.slider_sagittal, 'Value', handles.currentFramesag);
    set (handles.slider_sagittal, 'SliderStep', [1/handles.numFrames(1), 0.25]);
    
    set (handles.slider_transverse, 'Enable', 'on');
    set(handles.slider_transverse, 'Min', 1);
    set(handles.slider_transverse, 'Max', handles.numFrames(3));
    set (handles.slider_transverse, 'Value', handles.currentFrametran);
    set (handles.slider_transverse, 'SliderStep', [1/handles.numFrames(3), 0.25]);
    handles.img = image1;
    clear image1
    try
    load([handles.parentdir '\' handles.Imgfiles{get(handles.listbox_images,'Value')}],'contours','-mat');
    catch
    end
    handles.contour = contours;
    %updates handles with new values
    guidata(hObject, handles); 




% --- Executes on button press in feature_points.
function feature_points_Callback(hObject, eventdata, handles)
% hObject    handle to feature_points (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'imgfiles',handles.Imgfiles);
setappdata(0,'filenames',handles.filenames);
setappdata(0,'parentdir',handles.parentdir);
feat = featurep;
waitfor(feat);

