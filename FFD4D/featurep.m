function varargout = featurep(varargin)
% FEATUREP M-file for featurep.fig
%      FEATUREP, by itself, creates a new FEATUREP or raises the existing
%      singleton*.
%
%      H = FEATUREP returns the handle to a new FEATUREP or the handle to
%      the existing singleton*.
%
%      FEATUREP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FEATUREP.M with the given input arguments.
%
%      FEATUREP('Property','Value',...) creates a new FEATUREP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before featurep_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to featurep_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help featurep

% Last Modified by GUIDE v2.5 17-Oct-2008 23:38:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @featurep_OpeningFcn, ...
                   'gui_OutputFcn',  @featurep_OutputFcn, ...
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


% --- Executes just before featurep is made visible.
function featurep_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to featurep (see VARARGIN)

% Choose default command line output for featurep
handles.output = hObject;
handles.image1 = 0;
handles.image2 = 0;
handles.sz1 = [0,0,0];
handles.sz2 = [0,0,0];
handles.data1 = [];
handles.res = [1,1,1];
handles.contour1 =[];
handles.contour2 = [];
set(handles.fadeslide_sag,'Min',0);
set(handles.fadeslide_sag,'Max',5);
set(handles.fadeslide_tran,'Min',0);
set(handles.fadeslide_tran,'Max',5);
set(handles.fadeslide_cor,'Min',0);
set(handles.fadeslide_cor,'Max',5);
handles.fadeval = 0;
handles.Imgfiles = getappdata(0,'imgfiles');
handles.parentdir = getappdata(0,'parentdir');
handles.filenames = getappdata(0,'filenames');
sz = size(handles.filenames);
orientation  = find(sz == max(sz));
if orientation == 1
set(handles.image1_popup,'String',[{'Select An Image'} ; handles.filenames]);
set(handles.image2_popup,'String',[{'Select An Image'} ; handles.filenames]);
else
set(handles.image1_popup,'String',[{'Select An Image'} , handles.filenames]);
set(handles.image2_popup,'String',[{'Select An Image'} , handles.filenames]);
end
handles.fadeval_tran = round(get(handles.fadeslide_tran,'Value'))/get(handles.fadeslide_tran,'Max');
handles.fadeval_cor = round(get(handles.fadeslide_cor,'Value'))/get(handles.fadeslide_cor,'Max');
handles.fadeval_sag = round(get(handles.fadeslide_sag,'Value'))/get(handles.fadeslide_sag,'Max');
handles.selected = [];
handles.selon = 0;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes featurep wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = featurep_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider_tran_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
if isequal(handles.sz1,handles.sz2);
handles.currentFrametran = handles.sz1(3) - round(get(hObject,'Value'))+1;
image(handles.image1(:,:,handles.currentFrametran)*(1-(handles.fadeval_tran)) + handles.image2(:,:,handles.currentFrametran)*(handles.fadeval_tran), 'CDataMapping','scaled','Parent', handles.axes1);
set(handles.axes1,'Nextplot','add');    
if  ~isempty(handles.data1)
    loc = find(round(handles.data1(:,3)) ==handles.currentFrametran);

        if ~isempty(loc)
            for n = 1:length(loc)
        plot(handles.axes1, handles.data1(loc(n),1),handles.data1(loc(n),2),'r+','Parent',handles.axes1); %Point is plotted on the GUI
        text (handles.data1(loc(n),1) - 7, handles.data1(loc(n),2) + 6, num2str (loc(n)), 'Color', 'r','Parent',handles.axes1);
            end
        end
 if ~isempty(handles.selected)
            loc2 = find(loc == handles.selected);
            loc2 = loc(loc2);
        else
            loc2 = [];
        end
if ~isempty(loc2)
    for n = 1:length(loc2)
plot(handles.axes1, handles.data1(loc2(n),1),handles.data1(loc2(n),2),'y+','Parent',handles.axes1); %Point is plotted on the GUI
text (handles.data1(loc2(n),1) - 7, handles.data1(loc2(n),2) + 6, num2str(loc2(n)), 'Color', 'y','Parent',handles.axes1);
    end
end

    loc = find(round(handles.data1(:,6))==handles.currentFrametran);

        if ~isempty(loc)
            for n = 1:length(loc)
        plot(handles.axes1, handles.data1(loc(n),4),handles.data1(loc(n),5),'g+','Parent',handles.axes1); %Point is plotted on the GUI
        text (handles.data1(loc(n),4) -7, handles.data1(loc(n),5) +6 , num2str (loc(n)), 'Color', 'g','Parent',handles.axes1);
            end
        end
        if ~isempty(handles.selected)
            loc2 = find(loc == handles.selected);
            loc2 = loc(loc2);
        else
            loc2 = [];
        end
if ~isempty(loc2)
    for n = 1:length(loc2)
plot(handles.axes1, handles.data1(loc2(n),4),handles.data1(loc2(n),5),'y+','Parent',handles.axes1); %Point is plotted on the GUI
text (handles.data1(loc2(n),4) - 7, handles.data1(loc2(n),5) + 6, num2str(loc2(n)), 'Color', 'y','Parent',handles.axes1);
    end
end
    end
end
setappdata(0,'tranframe',handles.currentFrametran);
set(handles.tran_info,'String',[num2str(handles.currentFrametran) ' of ' num2str(handles.sz1(3))]);
set(handles.axes1,'Nextplot','replacechildren');
if ~isempty(handles.contour1)
if ~isempty(handles.contour1{handles.currentFrametran}) 
    for m = 1:length(handles.contour1{handles.currentFrametran})
patch(handles.contour1{handles.currentFrametran}{m}(:,1)-handles.lim(3)+1,handles.contour1{handles.currentFrametran}{m}(:,2)-handles.lim(1)+1,'r','EdgeColor','r','FaceColor','none','Parent',handles.axes1);
    end
end
end
guidata(hObject, handles);
% --- Executes during object creation, after setting all properties.
function slider_tran_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function fadeslide_tran_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider



if isequal(handles.sz1,handles.sz2);
handles.fadeval_tran = round(get(hObject,'Value'))/get(hObject,'Max');
image(handles.image1(:,:,handles.currentFrametran)*(1-(handles.fadeval_tran)) + handles.image2(:,:,handles.currentFrametran)*(handles.fadeval_tran), 'CDataMapping','scaled','Parent', handles.axes1);
set(handles.axes1,'Nextplot','add');    
if  ~isempty(handles.data1)
    loc = find(round(handles.data1(:,3)) ==handles.currentFrametran);

        if ~isempty(loc)
            for n = 1:length(loc)
        plot(handles.axes1, handles.data1(loc(n),1),handles.data1(loc(n),2),'r+','Parent',handles.axes1); %Point is plotted on the GUI
        text (handles.data1(loc(n),1) - 7, handles.data1(loc(n),2) + 6, num2str (loc(n)), 'Color', 'r','Parent',handles.axes1);
            end
        end
 if ~isempty(handles.selected)
            loc2 = find(loc == handles.selected);
            loc2 = loc(loc2);
        else
            loc2 = [];
        end
if ~isempty(loc2)
    for n = 1:length(loc2)
plot(handles.axes1, handles.data1(loc2(n),1),handles.data1(loc2(n),2),'y+','Parent',handles.axes1); %Point is plotted on the GUI
text (handles.data1(loc2(n),1) - 7, handles.data1(loc2(n),2) + 6, num2str(loc2(n)), 'Color', 'y','Parent',handles.axes1);
    end
end

    loc = find(round(handles.data1(:,6))==handles.currentFrametran);

        if ~isempty(loc)
            for n = 1:length(loc)
        plot(handles.axes1, handles.data1(loc(n),4),handles.data1(loc(n),5),'g+','Parent',handles.axes1); %Point is plotted on the GUI
        text (handles.data1(loc(n),4) -7, handles.data1(loc(n),5) +6 , num2str (loc(n)), 'Color', 'g','Parent',handles.axes1);
            end
        end
        if ~isempty(handles.selected)
            loc2 = find(loc == handles.selected);
            loc2 = loc(loc2);
        else
            loc2 = [];
        end
if ~isempty(loc2)
    for n = 1:length(loc2)
plot(handles.axes1, handles.data1(loc2(n),4),handles.data1(loc2(n),5),'y+','Parent',handles.axes1); %Point is plotted on the GUI
text (handles.data1(loc2(n),4) - 7, handles.data1(loc2(n),5) + 6, num2str(loc2(n)), 'Color', 'y','Parent',handles.axes1);
    end
end
    end
end
if ~isempty(handles.contour1)
if ~isempty(handles.contour1{handles.currentFrametran}) 
    for m = 1:length(handles.contour1{handles.currentFrametran})
patch(handles.contour1{handles.currentFrametran}{m}(:,1)-handles.lim(3)+1,handles.contour1{handles.currentFrametran}{m}(:,2)-handles.lim(1)+1,'r','EdgeColor','r','FaceColor','none','Parent',handles.axes1);
    end
end
end
set(handles.axes1,'Nextplot','replacechildren');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function fadeslide_tran_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
if handles.selon
%     if length(handles.selected)<2
        handles.selected = [handles.selected;get(handles.listbox1,'Value')];
%     end
end
if  isequal(handles.sz1,handles.sz2)
% imagesc(handles.image1(:,:,handles.currentFrametran)*(1-handles.fadeval_tran)+handles.image2(:,:,handles.currentFrametran)*handles.fadeval_tran,'Parent', handles.axes1);
    if  ~isempty(handles.data1)
        set(handles.axes2,'Nextplot','add');
        set(handles.axes3,'Nextplot','add');
        set(handles.axes1,'Nextplot','add');
    loc = find(handles.data1(:,3)==handles.currentFrametran);
    loc2 = find(handles.data1(:,1)==handles.currentFramecor);
    loc3 = find(handles.data1(:,2)==handles.currentFramesag);

        if ~isempty(loc)
            for n = 1:length(loc)
        plot(handles.axes1, handles.data1(loc(n),1),handles.data1(loc(n),2),'r+','Parent',handles.axes1); %Point is plotted on the GUI
        text (handles.data1(loc(n),1) - 7, handles.data1(loc(n),2) + 6, num2str (loc(n)), 'Color', 'r','Parent',handles.axes1);
            end
        end
        if ~isempty(loc2)
            for n = 1:length(loc2)
        plot(handles.axes2, handles.data1(loc2(n),2),handles.data1(loc2(n),3),'r+','Parent',handles.axes2); %Point is plotted on the GUI
        text (handles.data1(loc2(n),2) - 7, handles.data1(loc2(n),3) + 6, num2str(loc2(n)), 'Color', 'r','Parent',handles.axes2);
            end
        end
        if ~isempty(loc3)
            for n = 1:length(loc3)
        plot(handles.axes3, handles.data1(loc3(n),1),handles.data1(loc3(n),3),'r+','Parent',handles.axes3); %Point is plotted on the GUI
        text(handles.data1(loc3(n),1) - 7, handles.data1(loc3(n),3) + 6, num2str(loc3(n)), 'Color', 'r','Parent',handles.axes3);
            end
        end
    loc = find(handles.data1(:,6)==handles.currentFrametran);
    loc2 = find(handles.data1(:,4)==handles.currentFramecor);
    loc3 = find(handles.data1(:,5)==handles.currentFramesag);
        if ~isempty(loc)
            for n = 1:length(loc)
        plot(handles.axes1, handles.data1(loc(n),4),handles.data1(loc(n),5),'g+','Parent',handles.axes1); %Point is plotted on the GUI
        text (handles.data1(loc(n),4) - 7, handles.data1(loc(n),5) + 6, num2str (loc(n)), 'Color', 'g','Parent',handles.axes1);
            end
        end
        if ~isempty(loc2)
            for n = 1:length(loc2)
        plot(handles.axes2, handles.data1(loc2(n),5),handles.data1(loc2(n),6),'g+','Parent',handles.axes2); %Point is plotted on the GUI
        text (handles.data1(loc2(n),5) - 7, handles.data1(loc2(n),6) + 6, num2str(loc2(n)), 'Color', 'g','Parent',handles.axes2);
            end
        end
        if ~isempty(loc3)
            for n = 1:length(loc3)
        plot(handles.axes3, handles.data1(loc3(n),4),handles.data1(loc3(n),6),'g+','Parent',handles.axes3); %Point is plotted on the GUI
        text(handles.data1(loc3(n),4) - 7, handles.data1(loc3(n),6) + 6, num2str(loc3(n)), 'Color', 'g','Parent',handles.axes3);
            end
        end
         
    end
