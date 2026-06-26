function varargout = GUIEditTextualFileHeader(varargin)
% GUIEDITTEXTUALFILEHEADER M-file for GUIEditTextualFileHeader.fig
%      GUIEDITTEXTUALFILEHEADER, by itself, creates a new GUIEDITTEXTUALFILEHEADER or raises the existing
%      singleton*.
%
%      H = GUIEDITTEXTUALFILEHEADER returns the handle to a new GUIEDITTEXTUALFILEHEADER or the handle to
%      the existing singleton*.
%
%      GUIEDITTEXTUALFILEHEADER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIEDITTEXTUALFILEHEADER.M with the given input arguments.
%
%      GUIEDITTEXTUALFILEHEADER('Property','Value',...) creates a new GUIEDITTEXTUALFILEHEADER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUIEditTextualFileHeader_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUIEditTextualFileHeader_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUIEditTextualFileHeader

% Last Modified by GUIDE v2.5 17-Sep-2002 16:29:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUIEditTextualFileHeader_OpeningFcn, ...
                   'gui_OutputFcn',  @GUIEditTextualFileHeader_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);


if nargin & isstr(varargin{1})
  gui_State.gui_Callback = str2func(varargin{1});
end



if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end


% End initialization code - DO NOT EDIT

% --- Executes just before GUIEditTextualFileHeader is made visible.
function GUIEditTextualFileHeader_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUIEditTextualFileHeader (see VARARGIN)

% Choose default command line output for GUIEditTextualFileHeader
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Load TextualFileHeader if given
if length(varargin)>0
  if nargin & isstruct(varargin{1})
    if isfield(varargin{1},'TextualFileHeader')
    data=guidata(gcf);    
    data.SegyHeader=varargin{1};
    guidata(gcf, data);
    UpdateText(hObject, handles)  
    end 
  end
end


% UIWAIT makes GUIEditTextualFileHeader wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUIEditTextualFileHeader_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function eTextHeader_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eTextHeader (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function eTextHeader_Callback(hObject, eventdata, handles)
% hObject    handle to eTextHeader (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eTextHeader as text
%        str2double(get(hObject,'String')) returns contents of
%        eTextHeader as a double

  HS=get(hObject,'String');
  VAL=get(hObject,'Value');
  set(handles.eEditLine,'String',HS(VAL,:))

  
  

% --- Executes during object creation, after setting all properties.
function popType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in popType.
function popType_Callback(hObject, eventdata, handles)
% hObject    handle to popType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from
%        popType
  UpdateText(hObject,handles)
  
  
  
function UpdateText(hObject, handles)  
  data=guidata(hObject);
  
  HeaderType=get(handles.popType,'Value');
  
  if HeaderType==1,
    txt=char(ebcdic2ascii(data.SegyHeader.TextualFileHeader));
  else
    txt=char(data.SegyHeader.TextualFileHeader);
  end
  

  try
    s=[];
    for i=1:40;
      s=[s,txt((i-1)*80+1:(i-1)*80+80)];
      if i~=40 s=[s,'|']; end
    end
  catch
    if (HeaderType==1)
      warndlg(['The Textual Header is most probably NOT EBCDIC formatted'],'Textual Header Info')
    else
      warndlg(['The Textual Header is most probably NOT ASCII formatted'],'Textual Header Info')
    end
  end
  
  try
    set(handles.eTextHeader,'String',s)
  catch
    disp('WHUUPS')
  end
  

  
  


% --- Executes during object creation, after setting all properties.
function eEditLine_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eEditLine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function eEditLine_Callback(hObject, eventdata, handles)
% hObject    handle to eEditLine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eEditLine as text
%        str2double(get(hObject,'String')) returns contents of eEditLine as a double


