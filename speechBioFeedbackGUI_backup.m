function varargout = speechBioFeedbackGUI_backup(varargin)
% SPEECHBIOFEEDBACKGUI_BACKUP MATLAB code for speechBioFeedbackGUI_backup.fig
%      SPEECHBIOFEEDBACKGUI_BACKUP, by itself, creates a new SPEECHBIOFEEDBACKGUI_BACKUP or raises the existing
%      singleton*.
%
%      H = SPEECHBIOFEEDBACKGUI_BACKUP returns the handle to a new SPEECHBIOFEEDBACKGUI_BACKUP or the handle to
%      the existing singleton*.
%
%      SPEECHBIOFEEDBACKGUI_BACKUP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPEECHBIOFEEDBACKGUI_BACKUP.M with the given input arguments.
%
%      SPEECHBIOFEEDBACKGUI_BACKUP('Property','Value',...) creates a new SPEECHBIOFEEDBACKGUI_BACKUP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before speechBioFeedbackGUI_backup_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to speechBioFeedbackGUI_backup_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help speechBioFeedbackGUI_backup

% Last Modified by GUIDE v2.5 17-Jan-2016 19:15:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @speechBioFeedbackGUI_backup_OpeningFcn, ...
                   'gui_OutputFcn',  @speechBioFeedbackGUI_backup_OutputFcn, ...
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


% --- Executes just before speechBioFeedbackGUI_backup is made visible.
function speechBioFeedbackGUI_backup_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to speechBioFeedbackGUI_backup (see VARARGIN)

axes(handles.referenceWaveform) %turn off all axes
axis off
axes(handles.referenceSpectrogram)
axis off
axes(handles.testSpectrogram)
axis off
axes(handles.testWaveform)
axis off
axes(handles.differenceWaveform)
axis off
axes(handles.differenceSpectrogram)
axis off

handles.samplingrate = 44100; %sets Global sampling rate, sampling rate for whole project
set(handles.play,'visible','off') %makes 'play' button invisible
set(handles.save,'visible','off') %makes 'save' button invisible

% Choose default command line output for speechBioFeedbackGUI_backup
handles.output = hObject;

% Update handles structure
guidata(hObject, handles); %save changes to handles

% UIWAIT makes speechBioFeedbackGUI_backup wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = speechBioFeedbackGUI_backup_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in loadcorpus.
function loadcorpus_Callback(hObject, eventdata, handles)
% hObject    handle to loadcorpus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%load a corpus of existing, recorded sounds
handles.corpus = uigetfile; % allows user to load a word from a prerecorded corpus of English words


% --- Executes on button press in recordsound.
function recordsound_Callback(hObject, eventdata, handles)
% hObject    handle to recordsound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

recObj = audiorecorder(handles.samplingrate,16,1);  %Recording sound at 44kHz, 16 bit, 1 channel (not stereo) and naming it 'recObj'
set(handles.recording,'visible','on')    %Turns the red recording light on
duration = str2num(get(handles.duration,'String'));  %Sets the recording duration based off of duration box entry
recordblocking(recObj,duration);    %records sound recObj for duration, recordblocking pauses code in order to record
set(handles.recording,'visible','off') % turns the red recording light off
temp = getaudiodata(recObj); %gets the audio data from recObj and names it 'temp'
handles.referenceaudio = temp; %saves 'temp' audio data from recObj as 'handles.referenceaudio'

