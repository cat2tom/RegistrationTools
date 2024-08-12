function varargout = auto_segmentation(varargin)
% AUTO_SEGMENTATION M-file for auto_segmentation.fig
%      AUTO_SEGMENTATION, by itself, creates a new AUTO_SEGMENTATION or raises the existing
%      singleton*.
%
%      H = AUTO_SEGMENTATION returns the handle to a new AUTO_SEGMENTATION or the handle to
%      the existing singleton*.
%
%      AUTO_SEGMENTATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AUTO_SEGMENTATION.M with the given input arguments.
%
%      AUTO_SEGMENTATION('Property','Value',...) creates a new AUTO_SEGMENTATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before auto_segmentation_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to auto_segmentation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help auto_segmentation

% Last Modified by GUIDE v2.5 06-Sep-2007 18:01:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @auto_segmentation_OpeningFcn, ...
                   'gui_OutputFcn',  @auto_segmentation_OutputFcn, ...
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


% --- Executes just before auto_segmentation is made visible.
function auto_segmentation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to auto_segmentation (see VARARGIN)

% Choose default command line output for auto_segmentation
handles.output = hObject;
handles.values = ones(10,2);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes auto_segmentation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = auto_segmentation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
handles.values(1,2) = get(hObject,'Value');
guidata(hObject,handles);

% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
handles.values(2,2) = get(hObject,'Value');
guidata(hObject,handles);

% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3
handles.values(3,2) = get(hObject,'Value');
guidata(hObject,handles);

% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4
handles.values(4,2) = get(hObject,'Value');
guidata(hObject,handles);

% --- Executes on button press in im5.
function im5_Callback(hObject, eventdata, handles)
% hObject    handle to im5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of im5
handles.values(5,2) = get(hObject,'Value');
guidata(hObject,handles);

% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6
handles.values(6,2) = get(hObject,'Value');
guidata(hObject,handles);

% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7
handles.values(7,2) = get(hObject,'Value');
guidata(hObject,handles);

% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox8
handles.values(8,2) = get(hObject,'Value');
guidata(hObject,handles);

% --- Executes on button press in checkbox9.
function checkbox9_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox9
handles.values(9,2) = get(hObject,'Value');
guidata(hObject,handles);

% --- Executes on button press in checkbox10.
function checkbox10_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox10
handles.values(10,2) = get(hObject,'Value');
guidata(hObject,handles);

% --- Executes on button press in Accept.
function Accept_Callback(hObject, eventdata, handles)
% hObject    handle to Accept (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'autos',handles.values);
close auto_segmentation;
% --- Executes on button press in bone1.
function bone1_Callback(hObject, eventdata, handles)
% hObject    handle to bone1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bone1
handles.values(1,1) = get(hObject,'Value');
guidata(hObject,handles);

% --- Executes on button press in bone2.
function bone2_Callback(hObject, eventdata, handles)
% hObject    handle to bone2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bone2
handles.values(2,1) = get(hObject,'Value');
guidata(hObject,handles);

% --- Executes on button press in bone3.
function bone3_Callback(hObject, eventdata, handles)
% hObject    handle to bone3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bone3
handles.values(3,1) = get(hObject,'Value');
guidata(hObject,handles);

% --- Executes on button press in bone4.
function bone4_Callback(hObject, eventdata, handles)
% hObject    handle to bone4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bone4
handles.values(4,1) = get(hObject,'Value');
guidata(hObject,handles);

% --- Executes on button press in bone5.
function bone5_Callback(hObject, eventdata, handles)
% hObject    handle to bone5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bone5
handles.values(5,1) = get(hObject,'Value');
guidata(hObject,handles);

% --- Executes on button press in bone6.
function bone6_Callback(hObject, eventdata, handles)
% hObject    handle to bone6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bone6
handles.values(6,1) = get(hObject,'Value');
guidata(hObject,handles);

% --- Executes on button press in bone7.
function bone7_Callback(hObject, eventdata, handles)
% hObject    handle to bone7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bone7
handles.values(7,1) = get(hObject,'Value');
guidata(hObject,handles);

% --- Executes on button press in bone8.
function bone8_Callback(hObject, eventdata, handles)
% hObject    handle to bone8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bone8
handles.values(8,1) = get(hObject,'Value');
guidata(hObject,handles);

% --- Executes on button press in bone9.
function bone9_Callback(hObject, eventdata, handles)
% hObject    handle to bone9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bone9
handles.values(9,1) = get(hObject,'Value');
guidata(hObject,handles);

% --- Executes on button press in checkbox30.
function checkbox30_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox30


% --- Executes on button press in bone10.
function bone10_Callback(hObject, eventdata, handles)
% hObject    handle to bone10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bone10
handles.values(10,1) = get(hObject,'Value');
guidata(hObject,handles);

