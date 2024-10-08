function varargout = Dcoord(varargin)
%DCOORD M-file for Dcoord.fig
%      DCOORD, by itself, creates a new DCOORD or raises the existing
%      singleton*.
%
%      H = DCOORD returns the handle to a new DCOORD or the handle to
%      the existing singleton*.
%
%      DCOORD('Property','Value',...) creates a new DCOORD using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to Dcoord_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      DCOORD('CALLBACK') and DCOORD('CALLBACK',hObject,...) call the
%      local function named CALLBACK in DCOORD.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Dcoord

% Last Modified by GUIDE v2.5 20-Oct-2008 14:11:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Dcoord_OpeningFcn, ...
                   'gui_OutputFcn',  @Dcoord_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before Dcoord is made visible.
function Dcoord_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for Dcoord
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Dcoord wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Dcoord_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function X1_coord_Callback(hObject, eventdata, handles)
% hObject    handle to X1_coord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X1_coord as text
%        str2double(get(hObject,'String')) returns contents of X1_coord as a double
handles.coord1(2) = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function X1_coord_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X1_coord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Y1_coord_Callback(hObject, eventdata, handles)
% hObject    handle to Y1_coord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y1_coord as text
%        str2double(get(hObject,'String')) returns contents of Y1_coord as a double
handles.coord1(1) = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Y1_coord_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y1_coord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z1_coord_Callback(hObject, eventdata, handles)
% hObject    handle to Z1_coord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z1_coord as text
%        str2double(get(hObject,'String')) returns contents of Z1_coord as a double
handles.coord1(3) = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Z1_coord_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z1_coord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function X2_coord_Callback(hObject, eventdata, handles)
% hObject    handle to X2_coord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X2_coord as text
%        str2double(get(hObject,'String')) returns contents of X2_coord as a double
handles.coord2(2) = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function X2_coord_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X2_coord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Y2_coord_Callback(hObject, eventdata, handles)
% hObject    handle to Y2_coord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y2_coord as text
%        str2double(get(hObject,'String')) returns contents of Y2_coord as a double
handles.coord2(1) = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Y2_coord_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y2_coord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z2_coord_Callback(hObject, eventdata, handles)
% hObject    handle to Z2_coord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z2_coord as text
%        str2double(get(hObject,'String')) returns contents of Z2_coord as a double
handles.coord2(3) = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Z2_coord_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z2_coord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in accept_button.
function accept_button_Callback(hObject, eventdata, handles)
% hObject    handle to accept_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'coords',[handles.coord1;handles.coord2]);
close Dcoord

% --- Executes on button press in cancel_button.
function cancel_button_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

setappdata(0,'coords',0);
close Dcoord
