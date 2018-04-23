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

% Last Modified by GUIDE v2.5 23-Apr-2018 17:17:00

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
axes(handles.axes6);
set(handles.resolusi2, 'String', showResolusi(img));
imshow(img);

% --- Executes on button press in grayscaleButton.
function grayscaleButton_Callback(hObject, eventdata, handles)
% hObject    handle to grayscaleButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes6);
RED = image(:,:,1);
GREEN = image(:,:,2);
BLUE = image(:,:,3);
gray = 0.4*RED + 0.4*GREEN + 0.2*BLUE;
guidata(hObject,handles);
set(handles.resolusi2, 'String', showResolusi(gray));
axes(handles.axes6);
imshow(gray);



% --- Executes on button press in zoominButton.
function zoominButton_Callback(hObject, eventdata, handles)
% hObject    handle to zoominButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes6);
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
image = uint8(newImage);
guidata(hObject,handles);
set(handles.resolusi2, 'String', showResolusi(image));
axes(handles.axes6);
imshow(image);
figure, imshow(image);

% --- Executes on button press in zoomoutButton.
function zoomoutButton_Callback(hObject, eventdata, handles)
% hObject    handle to zoomoutButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes6);
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
image = uint8(newImage);
guidata(hObject,handles);
set(handles.resolusi2, 'String', showResolusi(image));
axes(handles.axes6);
imshow(image);
figure, imshow(image);


% --- Executes on button press in inverseButton.
function inverseButton_Callback(hObject, eventdata, handles)
% hObject    handle to inverseButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handlex.axes6);
image(:,:,:) = 255-image(:,:,:);
guidata(hObject,handles);
set(handles.resolusi2, 'String', showResolusi(image));
axes(handles.axes6);
imshow(image);


% --- Executes on button press in crop.
function crop_Callback(hObject, eventdata, handles)
% hObject    handle to crop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes6);
newRow = round(size(image,1)/2);
newColumn = round(size(image,2)/2);
row = newRow./2;
column = newColumn./2;
img = zeros(newRow,newColumn,3);
img = image(round(row):(newRow+round(row)),round(column):(newColumn+round(column)),:);
set(handles.resolusi2, 'String', showResolusi(img));
axes(handles.axes6);
imshow(img);


% --- Executes on button press in BrightnessSum.
function BrightnessSum_Callback(hObject, eventdata, handles)
% hObject    handle to BrightnessSum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes6);
x = get(handles.jumlah,'String');
y = str2num(x);
hasil(:,:,:) = y+image(:,:,:);
guidata(hObject,handles);
set(handles.resolusi2, 'String', showResolusi(hasil));
axes(handles.axes6);
imshow(hasil);


% --- Executes on button press in BrightnessTimes.
function BrightnessTimes_Callback(hObject, eventdata, handles)
% hObject    handle to BrightnessTimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes6);
x = get(handles.jumlah,'String');
y = str2num(x);
hasil(:,:,:) = y*image(:,:,:);
guidata(hObject,handles);
set(handles.resolusi2, 'String', showResolusi(hasil));
axes(handles.axes6);
imshow(hasil);


% --- Executes on button press in GelapSubs.
function GelapSubs_Callback(hObject, eventdata, handles)
% hObject    handle to GelapSubs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes6);
x = get(handles.jumlah,'String');
y = str2num(x);
hasil(:,:,:) = image(:,:,:)-y;
guidata(hObject,handles);
set(handles.resolusi2, 'String', showResolusi(hasil));
axes(handles.axes6);
imshow(hasil);

% --- Executes on button press in GelapDiv.
function GelapDiv_Callback(hObject, eventdata, handles)
% hObject    handle to GelapDiv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes6);
x = get(handles.jumlah,'String');
y = str2num(x);
hasil(:,:,:) = image(:,:,:)/y;
guidata(hObject,handles);
set(handles.resolusi2, 'String', showResolusi(hasil));
axes(handles.axes6);
imshow(hasil);


% --- Executes on button press in flipVertical.
function flipVertical_Callback(hObject, eventdata, handles)
% hObject    handle to flipVertical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes6);
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
set(handles.resolusi2, 'String', showResolusi(hasil));
axes(handles.axes6);
imshow(hasil);


% --- Executes on button press in flipHorizontal.
function flipHorizontal_Callback(hObject, eventdata, handles)
% hObject    handle to flipHorizontal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes6);
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
set(handles.resolusi2, 'String', showResolusi(hasil));
axes(handles.axes6);
imshow(hasil);

