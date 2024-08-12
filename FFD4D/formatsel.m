function varargout = formatsel(varargin)
% FORMATSEL M-file for formatsel.fig
%      FORMATSEL, by itself, creates a new FORMATSEL or raises the existing
%      singleton*.
%
%      H = FORMATSEL returns the handle to a new FORMATSEL or the handle to
%      the existing singleton*.
%
%      FORMATSEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FORMATSEL.M with the given input arguments.
%
%      FORMATSEL('Property','Value',...) creates a new FORMATSEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before formatsel_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to formatsel_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help formatsel

% Last Modified by GUIDE v2.5 04-Sep-2007 21:44:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @formatsel_OpeningFcn, ...
                   'gui_OutputFcn',  @formatsel_OutputFcn, ...
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


% --- Executes just before formatsel is made visible.
function formatsel_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to formatsel (see VARARGIN)

% Choose default command line output for formatsel
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes formatsel wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = formatsel_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in formatsel.
function format_men_Callback(hObject, eventdata, handles)
% hObject    handle to formatsel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns formatsel contents as cell array
%        contents{get(hObject,'Value')} returns selected item from formatsel


% --- Executes during object creation, after setting all properties.
function format_men_CreateFcn(hObject, eventdata, handles)
% hObject    handle to formatsel (see GCBO)
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
close formatsel

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'formsel','none');
close formatsel

