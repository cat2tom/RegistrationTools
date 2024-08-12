function varargout = newimage(varargin)
% NEWIMAGE M-file for newimage.fig
%      NEWIMAGE, by itself, creates a new NEWIMAGE or raises the existing
%      singleton*.
%
%      H = NEWIMAGE returns the handle to a new NEWIMAGE or the handle to
%      the existing singleton*.
%
%      NEWIMAGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEWIMAGE.M with the given input arguments.
%
%      NEWIMAGE('Property','Value',...) creates a new NEWIMAGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before newimage_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to newimage_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help newimage

% Last Modified by GUIDE v2.5 15-Oct-2007 00:06:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @newimage_OpeningFcn, ...
                   'gui_OutputFcn',  @newimage_OutputFcn, ...
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


% --- Executes just before newimage is made visible.
function newimage_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to newimage (see VARARGIN)

% Choose default command line output for newimage
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes newimage wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = newimage_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function name_Callback(hObject, eventdata, handles)
% hObject    handle to name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of name as text
%        str2double(get(hObject,'String')) returns contents of name as a double
handles.im_name = get(hObject,'String');
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to name (see GCBO)
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
setappdata(0,'im_name',handles.im_name);
close newimage

% --- Executes on button press in Cancel.
function Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'im_name',[]);
close newimage

