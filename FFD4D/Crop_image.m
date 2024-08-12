function varargout = Crop_image(varargin)
% APPLY_IMAGE M-file for apply_image.fig
%      APPLY_IMAGE, by itself, creates a new APPLY_IMAGE or raises the existing
%      singleton*.
%
%      H = APPLY_IMAGE returns the handle to a new APPLY_IMAGE or the handle to
%      the existing singleton*.
%
%      APPLY_IMAGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APPLY_IMAGE.M with the given input arguments.
%
%      APPLY_IMAGE('Property','Value',...) creates a new APPLY_IMAGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before apply_image_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to apply_image_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help apply_image

% Last Modified by GUIDE v2.5 27-Aug-2007 14:57:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Crop_image_OpeningFcn, ...
                   'gui_OutputFcn',  @Crop_image_OutputFcn, ...
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


% --- Executes just before apply_image is made visible.
function Crop_image_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to apply_image (see VARARGIN)

% Choose default command line output for apply_image
handles.output = hObject;
handles.lim = getappdata(0,'limits');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes apply_image wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Crop_image_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Left_Callback(hObject, eventdata, handles)
% hObject    handle to Left (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Left as text
%        str2double(get(hObject,'String')) returns contents of Left as a double
try
handles.lim(3) = str2double(get(hObject,'String'));
catch
    errordlg('Field requires a number');
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Left_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Left (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function right_Callback(hObject, eventdata, handles)
% hObject    handle to right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of right as text
%        str2double(get(hObject,'String')) returns contents of right as a double
try
handles.lim(4) = str2double(get(hObject,'String'));
catch
    errordlg('Field requires a number');
end
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function right_CreateFcn(hObject, eventdata, handles)
% hObject    handle to right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function posterior_Callback(hObject, eventdata, handles)
% hObject    handle to posterior (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of posterior as text
%        str2double(get(hObject,'String')) returns contents of posterior as a double
try
handles.lim(2) = str2double(get(hObject,'String'));
catch
    errordlg('Field requires a number');
end
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function posterior_CreateFcn(hObject, eventdata, handles)
% hObject    handle to posterior (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Anterior_Callback(hObject, eventdata, handles)
% hObject    handle to Anterior (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Anterior as text
%        str2double(get(hObject,'String')) returns contents of Anterior as a double
try
handles.lim(1) = str2double(get(hObject,'String'));
catch
    errordlg('Field requires a number');
end
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function Anterior_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Anterior (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function superior_Callback(hObject, eventdata, handles)
% hObject    handle to superior (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of superior as text
%        str2double(get(hObject,'String')) returns contents of superior as a double
try
handles.lim(5) = str2double(get(hObject,'String'));
catch
    errordlg('Field requires a number');
end
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function superior_CreateFcn(hObject, eventdata, handles)
% hObject    handle to superior (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inferior_Callback(hObject, eventdata, handles)
% hObject    handle to inferior (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inferior as text
%        str2double(get(hObject,'String')) returns contents of inferior as a double
try
handles.lim(6) = str2double(get(hObject,'String'));
catch
    errordlg('Field requires a number');
end
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function inferior_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inferior (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Apply.
function Apply_Callback(hObject, eventdata, handles)
% hObject    handle to Apply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'limits',handles.lim);
FFD4D('apply_crop',hObject, eventdata, handles);
close Crop_image

% --- Executes on button press in cancel.
function cancel_Callback(hObject, eventdata, handles)
% hObject    handle to cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close Crop_image

% --- Executes on button press in preview.
function preview_Callback(hObject, eventdata, handles)
% hObject    handle to preview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'limitspr',handles.lim);
% handle = getappdata(0,'handle');

FFD4D('preview_crop_Callback',hObject, eventdata, handles);
 axis off;
% --- Executes on button press in cancel.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


