function varargout = reg_params(varargin)
% REG_PARAMS M-file for reg_params.fig
%      REG_PARAMS, by itself, creates a new REG_PARAMS or raises the existing
%      singleton*.
%
%      H = REG_PARAMS returns the handle to a new REG_PARAMS or the handle to
%      the existing singleton*.
%
%      REG_PARAMS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REG_PARAMS.M with the given input arguments.
%
%      REG_PARAMS('Property','Value',...) creates a new REG_PARAMS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before reg_params_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to reg_params_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help reg_params

% Last Modified by GUIDE v2.5 09-Aug-2007 17:31:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @reg_params_OpeningFcn, ...
                   'gui_OutputFcn',  @reg_params_OutputFcn, ...
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


% --- Executes just before reg_params is made visible.
function reg_params_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to reg_params (see VARARGIN)

% Choose default command line output for reg_params
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes reg_params wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = reg_params_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
