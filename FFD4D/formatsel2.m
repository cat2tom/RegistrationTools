function varargout = formatsel2(varargin)
% FORMATSEL2 M-file for formatsel2.fig
%      FORMATSEL2, by itself, creates a new FORMATSEL2 or raises the existing
%      singleton*.
%
%      H = FORMATSEL2 returns the handle to a new FORMATSEL2 or the handle to
%      the existing singleton*.
%
%      FORMATSEL2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FORMATSEL2.M with the given input arguments.
%
%      FORMATSEL2('Property','Value',...) creates a new FORMATSEL2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before formatsel_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to formatsel2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help formatsel2

% Last Modified by GUIDE v2.5 14-May-2008 13:20:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @formatsel2_OpeningFcn, ...
                   'gui_OutputFcn',  @formatsel2_OutputFcn, ...
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


% --- Executes just before formatsel2 is made visible.
function formatsel2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to formatsel2 (see VARARGIN)

% Choose default command line output for formatsel2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes formatsel2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = formatsel2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in formatsel2.
function format_men_Callback(hObject, eventdata, handles)
% hObject    handle to formatsel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns formatsel2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from formatsel2


% --- Executes during object creation, after setting all properties.
function format_men_CreateFcn(hObject, eventdata, handles)
% hObject    handle to formatsel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in accept.
function accept_Callback(hObject, eventdata, handles)
% hObject    handle to accept (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = get(handles.format_men,'String') ;
selection = contents{get(handles.format_men,'Value')};
setappdata(0,'formsel',selection);
close formatsel2

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'formsel','none');
close formatsel2

