function varargout = validation(varargin)
% VALIDATION M-file for Validation.fig
%      VALIDATION, by itself, creates a new VALIDATION or raises the existing
%      singleton*.
%
%      H = VALIDATION returns the handle to a new VALIDATION or the handle to
%      the existing singleton*.
%
%      VALIDATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VALIDATION.M with the given input arguments.
%
%      VALIDATION('Property','Value',...) creates a new VALIDATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Validation_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Validation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Validation

% Last Modified by GUIDE v2.5 20-May-2008 13:30:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Validation_OpeningFcn, ...
                   'gui_OutputFcn',  @Validation_OutputFcn, ...
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


% --- Executes just before Validation is made visible.
function Validation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Validation (see VARARGIN)

% Choose default command line output for Validation
handles.output = hObject;
handles.image1 = 0;
handles.image2 = 0;
handles.sz1 = [0,0,0];
handles.sz2 = [0,0,0];
handles.data1 = [];
handles.data2 = [];
handles.data3 = [];
set(handles.slider2,'Min',0);
set(handles.slider2,'Max',5);
handles.fadeval = 0;
handles.currentFramecor = get(handles.slider1,'Value');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Validation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Validation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
if isequal(handles.sz1,handles.sz2);
handles.currentFramecor = handles.sz1(3) - round(get(hObject,'Value'));
image(handles.image1(:,:,handles.currentFramecor)*(1-handles.fadeval) + handles.image2(:,:,handles.currentFramecor)*handles.fadeval, 'CDataMapping','scaled','Parent', handles.axes1);
if ~isempty(handles.data1);
loc = find(handles.data3(:,1)==handles.currentFramecor);
if ~isempty(loc)
    for n = 1:length(loc)
plot(handles.axes1, handles.data1(loc(n),1),handles.data1(loc(n),2),'r+','Parent',handles.axes1); %Point is plotted on the GUI
text (handles.data1(loc(n),1) - 7, handles.data1(loc(n),2) + 6, num2str (loc(n)), 'Color', 'r','Parent',handles.axes1);
    end
end
loc = find(handles.currentFramecor == handles.data3(:,2));
if ~isempty(loc)
    for n = 1:length(loc)
plot(handles.axes1, handles.data1(loc(n),4),handles.data1(loc(n),5),'r+','Parent',handles.axes1); %Point is plotted on the GUI
text (handles.data1(loc(n),4) + 6, handles.data1(loc(n),5) - 4, num2str (loc(n)), 'Color', 'r','Parent',handles.axes1);
    end
end
end
end
setappdata(0,'frame',handles.currentFramecor);
guidata(hObject, handles);
% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider



if isequal(handles.sz1,handles.sz2);
handles.fadeval = round(get(hObject,'Value'))/get(hObject,'Max');
image(handles.image1(:,:,handles.currentFramecor)*(1-(handles.fadeval)) + handles.image2(:,:,handles.currentFramecor)*(handles.fadeval), 'CDataMapping','scaled','Parent', handles.axes1);
if ~isempty(handles.data1);
loc = find(handles.data3(:,1)==handles.currentFramecor);
if ~isempty(loc)
    for n = 1:length(loc)
plot(handles.axes1, handles.data1(loc(n),1),handles.data1(loc(n),2),'r+','Parent',handles.axes1); %Point is plotted on the GUI
text (handles.data1(loc(n),1) - 7, handles.data1(loc(n),2) + 6, num2str (loc(n)), 'Color', 'r','Parent',handles.axes1);
    end
end
loc = find(handles.currentFramecor == handles.data3(:,2));
if ~isempty(loc)
    for n = 1:length(loc)
plot(handles.axes1, handles.data1(loc(n),4),handles.data1(loc(n),5),'r+','Parent',handles.axes1); %Point is plotted on the GUI
text (handles.data1(loc(n),4) + 6, handles.data1(loc(n),5) - 4, num2str (loc(n)), 'Color', 'r','Parent',handles.axes1);
    end
end
end
end

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1

if ~isempty(handles.data1);
loc = find(handles.data3(:,1)==handles.currentFramecor);
if ~isempty(loc)
    for n = 1:length(loc)
