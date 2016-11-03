function varargout = AFinalDemo(varargin)
% AFINALDEMO MATLAB code for AFinalDemo.fig
%      AFINALDEMO, by itself, creates a new AFINALDEMO or raises the existing
%      singleton*.
%
%      H = AFINALDEMO returns the handle to a new AFINALDEMO or the handle to
%      the existing singleton*.
%
%      AFINALDEMO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AFINALDEMO.M with the given input arguments.
%
%      AFINALDEMO('Property','Value',...) creates a new AFINALDEMO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AFinalDemo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AFinalDemo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AFinalDemo

% Last Modified by GUIDE v2.5 24-Oct-2016 23:23:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AFinalDemo_OpeningFcn, ...
                   'gui_OutputFcn',  @AFinalDemo_OutputFcn, ...
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


% --- Executes just before AFinalDemo is made visible.
function AFinalDemo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AFinalDemo (see VARARGIN)

% Choose default command line output for AFinalDemo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AFinalDemo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AFinalDemo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_start.
function pushbutton_start_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
global x_record
set(handles.text9,'String',' ');
set(handles.text11,'String',' ');
a=0:0;
plot(a)
axis([0 1 -1 1])
s1 = str2double(get(handles.edit1,'String'));   %读取录音时长
%显示录音状态
set(handles.text13,'String','正在录音...');
recObj = audiorecorder(16000,16,1);
disp('Start speaking.')
recordblocking(recObj, s1);
disp('End of Recording.');
set(handles.text13,'String',' ');
% 获取录音数据
x_record = getaudiodata(recObj);
% save('record.mat','x_record')
% 绘制录音数据波形
plot(x_record/max(x_record));
axis([0 16000*s1 -1 1])


% --- Executes on button press in pushbutton_exist.
function pushbutton_exist_Callback(hObject, eventdata, handles)
button = questdlg('是否退出语音识别系统？','提示','是','否','否');
if strcmp(button,'是');
   close all;
end

% hObject    handle to pushbutton_exist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_show.
function pushbutton_show_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_result.
function pushbutton_result_Callback(hObject, eventdata, handles)
global x_record tim 
set(handles.text13,'String','正在处理，请稍候...');
% hObject    handle to pushbutton_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s2 = str2double(get(handles.edit5,'String'));
aa = demo_gui(x_record,s2);  %aa是个一行n列矩阵
ss=num2str(aa);
set(handles.text9,'String',ss);
tt=num2str(tim);
set(handles.text11,'String',tt);
set(handles.text13,'String',' ');


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton_exist.
function pushbutton_exist_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_exist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton_show.



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over text11.
function text11_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to text11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