% --- Executes on button press in rotate.
function rotate_Callback(hObject, eventdata, handles)
% hObject    handle to rotate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes6);
hasil = zeros(size(image,2),size(image,1),3);
for i= 1:size(image,2);
    for j=1:size(image,1);
        hasil(i,j,:) = image(j,i,:);
    end
end
hasil = uint8(hasil);
guidata(hObject,handles);
set(handles.resolusi2, 'String', showResolusi(hasil));
axes(handles.axes6);
imshow(hasil);



function jumlah_Callback(hObject, eventdata, handles)
% hObject    handle to jumlah (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of jumlah as text
%        str2double(get(hObject,'String')) returns contents of jumlah as a double


% --- Executes during object creation, after setting all properties.
function jumlah_CreateFcn(hObject, eventdata, handles)
% hObject    handle to jumlah (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in histogram.
function histogram_Callback(hObject, eventdata, handles)
% hObject    handle to histogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes6);
hasilred = zeros(256,1);
hasilgreen = zeros(256,1);
hasilblue = zeros(256,1);
for i =1:size(image,1)
    for j = 1:size(image,2)
        x = image(i,j,1)+1;
        y = image(i,j,2)+1;
        z = image(i,j,3)+1;
        hasilred(x) = hasilred(x)+1;
        hasilgreen(y) = hasilgreen(y)+1;
        hasilblue(z) = hasilblue(z)+1;
    end
end

set(handles.resolusi2, 'String', showResolusi(image));
axes(handles.axes2);
plot(hasilred);
axes(handles.axes3);
plot(hasilgreen);
axes(handles.axes4);
plot(hasilblue);
axes(handles.axes6);
imshow(image);


% --- Executes on button press in rotasi180.
function rotasi180_Callback(hObject, eventdata, handles)
% hObject    handle to rotasi180 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes6);
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
set(handles.resolusi2, 'String', showResolusi(hasil));
axes(handles.axes6);
imshow(hasil);

% --- Executes on button press in rotasi90.
function rotasi90_Callback(hObject, eventdata, handles)
% hObject    handle to rotasi90 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes6);
hasil = zeros(size(image,2),size(image,1),3);

for i= 1:size(hasil,1)
    m = size(image,1);
    for j=1:size(hasil,2)
        hasil(i,j,:) = image(m,i,:);
        m =m-1;
    end
end
hasil = uint8(hasil);
guidata(hObject,handles);
set(handles.resolusi2, 'String', showResolusi(hasil));
axes(handles.axes6);
imshow(hasil);

% --- Executes on button press in rotasi270.
function rotasi270_Callback(hObject, eventdata, handles)
% hObject    handle to rotasi270 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes6);
hasil = zeros(size(image,2),size(image,1),3);

n = size(image,2);
for i= 1:size(hasil,1)
    m= 1;
    for j=1:size(hasil,2)
        hasil(i,j,:) = image(m,n,:);
        m = m+1;
    end
    n= n-1;
end
hasil = uint8(hasil);
guidata(hObject,handles);
set(handles.resolusi2, 'String', showResolusi(hasil));
axes(handles.axes6);
imshow(hasil);


% --- Executes on button press in blurring.
function blurring_Callback(hObject, eventdata, handles)
% hObject    handle to blurring (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes6);
[n l m] = size(image);
x = 1/9;
Mask = [x x x; x x x; x x x];
img = zeros(n+2, l+2, m);
for i = 1:m
    for j = 1:n
        for k = 1:l
            img(j+1,k+1,i) = image(j,k,i);
        end
    end
end
newImage = zeros(n+2, l+2, m);
[k l m] = size(img);
for h=1:m
    for i=2:k-1
        for j=2:l-1
            newImage(i,j,h) = img(i-1,j-1,h)*Mask(1,1) + img(i-1,j,h)*Mask(1,2) + img(i-1,j+1,h)*Mask(1,3) + img(i,j-1,h)*Mask(2,1) + img(i,j,h)*Mask(2,2) + img(i,j+1,h)*Mask(2,3) + img(i+1,j-1,h)*Mask(3,1) + img(i+1,j,h)*Mask(3,2) + img(i+1,j+1,h)*Mask(3,3);
        end;
    end;