plot(handles.axes1, handles.data1(loc(n),1),handles.data1(loc(n),2),'r+','Parent',handles.axes1); %Point is plotted on the GUI
text (handles.data1(loc(n),1) - 7, handles.data1(loc(n),2) + 6, num2str (loc(n)), 'Color', 'r','Parent',handles.axes1);
    end
end
loc = find(handles.currentFramecor == handles.data3(:,2));
if ~isempty(loc)
    for n = 1:length(loc)
plot(handles.axes1, handles.data1(loc(n),4),handles.data1(loc(n),5),'r+','Parent',handles.axes1); %Point is plotted on the GUI
text (handles.data1(loc(n),4) + 6, handles.data1(loc(n),5) - 4, num2str (loc(n)), 'Color', 'r','Parent',handles.axes1);
    end
end
end

loc1 = get(hObject,'Value');

if ~isempty(handles.data1);
loc = find(handles.data3(:,1)==handles.currentFramecor);
loc2 = find(loc == loc1);
loc2 = loc(loc2);
if ~isempty(loc2)
    for n = 1:length(loc)
plot(handles.axes1, handles.data1(loc1,1),handles.data1(loc1,2),'g+','Parent',handles.axes1); %Point is plotted on the GUI
text (handles.data1(loc1,1) - 7, handles.data1(loc1,2) + 6, num2str (loc1), 'Color', 'g','Parent',handles.axes1);
    end
end
loc = find(handles.currentFramecor == handles.data3(:,2));
loc2 = find(loc == loc1);
loc2 = loc(loc2);
if ~isempty(loc2)
    for n = 1:length(loc)
plot(handles.axes1, handles.data1(loc1,4),handles.data1(loc1,5),'g+','Parent',handles.axes1); %Point is plotted on the GUI
text (handles.data1(loc1,4) + 6, handles.data1(loc1,5) - 4, num2str (loc1), 'Color', 'g','Parent',handles.axes1);
    end
end
end
% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in measure.
function measure_Callback(hObject, eventdata, handles)
% hObject    handle to measure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n = 1;
while n <= 4
    [x,y] = ginput(1);
    handles.currentFramecor = getappdata(0,'frame');
    coords{n} = [x,y,handles.currentFramecor];
    if n <= 2
        hold on
        plot(x,y,'r+','Parent',handles.axes1); %Point is plotted on the GUI
    end
     if n > 2
        hold on
        plot(x,y,'g+','Parent',handles.axes1); %Point is plotted on the GUI
     end
    n = n+1;
end

handles.data1 = [handles.data1;[coords{1},coords{2},coords{3},coords{4},(0.898*(coords{2}(2)-coords{1}(2))), (0.898*(coords{2}(1)-coords{1}(1))) , (0.898*(coords{2}(3)-coords{1}(3)))...
    (0.898*(coords{4}(2)-coords{3}(2))),(0.898*(coords{4}(1)-coords{3}(1))), (0.898*(coords{4}(3)-coords{3}(3)))]];

handles.data2 = [handles.data2; {[num2str(0.898*(coords{2}(2)-coords{1}(2))) ',' num2str(0.898*(coords{2}(1)-coords{1}(1))) ',' num2str(0.898*(coords{2}(3)-coords{1}(3))) ','...
    num2str(0.898*(coords{4}(2)-coords{3}(2))) ',' num2str(0.898*(coords{4}(1)-coords{3}(1))) ',' num2str(0.898*(coords{4}(3)-coords{3}(3)))]}];
handles.data3 = [handles.data3; [coords{1}(3), coords{2}(3)]];
set(handles.listbox1, 'String', handles.data2);
if isequal(handles.sz1,handles.sz2);
image(handles.image1(:,:,handles.currentFramecor)*(1-(handles.fadeval)) + handles.image2(:,:,handles.currentFramecor)*(handles.fadeval), 'CDataMapping','scaled','Parent', handles.axes1);
if ~isempty(handles.data1);
loc = find(handles.data3(:,1)==handles.currentFramecor);
if ~isempty(loc)
    for n = 1:length(loc)
