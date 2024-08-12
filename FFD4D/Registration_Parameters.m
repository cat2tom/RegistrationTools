function varargout = Registration_Parameters(varargin)
% REGISTRATION_PARAMETERS M-file for Registration_Parameters.fig
%      REGISTRATION_PARAMETERS, by itself, creates a new REGISTRATION_PARAMETERS or raises the existing
%      singleton*.
%
%      H = REGISTRATION_PARAMETERS returns the handle to a new REGISTRATION_PARAMETERS or the handle to
%      the existing singleton*.
%
%      REGISTRATION_PARAMETERS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REGISTRATION_PARAMETERS.M with the given input arguments.
%
%      REGISTRATION_PARAMETERS('Property','Value',...) creates a new REGISTRATION_PARAMETERS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Registration_Parameters_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Registration_Parameters_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Registration_Parameters

% Last Modified by GUIDE v2.5 02-Jun-2008 10:02:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Registration_Parameters_OpeningFcn, ...
                   'gui_OutputFcn',  @Registration_Parameters_OutputFcn, ...
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


% --- Executes just before Registration_Parameters is made visible.
function Registration_Parameters_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Registration_Parameters (see VARARGIN)

% Choose default command line output for Registration_Parameters
handles.output = hObject;
handles.reg_params = getappdata(0,'reg_params');
set(handles.iterations,'String',num2str(handles.reg_params{1}));
set(handles.steps,'String',num2str(handles.reg_params{2}));
set(handles.smoothness,'String',num2str(handles.reg_params{3}));
set(handles.fpointw,'String',num2str(handles.reg_params{4}));
set(handles.step_size,'String',num2str(handles.reg_params{5}));
set(handles.firstlev_1,'String',num2str(handles.reg_params{6}(1)));
set(handles.firstlev_2,'String',num2str(handles.reg_params{6}(2)));
set(handles.firstlev_3,'String',num2str(handles.reg_params{6}(3)));
set(handles.seclev_1,'String',num2str(handles.reg_params{7}(1)));
set(handles.seclev_2,'String',num2str(handles.reg_params{7}(2)));
set(handles.seclev_3,'String',num2str(handles.reg_params{7}(3)));
set(handles.cont_resx,'String',num2str(handles.reg_params{8}(1)));
set(handles.cont_resy,'String',num2str(handles.reg_params{8}(2)));
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Registration_Parameters wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Registration_Parameters_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function iterations_Callback(hObject, eventdata, handles)
% hObject    handle to iterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of iterations as text
%        str2double(get(hObject,'String')) returns contents of iterations as a double
handles.reg_params{1} = str2double(get(hObject,'String'));
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function iterations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function steps_Callback(hObject, eventdata, handles)
% hObject    handle to steps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of steps as text
%        str2double(get(hObject,'String')) returns contents of steps as a double
handles.reg_params{2} = str2double(get(hObject,'String'));
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function steps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to steps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function smoothness_Callback(hObject, eventdata, handles)
% hObject    handle to smoothness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of smoothness as text
%        str2double(get(hObject,'String')) returns contents of smoothness as a double
handles.reg_params{3} = str2double(get(hObject,'String'));
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function smoothness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to smoothness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fpointw_Callback(hObject, eventdata, handles)
% hObject    handle to fpointw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fpointw as text
%        str2double(get(hObject,'String')) returns contents of fpointw as a double
handles.reg_params{4} = str2double(get(hObject,'String'));
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function fpointw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fpointw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function step_size_Callback(hObject, eventdata, handles)
% hObject    handle to step_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of step_size as text
%        str2double(get(hObject,'String')) returns contents of step_size as a double
handles.reg_params{5} = str2double(get(hObject,'String'));
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function step_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to step_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function firstlev_1_Callback(hObject, eventdata, handles)
% hObject    handle to firstlev_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of firstlev_1 as text
%        str2double(get(hObject,'String')) returns contents of firstlev_1 as a double
handles.reg_params{6}(1) = str2double(get(hObject,'String'));
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function firstlev_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to firstlev_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function firstlev_2_Callback(hObject, eventdata, handles)
% hObject    handle to firstlev_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of firstlev_2 as text
%        str2double(get(hObject,'String')) returns contents of firstlev_2 as a double

handles.reg_params{6}(2) = str2double(get(hObject,'String'));
% Update handles structure
guidata(hObject, handles);
% --- Executes during object creation, after setting all properties.
function firstlev_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to firstlev_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function firstlev_3_Callback(hObject, eventdata, handles)
% hObject    handle to firstlev_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of firstlev_3 as text
%        str2double(get(hObject,'String')) returns contents of firstlev_3 as a double
handles.reg_params{6}(3) = str2double(get(hObject,'String'));
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function firstlev_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to firstlev_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function seclev_1_Callback(hObject, eventdata, handles)
% hObject    handle to seclev_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of seclev_1 as text
%        str2double(get(hObject,'String')) returns contents of seclev_1 as a double
handles.reg_params{7}(1) = str2double(get(hObject,'String'));
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function seclev_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to seclev_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function seclev_2_Callback(hObject, eventdata, handles)
% hObject    handle to seclev_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of seclev_2 as text
%        str2double(get(hObject,'String')) returns contents of seclev_2 as a double
handles.reg_params{7}(2) = str2double(get(hObject,'String'));
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function seclev_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to seclev_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function seclev_3_Callback(hObject, eventdata, handles)
% hObject    handle to seclev_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of seclev_3 as text
%        str2double(get(hObject,'String')) returns contents of seclev_3 as a double
handles.reg_params{7}(3) = str2double(get(hObject,'String'));
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function seclev_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to seclev_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Accept.
function Accept_Callback(hObject, eventdata, handles)
% hObject    handle to Accept (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'reg_params',handles.reg_params);
close Registration_Parameters

% --- Executes on button press in Cancel.
function Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close Registration_Parameters




function cont_resx_Callback(hObject, eventdata, handles)
% hObject    handle to cont_resx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cont_resx as text
%        str2double(get(hObject,'String')) returns contents of cont_resx as a double
handles.reg_params{8}(1) = str2num(get(handles.cont_resx,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function cont_resx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cont_resx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cont_resy_Callback(hObject, eventdata, handles)
% hObject    handle to cont_resy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cont_resy as text
%        str2double(get(hObject,'String')) returns contents of cont_resy as a double
handles.reg_params{8}(2) = str2num(get(handles.cont_resy,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function cont_resy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cont_resy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