end

loc1 = get(hObject,'Value');
%transverse view
if ~isempty(handles.data1);
loc2 = find(handles.data1(:,3)==handles.currentFrametran);
if handles.selon 
    
    loc = find(loc2 == loc1);
    for p = 1:length(handles.selected)
        loc = [loc; find(loc2 == handles.selected(p))];
    end
else
loc = find(loc2 == loc1);
end
loc2 = loc2(loc);

if ~isempty(loc2)
    for n = 1:length(loc2)
plot(handles.axes1, handles.data1(loc2(n),1),handles.data1(loc2(n),2),'y+','Parent',handles.axes1); %Point is plotted on the GUI
text (handles.data1(loc2(n),1) - 7, handles.data1(loc2(n),2) + 6, num2str(loc2(n)), 'Color', 'y','Parent',handles.axes1);
    end
end
loc2 = find(handles.currentFrametran == handles.data1(:,6));
if handles.selon 
    loc = find(loc2 == loc1);
    for p = 1:length(handles.selected)
        loc = [loc; find(loc2 == handles.selected(p))];
    end
else
loc = find(loc2 == loc1);
end
loc2 = loc2(loc);

if ~isempty(loc2)
    for n = 1:length(loc2)
plot(handles.axes1, handles.data1(loc2(n),4),handles.data1(loc2(n),5),'y+','Parent',handles.axes1); %Point is plotted on the GUI
text (handles.data1(loc2(n),4) -7, handles.data1(loc2(n),5) + 6, num2str(loc2(n)), 'Color', 'y','Parent',handles.axes1);
    end
end
end

%coronal view
if ~isempty(handles.data1);
loc2 = find(handles.data1(:,1)==handles.currentFramecor);
if handles.selon 
    loc = find(loc2 == loc1);
    for p = 1:length(handles.selected)
        loc = [loc; find(loc2 == handles.selected(p))];
    end
else
loc = find(loc2 == loc1);
end
loc2 = loc2(loc);
if ~isempty(loc2)
    for n = 1:length(loc2)
  plot(handles.axes2, handles.data1(loc2(n),2),handles.data1(loc2(n),3),'y+','Parent',handles.axes2); %Point is plotted on the GUI
  text (handles.data1(loc2(n),2) - 7, handles.data1(loc2(n),3) + 6, num2str(loc2(n)), 'Color', 'y','Parent',handles.axes2);
    end
end
loc2 = find(handles.currentFramecor == handles.data1(:,4));
if handles.selon 
    loc = find(loc2 == loc1);
    for p = 1:length(handles.selected)
        loc = [loc; find(loc2 == handles.selected(p))];
    end
else
loc = find(loc2 == loc1);
end
loc2 = loc2(loc);
if ~isempty(loc2)
    for n = 1:length(loc2)
        plot(handles.axes2, handles.data1(loc2(n),5),handles.data1(loc2(n),6),'y+','Parent',handles.axes2); %Point is plotted on the GUI
        text (handles.data1(loc2(n),5) - 7, handles.data1(loc2(n),6) + 6, num2str(loc2(n)), 'Color', 'y','Parent',handles.axes2);
    end
end
end

%sagital view
if ~isempty(handles.data1);
loc2 = find(handles.data1(:,2)==handles.currentFramesag);
if handles.selon 
   loc = find(loc2 == loc1);
    for p = 1:length(handles.selected)
        loc = [loc; find(loc2 == handles.selected(p))];
    end
else
loc = find(loc2 == loc1);
end
loc2 = loc2(loc);
if ~isempty(loc2)
    for n = 1:length(loc2)
       plot(handles.axes3, handles.data1(loc2(n),1),handles.data1(loc2(n),3),'y+','Parent',handles.axes3); %Point is plotted on the GUI
       text(handles.data1(loc2(n),1) - 7, handles.data1(loc2(n),3) + 6, num2str(loc2(n)), 'Color', 'y','Parent',handles.axes3);
    end
end
loc2 = find(handles.data1(:,5) == handles.currentFramesag );
if handles.selon 
   loc = find(loc2 == loc1);
    for p = 1:length(handles.selected)
        loc = [loc; find(loc2 == handles.selected(p))];
    end
else
loc = find(loc2 == loc1);
end
loc2 = loc2(loc);
if ~isempty(loc2)
    for n = 1:length(loc2)
        plot(handles.axes3, handles.data1(loc2(n),4),handles.data1(loc2(n),6),'y+','Parent',handles.axes3); %Point is plotted on the GUI
        text(handles.data1(loc2(n),4) - 7, handles.data1(loc2(n),6) + 6, num2str(loc2(n)), 'Color', 'y','Parent',handles.axes3);
    end
end
set(handles.axes2,'Nextplot','replacechildren');
set(handles.axes3,'Nextplot','replacechildren');
set(handles.axes1,'Nextplot','replacechildren');
end
guidata(hObject,handles);
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


% --- Executes on button press in measure.

% --------------------------------------------------------------------
function load_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to load_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName,FilterIndex] = uigetfile('*.xls','Load Analysis');
handles.data1 = xlsread([PathName FileName],'Sheet1');
handles.data2 = [];
sz = size(handles.data1);
for n = 1:sz(1)
handles.data2 = [handles.data2;{[num2str(handles.data1(n,13)) ',' num2str(handles.data1(n,14)) ',' num2str(handles.data1(n,15)) ','...
    num2str(handles.data1(n,16)) ',' num2str(handles.data1(n,17)) ',' num2str(handles.data1(n,18))]}];
end
handles.data3 = [handles.data3; [handles.data1(:,3), handles.data1(:,6)]];
set(handles.listbox1,'Value',1);
set(handles.listbox1,'String',handles.data2);
if isequal(handles.sz1,handles.sz2);
image(handles.image1(:,:,handles.currentFramecor)*(1-(handles.fadeval)) + handles.image2(:,:,handles.currentFramecor)*(handles.fadeval), 'CDataMapping','scaled','Parent', handles.axes1);
if ~isempty(handles.data1);
loc = find(handles.data3(:,1)==handles.currentFramecor);
if ~isempty(loc)
    for n = 1:length(loc)
plot(handles.axes1, handles.data1(loc(n),1),handles.data1(loc(n),2),'r+','Parent',handles.axes1); %Point is plotted on the GUI
text (handles.data1(loc(n),1) - 7, handles.data1(loc(n),2) + 6, num2str (loc(n)), 'Color', 'r','Parent',handles.axes1);
    end
end
loc = find(handles.currentFramecor == handles.data3(:,2));
if ~isempty(loc)
    for n = 1:length(loc)
plot(handles.axes1, handles.data1(loc(n),4),handles.data1(loc(n),5),'r+','Parent',handles.axes1); %Point is plotted on the GUI
text (handles.data1(loc(n),4) + 6, handles.data1(loc(n),5) - 4, num2str (loc(n)), 'Color', 'r','Parent',handles.axes1);
    end
end
end
end
guidata(hObject,handles);
% return to this
% --------------------------------------------------------------------
function save_analysis_Callback(hObject, eventdata, handles)%save analysis
% hObject    handle to save_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName,FilterIndex] = uiputfile('*.xls','Save Analysis As');
xlswrite([PathName FileName],{'X1','Y1','Z1','X2','Y2','Z2','X3','Y3','Z3','X4','Y4','Z4','dX','dY','dZ','dXmax','dYmax','dZmax'},'Sheet1');
xlswrite([PathName FileName], handles.data1,'Sheet1','A2' );


