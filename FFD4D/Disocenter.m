function varargout = Disocenter(varargin)
% DISOCENTER M-file for Disocenter.fig
%      DISOCENTER, by itself, creates a new DISOCENTER or raises the existing
%      singleton*.
%
%      H = DISOCENTER returns the handle to a new DISOCENTER or the handle to
%      the existing singleton*.
%
%      DISOCENTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DISOCENTER.M with the given input arguments.
%
%      DISOCENTER('Property','Value',...) creates a new DISOCENTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Disocenter_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Disocenter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Disocenter

% Last Modified by GUIDE v2.5 17-Oct-2008 16:51:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Disocenter_OpeningFcn, ...
                   'gui_OutputFcn',  @Disocenter_OutputFcn, ...
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


% --- Executes just before Disocenter is made visible.
function Disocenter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Disocenter (see VARARGIN)

% Choose default command line output for Disocenter
handles.output = hObject;
sz = getappdata(0,'imsize');
handles.center = getappdata(0,'center');
set(handles.X_coord,'String',num2str(handles.center(2)));
set(handles.Y_coord,'String',num2str(handles.center(1)));
set(handles.Z_coord,'String',num2str(handles.center(3)));

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Disocenter wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Disocenter_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function X_coord_Callback(hObject, eventdata, handles)
% hObject    handle to X_coord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X_coord as text
%        str2double(get(hObject,'String')) returns contents of X_coord as a double
handles.center(2) = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function X_coord_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X_coord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Y_coord_Callback(hObject, eventdata, handles)
% hObject    handle to Y_coord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y_coord as text
%        str2double(get(hObject,'String')) returns contents of Y_coord as a double
handles.center(1) = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Y_coord_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y_coord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z_coord_Callback(hObject, eventdata, handles)
% hObject    handle to Z_coord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z_coord as text
%        str2double(get(hObject,'String')) returns contents of Z_coord as a double
handles.center(3) = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Z_coord_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z_coord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in okbutton.
function okbutton_Callback(hObject, eventdata, handles)
% hObject    handle to okbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'center',handles.center);
close Disocenter;

% --- Executes on button press in use_mouse.
function use_mouse_Callback(hObject, eventdata, handles)
% hObject    handle to use_mouse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'center',1);
close Disocenter;
% --- Executes on button press in cancel.
function cancel_Callback(hObject, eventdata, handles)
% hObject    handle to cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'center',0);
close Disocenter;
