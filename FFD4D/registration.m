function varargout = registration(varargin)
% REGISTRATION M-file for registration.fig
%      REGISTRATION, by itself, creates a new REGISTRATION or raises the existing
%      singleton*.
%
%      H = REGISTRATION returns the handle to a new REGISTRATION or the handle to
%      the existing singleton*.
%
%      REGISTRATION('CALLBACK',hObject,eventData,handles,...) calls the
%      local
%      function named CALLBACK in REGISTRATION.M with the given input arguments.
%
%      REGISTRATION('Property','Value',...) creates a new REGISTRATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before registration_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to registration_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help registration

% Last Modified by GUIDE v2.5 05-Sep-2007 22:08:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @registration_OpeningFcn, ...
                   'gui_OutputFcn',  @registration_OutputFcn, ...
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


% --- Executes just before registration is made visible.
function registration_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to registration (see VARARGIN)

% Choose default command line output for registration
handles.output = hObject;
handles.imgfiles = getappdata(0,'filenames');
handles.thumbs  = zeros(100,100,length(handles.imgfiles));
handles.parentdir = getappdata(0,'parentdir');
handles.filenames = getappdata(0,'filenames2');
handles.selmode = 0;
handles.references = [];
handles.target = [];
handles.values = zeros(10,2);
handles.reg_params = getappdata(0,'reg_params');
for n = 1:length(handles.imgfiles)
    load([handles.parentdir '\' handles.imgfiles{n}],'thumb','-mat');
    handles.thumbs(:,:,n) = thumb;
end

for n = 1:min(length(handles.imgfiles),10)
     
    eval(sprintf(['image(handles.thumbs(:,:,' num2str(n) '),''CDataMapping'',''scaled'',''Parent'',handles.axis_' num2str(n) ',''ButtonDownFcn'', @axis_' num2str(n) '_ButtonDownFcn)']));
    eval(sprintf(['set(handles.axis_' num2str(n) ',''XTick'',[],''YTick'',[],''XTickLabel'','''',''YTickLabel'','''');']));
    colormap bone
    if length(handles.filenames{n}) > 25
        eval(sprintf(['set(handles.text' num2str(n) ',''String'',handles.filenames{' num2str(n) '}(1:25)));']));
    else
        eval(sprintf(['set(handles.text' num2str(n) ',''String'',handles.filenames{' num2str(n) '});'])); 
    end
end
handles.selmode = 0;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes registration wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = registration_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in sel_targ.
function sel_targ_Callback(hObject, eventdata, handles)
% hObject    handle to sel_targ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.selmode == 3
    handles.references = [];
    handles.target = [];
    for n = 1:min(length(handles.imgfiles),10)
     
    eval(sprintf(['image(handles.thumbs(:,:,' num2str(n) '),''CDataMapping'',''scaled'',''Parent'',handles.axis_' num2str(n) ',''ButtonDownFcn'', @axis_' num2str(n) '_ButtonDownFcn)']));
    eval(sprintf(['set(handles.axis_' num2str(n) ',''XTick'',[],''YTick'',[],''XTickLabel'','''',''YTickLabel'','''');']));
    colormap bone
    if length(handles.filenames{n}) > 25
        eval(sprintf(['set(handles.text' num2str(n) ',''String'',handles.filenames{' num2str(n) '}(1:25)));']));
    else
        eval(sprintf(['set(handles.text' num2str(n) ',''String'',handles.filenames{' num2str(n) '});'])); 
    end
    end
end
handles.selmode = 2;
guidata(hObject,handles);

% --- Executes on button press in calc_all_phase.
function calc_all_phase_Callback(hObject, eventdata, handles)
% hObject    handle to calc_all_phase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.filenames);
handles.references = 1:length(handles.filenames)-1;
handles.target = 2:length(handles.filenames)-1;
    rectangle('Position',[2,3,98,96],'Parent',handles.axis_1,'EdgeColor','g','LineStyle','-','LineWidth',4);
    eval(sprintf(['rectangle(''Position'',[2,3,98,96],''Parent'',handles.axis_' num2str(length(handles.filenames)) ',''EdgeColor'',''r'',''LineStyle'',''-'',''LineWidth'',4);']));
    if length(handles.filenames)>=3
        for n = 1:length(handles.filenames)-2
        eval(sprintf(['rectangle(''Position'',[2,3,98,96],''Parent'',handles.axis_' num2str(n+1) ',''EdgeColor'',''g'',''LineStyle'',''-'',''LineWidth'',4);']));
        eval(sprintf(['rectangle(''Position'',[9,10,84,82],''Parent'',handles.axis_' num2str(n+1) ',''EdgeColor'',''r'',''LineStyle'',''-'',''LineWidth'',4);']));
        end
    end
end
handles.selmode = 3;
guidata(hObject,handles);
% --- Executes on button press in sel_sour.
function sel_sour_Callback(hObject, eventdata, handles)
% hObject    handle to sel_sour (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.selmode == 3
    handles.references = [];
    handles.target = [];
    for n = 1:min(length(handles.imgfiles),10)
     
    eval(sprintf(['image(handles.thumbs(:,:,' num2str(n) '),''CDataMapping'',''scaled'',''Parent'',handles.axis_' num2str(n) ',''ButtonDownFcn'', @axis_' num2str(n) '_ButtonDownFcn)']));
    eval(sprintf(['set(handles.axis_' num2str(n) ',''XTick'',[],''YTick'',[],''XTickLabel'','''',''YTickLabel'','''');']));
    colormap bone
    if length(handles.filenames{n}) > 25
        eval(sprintf(['set(handles.text' num2str(n) ',''String'',handles.filenames{' num2str(n) '}(1:25)));']));
    else
        eval(sprintf(['set(handles.text' num2str(n) ',''String'',handles.filenames{' num2str(n) '});'])); 
    end
    end
end
handles.selmode = 1;
guidata(hObject,handles);

% --- Executes on button press in Register_images.
function Register_images_Callback(hObject, eventdata, handles)
% hObject    handle to Register_images (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = waitbar(0,'Extracting Contour Information ...','WindowStyle','modal');
values2 = zeros(10,1);
contsinfo = cell(10,10);
limits = zeros(10,6);
for n = 1:min(length(handles.imgfiles),10)
    try
        load([handles.parentdir '\' handles.imgfiles{n}],'continfo','lim','-mat');
contsinfo{n} = continfo;
limits(n,:) = lim;
    catch
        continfo = {};
    end
    if ~isempty(continfo)
        values2(n) = 1;
    end
    waitbar((n/min(length(handles.imgfiles),10))*0.1,h);
end
handles.values = [handles.values, values2];
if handles.selmode ~= 3
    for n = 1:length(handles.references)
        waitbar(0.1,h,['Registering Imageset ' num2str(n) '/' num2str(length(handles.references))]);
       try 
            load([handles.parentdir '\' handles.imgfiles{handles.references(n)}],'image1','FPcoords','lim','-mat');
            fpoints1 = FPcoords;
        catch
            load([handles.parentdir '\' handles.imgfiles{handles.references(n)}],'image1','-mat');
            fpoints1 = [];
            lim = size(image1);
       end
       limits(n,:) = lim;
%        image1 = image1(:,:,lim(5):lim(6));
            sz = size(image1);
        sz2 = [handles.reg_params{8}(2),handles.reg_params{8}(1),sz(3)];
%         zarray1 = zeros(1,1,sz(3));
% zarray2 = zeros(1,1,sz2(3));
% zarray1(:) = 1:sz(3);
% zarray2(:) = 1:(sz(3)-1)/(sz2(3)-1):sz(3);
image1 = interpslice(image1,sz2);
        if handles.values(handles.references(n),1) == 1 && handles.values(handles.references(n),2) == 1
            image1 = autoseg(image1,'bsl');
        elseif handles.values(handles.references(n),1) == 0 && handles.values(handles.references(n),2) == 1
            image1 = autoseg(image1,'sl');
        elseif handles.values(handles.references(n),1) == 1 && handles.values(handles.references(n),2) == 0
            image1 = autoseg(image1,'b');
        elseif handles.values(handles.references(n),1) == 0 && handles.values(handles.references(n),2) == 0
            image1(:,:,:) = 0;
        end
%         save('tempr.m','FPcoords','continfo','contsinfo','eventdata','fpoints1','h','hObject','handles','lim','n','values2');
%         clear('FPcoords','continfo','contsinfo','eventdata','fpoints1','h','hObject','handles','lim','n','values2');

    
% image1 = interp3(repmat(1:sz(2),[sz(1),1,sz(3)]),repmat((1:sz(1))',[1,sz(2),sz(3)]),repmat(zarray1,[sz(1),sz(2),1]),image1,repmat(1:(sz(2)-1)/(sz2(2)-1):sz(2),[sz2(1),1,sz2(3)]),repmat((1:(sz(1)-1)/(sz2(1)-1):sz(1))',[1,sz2(2),sz2(3)]),repmat(zarray2,[sz2(1),sz2(2),1]),'spline');
% load('tempr.m','-mat');
if ~isempty(contsinfo{handles.references(n)})
    for p = 1:length(contsinfo{handles.references(n)}{1})
    cont = getRTOGcont3(contsinfo{handles.references(n)}{1}{p},contsinfo{handles.references(n)}{2}{p},limits(n,:),handles.reg_params{8},contsinfo{handles.references(n)}{3}{p});
%     cont = cont(:,:,limits(n,5):limits(n,6));
    image1 = image1+cont;
    image1(image1 == 2) = 1; %clean up overlaps
    end
   clear cont;
end
image2 = image1;
clear image1;
try
        load([handles.parentdir '\' handles.imgfiles{handles.target}],'image1','FPcoords','-mat');
        fpoints2 = FPcoords;
catch
     load([handles.parentdir '\' handles.imgfiles{handles.target}],'image1','-mat');
    fpoints2 = [];
end
       sz = size(image1);
        sz2 = [handles.reg_params{8}(2),handles.reg_params{8}(1),sz(3)];
        image1 = interpslice(image1,sz2);
        image1 = image1(:,:,lim(5):lim(6));
        if handles.values(handles.target,1) == 1 && handles.values(handles.target,2) == 1
            image1 = autoseg(image1,'bsl');
        elseif handles.values(handles.target,1) == 0 && handles.values(handles.target,2) == 1
            image1 = autoseg(image1,'sl');
        elseif handles.values(handles.target,1) == 1 && handles.values(handles.target,2) == 0
            image1 = autoseg(image1,'b');
        elseif handles.values(handles.target,1) == 0 && handles.values(handles.target,2) == 0
            image1(:,:,:) = 0;
        end
 
%         image1 = interp3(repmat(1:sz(2),[sz(1),1,sz(3)]),repmat((1:sz(1))',[1,sz(2),sz(3)]),repmat(zarray1,[sz(1),sz(2),1]),image1,repmat(1:(sz(2)-1)/(sz2(2)-1):sz(1),[sz2(1),1,sz2(3)]),repmat((1:(sz(1)-1)/(sz2(1)-1):sz(1))',[1,sz2(2),sz2(3)]),repmat(zarray2,[sz2(1),sz2(2),1]),'spline');
        if ~isempty(contsinfo{handles.target})
              for p = 1:length(contsinfo{handles.target}{1})
                  try
                cont = getRTOGcont3(contsinfo{handles.target}{1}{p},contsinfo{handles.target}{2}{p},limits(n,:),handles.reg_params{8},contsinfo{handles.target}{3}{p});
                  catch
                      d = 1;
                  end
%                 cont = cont(:,:,limits(n,5):limits(n,6));
                image1 = image1+cont;
                image1(image1 == 2) = 1; %clean up overlaps
              end
            clear cont;
        end
        if ~isempty(fpoints1) && ~isempty(fpoints2)
        fpoints1(:,2) = (fpoints1(:,2)).*(sz2(1)-1)./(sz(1)-1); fpoints2(:,2) = (fpoints2(:,2)).*(sz2(1)-1)./(sz(1)-1);
        fpoints1(:,1) = (fpoints1(:,1)).*(sz2(2)-1)./(sz(2)-1); fpoints2(:,1) = (fpoints2(:,1)).*(sz2(2)-1)./(sz(2)-1);
        fpoints1(:,3) = (fpoints1(:,3)).*(sz2(3)-1)./(sz(3)-1); fpoints2(:,3) = (fpoints2(:,3)).*(sz2(3)-1)./(sz(3)-1);
        end
        
        [dimage,dgridx,dgridy,dgridz] = imdeform3D(image2,image1,handles.reg_params{3},handles.reg_params{4},handles.reg_params{5},handles.reg_params{1},handles.reg_params{2},fpoints2,fpoints1,handles.reg_params{6},handles.reg_params{7});
        clear dimage;
        waitbar((n/length(handles.references))*0.9+0.1,h,['Registering Imageset ' num2str(n) '/' num2str(length(handles.references))]);
        save([handles.parentdir '\' strrep(handles.imgfiles{handles.references(n)},'temp', ['to_' handles.filenames{handles.target} '_deform'])],'dgridx','dgridy','dgridz','lim');
        clear dgridx dgridy dgridz image1 image2
    end
else
    for n = 1:length(handles.references)
        waitbar((n/length(handles.references))*0.9+0.1,h,['Registering Imageset ' num2str(n) '/' num2str(length(handles.references))]);
        try
        load([handles.parentdir '\' handles.imgfiles{handles.references(n)}],'image1','FPcoords','lim','-mat');
        fpoints1 = FPcoords;
catch
    load([handles.parentdir '\' handles.imgfiles{handles.references(n)}],'image1','-mat');
    fpoints1 = [];
    lim = size(image1);
        end
  sz = size(image1);
        sz2 = [handles.reg_params{8}(2),handles.reg_params{8}(1),sz(3)];
%         zarray1 = zeros(1,1,sz(3));
% zarray2 = zeros(1,1,sz2(3));
% zarray1(:) = 1:sz(3);
% zarray2(:) = 1:(sz(3)-1)/(sz2(3)-1):sz(3);
image1 = interpslice(image1,sz2);
image1 = image1(:,:,lim(5):lim(6));
        if handles.values(handles.references(n),1) == 1 && handles.values(handles.references(n),2) == 1
            image1 = autoseg(image1,'bsl');
        elseif handles.values(handles.references(n),1) == 0 && handles.values(handles.references(n),2) == 1
            image1 = autoseg(image1,'sl');
        elseif handles.values(handles.references(n),1) == 1 && handles.values(handles.references(n),2) == 0
            image1 = autoseg(image1,'b');
        elseif handles.values(handles.references(n),1) == 0 && handles.values(handles.references(n),2) == 0
            image1(:,:,:) = 0;
        end
      
% image1 = interp3(repmat(1:sz(2),[sz(1),1,sz(3)]),repmat((1:sz(1))',[1,sz(2),sz(3)]),repmat(zarray1,[sz(1),sz(2),1]),image1,repmat(1:(sz(2)-1)/(sz2(2)-1):sz(2),[sz2(1),1,sz2(3)]),repmat((1:(sz(1)-1)/(sz2(1)-1):sz(1))',[1,sz2(2),sz2(3)]),repmat(zarray2,[sz2(1),sz2(2),1]),'spline');
if ~isempty(contsinfo{handles.references(n)})
      for p = 1:length(contsinfo{handles.references(n)}{1})
        cont = getRTOGcont3(contsinfo{handles.references(n)}{1}{p},contsinfo{handles.references(n)}{2}{p},limits(n,:),handles.reg_params{8},contsinfo{handles.references(n)}{3}{p});
%         cont = cont(:,:,limits(n,5):limits(n,6));
        image1 = image1+cont;
        image1(image1 == 2) = 1; %clean up overlaps
      end
    clear cont;
end
image2 = image1;
clear image1;
try
        load([handles.parentdir '\' handles.imgfiles{handles.target(n)}],'image1','FPcoords','-mat');
        fpoints2 = FPcoords;
catch
     load([handles.parentdir '\' handles.imgfiles{handles.target(n)}],'image1','-mat');
    fpoints2 = [];
end
   sz = size(image1);
        sz2 = [handles.reg_params{8}(2),handles.reg_params{8}(1),sz(3)];

        image1 = interpslice(image1,sz2);
        image1 = image1(:,:,lim(5):lim(6));
        if handles.values(handles.target(n),1) == 1 && handles.values(handles.target(n),2) == 1
            image1 = autoseg(image1,'bsl');
        elseif handles.values(handles.target(n),1) == 0 && handles.values(handles.target(n),2) == 1
            image1 = autoseg(image1,'sl');
        elseif handles.values(handles.target(n),1) == 1 && handles.values(handles.target(n),2) == 0
            image1 = autoseg(image1,'b');
        elseif handles.values(handles.target(n),1) == 0 && handles.values(handles.target(n),2) == 0
            image1(:,:,:) = 0;
        end
   
%         image2 = interp3(repmat(1:sz(2),[sz(1),1,sz(3)]),repmat((1:sz(1))',[1,sz(2),sz(3)]),repmat(zarray1,[sz(1),sz(2),1]),image1,repmat(1:(sz(2)-1)/(sz2(2)-1):sz(1),[sz2(1),1,sz2(3)]),repmat((1:(sz(1)-1)/(sz2(1)-1):sz(1))',[1,sz2(2),sz2(3)]),repmat(zarray2,[sz2(1),sz2(2),1]),'spline');
%         clear image1
        if ~isempty(contsinfo{handles.target(n)})
             for p = 1:length(contsinfo{handles.target(n)}{1})
                cont = getRTOGcont3(contsinfo{handles.target(n)}{1}{p},contsinfo{handles.target(n)}{2}{p},limits(n,:),handles.reg_params{8},contsinfo{handles.target(n)}{3}{p});
%                 cont = cont(:,:,limits(n,5):limits(n,6));
                image1 = image1+cont;
                image1(image1 == 2) = 1; %clean up overlaps
              end
            clear cont;
        end
        if ~isempty(fpoints1) && ~isempty(fpoints2)
        fpoints1(:,2) = (fpoints1(:,2)).*(sz2(1)-1)./(sz(1)-1); fpoints2(:,2) = (fpoints2(:,2)).*(sz2(1)-1)./(sz(1)-1);
        fpoints1(:,1) = (fpoints1(:,1)).*(sz2(2)-1)./(sz(2)-1); fpoints2(:,1) = (fpoints2(:,1)).*(sz2(2)-1)./(sz(2)-1);
        fpoints1(:,3) = (fpoints1(:,3)).*(sz2(3)-1)./(sz(3)-1); fpoints2(:,3) = (fpoints2(:,3)).*(sz2(3)-1)./(sz(3)-1);
        end
        
        [dimage,dgridx,dgridy,dgridz] = imdeform3D(image2,image1,handles.reg_params{3},handles.reg_params{4},handles.reg_params{5},handles.reg_params{1},handles.reg_params{2},fpoints2,fpoints1,handles.reg_params{6},handles.reg_params{7});
        clear dimage;
        save([handles.parentdir '\' strrep(handles.imgfiles{handles.references(n)},'temp', ['to_' handles.filenames{handles.target} '_deform'])],'dgridx','dgridy','dgridz','lim');
        clear dgridx dgridy dgridz image1 image2
    end
end
close(h);
% --- Executes on button press in auto_seg.
function auto_seg_Callback(hObject, eventdata, handles)
% hObject    handle to auto_seg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
autos = auto_segmentation;
waitfor(autos);
handles.values = getappdata(0,'autos');
guidata(hObject,handles);


% --- Executes on mouse press over axes background.
function axis_1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axis_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
if handles.selmode == 1 && length(handles.filenames) >= 1
    set(handles.axis_1, 'NextPlot','Add');
    rectangle('Position',[2,3,98,96],'Parent',handles.axis_1,'EdgeColor','g','LineStyle','-','LineWidth',4);
    rep = find(handles.references == 1);
    if isempty(rep)
        handles.references = [handles.references; 1];
    else
        handles.references(rep) = [];
        image(handles.thumbs(:,:,1),'CDataMapping','scaled','Parent',handles.axis_1,'ButtonDownFcn', @axis_1_ButtonDownFcn);
        set(handles.axis_1 ,'XTick',[],'YTick',[],'XTickLabel','','YTickLabel','');
        colormap bone
    end
    
elseif handles.selmode == 2 && length(handles.filenames) >= 1
set(handles.axis_1, 'NextPlot','Add');
rectangle('Position',[2,3,98,96],'Parent',handles.axis_1,'EdgeColor','r','LineStyle','-','LineWidth',4);
if isempty(handles.target)
    rep = find(handles.references == 1);
    if ~isempty(rep)
          handles.references(rep) = [];
    end
handles.target = 1;
else
     rep = find(handles.references == 1);
    if ~isempty(rep)
          handles.references(rep) = [];
    end
    eval(sprintf(['image(handles.thumbs(:,:,' num2str(handles.target) '),''CDataMapping'',''scaled'',''Parent'',handles.axis_' num2str(handles.target) ',''ButtonDownFcn'', @axis_' num2str(handles.target) '_ButtonDownFcn)']));
    eval(sprintf(['set(handles.axis_' num2str(handles.target) ',''XTick'',[],''YTick'',[],''XTickLabel'','''',''YTickLabel'','''');']));
    colormap bone
    handles.target = 1;
end
end
guidata(hObject,handles);

% --- Executes on mouse press over axes background.
function axis_2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axis_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
if handles.selmode == 1 && length(handles.filenames) >= 2
    set(handles.axis_2, 'NextPlot','Add');
    rectangle('Position',[2,3,98,96],'Parent',handles.axis_2,'EdgeColor','g','LineStyle','-','LineWidth',4);
    rep = find(handles.references == 2);
    if isempty(rep)
        handles.references = [handles.references; 2];
    else
        handles.references(rep) = [];
        image(handles.thumbs(:,:,2),'CDataMapping','scaled','Parent',handles.axis_2,'ButtonDownFcn', @axis_2_ButtonDownFcn);
        set(handles.axis_2 ,'XTick',[],'YTick',[],'XTickLabel','','YTickLabel','');
        colormap bone
    end
    
elseif handles.selmode == 2 && length(handles.filenames) >= 2
set(handles.axis_2, 'NextPlot','Add');
rectangle('Position',[2,3,98,96],'Parent',handles.axis_2,'EdgeColor','r','LineStyle','-','LineWidth',4);
if isempty(handles.target)
    rep = find(handles.references == 2);
    if ~isempty(rep)
          handles.references(rep) = [];
    end
handles.target = 2;
else
     rep = find(handles.references == 2);
    if ~isempty(rep)
          handles.references(rep) = [];
    end
    eval(sprintf(['image(handles.thumbs(:,:,' num2str(handles.target) '),''CDataMapping'',''scaled'',''Parent'',handles.axis_' num2str(handles.target) ',''ButtonDownFcn'', @axis_' num2str(handles.target) '_ButtonDownFcn)']));
    eval(sprintf(['set(handles.axis_' num2str(handles.target) ',''XTick'',[],''YTick'',[],''XTickLabel'','''',''YTickLabel'','''');']));
    colormap bone
    handles.target = 2;
end
end
guidata(hObject,handles);

% --- Executes on mouse press over axes background.
function axis_3_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axis_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
if handles.selmode == 1 && length(handles.filenames) >= 3
    set(handles.axis_3, 'NextPlot','Add');
    rectangle('Position',[2,3,98,96],'Parent',handles.axis_3,'EdgeColor','g','LineStyle','-','LineWidth',4);
    rep = find(handles.references == 3);
    if isempty(rep)
        handles.references = [handles.references; 3];
    else
        handles.references(rep) = [];
        image(handles.thumbs(:,:,3),'CDataMapping','scaled','Parent',handles.axis_3,'ButtonDownFcn', @axis_3_ButtonDownFcn);
        set(handles.axis_3 ,'XTick',[],'YTick',[],'XTickLabel','','YTickLabel','');
        colormap bone
    end
    
elseif handles.selmode == 2 && length(handles.filenames) >= 3
set(handles.axis_3, 'NextPlot','Add');
rectangle('Position',[2,3,98,96],'Parent',handles.axis_3,'EdgeColor','r','LineStyle','-','LineWidth',4);
    if isempty(handles.target)
        rep = find(handles.references == 3);
        if ~isempty(rep)
              handles.references(rep) = [];
        end
    handles.target = 3;
    else
         rep = find(handles.references == 3);
        if ~isempty(rep)
              handles.references(rep) = [];
        end
        eval(sprintf(['image(handles.thumbs(:,:,' num2str(handles.target) '),''CDataMapping'',''scaled'',''Parent'',handles.axis_' num2str(handles.target) ',''ButtonDownFcn'', @axis_' num2str(handles.target) '_ButtonDownFcn)']));
        eval(sprintf(['set(handles.axis_' num2str(handles.target) ',''XTick'',[],''YTick'',[],''XTickLabel'','''',''YTickLabel'','''');']));
        colormap bone
        handles.target = 3;
    end
end
guidata(hObject,handles);

% --- Executes on mouse press over axes background.
function axis_4_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axis_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
if handles.selmode == 1 && length(handles.filenames) >= 4
    set(handles.axis_4, 'NextPlot','Add');
    rectangle('Position',[2,3,98,96],'Parent',handles.axis_4,'EdgeColor','g','LineStyle','-','LineWidth',4);
    rep = find(handles.references == 4);
    if isempty(rep)
        handles.references = [handles.references; 4];
    else
        handles.references(rep) = [];
        image(handles.thumbs(:,:,4),'CDataMapping','scaled','Parent',handles.axis_4,'ButtonDownFcn', @axis_4_ButtonDownFcn);
        set(handles.axis_4 ,'XTick',[],'YTick',[],'XTickLabel','','YTickLabel','');
        colormap bone
    end
    
elseif handles.selmode == 2 && length(handles.filenames) >= 4
set(handles.axis_4, 'NextPlot','Add');
rectangle('Position',[2,3,98,96],'Parent',handles.axis_4,'EdgeColor','r','LineStyle','-','LineWidth',4);
if isempty(handles.target)
    rep = find(handles.references == 4);
    if ~isempty(rep)
          handles.references(rep) = [];
    end
handles.target = 4;
else
     rep = find(handles.references == 4);
    if ~isempty(rep)
          handles.references(rep) = [];
    end
    eval(sprintf(['image(handles.thumbs(:,:,' num2str(handles.target) '),''CDataMapping'',''scaled'',''Parent'',handles.axis_' num2str(handles.target) ',''ButtonDownFcn'', @axis_' num2str(handles.target) '_ButtonDownFcn)']));
    eval(sprintf(['set(handles.axis_' num2str(handles.target) ',''XTick'',[],''YTick'',[],''XTickLabel'','''',''YTickLabel'','''');']));
    colormap bone
    handles.target = 4;
end
end
guidata(hObject,handles);

% --- Executes on mouse press over axes background.
function axis_5_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axis_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
if handles.selmode == 1&& length(handles.filenames) >= 5
    set(handles.axis_5, 'NextPlot','Add');
    rectangle('Position',[2,3,98,96],'Parent',handles.axis_5,'EdgeColor','g','LineStyle','-','LineWidth',4);
    rep = find(handles.references == 5);
    if isempty(rep)
        handles.references = [handles.references; 5];
    else
        handles.references(rep) = [];
        image(handles.thumbs(:,:,5),'CDataMapping','scaled','Parent',handles.axis_5,'ButtonDownFcn', @axis_5_ButtonDownFcn);
        set(handles.axis_5 ,'XTick',[],'YTick',[],'XTickLabel','','YTickLabel','');
        colormap bone
    end
    
elseif handles.selmode == 2 && length(handles.filenames) >= 5
set(handles.axis_5, 'NextPlot','Add');
rectangle('Position',[2,3,98,96],'Parent',handles.axis_5,'EdgeColor','r','LineStyle','-','LineWidth',4);
if isempty(handles.target)
    rep = find(handles.references == 5);
    if ~isempty(rep)
          handles.references(rep) = [];
    end
handles.target = 5;
else
     rep = find(handles.references == 5);
    if ~isempty(rep)
          handles.references(rep) = [];
    end
    eval(sprintf(['image(handles.thumbs(:,:,' num2str(handles.target) '),''CDataMapping'',''scaled'',''Parent'',handles.axis_' num2str(handles.target) ',''ButtonDownFcn'', @axis_' num2str(handles.target) '_ButtonDownFcn)']));
    eval(sprintf(['set(handles.axis_' num2str(handles.target) ',''XTick'',[],''YTick'',[],''XTickLabel'','''',''YTickLabel'','''');']));
    colormap bone
    handles.target = 5;
end
end
guidata(hObject,handles);
% --- Executes on mouse press over axes background.
function axis_6_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axis_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
if handles.selmode == 1 && length(handles.filenames) >= 6
    set(handles.axis_6, 'NextPlot','Add');
    rectangle('Position',[2,3,98,96],'Parent',handles.axis_6,'EdgeColor','g','LineStyle','-','LineWidth',4);
    rep = find(handles.references == 6);
    if isempty(rep)
        handles.references = [handles.references; 6];
    else
        handles.references(rep) = [];
        image(handles.thumbs(:,:,6),'CDataMapping','scaled','Parent',handles.axis_6,'ButtonDownFcn', @axis_6_ButtonDownFcn);
        set(handles.axis_6 ,'XTick',[],'YTick',[],'XTickLabel','','YTickLabel','');
        colormap bone
    end
    
elseif handles.selmode == 2 && length(handles.filenames) >= 6
set(handles.axis_6, 'NextPlot','Add');
rectangle('Position',[2,3,98,96],'Parent',handles.axis_6,'EdgeColor','r','LineStyle','-','LineWidth',4);
if isempty(handles.target)
    rep = find(handles.references == 6);
    if ~isempty(rep)
          handles.references(rep) = [];
    end
handles.target = 6;
else
     rep = find(handles.references == 6);
    if ~isempty(rep)
          handles.references(rep) = [];
    end
    eval(sprintf(['image(handles.thumbs(:,:,' num2str(handles.target) '),''CDataMapping'',''scaled'',''Parent'',handles.axis_' num2str(handles.target) ',''ButtonDownFcn'', @axis_' num2str(handles.target) '_ButtonDownFcn)']));
    eval(sprintf(['set(handles.axis_' num2str(handles.target) ',''XTick'',[],''YTick'',[],''XTickLabel'','''',''YTickLabel'','''');']));
    colormap bone
    handles.target = 6;
end
end
guidata(hObject,handles);


% --- Executes on mouse press over axes background.
function axis_7_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axis_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
if handles.selmode == 1 && length(handles.filenames) >= 7
    set(handles.axis_7, 'NextPlot','Add');
    rectangle('Position',[2,3,98,96],'Parent',handles.axis_7,'EdgeColor','g','LineStyle','-','LineWidth',4);
    rep = find(handles.references == 7);
    if isempty(rep)
        handles.references = [handles.references; 7];
    else
        handles.references(rep) = [];
        image(handles.thumbs(:,:,7),'CDataMapping','scaled','Parent',handles.axis_7,'ButtonDownFcn', @axis_7_ButtonDownFcn);
        set(handles.axis_7 ,'XTick',[],'YTick',[],'XTickLabel','','YTickLabel','');
        colormap bone
    end
    
elseif handles.selmode == 2 && length(handles.filenames) >= 7
set(handles.axis_7, 'NextPlot','Add');
rectangle('Position',[2,3,98,96],'Parent',handles.axis_7,'EdgeColor','r','LineStyle','-','LineWidth',4);
if isempty(handles.target)
    rep = find(handles.references == 7);
    if ~isempty(rep)
          handles.references(rep) = [];
    end
handles.target = 7;
else
     rep = find(handles.references == 7);
    if ~isempty(rep)
          handles.references(rep) = [];
    end
    eval(sprintf(['image(handles.thumbs(:,:,' num2str(handles.target) '),''CDataMapping'',''scaled'',''Parent'',handles.axis_' num2str(handles.target) ',''ButtonDownFcn'', @axis_' num2str(handles.target) '_ButtonDownFcn)']));
    eval(sprintf(['set(handles.axis_' num2str(handles.target) ',''XTick'',[],''YTick'',[],''XTickLabel'','''',''YTickLabel'','''');']));
    colormap bone
    handles.target = 7;
end
end
guidata(hObject,handles);

% --- Executes on mouse press over axes background.
function axis_8_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axis_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
if handles.selmode == 1 && length(handles.filenames) >= 8
    set(handles.axis_8, 'NextPlot','Add');
    rectangle('Position',[2,3,98,96],'Parent',handles.axis_8,'EdgeColor','g','LineStyle','-','LineWidth',4);
    rep = find(handles.references == 8);
    if isempty(rep)
        handles.references = [handles.references; 8];
    else
        handles.references(rep) = [];
        image(handles.thumbs(:,:,8),'CDataMapping','scaled','Parent',handles.axis_8,'ButtonDownFcn', @axis_8_ButtonDownFcn);
        set(handles.axis_8 ,'XTick',[],'YTick',[],'XTickLabel','','YTickLabel','');
        colormap bone
    end
    
elseif handles.selmode == 2 && length(handles.filenames) >= 8
set(handles.axis_8, 'NextPlot','Add');
rectangle('Position',[2,3,98,96],'Parent',handles.axis_8,'EdgeColor','r','LineStyle','-','LineWidth',4);
if isempty(handles.target)
    rep = find(handles.references == 8);
    if ~isempty(rep)
          handles.references(rep) = [];
    end
handles.target = 8;
else
     rep = find(handles.references == 8);
    if ~isempty(rep)
          handles.references(rep) = [];
    end
    eval(sprintf(['image(handles.thumbs(:,:,' num2str(handles.target) '),''CDataMapping'',''scaled'',''Parent'',handles.axis_' num2str(handles.target) ',''ButtonDownFcn'', @axis_' num2str(handles.target) '_ButtonDownFcn)']));
    eval(sprintf(['set(handles.axis_' num2str(handles.target) ',''XTick'',[],''YTick'',[],''XTickLabel'','''',''YTickLabel'','''');']));
    colormap bone
    handles.target = 8;
end
end
guidata(hObject,handles);


% --- Executes on mouse press over axes background.
function axis_9_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axis_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
if handles.selmode == 1 && length(handles.filenames) >= 9
    set(handles.axis_9, 'NextPlot','Add');
    rectangle('Position',[2,3,98,96],'Parent',handles.axis_9,'EdgeColor','g','LineStyle','-','LineWidth',4);
    rep = find(handles.references == 9);
    if isempty(rep)
        handles.references = [handles.references; 9];
    else
        handles.references(rep) = [];
        image(handles.thumbs(:,:,9),'CDataMapping','scaled','Parent',handles.axis_9,'ButtonDownFcn', @axis_9_ButtonDownFcn);
        set(handles.axis_9 ,'XTick',[],'YTick',[],'XTickLabel','','YTickLabel','');
        colormap bone
    end
    
elseif handles.selmode == 2 && length(handles.filenames) >= 9
set(handles.axis_9, 'NextPlot','Add');
rectangle('Position',[2,3,98,96],'Parent',handles.axis_9,'EdgeColor','r','LineStyle','-','LineWidth',4);
if isempty(handles.target)
    rep = find(handles.references == 9);
    if ~isempty(rep)
          handles.references(rep) = [];
    end
handles.target = 9;
else
     rep = find(handles.references == 9);
    if ~isempty(rep)
          handles.references(rep) = [];
    end
    eval(sprintf(['image(handles.thumbs(:,:,' num2str(handles.target) '),''CDataMapping'',''scaled'',''Parent'',handles.axis_' num2str(handles.target) ',''ButtonDownFcn'', @axis_' num2str(handles.target) '_ButtonDownFcn)']));
    eval(sprintf(['set(handles.axis_' num2str(handles.target) ',''XTick'',[],''YTick'',[],''XTickLabel'','''',''YTickLabel'','''');']));
    colormap bone
    handles.target = 9;
end
end
guidata(hObject,handles);

% --- Executes on mouse press over axes background.
function axis_10_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axis_10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
if handles.selmode == 1 && length(handles.filenames) >= 10
    set(handles.axis_10, 'NextPlot','Add');
    rectangle('Position',[2,3,98,96],'Parent',handles.axis_10,'EdgeColor','g','LineStyle','-','LineWidth',4);
    rep = find(handles.references == 10);
    if isempty(rep)
        handles.references = [handles.references; 10];
    else
        handles.references(rep) = [];
        image(handles.thumbs(:,:,10),'CDataMapping','scaled','Parent',handles.axis_10,'ButtonDownFcn', @axis_10_ButtonDownFcn);
        set(handles.axis_10 ,'XTick',[],'YTick',[],'XTickLabel','','YTickLabel','');
        colormap bone
    end
    
elseif handles.selmode == 2 && length(handles.filenames) >= 10
set(handles.axis_10, 'NextPlot','Add');
rectangle('Position',[2,3,98,96],'Parent',handles.axis_10,'EdgeColor','r','LineStyle','-','LineWidth',4);
if isempty(handles.target)
    rep = find(handles.references == 10);
    if ~isempty(rep)
          handles.references(rep) = [];
    end
handles.target = 10;
else
     rep = find(handles.references == 10);
    if ~isempty(rep)
          handles.references(rep) = [];
    end
    eval(sprintf(['image(handles.thumbs(:,:,' num2str(handles.target) '),''CDataMapping'',''scaled'',''Parent'',handles.axis_' num2str(handles.target) ',''ButtonDownFcn'', @axis_' num2str(handles.target) '_ButtonDownFcn)']));
    eval(sprintf(['set(handles.axis_' num2str(handles.target) ',''XTick'',[],''YTick'',[],''XTickLabel'','''',''YTickLabel'','''');']));
    colormap bone
    handles.target = 10;
end
end
guidata(hObject,handles);
