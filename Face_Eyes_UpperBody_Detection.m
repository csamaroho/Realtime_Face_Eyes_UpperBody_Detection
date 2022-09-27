function varargout = Face_Eyes_UpperBody_Detection(varargin)
% FACE_EYES_UPPERBODY_DETECTION MATLAB code for Face_Eyes_UpperBody_Detection.fig
%      FACE_EYES_UPPERBODY_DETECTION, by itself, creates a new FACE_EYES_UPPERBODY_DETECTION or raises the existing
%      singleton*.
%
%      H = FACE_EYES_UPPERBODY_DETECTION returns the handle to a new FACE_EYES_UPPERBODY_DETECTION or the handle to
%      the existing singleton*.
%
%      FACE_EYES_UPPERBODY_DETECTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FACE_EYES_UPPERBODY_DETECTION.M with the given input arguments.
%
%      FACE_EYES_UPPERBODY_DETECTION('Property','Value',...) creates a new FACE_EYES_UPPERBODY_DETECTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Face_Eyes_UpperBody_Detection_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Face_Eyes_UpperBody_Detection_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Face_Eyes_UpperBody_Detection

% Last Modified by GUIDE v2.5 27-Sep-2022 18:05:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Face_Eyes_UpperBody_Detection_OpeningFcn, ...
                   'gui_OutputFcn',  @Face_Eyes_UpperBody_Detection_OutputFcn, ...
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


% --- Executes just before Face_Eyes_UpperBody_Detection is made visible.
function Face_Eyes_UpperBody_Detection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Face_Eyes_UpperBody_Detection (see VARARGIN)

% Choose default command line output for Face_Eyes_UpperBody_Detection
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Face_Eyes_UpperBody_Detection wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Face_Eyes_UpperBody_Detection_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Open_Webcam.
function Open_Webcam_Callback(hObject, eventdata, handles)
% hObject    handle to Open_Webcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global c;
global tvar;
tvar=true;
c=webcam();
while(true)
    if(tvar==false)
        break;
    else
        e=c.snapshot;
        axes(handles.axes2);
   imshow(e);
   drawnow;
    end
end
                

% --- Executes on button press in Detect_Face.
function Detect_Face_Callback(hObject, eventdata, handles)
% hObject    handle to Detect_Face (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FaceDetect=vision.CascadeObjectDetector;
global c;
global tvar;
tvar=true;
c=webcam();
while(true)
    if(tvar==false)
        break;
    else
        e=c.snapshot;
        Box=step(FaceDetect,e);
        imshow(e);
        hold on;
        for i=1:size(Box,1)
            rectangle('Position',Box(i,:),'Linewidth',5,'LineStyle','-','EdgeColor','r');
        end
        hold off;
   drawnow;
    end
end

% --- Executes on button press in Detect_Eyes.
function Detect_Eyes_Callback(hObject, eventdata, handles)
% hObject    handle to Detect_Eyes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
EyeDetect=vision.CascadeObjectDetector('EyePairBig');
EyeDetect.MinSize=[11 45];
EyeDetect.MergeThreshold=16;
global c;
global tvar;
tvar=true;
c=webcam();
while(true)
    if(tvar==false)
        break;
    else
        e=c.snapshot;
        Box=step(EyeDetect,e);
        imshow(e);
        hold on;
        for i=1:size(Box,1)
            rectangle('Position',Box(i,:),'Linewidth',5,'LineStyle','-','EdgeColor','r');
        end
        hold off;
   drawnow;
    end
end

% --- Executes on button press in Detect_Upper_Body.
function Detect_Upper_Body_Callback(hObject, eventdata, handles)
% hObject    handle to Detect_Upper_Body (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
UBDetect=vision.CascadeObjectDetector('UpperBody');
EyeDetect.MinSize=[60 60];
EyeDetect.MergeThreshold=10;
global c;
global tvar;
tvar=true;
c=webcam();
while(true)
    if(tvar==false)
        break;
    else
        e=c.snapshot;
        Box=step(UBDetect,e);
        imshow(e);
        hold on;
        for i=1:size(Box,1)
            rectangle('Position',Box(i,:),'Linewidth',5,'LineStyle','-','EdgeColor','r');
        end
        hold off;
   drawnow;
    end
end

% --- Executes on button press in Close_Webcam.
function Close_Webcam_Callback(hObject, eventdata, handles)
% hObject    handle to Close_Webcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tvr;
tvr=false;
clear global c;
axes(handles.axes2);
imshow('C:\Users\HP\Downloads\ThankYou.jpg');