end;
newImage = uint8(newImage);
set(handles.resolusi2, 'String', showResolusi(newImage));
axes(handles.axes6);
imshow(newImage);


% --- Executes on button press in edgedetect.
function edgedetect_Callback(hObject, eventdata, handles)
% hObject    handle to edgedetect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes6);
[n l m] = size(image);
Mask = [0 1 0; 1 -4 1; 0 1 0];
img = zeros(n+2, l+2, m);
for i = 1:m
    for j = 1:n
        for k = 1:l
            img(j+1,k+1,i) = image(j,k,i);
        end
    end
end
newImage = zeros(n+2, l+2, m);
[k l m] = size(img);
for h=1:m
    for i=2:k-1
        for j=2:l-1
            newImage(i,j,h) = img(i-1,j-1,h)*Mask(1,1) + img(i-1,j,h)*Mask(1,2) + img(i-1,j+1,h)*Mask(1,3) + img(i,j-1,h)*Mask(2,1) + img(i,j,h)*Mask(2,2) + img(i,j+1,h)*Mask(2,3) + img(i+1,j-1,h)*Mask(3,1) + img(i+1,j,h)*Mask(3,2) + img(i+1,j+1,h)*Mask(3,3);
        end;
    end;
end;
newImage = uint8(newImage);
set(handles.resolusi2, 'String', showResolusi(newImage));
axes(handles.axes6);
imshow(newImage);


% --- Executes on button press in sharp.
function sharp_Callback(hObject, eventdata, handles)
% hObject    handle to sharp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes6);
[n l m] = size(image);
Mask = [0 -1 0; -1 5 -1; 0 -1 0];
img = zeros(n+2, l+2, m);
for i = 1:m
    for j = 1:n
        for k = 1:l
            img(j+1,k+1,i) = image(j,k,i);
        end
    end
end
newImage = zeros(n+2, l+2, m);
[k l m] = size(img);
for h=1:m
    for i=2:k-1
        for j=2:l-1
            newImage(i,j,h) = img(i-1,j-1,h)*Mask(1,1) + img(i-1,j,h)*Mask(1,2) + img(i-1,j+1,h)*Mask(1,3) + img(i,j-1,h)*Mask(2,1) + img(i,j,h)*Mask(2,2) + img(i,j+1,h)*Mask(2,3) + img(i+1,j-1,h)*Mask(3,1) + img(i+1,j,h)*Mask(3,2) + img(i+1,j+1,h)*Mask(3,3);
        end;
    end;
end;
newImage = uint8(newImage);
set(handles.resolusi2, 'String', showResolusi(newImage));
axes(handles.axes6);
imshow(newImage);



function m11_Callback(hObject, eventdata, handles)
% hObject    handle to m11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of m11 as text
%        str2double(get(hObject,'String')) returns contents of m11 as a double


% --- Executes during object creation, after setting all properties.
function m11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to m11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function m12_Callback(hObject, eventdata, handles)
% hObject    handle to m12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of m12 as text
%        str2double(get(hObject,'String')) returns contents of m12 as a double


% --- Executes during object creation, after setting all properties.
function m12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to m12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function m13_Callback(hObject, eventdata, handles)
% hObject    handle to m13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of m13 as text
%        str2double(get(hObject,'String')) returns contents of m13 as a double


% --- Executes during object creation, after setting all properties.
function m13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to m13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function m21_Callback(hObject, eventdata, handles)
% hObject    handle to m21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of m21 as text
%        str2double(get(hObject,'String')) returns contents of m21 as a double


% --- Executes during object creation, after setting all properties.
function m21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to m21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function m22_Callback(hObject, eventdata, handles)
% hObject    handle to m22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of m22 as text
%        str2double(get(hObject,'String')) returns contents of m22 as a double


% --- Executes during object creation, after setting all properties.
function m22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to m22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function m23_Callback(hObject, eventdata, handles)
% hObject    handle to m23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of m23 as text
%        str2double(get(hObject,'String')) returns contents of m23 as a double


% --- Executes during object creation, after setting all properties.
function m23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to m23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function m31_Callback(hObject, eventdata, handles)
% hObject    handle to m31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of m31 as text
%        str2double(get(hObject,'String')) returns contents of m31 as a double


% --- Executes during object creation, after setting all properties.
function m31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to m31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function m32_Callback(hObject, eventdata, handles)
% hObject    handle to m32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of m32 as text
%        str2double(get(hObject,'String')) returns contents of m32 as a double