plot(handles.axes1, handles.data1(loc(n),1),handles.data1(loc(n),2),'r+','Parent',handles.axes1); %Point is plotted on the GUI
text (handles.data1(loc(n),1) - 7, handles.data1(loc(n),2) + 6, num2str (loc(n)), 'Color', 'r','Parent',handles.axes1);
    end
end
loc = find(handles.currentFramecor == handles.data3(:,2));
if ~isempty(loc)
    for n = 1:length(loc)
plot(handles.axes1, handles.data1(loc(n),4),handles.data1(loc(n),5),'r+','Parent',handles.axes1); %Point is plotted on the GUI
text (handles.data1(loc(n),4) + 6, handles.data1(loc(n),5) - 4, num2str (loc(n)), 'Color', 'r','Parent',handles.axes1);
    end
end
end
end
guidata(hObject, handles);


% --- Executes on button press in remove.
function remove_Callback(hObject, eventdata, handles)
% hObject    handle to remove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
point = get(handles.listbox1,'Value');
handles.data1(point,:) = [];
handles.data2(point) = [];
handles.data3(point,:) = [];
guidata(hObject, handles);
if point ~= 1
set(handles.listbox1,'Value',point-1);
end
set(handles.listbox1, 'String', handles.data2);
if isequal(handles.sz1,handles.sz2);
image(handles.image1(:,:,handles.currentFramecor)*(1-(handles.fadeval)) + handles.image2(:,:,handles.currentFramecor)*(handles.fadeval), 'CDataMapping','scaled','Parent', handles.axes1);
if ~isempty(handles.data1);
loc = find(handles.data3(:,1)==handles.currentFramecor);
if ~isempty(loc)
    for n = 1:length(loc)
plot(handles.axes1, handles.data1(loc(n),1),handles.data1(loc(n),2),'r+','Parent',handles.axes1); %Point is plotted on the GUI
text (handles.data1(loc(n),1) - 7, handles.data1(loc(n),2) + 6, num2str (loc(n)), 'Color', 'r','Parent',handles.axes1);
    end
end
loc = find(handles.currentFramecor == handles.data3(:,2));
if ~isempty(loc)
    for n = 1:length(loc)
plot(handles.axes1, handles.data1(loc(n),4),handles.data1(loc(n),5),'r+','Parent',handles.axes1); %Point is plotted on the GUI
text (handles.data1(loc(n),4) + 6, handles.data1(loc(n),5) - 4, num2str (loc(n)), 'Color', 'r','Parent',handles.axes1);
    end
end
end
end
% --------------------------------------------------------------------
function load_reference_image_Callback(hObject, eventdata, handles)
% hObject    handle to load_reference_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
formsel = formatsel2;
waitfor(formsel);
selection = getappdata(0,'formsel');
switch selection
    case{'DICOM'}
        directory_name = uigetdir;
if ~isnumeric(directory_name)
[image1,imgData] = loadDICOM2(directory_name);
[pathstr, name, ext, versn] = fileparts(directory_name);
end
case{'RTOG'}
[name, pathname, filterindex] = uigetfile({'*.*',  'All Files (*.*)'},'Select RTOG header file 0000');
if filterindex ==0
    return
end
image1 = loadRTOG([pathname name]);
    case{'MAT'}
        [FileName,PathName,FilterIndex] = uigetfile({'*.m',  'Matlab file (.mat)'},'Select saved data');
        load([PathName FileName], '-mat');
end
handles.sz1 = size(image1);
set(handles.slider1,'Min',0);
set(handles.slider1,'Max',handles.sz1(3)-1);
handles.image1 = image1;
clear image1;
 fadeval = round(get(handles.slider2,'Value'))/get(handles.slider2,'Max');
slice = handles.sz1(3) -  round(get(handles.slider1,'Value'));
if isequal(handles.sz1,handles.sz2);
image(handles.image1(:,:,slice)*(1-(fadeval)) + handles.image2(:,:,slice)*(fadeval));
colormap bone;
end
handles.currentFramecor = slice;
handles.fadeval = fadeval;
guidata(hObject, handles);
% --------------------------------------------------------------------
function load_target_image_Callback(hObject, eventdata, handles)
% hObject    handle to load_target_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