% --------------------------------------------------------------------
function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in add_feature_point.
function add_feature_point_Callback(hObject, eventdata, handles)
% hObject    handle to add_feature_point (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

sz = size(handles.data1);
set(handles.axes3, 'NextPlot', 'add');
set(handles.axes2, 'NextPlot', 'add');
for n = 1:2
    [x,y] = ginput(1);
    if handles.axes1 == gca
        handles.currentFrametran = getappdata(0,'tranframe');
        coords{n} = [x,y,handles.currentFrametran];
        hold on
        if n == 1
        plot(handles.axes1, coords{n}(1),coords{n}(2),'r+','Parent',handles.axes1); %Point is plotted on the GUI
        text (coords{n}(1) - 7, coords{n}(2) + 6, num2str(sz(1)+1), 'Color', 'r','Parent',handles.axes1);
        else
           plot(handles.axes1, coords{n}(1),coords{n}(2),'g+','Parent',handles.axes1); %Point is plotted on the GUI
        text (coords{n}(1) - 7, coords{n}(2) + 6, num2str(sz(1)+1), 'Color', 'g','Parent',handles.axes1);
        end
    elseif handles.axes2 == gca
        
        handles.currentFramecor = getappdata(0,'corframe');
        coords{n} = [handles.currentFramecor,x,y];
        if n == 1
        plot(handles.axes2, coords{n}(2),coords{n}(3),'r+','Parent',handles.axes2); %Point is plotted on the GUI
        text (coords{n}(2) - 7, coords{n}(3) + 6, num2str(sz(1)+1), 'Color', 'r','Parent',handles.axes2);
        else
           plot(handles.axes2, coords{n}(2),coords{n}(3),'g+','Parent',handles.axes2); %Point is plotted on the GUI
        text (coords{n}(2) - 7, coords{n}(3) + 6, num2str(sz(1)+1), 'Color', 'g','Parent',handles.axes2);
        end
        
    elseif handles.axes3 == gca
        
        handles.currentFramesag = getappdata(0,'sagframe');
        coords{n} = [x,handles.currentFramesag,y]; 
        if n == 1
           plot(handles.axes3, coords{n}(1),coords{n}(3),'r+','Parent',handles.axes3); %Point is plotted on the GUI
           text (coords{n}(1) - 7, coords{n}(3) + 6, num2str(sz(1)+1), 'Color', 'r','Parent',handles.axes3);
        else
           plot(handles.axes3, coords{n}(1),coords{n}(3),'g+','Parent',handles.axes3); %Point is plotted on the GUI
           text (coords{n}(1) - 7, coords{n}(3) + 6, num2str(sz(1)+1), 'Color', 'g','Parent',handles.axes3);
        end
        
    end
 
end

handles.data1 = [handles.data1;[coords{1},coords{2}]];

sz = size(handles.data1);
% handles.data3 = [handles.data3; [coords{1}(3), coords{2}(3)]];


if  isequal(handles.sz1,handles.sz2)
% imagesc(handles.image1(:,:,handles.currentFrametran)*(1-handles.fadeval_tran)+handles.image2(:,:,handles.currentFrametran)*handles.fadeval_tran,'Parent', handles.axes1);
    if  ~isempty(handles.data1)
    loc = find(handles.data1(:,3)==handles.currentFrametran);
    loc2 = find(handles.data1(:,1)==handles.currentFramecor);
    loc3 = find(handles.data1(:,2)==handles.currentFramesag);

        if ~isempty(loc)
            for n = 1:length(loc)
        plot(handles.axes1, handles.data1(loc(n),1),handles.data1(loc(n),2),'r+','Parent',handles.axes1); %Point is plotted on the GUI
        text (handles.data1(loc(n),1) - 7, handles.data1(loc(n),2) + 6, num2str (loc(n)), 'Color', 'r','Parent',handles.axes1);
            end
        end
        if ~isempty(loc2)
            for n = 1:length(loc2)
        plot(handles.axes2, handles.data1(loc2(n),2),handles.data1(loc2(n),3),'r+','Parent',handles.axes2); %Point is plotted on the GUI
        text (handles.data1(loc2(n),2) - 7, handles.data1(loc2(n),3) + 6, num2str(loc2(n)), 'Color', 'r','Parent',handles.axes2);
            end
        end
        if ~isempty(loc3)
            for n = 1:length(loc3)
        plot(handles.axes3, handles.data1(loc3(n),1),handles.data1(loc3(n),3),'r+','Parent',handles.axes3); %Point is plotted on the GUI
        text(handles.data1(loc3(n),1) - 7, handles.data1(loc3(n),3) + 6, num2str(loc3(n)), 'Color', 'r','Parent',handles.axes3);
            end
        end
    loc = find(handles.data1(:,6)==handles.currentFrametran);
    loc2 = find(handles.data1(:,4)==handles.currentFramecor);
    loc3 = find(handles.data1(:,5)==handles.currentFramesag);
        if ~isempty(loc)
            for n = 1:length(loc)
        plot(handles.axes1, handles.data1(loc(n),4),handles.data1(loc(n),5),'g+','Parent',handles.axes1); %Point is plotted on the GUI
        text (handles.data1(loc(n),4) - 7, handles.data1(loc(n),5) + 6, num2str (loc(n)), 'Color', 'g','Parent',handles.axes1);
            end
        end
        if ~isempty(loc2)
            for n = 1:length(loc2)
        plot(handles.axes2, handles.data1(loc2(n),5),handles.data1(loc2(n),6),'g+','Parent',handles.axes2); %Point is plotted on the GUI
        text (handles.data1(loc2(n),5) - 7, handles.data1(loc2(n),6) + 6, num2str(loc2(n)), 'Color', 'g','Parent',handles.axes2);
            end
        end
        if ~isempty(loc3)
            for n = 1:length(loc3)
        plot(handles.axes3, handles.data1(loc3(n),4),handles.data1(loc3(n),6),'g+','Parent',handles.axes3); %Point is plotted on the GUI
        text(handles.data1(loc3(n),4) - 7, handles.data1(loc3(n),6) + 6, num2str(loc3(n)), 'Color', 'g','Parent',handles.axes3);
            end
        end
    end
end
list = [];
for t = 1:sz(1)
list = [list;{t}];
end
set(handles.axes2, 'NextPlot', 'replacechildren');
set(handles.axes3, 'NextPlot', 'replacechildren');
set(handles.listbox1,'String',list);
guidata(hObject, handles);

% --- Executes on button press in remove_feature_point.
function remove_feature_point_Callback(hObject, eventdata, handles)
% hObject    handle to remove_feature_point (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
point = get(handles.listbox1,'Value');
handles.data1(point,:) = [];
guidata(hObject, handles);
if point ~= 1
set(handles.listbox1,'Value',point-1);
end
if  isequal(handles.sz1,handles.sz2)
set(handles.axes2, 'NextPlot', 'add');
set(handles.axes3, 'NextPlot', 'add');
set(handles.axes1, 'NextPlot', 'add');
imagesc(handles.image1(:,:,handles.currentFrametran)*(1-handles.fadeval_tran)+handles.image2(:,:,handles.currentFrametran)*handles.fadeval_tran,'Parent', handles.axes1);
image(reshape(handles.image1(handles.currentFramesag,:,:),handles.sz1(2),handles.sz1(3))'*(1-handles.fadeval_sag)+reshape(handles.image2(handles.currentFramesag,:,:),handles.sz1(2),handles.sz1(3))'*handles.fadeval_sag, 'CDataMapping','scaled','Parent', handles.axes3);
image(reshape(handles.image1(:,handles.currentFramecor,:),handles.sz1(1),handles.sz1(3))'*(1-handles.fadeval_cor)+reshape(handles.image2(:,handles.currentFramecor,:),handles.sz1(1),handles.sz1(3))'*handles.fadeval_cor, 'CDataMapping','scaled','Parent', handles.axes2);

    if  ~isempty(handles.data1)
    loc = find(handles.data1(:,3)==handles.currentFrametran);
    loc2 = find(handles.data1(:,1)==handles.currentFramecor);
    loc3 = find(handles.data1(:,2)==handles.currentFramesag);

        if ~isempty(loc)
            for n = 1:length(loc)
        plot(handles.axes1, handles.data1(loc(n),1),handles.data1(loc(n),2),'r+','Parent',handles.axes1); %Point is plotted on the GUI
        text (handles.data1(loc(n),1) - 7, handles.data1(loc(n),2) + 6, num2str (loc(n)), 'Color', 'r','Parent',handles.axes1);
            end
        end
        if ~isempty(loc2)
            for n = 1:length(loc2)
        plot(handles.axes2, handles.data1(loc2(n),2),handles.data1(loc2(n),3),'r+','Parent',handles.axes2); %Point is plotted on the GUI
        text (handles.data1(loc2(n),2) - 7, handles.data1(loc2(n),3) + 6, num2str(loc2(n)), 'Color', 'r','Parent',handles.axes2);
            end
        end
        if ~isempty(loc3)
            for n = 1:length(loc3)
        plot(handles.axes3, handles.data1(loc3(n),1),handles.data1(loc3(n),3),'r+','Parent',handles.axes3); %Point is plotted on the GUI
        text(handles.data1(loc3(n),1) - 7, handles.data1(loc3(n),3) + 6, num2str(loc3(n)), 'Color', 'r','Parent',handles.axes3);
            end
        end
    loc = find(handles.data1(:,6)==handles.currentFrametran);
    loc2 = find(handles.data1(:,4)==handles.currentFramecor);
    loc3 = find(handles.data1(:,5)==handles.currentFramesag);
        if ~isempty(loc)
            for n = 1:length(loc)
        plot(handles.axes1, handles.data1(loc(n),4),handles.data1(loc(n),5),'g+','Parent',handles.axes1); %Point is plotted on the GUI
        text (handles.data1(loc(n),4) - 7, handles.data1(loc(n),5) + 6, num2str (loc(n)), 'Color', 'g','Parent',handles.axes1);
            end
        end
        if ~isempty(loc2)
            for n = 1:length(loc2)
        plot(handles.axes2, handles.data1(loc2(n),5),handles.data1(loc2(n),6),'g+','Parent',handles.axes2); %Point is plotted on the GUI
        text (handles.data1(loc2(n),5) - 7, handles.data1(loc2(n),6) + 6, num2str(loc2(n)), 'Color', 'g','Parent',handles.axes2);
            end
        end
        if ~isempty(loc3)
            for n = 1:length(loc3)
        plot(handles.axes3, handles.data1(loc3(n),4),handles.data1(loc3(n),6),'g+','Parent',handles.axes3); %Point is plotted on the GUI
        text(handles.data1(loc3(n),4) - 7, handles.data1(loc3(n),6) + 6, num2str(loc3(n)), 'Color', 'g','Parent',handles.axes3);
            end
        end
    end
end
sz  = size(handles.data1);
list = [];
for t = 1:sz(1)
list = [list;{t}];
end
set(handles.axes2, 'NextPlot', 'replacechildren');
set(handles.axes3, 'NextPlot', 'replacechildren');
set(handles.axes1, 'NextPlot', 'replacechildren');
set(handles.listbox1,'String',list);
guidata(hObject, handles);


% --- Executes on button press in move_feature_point.
function move_feature_point_Callback(hObject, eventdata, handles)
% hObject    handle to move_feature_point (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 [x,y] = ginput(1);
    if handles.axes1 == gca
        handles.currentFrametran = getappdata(0,'tranframe');
        coords = [x,y,handles.currentFrametran];     
    elseif handles.axes2 == gca
        handles.currentFramecor = getappdata(0,'corframe');
        coords = [handles.currentFramecor,x,y];
    elseif handles.axes3 == gca
        handles.currentFramesag = getappdata(0,'sagframe');
        coords = [x,handles.currentFramesag,y]; 
    end
 
   handles.data1(get(handles.listbox1,'Value'),1:3) = coords;
if  isequal(handles.sz1,handles.sz2)
    set(handles.axes1,'Nextplot','add');
    set(handles.axes2,'Nextplot','add');
    set(handles.axes2,'Nextplot','add');
    image(handles.image1(:,:,handles.currentFrametran)*(1-handles.fadeval_tran)+handles.image2(:,:,handles.currentFrametran)*handles.fadeval_tran, 'CDataMapping','scaled','Parent', handles.axes1);
    image(reshape(handles.image1(:,handles.currentFramecor,:),handles.sz1(1),handles.sz1(3))'*(1-handles.fadeval_cor)+reshape(handles.image2(:,handles.currentFramecor,:),handles.sz1(1),handles.sz1(3))'*handles.fadeval_cor, 'CDataMapping','scaled','Parent', handles.axes2);    
    image(reshape(handles.image1(handles.currentFramesag,:,:),handles.sz1(2),handles.sz1(3))'*(1-handles.fadeval_sag)+reshape(handles.image2(handles.currentFramesag,:,:),handles.sz1(2),handles.sz1(3))'*handles.fadeval_sag, 'CDataMapping','scaled','Parent', handles.axes3);
    if  ~isempty(handles.data1)
    loc = find(handles.data1(:,3)==handles.currentFrametran);
    loc2 = find(handles.data1(:,1)==handles.currentFramecor);
    loc3 = find(handles.data1(:,2)==handles.currentFramesag);

        if ~isempty(loc)
            for n = 1:length(loc)
        plot(handles.axes1, handles.data1(loc(n),1),handles.data1(loc(n),2),'r+','Parent',handles.axes1); %Point is plotted on the GUI
        text (handles.data1(loc(n),1) - 7, handles.data1(loc(n),2) + 6, num2str (loc(n)), 'Color', 'r','Parent',handles.axes1);
            end
        end
        if ~isempty(loc2)
            for n = 1:length(loc2)
        plot(handles.axes2, handles.data1(loc2(n),2),handles.data1(loc2(n),3),'r+','Parent',handles.axes2); %Point is plotted on the GUI
        text (handles.data1(loc2(n),2) - 7, handles.data1(loc2(n),3) + 6, num2str(loc2(n)), 'Color', 'r','Parent',handles.axes2);
            end
        end
        if ~isempty(loc3)
            for n = 1:length(loc3)
        plot(handles.axes3, handles.data1(loc3(n),1),handles.data1(loc3(n),3),'r+','Parent',handles.axes3); %Point is plotted on the GUI
        text(handles.data1(loc3(n),1) - 7, handles.data1(loc3(n),3) + 6, num2str(loc3(n)), 'Color', 'r','Parent',handles.axes3);
            end
        end
    loc = find(handles.data1(:,6)==handles.currentFrametran);
    loc2 = find(handles.data1(:,4)==handles.currentFramecor);
    loc3 = find(handles.data1(:,5)==handles.currentFramesag);
        if ~isempty(loc)
            for n = 1:length(loc)
        plot(handles.axes1, handles.data1(loc(n),4),handles.data1(loc(n),5),'g+','Parent',handles.axes1); %Point is plotted on the GUI
        text (handles.data1(loc(n),4) - 7, handles.data1(loc(n),5) + 6, num2str (loc(n)), 'Color', 'g','Parent',handles.axes1);
            end
        end
        if ~isempty(loc2)
            for n = 1:length(loc2)
        plot(handles.axes2, handles.data1(loc2(n),5),handles.data1(loc2(n),6),'g+','Parent',handles.axes2); %Point is plotted on the GUI
        text (handles.data1(loc2(n),5) - 7, handles.data1(loc2(n),6) + 6, num2str(loc2(n)), 'Color', 'g','Parent',handles.axes2);
            end
        end
        if ~isempty(loc3)
            for n = 1:length(loc3)
        plot(handles.axes3, handles.data1(loc3(n),4),handles.data1(loc3(n),6),'g+','Parent',handles.axes3); %Point is plotted on the GUI
        text(handles.data1(loc3(n),4) - 7, handles.data1(loc3(n),6) + 6, num2str(loc3(n)), 'Color', 'g','Parent',handles.axes3);
            end
        end
    set(handles.axes1,'Nextplot','replacechildren');
    set(handles.axes2,'Nextplot','replacechildren');
    set(handles.axes2,'Nextplot','replacechildren');
    end
end
guidata(hObject, handles);
% --- Executes on button press in fill_points.
function fill_points_Callback(hObject, eventdata, handles)
% hObject    handle to fill_points (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x1 = handles.data1(handles.selected,1);
y1 = handles.data1(handles.selected,2);
z1 = handles.data1(handles.selected,3);
x2 = handles.data1(handles.selected,4);
y2 = handles.data1(handles.selected,5);
z2 = handles.data1(handles.selected,6);
% x1i = interp1(1:length(x1),x1,1:0.25:length(x1));
% y1i = interp1(x1,y1,x1i,'cubic');
% z1i = interp1(x1,z1,x1i,'cubic');
x1i = interp1(1:length(x1),x1,1:0.25:length(x1),'cubic');
y1i = interp1(1:length(y1),y1,1:0.25:length(y1),'cubic');
z1i = interp1(1:length(z1),z1,1:0.25:length(z1),'cubic');
x2i = interp1(1:length(x2),x2,1:0.25:length(x2),'cubic');
y2i = interp1(1:length(y2),y2,1:0.25:length(y2),'cubic');
z2i = interp1(1:length(z2),z2,1:0.25:length(z2),'cubic');
% x2i = interp1(1:length(x2),x2,1:0.25:length(x2));
% y2i = interp1(x2,y2,x2i,'cubic');
% z2i = interp1(x2,z2,x2i,'cubic');
handles.data1(handles.selected,:) = [];
handles.data1 = [handles.data1;[x1i',y1i',z1i',x2i',y2i',z2i']];

sz = size(handles.data1);

if  isequal(handles.sz1,handles.sz2)
imagesc(handles.image1(:,:,handles.currentFrametran)*(1-handles.fadeval_tran)+handles.image2(:,:,handles.currentFrametran)*handles.fadeval_tran,'Parent', handles.axes1);
image(reshape(handles.image1(handles.currentFramesag,:,:),handles.sz1(2),handles.sz1(3))'*(1-handles.fadeval_sag)+reshape(handles.image2(handles.currentFramesag,:,:),handles.sz1(2),handles.sz1(3))'*handles.fadeval_sag, 'CDataMapping','scaled','Parent', handles.axes3);
image(reshape(handles.image1(:,handles.currentFramecor,:),handles.sz1(1),handles.sz1(3))'*(1-handles.fadeval_cor)+reshape(handles.image2(:,handles.currentFramecor,:),handles.sz1(1),handles.sz1(3))'*handles.fadeval_cor, 'CDataMapping','scaled','Parent', handles.axes2);
set(handles.axes3, 'NextPlot', 'add');
set(handles.axes2, 'NextPlot', 'add');
set(handles.axes1, 'NextPlot', 'add');
if  ~isempty(handles.data1)
    loc = find(handles.data1(:,3)==handles.currentFrametran);
    loc2 = find(handles.data1(:,1)==handles.currentFramecor);
    loc3 = find(handles.data1(:,2)==handles.currentFramesag);

        if ~isempty(loc)
            for n = 1:length(loc)
        plot(handles.axes1, handles.data1(loc(n),1),handles.data1(loc(n),2),'r+','Parent',handles.axes1); %Point is plotted on the GUI
        text (handles.data1(loc(n),1) - 7, handles.data1(loc(n),2) + 6, num2str (loc(n)), 'Color', 'r','Parent',handles.axes1);
            end
        end
        if ~isempty(loc2)
            for n = 1:length(loc2)
        plot(handles.axes2, handles.data1(loc2(n),2),handles.data1(loc2(n),3),'r+','Parent',handles.axes2); %Point is plotted on the GUI
        text (handles.data1(loc2(n),2) - 7, handles.data1(loc2(n),3) + 6, num2str(loc2(n)), 'Color', 'r','Parent',handles.axes2);
            end
        end
        if ~isempty(loc3)
            for n = 1:length(loc3)
        plot(handles.axes3, handles.data1(loc3(n),1),handles.data1(loc3(n),3),'r+','Parent',handles.axes3); %Point is plotted on the GUI
        text(handles.data1(loc3(n),1) - 7, handles.data1(loc3(n),3) + 6, num2str(loc3(n)), 'Color', 'r','Parent',handles.axes3);
            end
        end
    loc = find(handles.data1(:,6)==handles.currentFrametran);
    loc2 = find(handles.data1(:,4)==handles.currentFramecor);
    loc3 = find(handles.data1(:,5)==handles.currentFramesag);
        if ~isempty(loc)
            for n = 1:length(loc)
        plot(handles.axes1, handles.data1(loc(n),4),handles.data1(loc(n),5),'g+','Parent',handles.axes1); %Point is plotted on the GUI
        text (handles.data1(loc(n),4) - 7, handles.data1(loc(n),5) + 6, num2str (loc(n)), 'Color', 'g','Parent',handles.axes1);
            end
        end
        if ~isempty(loc2)
            for n = 1:length(loc2)
        plot(handles.axes2, handles.data1(loc2(n),5),handles.data1(loc2(n),6),'g+','Parent',handles.axes2); %Point is plotted on the GUI
        text (handles.data1(loc2(n),5) - 7, handles.data1(loc2(n),6) + 6, num2str(loc2(n)), 'Color', 'g','Parent',handles.axes2);
            end
        end
        if ~isempty(loc3)
            for n = 1:length(loc3)
        plot(handles.axes3, handles.data1(loc3(n),4),handles.data1(loc3(n),6),'g+','Parent',handles.axes3); %Point is plotted on the GUI
        text(handles.data1(loc3(n),4) - 7, handles.data1(loc3(n),6) + 6, num2str(loc3(n)), 'Color', 'g','Parent',handles.axes3);
            end
        end
    end
end
list = [];
for t = 1:sz(1)
list = [list;{t}];
end
set(handles.axes2, 'NextPlot', 'replacechildren');
set(handles.axes3, 'NextPlot', 'replacechildren');
% set(handles.axes1, 'NextPlot', 'replacechildren');
set(handles.listbox1,'String',list);
handles.selon = 0;
handles.selected = [];
guidata(hObject, handles);

% --- Executes on button press in select_feature_points.
function select_feature_points_Callback(hObject, eventdata, handles)
% hObject    handle to select_feature_points (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on slider movement.
function slider_cor_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
if isequal(handles.sz1,handles.sz2);
handles.currentFramecor = round(get(hObject,'Value'));
 image(reshape(handles.image1(:,handles.currentFramecor,:),handles.sz1(1),handles.sz1(3))'*(1-handles.fadeval_cor)+reshape(handles.image2(:,handles.currentFramecor,:),handles.sz1(1),handles.sz1(3))'*handles.fadeval_cor, 'CDataMapping','scaled','Parent', handles.axes2);
    if  ~isempty(handles.data1)
    loc2 = find(round(handles.data1(:,1))==handles.currentFramecor);
    set(handles.axes2, 'NextPlot', 'add');
        if ~isempty(loc2)
            for n = 1:length(loc2)
                plot(handles.axes2, handles.data1(loc2(n),2),handles.data1(loc2(n),3),'r+','Parent',handles.axes2); %Point is plotted on the GUI
                text (handles.data1(loc2(n),2) - 7, handles.data1(loc2(n),3) + 6, num2str(loc2(n)), 'Color', 'r','Parent',handles.axes2);
            end
        end
        
       
        if ~isempty(handles.selected)
            loc = find(loc2 == handles.selected);
            loc2 = loc2(loc);
        else
            loc2 = [];
        end
         if ~isempty(loc2)
            for n = 1:length(loc2)
          plot(handles.data1(loc2(n),2),handles.data1(loc2(n),3),'y+','Parent',handles.axes2); %Point is plotted on the GUI
          text (handles.data1(loc2(n),2) - 7, handles.data1(loc2(n),3) + 6, num2str(loc2(n)), 'Color', 'y','Parent',handles.axes2);
            end
        end
        loc2 = find(round(handles.data1(:,4))==handles.currentFramecor);
        if ~isempty(loc2)
            for n = 1:length(loc2)
        plot(handles.data1(loc2(n),5),handles.data1(loc2(n),6),'g+','Parent',handles.axes2); %Point is plotted on the GUI
        text (handles.data1(loc2(n),5) - 7, handles.data1(loc2(n),6) + 6, num2str(loc2(n)), 'Color', 'g','Parent',handles.axes2);
            end
        end
         if ~isempty(handles.selected)
            loc = find(loc2 == handles.selected);
            loc2 = loc2(loc);
        else
            loc2 = [];
        end

          if ~isempty(loc2)
            for n = 1:length(loc2)
          plot(handles.data1(loc2(n),2),handles.data1(loc2(n),3),'y+','Parent',handles.axes2); %Point is plotted on the GUI
          text (handles.data1(loc2(n),5) - 7, handles.data1(loc2(n),6) + 6, num2str(loc2(n)), 'Color', 'y','Parent',handles.axes2);
            end
          end
        set(handles.axes2, 'NextPlot', 'replacechildren');
    end
end
setappdata(0,'corframe',handles.currentFramecor);
set(handles.cor_info,'String',[num2str(handles.currentFramecor) ' of ' num2str(handles.sz1(2))]);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider_cor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function fadeslide_cor_Callback(hObject, eventdata, handles)
% hObject    handle to fadeslide_cor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
if isequal(handles.sz1,handles.sz2);
handles.fadeval_cor = round(get(hObject,'Value'))/get(hObject,'Max');
    image(reshape(handles.image1(:,handles.currentFramecor,:),handles.sz1(1),handles.sz1(3))'*(1-handles.fadeval_cor)+reshape(handles.image2(:,handles.currentFramecor,:),handles.sz1(1),handles.sz1(3))'*handles.fadeval_cor, 'CDataMapping','scaled','Parent', handles.axes2);

    if  ~isempty(handles.data1)
    loc2 = find(round(handles.data1(:,1))==handles.currentFramecor);
    set(handles.axes2, 'NextPlot', 'add');
        if ~isempty(loc2)
            for n = 1:length(loc2)
                plot(handles.axes2, handles.data1(loc2(n),2),handles.data1(loc2(n),3),'r+','Parent',handles.axes2); %Point is plotted on the GUI
                text (handles.data1(loc2(n),2) - 7, handles.data1(loc2(n),3) + 6, num2str(loc2(n)), 'Color', 'r','Parent',handles.axes2);
            end
        end
        
       
        if ~isempty(handles.selected)
            loc = find(loc2 == handles.selected);
            loc2 = loc2(loc);
        else
            loc2 = [];
        end
         if ~isempty(loc2)
            for n = 1:length(loc2)
          plot(handles.data1(loc2(n),2),handles.data1(loc2(n),3),'y+','Parent',handles.axes2); %Point is plotted on the GUI
          text (handles.data1(loc2(n),2) - 7, handles.data1(loc2(n),3) + 6, num2str(loc2(n)), 'Color', 'y','Parent',handles.axes2);
            end
        end
        loc2 = find(round(handles.data1(:,4))==handles.currentFramecor);
        if ~isempty(loc2)
            for n = 1:length(loc2)
        plot(handles.data1(loc2(n),5),handles.data1(loc2(n),6),'g+','Parent',handles.axes2); %Point is plotted on the GUI
        text (handles.data1(loc2(n),5) - 7, handles.data1(loc2(n),6) + 6, num2str(loc2(n)), 'Color', 'g','Parent',handles.axes2);
            end
        end
         if ~isempty(handles.selected)
            loc = find(loc2 == handles.selected);
            loc2 = loc2(loc);
        else
            loc2 = [];
        end

          if ~isempty(loc2)
            for n = 1:length(loc2)
          plot(handles.data1(loc2(n),2),handles.data1(loc2(n),3),'y+','Parent',handles.axes2); %Point is plotted on the GUI
          text (handles.data1(loc2(n),5) - 7, handles.data1(loc2(n),6) + 6, num2str(loc2(n)), 'Color', 'y','Parent',handles.axes2);
            end
          end
        set(handles.axes2, 'NextPlot', 'replacechildren');
    end
end

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function fadeslide_cor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fadeslide_cor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_sag_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
if  isequal(handles.sz1,handles.sz2)
    handles.currentFramesag = round(get(hObject,'Value'));
    image(reshape(handles.image1(handles.currentFramesag,:,:),handles.sz1(2),handles.sz1(3))'*(1-handles.fadeval_sag)+reshape(handles.image2(handles.currentFramesag,:,:),handles.sz1(2),handles.sz1(3))'*handles.fadeval_sag, 'CDataMapping','scaled','Parent', handles.axes3);
    if  ~isempty(handles.data1)
    loc3 = find(round(handles.data1(:,2))==handles.currentFramesag);
    set(handles.axes3, 'NextPlot', 'add');

        if ~isempty(loc3)
            for n = 1:length(loc3)
        plot(handles.axes3, handles.data1(loc3(n),1),handles.data1(loc3(n),3),'r+','Parent',handles.axes3); %Point is plotted on the GUI
        text(handles.data1(loc3(n),1) - 7, handles.data1(loc3(n),3) + 6, num2str(loc3(n)), 'Color', 'r','Parent',handles.axes3);
            end
        end
        
         if ~isempty(handles.selected)
            loc2 = find(loc3 == handles.selected);
            loc2 = loc3(loc2);
        else
            loc2 = [];
        end


        if ~isempty(loc2)
            for n = 1:length(loc2)
               plot(handles.axes3, handles.data1(loc2(n),1),handles.data1(loc2(n),3),'y+','Parent',handles.axes3); %Point is plotted on the GUI
               text(handles.data1(loc2(n),1) - 7, handles.data1(loc2(n),3) + 6, num2str(loc2(n)), 'Color', 'y','Parent',handles.axes3);
            end
        end

        loc3 = find(round(handles.data1(:,5))==handles.currentFramesag);

        if ~isempty(loc3)
            for n = 1:length(loc3)
        plot(handles.axes3, handles.data1(loc3(n),4),handles.data1(loc3(n),6),'g+','Parent',handles.axes3); %Point is plotted on the GUI
        text(handles.data1(loc3(n),4) - 7, handles.data1(loc3(n),6) + 6, num2str(loc3(n)), 'Color', 'g','Parent',handles.axes3);
            end
        end
        
         if ~isempty(handles.selected)
            loc2 = find(loc3 == handles.selected);
            loc2 = loc3(loc2);
        else
            loc2 = [];
        end
        
        if ~isempty(loc2)
            for n = 1:length(loc2)
               plot(handles.axes3, handles.data1(loc2(n),4),handles.data1(loc2(n),6),'y+','Parent',handles.axes3); %Point is plotted on the GUI
               text(handles.data1(loc2(n),4) - 7, handles.data1(loc2(n),6) + 6, num2str(loc2(n)), 'Color', 'y','Parent',handles.axes3);
            end
        end
        set(handles.axes3, 'NextPlot', 'replacechildren');
    end
end
setappdata(0,'sagframe',handles.currentFramesag);
set(handles.sag_info,'String',[num2str(handles.currentFramesag) ' of ' num2str(handles.sz1(1))]);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider_sag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function fadeslide_sag_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

if  isequal(handles.sz1,handles.sz2)
    handles.fadeval_sag = round(get(hObject,'Value'))/get(hObject,'Max');
   image(reshape(handles.image1(handles.currentFramesag,:,:),handles.sz1(2),handles.sz1(3))'*(1-handles.fadeval_sag)+reshape(handles.image2(handles.currentFramesag,:,:),handles.sz1(2),handles.sz1(3))'*handles.fadeval_sag, 'CDataMapping','scaled','Parent', handles.axes3);
    if  ~isempty(handles.data1)
    set(handles.axes3, 'NextPlot', 'add');
    loc3 = find(round(handles.data1(:,2))==handles.currentFramesag);


        if ~isempty(loc3)
            for n = 1:length(loc3)
        plot(handles.axes3, handles.data1(loc3(n),1),handles.data1(loc3(n),3),'r+','Parent',handles.axes3); %Point is plotted on the GUI
        text(handles.data1(loc3(n),1) - 7, handles.data1(loc3(n),3) + 6, num2str(loc3(n)), 'Color', 'r','Parent',handles.axes3);
            end
        end
        
        
        if ~isempty(handles.selected)
            loc2 = find(loc3 == handles.selected);
            loc2 = loc3(loc2);
        else
            loc2 = [];
        end

        if ~isempty(loc2)
            for n = 1:length(loc2)
               plot(handles.axes3, handles.data1(loc2(n),1),handles.data1(loc2(n),3),'y+','Parent',handles.axes3); %Point is plotted on the GUI
               text(handles.data1(loc2(n),1) - 7, handles.data1(loc2(n),3) + 6, num2str(loc2(n)), 'Color', 'y','Parent',handles.axes3);
            end
        end

    loc3 = find(round(handles.data1(:,5))==handles.currentFramesag);

        if ~isempty(loc3)
            for n = 1:length(loc3)
        plot(handles.axes3, handles.data1(loc3(n),4),handles.data1(loc3(n),6),'g+','Parent',handles.axes3); %Point is plotted on the GUI
        text(handles.data1(loc3(n),4) - 7, handles.data1(loc3(n),6) + 6, num2str(loc3(n)), 'Color', 'g','Parent',handles.axes3);
            end
        end
        
        if ~isempty(handles.selected)
            loc2 = find(loc3 == handles.selected);
            loc2 = loc3(loc2);
        else
            loc2 = [];
        end


        if ~isempty(loc2)
            for n = 1:length(loc2)
               plot(handles.axes3, handles.data1(loc2(n),4),handles.data1(loc2(n),6),'y+','Parent',handles.axes3); %Point is plotted on the GUI
               text(handles.data1(loc2(n),4) - 7, handles.data1(loc2(n),6) + 6, num2str(loc2(n)), 'Color', 'y','Parent',handles.axes3);
            end
        end
        set(handles.axes3, 'NextPlot', 'replacechildren');
    end
end

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function fadeslide_sag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in save_points.
function save_points_Callback(hObject, eventdata, handles)
% hObject    handle to save_points (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n1 = get(handles.image1_popup,'Value') -1;
n2 = get(handles.image2_popup,'Value') -1;
FPcoords = [handles.data1(:,2),handles.data1(:,1),handles.data1(:,3)];
save([handles.parentdir '\' handles.Imgfiles{n1}],'FPcoords','-append');
FPcoords = [handles.data1(:,5),handles.data1(:,4),handles.data1(:,6)];
save([handles.parentdir '\' handles.Imgfiles{n2}],'FPcoords','-append'); 

% --- Executes on selection change in image1_popup.
function image1_popup_Callback(hObject, eventdata, handles)
% hObject    handle to image1_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns image1_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from image1_popup

imgData = [];
handles.img = [];
handles.imgData = [];
contours = [];

try
load([handles.parentdir '\' handles.Imgfiles{get(handles.image1_popup,'Value')-1}],'image1','imgData','lim','-mat');
catch
    warning('Invalid Image data file');
end
try
load([handles.parentdir '\' handles.Imgfiles{get(handles.image1_popup,'Value')-1}],'contours','-mat');
handles.contour1 = contours;
catch
end
handles.contour1 = contours;
load([handles.parentdir '\' handles.Imgfiles{get(handles.image1_popup,'Value')-1}],'FPcoords','-mat');
if isempty(FPcoords)
    handles.FPcoords1 = [];
else
handles.FPcoords1 = [FPcoords(:,2),FPcoords(:,1),FPcoords(:,3)];
end


image1(image1 == -2000) = 0;
handles.imgData = imgData;
clear imgData;
sz = size(image1);
handles.lim = lim;
    handles.image1 = image1;
    %find out # of frames
    handles.sz1 = sz;
    handles.currentFrametran = round(handles.sz1(3)/2);
    handles.currentFramecor = round(handles.sz1(1)/2);
    handles.currentFramesag = round(handles.sz1(2)/2);
if isequal(handles.sz1,handles.sz2);
    
    sz1 = size(handles.FPcoords1);
    sz2 = size(handles.FPcoords2);
    if isequal(sz1,[0,0]) && isequal(sz2,[0,0])
        handles.data1 = [];
    elseif isequal(sz1,[0,0])
        handles.data1 = [handles.FPcoords2(:,1:2)-10,handles.FPcoords2(:,3),handles.FPcoords2];
    elseif isequal(sz2,[0,0])
        handles.data1 = [handles.FPcoords1(:,1:2)+10,handles.FPcoords1(:,3),handles.FPcoords1];
    else
        if sz1(1) > sz2(1) 
            handles.data1 = [handles.FPcoords1(1:sz2(1),:),handles.FPcoords2];
            handles.data1 = [handles.data1;[handles.FPcoords1(sz2(1)+1:end,:),handles.FPcoords1(sz2(1)+1:end,1:2)+10,handles.FPcoords1(sz2(1)+1:end,3)]];
        elseif sz2(1) > sz1(1) 
            handles.data1 = [handles.FPcoords1,handles.FPcoords2(1:sz1(1),:)];
            handles.data1 = [handles.data1;[handles.FPcoords2(sz1(1)+1:end,1:2)-10,handles.FPcoords2(sz1(1)+1:end,3),handles.FPcoords2(sz1(1)+1:end,:)]];
        else
            handles.data1 = [handles.FPcoords1,handles.FPcoords2];
        end
    end
    %shows the first frame.
    set(handles.axes1, 'NextPlot','Replace');
    image(handles.image1(:,:,handles.currentFrametran)*(1-handles.fadeval_tran)+handles.image2(:,:,handles.currentFrametran)*handles.fadeval_tran, 'CDataMapping','scaled','Parent', handles.axes1);
%     axis image;
    set (handles.axes1, 'NextPlot', 'replacechildren');
    colormap bone;
    set(handles.tran_info, 'String', strcat(num2str (handles.currentFrametran), ' of ', num2str(handles.sz1(3))));
    set(handles.axes2, 'NextPlot','Replace');
    image(reshape(handles.image1(:,handles.currentFramecor,:),handles.sz1(1),handles.sz1(3))'*(1-handles.fadeval_cor)+reshape(handles.image2(:,handles.currentFramecor,:),handles.sz1(1),handles.sz1(3))'*handles.fadeval_cor, 'CDataMapping','scaled','Parent', handles.axes2);
%     axis image;
    set (handles.axes2, 'NextPlot', 'replacechildren');
    colormap bone;
       set(handles.cor_info, 'String', strcat(num2str (handles.currentFramecor), ' of ', num2str(handles.sz1(1))));
    set(handles.axes3, 'NextPlot','Replace');
image(reshape(handles.image1(handles.currentFramesag,:,:),handles.sz1(2),handles.sz1(3))'*(1-handles.fadeval_sag)+reshape(handles.image2(handles.currentFramesag,:,:),handles.sz1(2),handles.sz1(3))'*handles.fadeval_sag, 'CDataMapping','scaled','Parent', handles.axes3);
%     axis image;
    set (handles.axes3, 'NextPlot', 'replacechildren');
    colormap bone;
    set(handles.sag_info, 'String', strcat(num2str (handles.currentFramesag), ' of ', num2str(handles.sz1(2))));
    %displays image information
    try
    set(handles.date_acquired, 'String', Imgdata(1).Date);
    catch
    end

    %Sets up sliders
    set (handles.slider_cor, 'Enable', 'on');
    set(handles.slider_cor, 'Min', 1);
    set(handles.slider_cor, 'Max', handles.sz1(2));
    set (handles.slider_cor, 'Value', handles.currentFramecor);
    set (handles.slider_cor, 'SliderStep', [1/handles.sz1(2), 0.25]);
    
    set (handles.slider_sag, 'Enable', 'on');
    set(handles.slider_sag, 'Min', 1);
    set(handles.slider_sag, 'Max', handles.sz1(1));
    set (handles.slider_sag, 'Value', handles.currentFramesag);
    set (handles.slider_sag, 'SliderStep', [1/handles.sz1(1), 0.25]);
    
    set (handles.slider_tran, 'Enable', 'on');
    set(handles.slider_tran, 'Min', 1);
    set(handles.slider_tran, 'Max', handles.sz1(3));
    set (handles.slider_tran, 'Value', handles.currentFrametran);
    set (handles.slider_tran, 'SliderStep', [1/handles.sz1(3), 0.25]);
    
handles.currentFrametran = get(handles.slider_tran,'Value');
handles.currentFramecor = get(handles.slider_cor,'Value');
handles.currentFramesag = get(handles.slider_sag,'Value');
setappdata(0,'tranframe',handles.currentFrametran);
setappdata(0,'corframe',handles.currentFramecor);
setappdata(0,'sagframe',handles.currentFramesag);
end

    clear image1
if  isequal(handles.sz1,handles.sz2)
set(handles.axes2, 'NextPlot', 'add');
set(handles.axes3, 'NextPlot', 'add');
set(handles.axes1, 'NextPlot', 'add');
imagesc(handles.image1(:,:,handles.currentFrametran)*(1-handles.fadeval_tran)+handles.image2(:,:,handles.currentFrametran)*handles.fadeval_tran,'Parent', handles.axes1);
image(reshape(handles.image1(handles.currentFramesag,:,:),handles.sz1(2),handles.sz1(3))'*(1-handles.fadeval_sag)+reshape(handles.image2(handles.currentFramesag,:,:),handles.sz1(2),handles.sz1(3))'*handles.fadeval_sag, 'CDataMapping','scaled','Parent', handles.axes3);
image(reshape(handles.image1(:,handles.currentFramecor,:),handles.sz1(1),handles.sz1(3))'*(1-handles.fadeval_cor)+reshape(handles.image2(:,handles.currentFramecor,:),handles.sz1(1),handles.sz1(3))'*handles.fadeval_cor, 'CDataMapping','scaled','Parent', handles.axes2);
if ~isempty(handles.contour1)
if ~isempty(handles.contour1{handles.currentFrametran}) 
    for m = 1:length(handles.contour1{handles.currentFrametran})
patch(handles.contour1{handles.currentFrametran}{m}(:,1)-handles.lim(3)+1,handles.contour1{handles.currentFrametran}{m}(:,2)-handles.lim(1)+1,'r','EdgeColor','r','FaceColor','none','Parent',handles.axes1);
    end
end
end
    if  ~isempty(handles.data1)
    loc = find(handles.data1(:,3)==handles.currentFrametran);
    loc2 = find(handles.data1(:,1)==handles.currentFramecor);
    loc3 = find(handles.data1(:,2)==handles.currentFramesag);

        if ~isempty(loc)
            for n = 1:length(loc)
        plot(handles.axes1, handles.data1(loc(n),1),handles.data1(loc(n),2),'r+','Parent',handles.axes1); %Point is plotted on the GUI
        text (handles.data1(loc(n),1) - 7, handles.data1(loc(n),2) + 6, num2str (loc(n)), 'Color', 'r','Parent',handles.axes1);
            end
        end
        if ~isempty(loc2)
            for n = 1:length(loc2)
        plot(handles.axes2, handles.data1(loc2(n),2),handles.data1(loc2(n),3),'r+','Parent',handles.axes2); %Point is plotted on the GUI
        text (handles.data1(loc2(n),2) - 7, handles.data1(loc2(n),3) + 6, num2str(loc2(n)), 'Color', 'r','Parent',handles.axes2);
            end
        end
        if ~isempty(loc3)
            for n = 1:length(loc3)
        plot(handles.axes3, handles.data1(loc3(n),1),handles.data1(loc3(n),3),'r+','Parent',handles.axes3); %Point is plotted on the GUI
        text(handles.data1(loc3(n),1) - 7, handles.data1(loc3(n),3) + 6, num2str(loc3(n)), 'Color', 'r','Parent',handles.axes3);
            end
        end
    loc = find(handles.data1(:,6)==handles.currentFrametran);
    loc2 = find(handles.data1(:,4)==handles.currentFramecor);
    loc3 = find(handles.data1(:,5)==handles.currentFramesag);
        if ~isempty(loc)
            for n = 1:length(loc)
        plot(handles.axes1, handles.data1(loc(n),4),handles.data1(loc(n),5),'g+','Parent',handles.axes1); %Point is plotted on the GUI
        text (handles.data1(loc(n),4) - 7, handles.data1(loc(n),5) + 6, num2str (loc(n)), 'Color', 'g','Parent',handles.axes1);
            end
        end
        if ~isempty(loc2)
            for n = 1:length(loc2)
        plot(handles.axes2, handles.data1(loc2(n),5),handles.data1(loc2(n),6),'g+','Parent',handles.axes2); %Point is plotted on the GUI
        text (handles.data1(loc2(n),5) - 7, handles.data1(loc2(n),6) + 6, num2str(loc2(n)), 'Color', 'g','Parent',handles.axes2);
            end
        end
        if ~isempty(loc3)
            for n = 1:length(loc3)
        plot(handles.axes3, handles.data1(loc3(n),4),handles.data1(loc3(n),6),'g+','Parent',handles.axes3); %Point is plotted on the GUI
        text(handles.data1(loc3(n),4) - 7, handles.data1(loc3(n),6) + 6, num2str(loc3(n)), 'Color', 'g','Parent',handles.axes3);
            end
        end
    end
end
sz  = size(handles.data1);
list = [];
for t = 1:sz(1)
list = [list;{t}];
end
set(handles.axes2, 'NextPlot', 'replacechildren');
set(handles.axes3, 'NextPlot', 'replacechildren');
set(handles.axes1, 'NextPlot', 'replacechildren');
set(handles.listbox1,'String',list);
    
    guidata(hObject, handles); 

% --- Executes during object creation, after setting all properties.
function image1_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to image1_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in image2_popup.
function image2_popup_Callback(hObject, eventdata, handles)
% hObject    handle to image2_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns image2_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from image2_popup
imgData = [];
handles.img = [];
handles.imgData = [];
contours = [];

try
load([handles.parentdir '\' handles.Imgfiles{get(handles.image2_popup,'Value')-1}],'image1','imgData','lim','-mat');
catch
    warning('Invalid Image data file');
end
try
load([handles.parentdir '\' handles.Imgfiles{get(handles.image1_popup,'Value')-1}],'contours','-mat');
catch
end
handles.contour2 = contours;
load([handles.parentdir '\' handles.Imgfiles{get(handles.image2_popup,'Value')-1}],'FPcoords','-mat');
    if isempty(FPcoords)
        handles.FPcoords2 = [];
    else
        handles.FPcoords2 = [FPcoords(:,2),FPcoords(:,1),FPcoords(:,3)];
    end
image1(image1 == -2000) = 0;
handles.imgData = imgData;
clear imgData;
sz = size(image1);
handles.lim = lim;
    handles.image2 = image1;
    clear image1
    %find out # of frames
    handles.sz2 = sz;
    handles.currentFrametran = round(handles.sz1(3)/2);
    handles.currentFramecor = round(handles.sz1(1)/2);
    handles.currentFramesag = round(handles.sz1(2)/2);
if isequal(handles.sz1,handles.sz2);
    sz1 = size(handles.FPcoords1);
    sz2 = size(handles.FPcoords2);
    if isequal(sz1,[0,0]) && isequal(sz2,[0,0])
        handles.data1 = [];
    elseif isequal(sz1,[0,0])
        handles.data1 = [handles.FPcoords2(:,1:2) -10,handles.FPcoords2(:,3),handles.FPcoords2];
    elseif isequal(sz2,[0,0])
        handles.data1 = [handles.FPcoords1,handles.FPcoords1(:,1:2)+10,handles.FPcoords1(:,3)];
    else
    if sz1(1) > sz2(1) 
        handles.data1 = [handles.FPcoords1(1:sz2(1),:),handles.FPcoords2];
        handles.data1 = [handles.data1;[handles.FPcoords1(sz2(1)+1:end,:),handles.FPcoords1(sz2(1)+1:end,1:2)+10,handles.FPcoords1(sz2(1)+1:end,3)]];
    elseif sz2(1) > sz1(1) 
        handles.data1 = [handles.FPcoords1,handles.FPcoords2(1:sz1(1),:)];
        handles.data1 = [handles.data1;[handles.FPcoords2(sz1(1)+1:end,1:2)-10,handles.FPcoords2(sz1(1)+1:end,3),handles.FPcoords2(sz1(1)+1:end,:)]];
    else
        handles.data1 = [handles.FPcoords1,handles.FPcoords2];
    end
    end
    %shows the first frame.
    set(handles.axes1, 'NextPlot','Replace');
    image(handles.image1(:,:,handles.currentFrametran)*(1-handles.fadeval_tran)+handles.image2(:,:,handles.currentFrametran)*handles.fadeval_tran, 'CDataMapping','scaled','Parent', handles.axes1);
%     axis image;
    set (handles.axes1, 'NextPlot', 'replacechildren');
    colormap bone;
    set(handles.tran_info, 'String', strcat(num2str (handles.currentFrametran), ' of ', num2str(handles.sz1(3))));
    set(handles.axes2, 'NextPlot','Replace');
    image(reshape(handles.image1(:,handles.currentFramecor,:),handles.sz1(1),handles.sz1(3))'*(1-handles.fadeval_cor)+reshape(handles.image2(:,handles.currentFramecor,:),handles.sz1(1),handles.sz1(3))'*handles.fadeval_cor, 'CDataMapping','scaled','Parent', handles.axes2);
%     axis image;
    set (handles.axes2, 'NextPlot', 'replacechildren');
    colormap bone;
       set(handles.cor_info, 'String', strcat(num2str (handles.currentFramecor), ' of ', num2str(handles.sz1(1))));
    set(handles.axes3, 'NextPlot','Replace');
    image(reshape(handles.image1(handles.currentFramesag,:,:),handles.sz1(2),handles.sz1(3))'*(1-handles.fadeval_sag)+reshape(handles.image2(handles.currentFramesag,:,:),handles.sz1(2),handles.sz1(3))'*handles.fadeval_sag, 'CDataMapping','scaled','Parent', handles.axes3);
%     axis image;
    set (handles.axes3, 'NextPlot', 'replacechildren');
    colormap bone;
    set(handles.sag_info, 'String', strcat(num2str (handles.currentFramesag), ' of ', num2str(handles.sz1(2))));
    %displays image information
    try
    set(handles.date_acquired, 'String', Imgdata(1).Date);
    catch
    end

    %Sets up sliders
    set (handles.slider_cor, 'Enable', 'on');
    set(handles.slider_cor, 'Min', 1);
    set(handles.slider_cor, 'Max', handles.sz1(2));
    set (handles.slider_cor, 'Value', handles.currentFramecor);
    set (handles.slider_cor, 'SliderStep', [1/handles.sz1(2), 0.25]);
    
    set (handles.slider_sag, 'Enable', 'on');
    set(handles.slider_sag, 'Min', 1);
    set(handles.slider_sag, 'Max', handles.sz1(1));
    set (handles.slider_sag, 'Value', handles.currentFramesag);
    set (handles.slider_sag, 'SliderStep', [1/handles.sz1(1), 0.25]);
    
    set (handles.slider_tran, 'Enable', 'on');
    set(handles.slider_tran, 'Min', 1);
    set(handles.slider_tran, 'Max', handles.sz1(3));
    set (handles.slider_tran, 'Value', handles.currentFrametran);
    set (handles.slider_tran, 'SliderStep', [1/handles.sz1(3), 0.25]);
    
handles.currentFrametran = get(handles.slider_tran,'Value');
handles.currentFramecor = get(handles.slider_cor,'Value');
handles.currentFramesag = get(handles.slider_sag,'Value');
setappdata(0,'tranframe',handles.currentFrametran);
setappdata(0,'corframe',handles.currentFramecor);
setappdata(0,'sagframe',handles.currentFramesag);
end

if  isequal(handles.sz1,handles.sz2)
set(handles.axes2, 'NextPlot', 'add');
set(handles.axes3, 'NextPlot', 'add');
set(handles.axes1, 'NextPlot', 'add');
imagesc(handles.image1(:,:,handles.currentFrametran)*(1-handles.fadeval_tran)+handles.image2(:,:,handles.currentFrametran)*handles.fadeval_tran,'Parent', handles.axes1);
image(reshape(handles.image1(handles.currentFramesag,:,:),handles.sz1(2),handles.sz1(3))'*(1-handles.fadeval_sag)+reshape(handles.image2(handles.currentFramesag,:,:),handles.sz1(2),handles.sz1(3))'*handles.fadeval_sag, 'CDataMapping','scaled','Parent', handles.axes3);
image(reshape(handles.image1(:,handles.currentFramecor,:),handles.sz1(1),handles.sz1(3))'*(1-handles.fadeval_cor)+reshape(handles.image2(:,handles.currentFramecor,:),handles.sz1(1),handles.sz1(3))'*handles.fadeval_cor, 'CDataMapping','scaled','Parent', handles.axes2);
if ~isempty(handles.contour2)
if ~isempty(handles.contour2{handles.currentFrametran}) 
    for m = 1:length(handles.contour2{handles.currentFrametran})
patch(handles.contour2{handles.currentFrametran}{m}(:,1)-handles.lim(3)+1,handles.contour2{handles.currentFrametran}{m}(:,2)-handles.lim(1)+1,'g','EdgeColor','g','FaceColor','none','Parent',handles.axes1);
    end
end
end
    if  ~isempty(handles.data1)
    loc = find(handles.data1(:,3)==handles.currentFrametran);
    loc2 = find(handles.data1(:,1)==handles.currentFramecor);
    loc3 = find(handles.data1(:,2)==handles.currentFramesag);

        if ~isempty(loc)
            for n = 1:length(loc)
        plot(handles.axes1, handles.data1(loc(n),1),handles.data1(loc(n),2),'r+','Parent',handles.axes1); %Point is plotted on the GUI
        text (handles.data1(loc(n),1) - 7, handles.data1(loc(n),2) + 6, num2str (loc(n)), 'Color', 'r','Parent',handles.axes1);
            end
        end
        if ~isempty(loc2)
            for n = 1:length(loc2)
        plot(handles.axes2, handles.data1(loc2(n),2),handles.data1(loc2(n),3),'r+','Parent',handles.axes2); %Point is plotted on the GUI
        text (handles.data1(loc2(n),2) - 7, handles.data1(loc2(n),3) + 6, num2str(loc2(n)), 'Color', 'r','Parent',handles.axes2);
            end
        end
        if ~isempty(loc3)
            for n = 1:length(loc3)
        plot(handles.axes3, handles.data1(loc3(n),1),handles.data1(loc3(n),3),'r+','Parent',handles.axes3); %Point is plotted on the GUI
        text(handles.data1(loc3(n),1) - 7, handles.data1(loc3(n),3) + 6, num2str(loc3(n)), 'Color', 'r','Parent',handles.axes3);
            end
        end
    loc = find(handles.data1(:,6)==handles.currentFrametran);
    loc2 = find(handles.data1(:,4)==handles.currentFramecor);
    loc3 = find(handles.data1(:,5)==handles.currentFramesag);
        if ~isempty(loc)
            for n = 1:length(loc)
        plot(handles.axes1, handles.data1(loc(n),4),handles.data1(loc(n),5),'g+','Parent',handles.axes1); %Point is plotted on the GUI
        text (handles.data1(loc(n),4) - 7, handles.data1(loc(n),5) + 6, num2str (loc(n)), 'Color', 'g','Parent',handles.axes1);
            end
        end
        if ~isempty(loc2)
            for n = 1:length(loc2)
        plot(handles.axes2, handles.data1(loc2(n),5),handles.data1(loc2(n),6),'g+','Parent',handles.axes2); %Point is plotted on the GUI
        text (handles.data1(loc2(n),5) - 7, handles.data1(loc2(n),6) + 6, num2str(loc2(n)), 'Color', 'g','Parent',handles.axes2);
            end
        end
        if ~isempty(loc3)
            for n = 1:length(loc3)
        plot(handles.axes3, handles.data1(loc3(n),4),handles.data1(loc3(n),6),'g+','Parent',handles.axes3); %Point is plotted on the GUI
        text(handles.data1(loc3(n),4) - 7, handles.data1(loc3(n),6) + 6, num2str(loc3(n)), 'Color', 'g','Parent',handles.axes3);
            end
        end
    end
end
sz  = size(handles.data1);
list = [];
for t = 1:sz(1)
list = [list;{t}];
end
set(handles.axes2, 'NextPlot', 'replacechildren');
set(handles.axes3, 'NextPlot', 'replacechildren');
set(handles.axes1, 'NextPlot', 'replacechildren');
set(handles.listbox1,'String',list);
    %updates handles with new values
    guidata(hObject, handles); 

% --- Executes during object creation, after setting all properties.
function image2_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to image2_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in move_feature_point2.
function move_feature_point2_Callback(hObject, eventdata, handles)
% hObject    handle to move_feature_point2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 [x,y] = ginput(1);
    if handles.axes1 == gca
        handles.currentFrametran = getappdata(0,'tranframe');
        coords = [x,y,handles.currentFrametran];     
    elseif handles.axes2 == gca
        handles.currentFramecor = getappdata(0,'corframe');
        coords = [handles.currentFramecor,x,y];
    elseif handles.axes3 == gca
        handles.currentFramesag = getappdata(0,'sagframe');
        coords = [x,handles.currentFramesag,y]; 
    end
 
   handles.data1(get(handles.listbox1,'Value'),4:6) = coords;
if  isequal(handles.sz1,handles.sz2)
    set(handles.axes1,'Nextplot','add');
    set(handles.axes2,'Nextplot','add');
    set(handles.axes2,'Nextplot','add');
    image(handles.image1(:,:,handles.currentFrametran)*(1-handles.fadeval_tran)+handles.image2(:,:,handles.currentFrametran)*handles.fadeval_tran, 'CDataMapping','scaled','Parent', handles.axes1);
    image(reshape(handles.image1(:,handles.currentFramecor,:),handles.sz1(1),handles.sz1(3))'*(1-handles.fadeval_cor)+reshape(handles.image2(:,handles.currentFramecor,:),handles.sz1(1),handles.sz1(3))'*handles.fadeval_cor, 'CDataMapping','scaled','Parent', handles.axes2);    
    image(reshape(handles.image1(handles.currentFramesag,:,:),handles.sz1(2),handles.sz1(3))'*(1-handles.fadeval_sag)+reshape(handles.image2(handles.currentFramesag,:,:),handles.sz1(2),handles.sz1(3))'*handles.fadeval_sag, 'CDataMapping','scaled','Parent', handles.axes3);
    if  ~isempty(handles.data1)
    loc = find(handles.data1(:,3)==handles.currentFrametran);
    loc2 = find(handles.data1(:,1)==handles.currentFramecor);
    loc3 = find(handles.data1(:,2)==handles.currentFramesag);

        if ~isempty(loc)
            for n = 1:length(loc)
        plot(handles.axes1, handles.data1(loc(n),1),handles.data1(loc(n),2),'r+','Parent',handles.axes1); %Point is plotted on the GUI
        text (handles.data1(loc(n),1) - 7, handles.data1(loc(n),2) + 6, num2str (loc(n)), 'Color', 'r','Parent',handles.axes1);
            end
        end
        if ~isempty(loc2)
            for n = 1:length(loc2)
        plot(handles.axes2, handles.data1(loc2(n),2),handles.data1(loc2(n),3),'r+','Parent',handles.axes2); %Point is plotted on the GUI
        text (handles.data1(loc2(n),2) - 7, handles.data1(loc2(n),3) + 6, num2str(loc2(n)), 'Color', 'r','Parent',handles.axes2);
            end
        end
        if ~isempty(loc3)
            for n = 1:length(loc3)
        plot(handles.axes3, handles.data1(loc3(n),1),handles.data1(loc3(n),3),'r+','Parent',handles.axes3); %Point is plotted on the GUI
        text(handles.data1(loc3(n),1) - 7, handles.data1(loc3(n),3) + 6, num2str(loc3(n)), 'Color', 'r','Parent',handles.axes3);
            end
        end
    loc = find(handles.data1(:,6)==handles.currentFrametran);
    loc2 = find(handles.data1(:,4)==handles.currentFramecor);
    loc3 = find(handles.data1(:,5)==handles.currentFramesag);
        if ~isempty(loc)
            for n = 1:length(loc)
        plot(handles.axes1, handles.data1(loc(n),4),handles.data1(loc(n),5),'g+','Parent',handles.axes1); %Point is plotted on the GUI
        text (handles.data1(loc(n),4) - 7, handles.data1(loc(n),5) + 6, num2str (loc(n)), 'Color', 'g','Parent',handles.axes1);
            end
        end
        if ~isempty(loc2)
            for n = 1:length(loc2)
        plot(handles.axes2, handles.data1(loc2(n),5),handles.data1(loc2(n),6),'g+','Parent',handles.axes2); %Point is plotted on the GUI
        text (handles.data1(loc2(n),5) - 7, handles.data1(loc2(n),6) + 6, num2str(loc2(n)), 'Color', 'g','Parent',handles.axes2);
            end
        end
        if ~isempty(loc3)
            for n = 1:length(loc3)
        plot(handles.axes3, handles.data1(loc3(n),4),handles.data1(loc3(n),6),'g+','Parent',handles.axes3); %Point is plotted on the GUI
        text(handles.data1(loc3(n),4) - 7, handles.data1(loc3(n),6) + 6, num2str(loc3(n)), 'Color', 'g','Parent',handles.axes3);
            end
        end
    set(handles.axes1,'Nextplot','replacechildren');
    set(handles.axes2,'Nextplot','replacechildren');
    set(handles.axes2,'Nextplot','replacechildren');
    end
end
guidata(hObject, handles);

% --- Executes on button press in select_pairs.
function select_pairs_Callback(hObject, eventdata, handles)
% hObject    handle to select_pairs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.selon == 0
handles.selon = 1;
handles.selected = [];
else
handles.selon = 0;
end
if  isequal(handles.sz1,handles.sz2)
    image(handles.image1(:,:,handles.currentFrametran)*(1-handles.fadeval_tran)+handles.image2(:,:,handles.currentFrametran)*handles.fadeval_tran, 'CDataMapping','scaled','Parent', handles.axes1);
    image(reshape(handles.image1(:,handles.currentFramecor,:),handles.sz1(1),handles.sz1(3))'*(1-handles.fadeval_cor)+reshape(handles.image2(:,handles.currentFramecor,:),handles.sz1(1),handles.sz1(3))'*handles.fadeval_cor, 'CDataMapping','scaled','Parent', handles.axes2);    
    image(reshape(handles.image1(handles.currentFramesag,:,:),handles.sz1(2),handles.sz1(3))'*(1-handles.fadeval_sag)+reshape(handles.image2(handles.currentFramesag,:,:),handles.sz1(2),handles.sz1(3))'*handles.fadeval_sag, 'CDataMapping','scaled','Parent', handles.axes3);
    if  ~isempty(handles.data1)
        set(handles.axes2,'Nextplot','add');
        set(handles.axes3,'Nextplot','add');
    loc = find(handles.data1(:,3)==handles.currentFrametran);
    loc2 = find(handles.data1(:,1)==handles.currentFramecor);
    loc3 = find(handles.data1(:,2)==handles.currentFramesag);

        if ~isempty(loc)
            for n = 1:length(loc)
        plot(handles.axes1, handles.data1(loc(n),1),handles.data1(loc(n),2),'r+','Parent',handles.axes1); %Point is plotted on the GUI
        text (handles.data1(loc(n),1) - 7, handles.data1(loc(n),2) + 6, num2str (loc(n)), 'Color', 'r','Parent',handles.axes1);
            end
        end
        if ~isempty(loc2)
            for n = 1:length(loc2)
        plot(handles.axes2, handles.data1(loc2(n),2),handles.data1(loc2(n),3),'r+','Parent',handles.axes2); %Point is plotted on the GUI
        text (handles.data1(loc2(n),2) - 7, handles.data1(loc2(n),3) + 6, num2str(loc2(n)), 'Color', 'r','Parent',handles.axes2);
            end
        end
        if ~isempty(loc3)
            for n = 1:length(loc3)
        plot(handles.axes3, handles.data1(loc3(n),1),handles.data1(loc3(n),3),'r+','Parent',handles.axes3); %Point is plotted on the GUI
        text(handles.data1(loc3(n),1) - 7, handles.data1(loc3(n),3) + 6, num2str(loc3(n)), 'Color', 'r','Parent',handles.axes3);
            end
        end
    loc = find(handles.data1(:,6)==handles.currentFrametran);
    loc2 = find(handles.data1(:,4)==handles.currentFramecor);
    loc3 = find(handles.data1(:,5)==handles.currentFramesag);
        if ~isempty(loc)
            for n = 1:length(loc)
        plot(handles.axes1, handles.data1(loc(n),4),handles.data1(loc(n),5),'g+','Parent',handles.axes1); %Point is plotted on the GUI
        text (handles.data1(loc(n),4) - 7, handles.data1(loc(n),5) + 6, num2str (loc(n)), 'Color', 'g','Parent',handles.axes1);
            end
        end
        if ~isempty(loc2)
            for n = 1:length(loc2)
        plot(handles.axes2, handles.data1(loc2(n),5),handles.data1(loc2(n),6),'g+','Parent',handles.axes2); %Point is plotted on the GUI
        text (handles.data1(loc2(n),5) - 7, handles.data1(loc2(n),6) + 6, num2str(loc2(n)), 'Color', 'g','Parent',handles.axes2);
            end
        end
        if ~isempty(loc3)
            for n = 1:length(loc3)
        plot(handles.axes3, handles.data1(loc3(n),4),handles.data1(loc3(n),6),'g+','Parent',handles.axes3); %Point is plotted on the GUI
        text(handles.data1(loc3(n),4) - 7, handles.data1(loc3(n),6) + 6, num2str(loc3(n)), 'Color', 'g','Parent',handles.axes3);
            end
        end
        set(handles.axes2,'Nextplot','replacechildren');
        set(handles.axes3,'Nextplot','replacechildren');
    end
end

guidata(hObject, handles);




% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1




% --- Executes on button press in designate_isocenter.
function designate_isocenter_Callback(hObject, eventdata, handles)
% hObject    handle to designate_isocenter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sz = size(handles.image1);
setappdata(0,'imsize',sz); 
handles.isocenter = [sz(1)/2,sz(2)/2,sz(3)/2];
setappdata(0,'center',handles.isocenter);
des = Disocenter;
waitfor(des);
center = getappdata(0,'center');
if center == 0
%do nothing
elseif center == 1
    sz = size(handles.image1);
    set(handles.text2,'String','Designate isocenter in AP and LR below','ForegroundColor','g','FontWeight','Bold','FontSize',10);
    [x,y] = ginput(1);
    set(handles.text2,'String','Transverse','ForegroundColor','k','FontWeight','Normal','FontSize',8);
    hold on
    line([0,sz(2)],[y,y],'Color','w','LineStyle','-','Parent',handles.axes1);
    line([x,x],[0,sz(1)],'Color','w','LineStyle','-','Parent',handles.axes1);
    set(handles.text3,'String','Designate in IS below','ForegroundColor','g','FontWeight','Bold','FontSize',10);
    [y1,z] = ginput(1);
    set(handles.text3,'String','Coronal','ForegroundColor','k','FontWeight','Normal','FontSize',8);
    hold on
    line([0,sz(1)],[z,z],'Color','w','LineStyle','-','Parent',handles.axes2);
    line([y,y],[0,sz(3)],'Color','w','LineStyle','-','Parent',handles.axes2);
    line([0,sz(2)],[z,z],'Color','w','LineStyle','-','Parent',handles.axes3);
    line([x,x],[0,sz(3)],'Color','w','LineStyle','-','Parent',handles.axes3);
    handles.isocenter = [y,x,z];
else
    handles.isocenter = center;
    y = center(1); x = center(2); z = center(3);
    line([0,sz(2)],[y,y],'Color','w','LineStyle','-','Parent',handles.axes1);
    line([x,x],[0,sz(1)],'Color','w','LineStyle','-','Parent',handles.axes1);
    line([0,sz(1)],[z,z],'Color','w','LineStyle','-','Parent',handles.axes2);
    line([y,y],[0,sz(3)],'Color','w','LineStyle','-','Parent',handles.axes2);
    line([0,sz(2)],[z,z],'Color','w','LineStyle','-','Parent',handles.axes3);
    line([x,x],[0,sz(3)],'Color','w','LineStyle','-','Parent',handles.axes3);
end
    
    guidata(hObject,handles);


% --- Executes on button press in pushbutton12.
function designate_coordinates_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
des = Dcoord;
waitfor(des);
coord = getappdata(0,'coords');
if coord == 0
    %do nothing
else
    coords = zeros(2,3);
    coords(:,2) = coord(:,1)./handles.res(1) + handles.isocenter(2);
    coords(:,1) = coord(:,2)./handles.res(2) + handles.isocenter(1);
    coords(:,3) = coord(:,3)./handles.res(3) + handles.isocenter(3);
    handles.data1 = [handles.data1;[coords(1,:),coords(2,:)]];

sz = size(handles.data1);
% handles.data3 = [handles.data3; [coords{1}(3), coords{2}(3)]];


if  isequal(handles.sz1,handles.sz2)
% imagesc(handles.image1(:,:,handles.currentFrametran)*(1-handles.fadeval_tran)+handles.image2(:,:,handles.currentFrametran)*handles.fadeval_tran,'Parent', handles.axes1);
    if  ~isempty(handles.data1)
    loc = find(handles.data1(:,3)==handles.currentFrametran);
    loc2 = find(handles.data1(:,1)==handles.currentFramecor);
    loc3 = find(handles.data1(:,2)==handles.currentFramesag);

        if ~isempty(loc)
            for n = 1:length(loc)
        plot(handles.axes1, handles.data1(loc(n),1),handles.data1(loc(n),2),'r+','Parent',handles.axes1); %Point is plotted on the GUI
        text (handles.data1(loc(n),1) - 7, handles.data1(loc(n),2) + 6, num2str (loc(n)), 'Color', 'r','Parent',handles.axes1);
            end
        end
        if ~isempty(loc2)
            for n = 1:length(loc2)
        plot(handles.axes2, handles.data1(loc2(n),2),handles.data1(loc2(n),3),'r+','Parent',handles.axes2); %Point is plotted on the GUI
        text (handles.data1(loc2(n),2) - 7, handles.data1(loc2(n),3) + 6, num2str(loc2(n)), 'Color', 'r','Parent',handles.axes2);
            end
        end
        if ~isempty(loc3)
            for n = 1:length(loc3)
        plot(handles.axes3, handles.data1(loc3(n),1),handles.data1(loc3(n),3),'r+','Parent',handles.axes3); %Point is plotted on the GUI
        text(handles.data1(loc3(n),1) - 7, handles.data1(loc3(n),3) + 6, num2str(loc3(n)), 'Color', 'r','Parent',handles.axes3);
            end
        end
    loc = find(handles.data1(:,6)==handles.currentFrametran);
    loc2 = find(handles.data1(:,4)==handles.currentFramecor);
    loc3 = find(handles.data1(:,5)==handles.currentFramesag);
        if ~isempty(loc)
            for n = 1:length(loc)
        plot(handles.axes1, handles.data1(loc(n),4),handles.data1(loc(n),5),'g+','Parent',handles.axes1); %Point is plotted on the GUI
        text (handles.data1(loc(n),4) - 7, handles.data1(loc(n),5) + 6, num2str (loc(n)), 'Color', 'g','Parent',handles.axes1);
            end
        end
        if ~isempty(loc2)
            for n = 1:length(loc2)
        plot(handles.axes2, handles.data1(loc2(n),5),handles.data1(loc2(n),6),'g+','Parent',handles.axes2); %Point is plotted on the GUI
        text (handles.data1(loc2(n),5) - 7, handles.data1(loc2(n),6) + 6, num2str(loc2(n)), 'Color', 'g','Parent',handles.axes2);
            end
        end
        if ~isempty(loc3)
            for n = 1:length(loc3)
        plot(handles.axes3, handles.data1(loc3(n),4),handles.data1(loc3(n),6),'g+','Parent',handles.axes3); %Point is plotted on the GUI
        text(handles.data1(loc3(n),4) - 7, handles.data1(loc3(n),6) + 6, num2str(loc3(n)), 'Color', 'g','Parent',handles.axes3);
            end
        end
    end
end
list = [];
for t = 1:sz(1)
list = [list;{t}];
end
set(handles.axes2, 'NextPlot', 'replacechildren');
set(handles.axes3, 'NextPlot', 'replacechildren');
set(handles.listbox1,'String',list);
guidata(hObject, handles);
end
% --------------------------------------------------------------------
function resolution_Callback(hObject, eventdata, handles)
% hObject    handle to resolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
res = resolution;
waitfor(res);
res = getappdata(0,'res');
if res == 0
    handles.res = [1,1,1];
else
    handles.res = res;
end