% --- Executes during object creation, after setting all properties.
function m32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to m32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function m33_Callback(hObject, eventdata, handles)
% hObject    handle to m33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of m33 as text
%        str2double(get(hObject,'String')) returns contents of m33 as a double


% --- Executes during object creation, after setting all properties.
function m33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to m33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in konvolusi.
function konvolusi_Callback(hObject, eventdata, handles)
% hObject    handle to konvolusi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a = get(handles.m11,'String');
b11 = str2num(a);
a = get(handles.m12,'String');
b12 = str2num(a);
a = get(handles.m13,'String');
b13 = str2num(a);
a = get(handles.m21,'String');
b21 = str2num(a);
a = get(handles.m22,'String');
b22 = str2num(a);
a = get(handles.m23,'String');
b23 = str2num(a);
a = get(handles.m31,'String');
b31 = str2num(a);
a = get(handles.m32,'String');
b32 = str2num(a);
a = get(handles.m33,'String');
b33 = str2num(a);
Mask = [b11 b12 b13; b21 b22 b23; b31 b32 b33];
image = getimage(handles.axes6);
[n l m] = size(image);
img = zeros(n+2, l+2, m);
for i = 1:m
    for j = 1:n
        for k = 1:l
            img(j+1,k+1,i) = image(j,k,i);
        end
    end
end
newImage = zeros(n+2, l+2, m);
[k l m] = size(img);
for h=1:m
    for i=2:k-1
        for j=2:l-1
            newImage(i,j,h) = img(i-1,j-1,h)*Mask(1,1) + img(i-1,j,h)*Mask(1,2) + img(i-1,j+1,h)*Mask(1,3) + img(i,j-1,h)*Mask(2,1) + img(i,j,h)*Mask(2,2) + img(i,j+1,h)*Mask(2,3) + img(i+1,j-1,h)*Mask(3,1) + img(i+1,j,h)*Mask(3,2) + img(i+1,j+1,h)*Mask(3,3);
        end;
    end;
end;
newImage = uint8(newImage);
set(handles.resolusi2, 'String', showResolusi(newImage));
axes(handles.axes6);
imshow(newImage);


