function varargout = Linear_regression(varargin)
% LINEAR_REGRESSION MATLAB code for Linear_regression.fig
%      LINEAR_REGRESSION, by itself, creates a new LINEAR_REGRESSION or raises the existing
%      singleton*.
%
%      H = LINEAR_REGRESSION returns the handle to a new LINEAR_REGRESSION or the handle to
%      the existing singleton*.
%
%      LINEAR_REGRESSION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LINEAR_REGRESSION.M with the given input arguments.
%
%      LINEAR_REGRESSION('Property','Value',...) creates a new LINEAR_REGRESSION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Linear_regression_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Linear_regression_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Linear_regression

% Last Modified by GUIDE v2.5 13-May-2022 21:58:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Linear_regression_OpeningFcn, ...
                   'gui_OutputFcn',  @Linear_regression_OutputFcn, ...
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


% --- Executes just before Linear_regression is made visible.
function Linear_regression_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Linear_regression (see VARARGIN)

% Choose default command line output for Linear_regression
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Linear_regression wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Linear_regression_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in models.
function models_Callback(hObject, eventdata, handles)
% hObject    handle to models (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns models contents as cell array
%        contents{get(hObject,'Value')} returns selected item from models


% --- Executes during object creation, after setting all properties.
function models_CreateFcn(hObject, eventdata, handles)
% hObject    handle to models (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in plot.
function plot_Callback(hObject, eventdata, handles)
n = str2num(get(handles.n,'string'));
s = get(handles.uitable1,'data');
for i =1 : 1: n
  x(i) = s(i,1);

  y(i) = s(i,2);
end
list = get(handles.models,'value');
[a, b, r] = linreg1(x, y,list);
set(handles.r,'string',r);

switch list
    case 1 
        y_bfit = a+b*x;
        axes(handles.axes1);
        hold off
        plot(x, y, 'x', 'markersize', 7)    %plotting the data points
        hold on
        plot(x,y_bfit) 
        f = [num2str(a)  '+ '  num2str(b) ' x'];    
    case 2
        x1 = linspace(x(1),x(n),(round(abs(x(n)-x(1))*20)));
        y_bfit = a*exp(b*x1);
        axes(handles.axes1);
        hold off
        plot(x, y, 'x', 'markersize', 7)    %plotting the data points
        hold on
        plot(x1,y_bfit) 
        f = [num2str(a)  '* exp( ' num2str(b) +'* x )'];
       
    case 3
        x1 = linspace(x(1),x(n),(round(abs(x(n)-x(1))*20)));
        y_bfit = a * x1.^b;
        axes(handles.axes1);
        hold off
        plot(x, y, 'x', 'markersize', 7)    %plotting the data points
        hold on
        plot(x1,y_bfit) 
         f = [num2str(a)  ' * ' ' x ^' num2str(b)] ;
        
    case 4
        x1 = linspace(x(1),x(n),(round(abs(x(n)-x(1))*20)));
        y_bfit = a*x1./(b+x1)
        axes(handles.axes1);
        hold off
        plot(x, y, 'x', 'markersize', 7)    %plotting the data points
        hold on
        plot(x1,y_bfit) 
        f = [num2str(a)  '* x /('  num2str(b) '+ x)'];
end
set(handles.fun,'string',f);
function [a, b, r] = linreg1(x, y,list_choice)
 n = length(x);      %number of data points
if n ~= length(y)
    error('Vectors must have the same length')
end


switch list_choice
    case 1        % line
        X = x;
        Y = y;
    case 2
        X =x;      % exponential model
        for i = 1 :1:n          
            if y(i)== 0               % to avoid error in case of zero input
                y(i) = 0.0000000001;
            end
        end
        Y = log (y);
       
    case 3
        for i = 1 :1:n
          if x(i)== 0
            x(i) = 0.0000000001;
          end
        end
        X = log(x);
        for i = 1 :1:n
            if y(i)== 0
                y(i) = 0.0000000001;
            end
        end
        Y = log(y);
    case 4                 % growth model
       for i = 1 :1:n    
          if x(i)== 0        
            x(i) = 0.0000000001;
          end
        end
        X = 1./x;
        for i = 1 :1:n
            if y(i)== 0
                y(i) = 0.0000000001;
            end
        end
        Y = 1./y;
end
sum_x = sum(X(:));  %converting x to a column matrix and computing the sum   
sum_y = sum(Y(:));
x_squared = X.^2;
y_squared = Y.^2;
sum_x_squared = sum(x_squared(:));  
sum_y_squared = sum(y_squared(:)); 
xy = X.*Y; 
sum_xy = sum(xy(:));

a1 = ((n * sum_xy) - (sum_x * sum_y)) / ((n * sum_x_squared) - sum_x.^2); ...
    %slope value
a0 = (sum_y - (sum_x * a1)) / n;    %intercept
r = ((n * sum_xy) - (sum_x * sum_y)) / ...
    (sqrt(n * sum_x_squared - sum_x^2) * ...
    sqrt(n * sum_y_squared - sum_y^2)); %correlation coefficient
r = abs(r);
    %best fit line equation



switch list_choice
    case 1                % to get the constant of each model
        a = a0;
        b = a1;

    case 2
        a = exp(a0);
        b = a1;
    case 3
        a = exp(a0);
        b= a1;

    case 4
     
        a = 1/a0
        
        b = a1*a

end

% hObject    handle to plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function fun_Callback(hObject, eventdata, handles)
% hObject    handle to fun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fun as text
%        str2double(get(hObject,'String')) returns contents of fun as a double


% --- Executes during object creation, after setting all properties.
function fun_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function r_Callback(hObject, eventdata, handles)
% hObject    handle to r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of r as text
%        str2double(get(hObject,'String')) returns contents of r as a double


% --- Executes during object creation, after setting all properties.
function r_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)

% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected cell(s) is changed in uitable1.
function uitable1_CellSelectionCallback(hObject, eventdata, handles)

% hObject    handle to uitable1 (see GCBO)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)



function n_Callback(hObject, eventdata, handles)
% hObject    handle to n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n as text
%        str2double(get(hObject,'String')) returns contents of n as a double


% --- Executes during object creation, after setting all properties.
function n_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles)

n = str2num(get(handles.n,'string'));
data = zeros(n,2);
set(handles.uitable1,'Data',data);
% hObject    handle to ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