formsel = formatsel2;
waitfor(formsel);
selection = getappdata(0,'formsel');
switch selection
    case{'DICOM'}
        directory_name = uigetdir;
if ~isnumeric(directory_name)
[image1,imgData] = loadDICOM2(directory_name);
[pathstr, name, ext, versn] = fileparts(directory_name);
end
case{'RTOG'}
[name, pathname, filterindex] = uigetfile({'*.*',  'All Files (*.*)'},'Select RTOG header file 0000');
if filterindex ==0
    return
end
image1 = loadRTOG([pathname name]);
    case{'MAT'}
        [FileName,PathName,FilterIndex] = uigetfile({'*.m',  'Matlab file (.mat)'},'Select saved data');
        load([PathName '\' FileName], '-mat');
end
handles.sz2 = size(image1);
set(handles.slider1,'Min',0);
set(handles.slider1,'Max',handles.sz2(3)-1);
handles.image2 = image1;
clear image1;
fadeval = round(get(handles.slider2,'Value'))/get(handles.slider2,'Max');
slice = handles.sz1(3) - round(get(handles.slider1,'Value'));
if isequal(handles.sz1,handles.sz2);
image(handles.image1(:,:,slice)*(1-(fadeval)) + handles.image2(:,:,slice)*(fadeval));
colormap bone;
end
handles.currentFramecor = slice;
handles.fadeval = fadeval;
guidata(hObject, handles);
% --------------------------------------------------------------------
function load_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to load_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName,FilterIndex] = uigetfile('*.xls','Load Analysis');
handles.data1 = xlsread([PathName FileName],'Sheet1');
handles.data2 = [];
sz = size(handles.data1);
for n = 1:sz(1)
handles.data2 = [handles.data2;{[num2str(handles.data1(n,13)) ',' num2str(handles.data1(n,14)) ',' num2str(handles.data1(n,15)) ','...
    num2str(handles.data1(n,16)) ',' num2str(handles.data1(n,17)) ',' num2str(handles.data1(n,18))]}];
end
handles.data3 = [handles.data3; [handles.data1(:,3), handles.data1(:,6)]];
set(handles.listbox1,'Value',1);
set(handles.listbox1,'String',handles.data2);
if isequal(handles.sz1,handles.sz2);
image(handles.image1(:,:,handles.currentFramecor)*(1-(handles.fadeval)) + handles.image2(:,:,handles.currentFramecor)*(handles.fadeval), 'CDataMapping','scaled','Parent', handles.axes1);
if ~isempty(handles.data1);
loc = find(handles.data3(:,1)==handles.currentFramecor);
if ~isempty(loc)
    for n = 1:length(loc)
plot(handles.axes1, handles.data1(loc(n),1),handles.data1(loc(n),2),'r+','Parent',handles.axes1); %Point is plotted on the GUI
text (handles.data1(loc(n),1) - 7, handles.data1(loc(n),2) + 6, num2str (loc(n)), 'Color', 'r','Parent',handles.axes1);
    end
end
loc = find(handles.currentFramecor == handles.data3(:,2));
if ~isempty(loc)
    for n = 1:length(loc)
plot(handles.axes1, handles.data1(loc(n),4),handles.data1(loc(n),5),'r+','Parent',handles.axes1); %Point is plotted on the GUI
text (handles.data1(loc(n),4) + 6, handles.data1(loc(n),5) - 4, num2str (loc(n)), 'Color', 'r','Parent',handles.axes1);
    end
end
end
end
guidata(hObject,handles);
% return to this
% --------------------------------------------------------------------
function save_analysis_Callback(hObject, eventdata, handles)%save analysis
% hObject    handle to save_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName,FilterIndex] = uiputfile('*.xls','Save Analysis As');
xlswrite([PathName FileName],{'X1','Y1','Z1','X2','Y2','Z2','X3','Y3','Z3','X4','Y4','Z4','dX','dY','dZ','dXmax','dYmax','dZmax'},'Sheet1');
xlswrite([PathName FileName], handles.data1,'Sheet1','A2' );


% --------------------------------------------------------------------
function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