% --- Executes on button press in meanFiltering.
function meanFiltering_Callback(hObject, eventdata, handles)
% hObject    handle to meanFiltering (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = getimage(handles.axes6);
result = zeros(size(img));
[r g b] = size(result);

for i = 1:b
    for j = 2:r-1
        for k = 2:g-1
            A = [img(j-1,k-1,i); img(j-1,k,i); img(j-1,k+1,i); img(j,k-1,i); img(j,k,i); img(j,k+1,i); img(j+1,k-1,i); img(j+1,k,i); img(j+1,k+1,i)];
            result(j,k,i) = round(mean(A));
        end
    end
end
img = uint8(result);
set(handles.resolusi2, 'String', showResolusi(img));
axes(handles.axes6);
imshow(img);

% --- Executes on button press in medianFiltering.
function medianFiltering_Callback(hObject, eventdata, handles)
% hObject    handle to medianFiltering (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = getimage(handles.axes6);
result = zeros(size(img));
[r g b] = size(result);

for i = 1:b
    for j = 2:r-1
        for k = 2:g-1
            A = [img(j-1,k-1,i); img(j-1,k,i); img(j-1,k+1,i); img(j,k-1,i); img(j,k,i); img(j,k+1,i); img(j+1,k-1,i); img(j+1,k,i); img(j+1,k+1,i)];
            result(j,k,i) = round(median(A));
        end
    end
end
img = uint8(result);
set(handles.resolusi2, 'String', showResolusi(img));
axes(handles.axes6);
imshow(img);

% --- Executes on button press in modusFiltering.
function modusFiltering_Callback(hObject, eventdata, handles)
% hObject    handle to modusFiltering (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = getimage(handles.axes6);
result = zeros(size(img));
[r g b] = size(result);

for i = 1:b
    for j = 2:r-1
        for k = 2:g-1
            A = [img(j-1,k-1,i); img(j-1,k,i); img(j-1,k+1,i); img(j,k-1,i); img(j,k,i); img(j,k+1,i); img(j+1,k-1,i); img(j+1,k,i); img(j+1,k+1,i)];
            result(j,k,i) = mode(A);
        end
    end
end
img = uint8(result);
set(handles.resolusi2, 'String', showResolusi(img));
axes(handles.axes6);
imshow(img);
% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes1);
set(handles.resolusi2, 'String', showResolusi(image));
axes(handles.axes6);
imshow(image);


% --- Executes on button press in segmentasi.
function segmentasi_Callback(hObject, eventdata, handles)
% hObject    handle to segmentasi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I = getimage(handles.axes6);
x = get(handles.popupmenu4,'Value');
putih = uint8(zeros(size(I)));
biru = uint8(zeros(size(I)));
kuning = uint8(zeros(size(I)));
merah = uint8(zeros(size(I)));
Hijau = uint8(zeros(size(I)));
Orange = uint8(zeros(size(I)));
Ungu = uint8(zeros(size(I)));
Coklat = uint8(zeros(size(I)));
for i = 1:size(I,1)
    for j = 1:size(I,2)
        if ((I(i,j,1) <= 75) && (I(i,j,2) <= 115) && (I(i,j,3) >= 140))
            biru(i,j,:) = I(i,j,:);
        end
        if ((I(i,j,1) >= 130) && (I(i,j,2) <= 80) && (I(i,j,3) <= 80))
            merah(i,j,:) = I(i,j,:);
        end
        if ((I(i,j,1) >= 200) && (I(i,j,2) >= 200)&& (I(i,j,3) <= 50))
            kuning(i,j,:) = I(i,j,:);
        end
        if ((I(i,j,1) >= 210) && (I(i,j,2) >= 210) && (I(i,j,3) >= 210))
            putih(i,j,:) = I(i,j,:);
        end
        if ((I(i,j,1) <= 80) && (I(i,j,2) >= 200) && (I(i,j,3) <= 80))
            Hijau(i,j,:) = I(i,j,:);
        end
        if ((I(i,j,1) >= 175) && (I(i,j,2) >= 70) && (I(i,j,2) <= 130) && (I(i,j,3) <= 40))
            Orange(i,j,:) = I(i,j,:);
        end
        if ((I(i,j,1) >= 175) && (I(i,j,1) <= 230) && (I(i,j,2) >= 70) && (I(i,j,2) <= 130) && (I(i,j,3) >= 175) && (I(i,j,3) <= 230))
            Ungu(i,j,:) = I(i,j,:);
        end
        if ((I(i,j,1) >= 120) && (I(i,j,1) <= 180) && (I(i,j,2) >= 70) && (I(i,j,2) <= 130) && (I(i,j,3) >= 25) && (I(i,j,3) <= 80))
           Coklat(i,j,:) = I(i,j,:);
        end
    end
end

switch x
    case 1
        I = putih;
    case 2
        I = biru;
    case 3
        I = kuning;
    case 4
        I = merah;
    case 5
        I = Hijau;
    case 6
        I = Orange;
    case 7
        I = Ungu;
    case 8
        I = Coklat;
end
set(handles.resolusi2, 'String', showResolusi(I));
axes(handles.axes6);
imshow(I);


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in dilation.
function dilation_Callback(hObject, eventdata, handles)
% hObject    handle to dilation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = getimage(handles.axes6);
image = zeros(size(img));
MASK=zeros(size(img,1)+2,size(img,2)+2,size(img,3));
MASK(2:size(MASK,1)-1,2:size(MASK,2)-1,:)=img;
for i=1:size(MASK,3)
    for j=2:size(MASK,1)-1
        for k=2:size(MASK,2)-1
            image(j-1,k-1,i)=max(max(MASK(j-1:j+1,k-1:k+1,i)));
        end
    end
end
image=uint8(image);
set(handles.resolusi2, 'String', showResolusi(image));
axes(handles.axes6);
imshow(image);

% --- Executes on button press in erotion.
function erotion_Callback(hObject, eventdata, handles)
% hObject    handle to erotion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = getimage(handles.axes6);
image = zeros(size(img));
MASK=zeros(size(img,1)+2,size(img,2)+2,size(img,3));
MASK(2:size(MASK,1)-1,2:size(MASK,2)-1,:)=img;
for i=1:size(MASK,3)
    for j=2:size(MASK,1)-1
        for k=2:size(MASK,2)-1
            image(j-1,k-1,i)=min(min(MASK(j-1:j+1,k-1:k+1,i)));
        end
    end
end
image=uint8(image);
set(handles.resolusi2, 'String', showResolusi(image));
axes(handles.axes6);
imshow(image);