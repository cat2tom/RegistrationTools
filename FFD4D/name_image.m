function varargout = name_image(varargin)
% NAME_IMAGE M-file for name_image.fig
%      NAME_IMAGE, by itself, creates a new NAME_IMAGE or raises the existing
%      singleton*.
%
%      H = NAME_IMAGE returns the handle to a new NAME_IMAGE or the handle to
%      the existing singleton*.
%
%      NAME_IMAGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NAME_IMAGE.M with the given input arguments.
%
%      NAME_IMAGE('Property','Value',...) creates a new NAME_IMAGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before name_image_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to name_image_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help name_image

% Last Modified by GUIDE v2.5 03-Feb-2008 13:28:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @name_image_OpeningFcn, ...
                   'gui_OutputFcn',  @name_image_OutputFcn, ...
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


% --- Executes just before name_image is made visible.
function name_image_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to name_image (see VARARGIN)

% Choose default command line output for name_image
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes name_image wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = name_image_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function name_field_Callback(hObject, eventdata, handles)
% hObject    handle to name_field (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of name_field as text
%        str2double(get(hObject,'String')) returns contents of name_field as a double
handles.name = get(hObject,'String');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function name_field_CreateFcn(hObject, eventdata, handles)
% hObject    handle to name_field (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Accept_pushbutton.
function Accept_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Accept_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'imagename',handles.name);
close name_image;

% --- Executes on button press in Cancel.
function Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'imagename',0);