axes(handles.referenceWaveform)
plot(temp) %plots the audio data from recObj (user's speech)
axis off 
sound(temp,handles.samplingrate); % plays back recObj at the sampling rate '44100'

set(handles.play,'visible','on') %makes the play button visible
set(handles.save,'visible','on') %makes the save button visible
axes(handles.referenceSpectrogram) %set the axes
handles.RSS = spectrogram(temp,hanning(128),32,[0:39.2:10000],handles.samplingrate,'yaxis'); %Saves the spectrogram data of the recorded sound
spectrogram(temp,hanning(128),32,[0:39.2:10000],handles.samplingrate,'yaxis');  %displays the spectrogram

colormap(jet); 
colorbar off
get(gca)
guidata(hObject, handles);
%set(handles.referenceWaveform,'axis','off')


% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

sound(handles.referenceaudio,handles.samplingrate) %plays the reference audio
lengthofSample = length(handles.referenceaudio)

    %%----%%Attempts to plot a vertical line over the current time in the audio playback
    axes(handles.referenceWaveform)
    h = line([0 0],ylim,'color','k')
    axes(handles.referenceSpectrogram)
    h2 = line([0 0],ylim,'color','w')

    for ii = 1:720:lengthofSample
        set(h,'XData',[ii ii])
        set(h2,'XData',[ii/44100 ii/44100])
        pause(0.0163/2)
        %This should be going for 2 seconds, but the way we wrote it is 1 second. Why?
    end
    set(h,'visible','off')
    %%----%%

function duration_Callback(hObject, eventdata, handles)
% hObject    handle to duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of duration as text
%        str2double(get(hObject,'String')) returns contents of duration as a double
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
%%%%I DONT KNOW WHAT THIS DOES%%%%
function duration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

filename = uiputfile('*.mat');  %sets the saved file as a matlab (.mat) file
speechSample = handles.referenceaudio;  %audio data to be saved is reference audio
save(filename,'speechSample');  %actually saves the data



% --- Executes on button press in play2.
function play2_Callback(hObject, ~, handles)
% hObject    handle to play2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in record2.
function record2_Callback(hObject, eventdata, handles)
% hObject    handle to record2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

recObj = audiorecorder(handles.samplingrate,16,1); %Recording sound at 44kHz, 16 bit, 1 channel (not stereo)
set(handles.recording,'visible','on') 
duration = str2num(get(handles.duration,'String'))
recordblocking(recObj,duration);

set(handles.recording,'visible','off')
temp = getaudiodata(recObj);
handles.testaudio = temp; 
axes(handles.testWaveform)
plot(temp)
axis off

sound(temp,handles.samplingrate);
guidata(hObject, handles);

set(handles.play,'visible','on')
handles.speechsample = temp;
set(handles.save,'visible','on')
axes(handles.testSpectrogram)
handles.TSS = spectrogram(temp,hanning(128),32,[0:39.2:10000],handles.samplingrate,'yaxis');
spectrogram(temp,hanning(128),32,[0:39.2:10000],handles.samplingrate,'yaxis');
colormap(jet)
colorbar off
get(gca)

%Calculate the differences. First Waveform, then spectrogram
axes(handles.differenceWaveform)
temp2 = abs(handles.referenceaudio)-abs(handles.testaudio);
plot(temp2)
axis off

axes(handles.differenceSpectrogram)
temp3 = (real(handles.RSS).^2)-(real(handles.TSS).^2);
h4 = imagesc(flipud(temp3))

axis off

colormap(handles.differenceSpectrogram,'hot')

% --- Executes on button press in recording2.
function recording2_Callback(hObject, eventdata, handles)
% hObject    handle to recording2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function duration2_Callback(hObject, eventdata, handles)
% hObject    handle to duration2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of duration2 as text
%        str2double(get(hObject,'String')) returns contents of duration2 as a double


% --- Executes during object creation, after setting all properties.
function duration2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to duration2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in trim.
function trim_Callback(hObject, eventdata, handles)
% hObject    handle to trim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



%Homework
%Make sure load button works. Just make it load one word. About
%Plot the output of that where the reference is indicated. Waveform and
%Spectrogram
%Move the existing output of the recording to where the test is

%Next time:
%*Trim button
%*Flexible load
%*Flexible samplingrate for moving line

%Time after that
%Make the difference work


% --- Executes on button press in playsound2.
function playsound2_Callback(hObject, eventdata, handles)
% hObject    handle to playsound2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in startRealtime.
function startRealtime_Callback(hObject, eventdata, handles)
% hObject    handle to startRealtime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in stopRealtime.
function stopRealtime_Callback(hObject, eventdata, handles)
% hObject    handle to stopRealtime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
