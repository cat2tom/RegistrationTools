function varargout = load_patient(varargin)
% LOAD_PATIENT M-file for load_patient.fig
%      LOAD_PATIENT, by itself, creates a new LOAD_PATIENT or raises the existing
%      singleton*.
%
%      H = LOAD_PATIENT returns the handle to a new LOAD_PATIENT or the handle to
%      the existing singleton*.
%
%      LOAD_PATIENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOAD_PATIENT.M with the given input arguments.
%
%      LOAD_PATIENT('Property','Value',...) creates a new LOAD_PATIENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before load_patient_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to load_patient_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help load_patient

% Last Modified by GUIDE v2.5 10-Aug-2007 10:47:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @load_patient_OpeningFcn, ...
                   'gui_OutputFcn',  @load_patient_OutputFcn, ...
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


% --- Executes just before load_patient is made visible.
function load_patient_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to load_patient (see VARARGIN)

% Choose default command line output for load_patient
handles.output = hObject;
handles.parentdir = getappdata(0,'parentdir');
fid = fopen([handles.parentdir '\patients.txt']);
names = textscan(fid,'%s','Delimiter','\n');
names = names{1};
fclose(fid);
set(handles.listbox1,'String',names);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes load_patient wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = load_patient_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


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


% --- Executes on button press in Accept.
function Accept_Callback(hObject, eventdata, handles)
% hObject    handle to Accept (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% contents = get(handles.listbox1,'String');
name = get(handles.listbox1,'Value');
setappdata(0,'pat_name',name);
close load_patient

% --- Executes on button press in Cancel.
function Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

setappdata(0,'pat_name','no patient loaded');
close load_patient
