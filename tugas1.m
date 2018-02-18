function varargout = tugas1(varargin)
% TUGAS1 MATLAB code for tugas1.fig
%      TUGAS1, by itself, creates a new TUGAS1 or raises the existing
%      singleton*.
%
%      H = TUGAS1 returns the handle to a new TUGAS1 or the handle to
%      the existing singleton*.
%
%      TUGAS1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TUGAS1.M with the given input arguments.
%
%      TUGAS1('Property','Value',...) creates a new TUGAS1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tugas1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tugas1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tugas1

% Last Modified by GUIDE v2.5 16-Feb-2018 13:50:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tugas1_OpeningFcn, ...
                   'gui_OutputFcn',  @tugas1_OutputFcn, ...
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


% --- Executes just before tugas1 is made visible.
function tugas1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tugas1 (see VARARGIN)

% Choose default command line output for tugas1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tugas1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = tugas1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in search.
function search_Callback(hObject, eventdata, handles)
% hObject    handle to search (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
[file,path] = uigetfile({'*.jpg;*.png'},'cari image');
img = imread([path file]);
guidata(hObject,handles);
axes(handles.axes1);
set(handles.resolusi, 'String', showResolusi(img));
imshow(img);


% --- Executes on button press in grayscaleButton.
function grayscaleButton_Callback(hObject, eventdata, handles)
% hObject    handle to grayscaleButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes1);
RED = image(:,:,1);
GREEN = image(:,:,2);
BLUE = image(:,:,3);
gray = 0.4*RED + 0.4*GREEN + 0.2*BLUE;
guidata(hObject,handles);
axes(handles.axes1);

imshow(gray);



% --- Executes on button press in zoominButton.
function zoominButton_Callback(hObject, eventdata, handles)
% hObject    handle to zoominButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes1);
% rows = size(image,1);
% cols = size(image,2);
% out = zeros(2*rows, 2*cols, size(image,3));
% out(1:2:end,1:2:end,:) = image; %// Left
% out(2:2:end,1:2:end,:) = image; %// Bottom
% out(1:2:end,2:2:end,:) = image; %// Right
% out(2:2:end,2:2:end,:) = image; %// Bottom-Right
row = 2*size(image,1);
column = 2*size(image,2);
newImage = zeros(row, column, 3);
m = 1; n = 1;
for i = 1:size(image,1)
    for j = 1:size(image,2)
        newImage(m,n,:) = image(i,j,:);
        newImage(m,n+1,:) = image(i,j,:);
        newImage(m+1,n,:) = image(i,j,:);
        newImage(m+1,n+1,:) = image(i,j,:);
        n = n+2;
    end
    m = m+2;
    n = 1;    
end
newImage = uint8(newImage);
guidata(hObject,handles);
set(handles.resolusi, 'String', showResolusi(newImage));
figure, imshow(newImage);

% --- Executes on button press in zoomoutButton.
function zoomoutButton_Callback(hObject, eventdata, handles)
% hObject    handle to zoomoutButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes1);
newImage = zeros(round(size(image,1)/2), round(size(image,2)/2), 3);
m = 1; n = 1;
for i = 1:size(newImage,1)
    for j = 1:size(newImage,2)
        newImage(i,j,:) = image(m,n,:);
        n = round(n+2);
    end
    m = round(m+2);
    n = 1;
end
newImage = uint8(newImage);
guidata(hObject,handles);
set(handles.resolusi, 'String', showResolusi(newImage));
figure, imshow(newImage);


% --- Executes on button press in inverseButton.
function inverseButton_Callback(hObject, eventdata, handles)
% hObject    handle to inverseButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes1);
hasil(:,:,:) = 255-image(:,:,:);
guidata(hObject,handles);
axes(handles.axes1);
imshow(hasil);


% --- Executes on button press in crop.
function crop_Callback(hObject, eventdata, handles)
% hObject    handle to crop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes1);
newRow = round(size(image,1)/2);
newColumn = round(size(image,2)/2);
row = newRow./2;
column = newColumn./2;
img = zeros(newRow,newColumn,3);
img = image(round(row):(newRow+round(row)),round(column):(newColumn+round(column)),:);
set(handles.resolusi, 'String', showResolusi(img));
imshow(img);


% --- Executes on button press in BrightnessSum.
function BrightnessSum_Callback(hObject, eventdata, handles)
% hObject    handle to BrightnessSum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes1);
hasil(:,:,:) = 30+image(:,:,:);
guidata(hObject,handles);
axes(handles.axes1);
imshow(hasil);


% --- Executes on button press in BrightnessTimes.
function BrightnessTimes_Callback(hObject, eventdata, handles)
% hObject    handle to BrightnessTimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes1);
hasil(:,:,:) = 3*image(:,:,:);
guidata(hObject,handles);
axes(handles.axes1);
imshow(hasil);


% --- Executes on button press in GelapSubs.
function GelapSubs_Callback(hObject, eventdata, handles)
% hObject    handle to GelapSubs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes1);
hasil(:,:,:) = image(:,:,:)-30;
guidata(hObject,handles);
axes(handles.axes1);
imshow(hasil);

% --- Executes on button press in GelapDiv.
function GelapDiv_Callback(hObject, eventdata, handles)
% hObject    handle to GelapDiv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes1);
hasil(:,:,:) = image(:,:,:)/3;
guidata(hObject,handles);
axes(handles.axes1);
imshow(hasil);


% --- Executes on button press in flipVertical.
function flipVertical_Callback(hObject, eventdata, handles)
% hObject    handle to flipVertical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes1);
hasil(:,:,:) = image(:,:,:);
m =1; n=1;
for i=size(image,1):-1:1
    for j=size(image,2):-1:1
        hasil(m,n,:) = image(i,j,:);
        n = n+1;
    end
    m=m+1;
    n=1;
end
hasil = uint8(hasil);
guidata(hObject,handles);
axes(handles.axes1);
imshow(hasil);


% --- Executes on button press in flipHorizontal.
function flipHorizontal_Callback(hObject, eventdata, handles)
% hObject    handle to flipHorizontal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes1);
hasil(:,:,:) = image(:,:,:);
m =1; n=1;
for i=1:size(image,1)
    for j=size(image,2):-1:1
        hasil(m,n,:) = image(i,j,:);
        n = n+1;
    end
    m=m+1;
    n=1;
end
hasil = uint8(hasil);
guidata(hObject,handles);
axes(handles.axes1);
imshow(hasil);

% --- Executes on button press in rotate.
function rotate_Callback(hObject, eventdata, handles)
% hObject    handle to rotate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes1);
hasil = zeros(size(image,2),size(image,1),3);
for i= 1:size(image,2);
    for j=1:size(image,1);
        hasil(i,j,:) = image(j,i,:);
    end
end
hasil = uint8(hasil);
guidata(hObject,handles);
axes(handles.axes1);
set(handles.resolusi, 'String', showResolusi(hasil));
imshow(hasil);