% GetSegyTraceHeader : Reads a seg y trace, data and header
%
% [SegyTraceHeader]=GetSegyTraceHeader(segyid,TraceStart,DataFormat,ns);
%
%
% (C) 2001-2004 Thomas Mejer Hansen, tmh@gfy.ku.dk/thomas@cultpenguin.com
% 
%    This program is free software; you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation; either version 2 of the License, or
%    (at your option) any later version.
%
%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with this program; if not, write to the Free Software
%    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
%

function [SegyTraceHeader]=GetSegyTraceHeader(segyid,TraceStart,DataFormat,ns,SegyTraceHeader);

if exist('DataFormat')==0, DataFormat='float32'; end
if exist('TraceStart')==0, TraceStart=ftell(segyid); end

if exist('SegyTraceHeader')
    if isempty('SegyTraceHeader');
        clear SegyTraceHeader;
    end
end


fseek(segyid,TraceStart,'bof');

% GET POSITION FOR EASY LATER LOCALIZATION
SegyTraceHeader.SegyMAT_TraceStart = ftell(segyid);

SegyTraceHeader.TraceSequenceLine=fread(segyid,1,'int32');    % 0
SegyTraceHeader.TraceSequenceFile=fread(segyid,1,'int32');    % 4 
SegyTraceHeader.FieldRecord=fread(segyid,1,'int32');          % 8
SegyTraceHeader.TraceNumber=fread(segyid,1,'int32');          % 12
SegyTraceHeader.EnergySourcePoint=fread(segyid,1,'int32');    % 16
SegyTraceHeader.cdp=fread(segyid,1,'int32');                  % 20
SegyTraceHeader.cdpTrace=fread(segyid,1,'int32');             % 24

SegyTraceHeader.TraceIdenitifactionCode=fread(segyid,1,'int16'); % 28

SegyTraceHeader.NSummedTraces=fread(segyid,1,'int16'); % 30
SegyTraceHeader.NStackedTraces=fread(segyid,1,'int16'); % 32
SegyTraceHeader.DataUse=fread(segyid,1,'int16'); % 34
SegyTraceHeader.offset=fread(segyid,1,'int32');             %36

SegyTraceHeader.ReceiverGroupElevation=fread(segyid,1,'int32');             %40
SegyTraceHeader.SourceSurfaceElevation=fread(segyid,1,'int32');             %44
SegyTraceHeader.SourceDepth=fread(segyid,1,'int32');             %48
SegyTraceHeader.ReceiverDatumElevation=fread(segyid,1,'int32');             %52
SegyTraceHeader.SourceDatumElevation=fread(segyid,1,'int32');             %56
SegyTraceHeader.SourceWaterDepth=fread(segyid,1,'int32');  %60
SegyTraceHeader.GroupWaterDepth=fread(segyid,1,'int32');  %64
SegyTraceHeader.ElevationScalar=fread(segyid,1,'int16');  %68

% Multiply/divide next number for following 4 values
SegyTraceHeader.SourceGroupScalar=fread(segyid,1,'int16');  %70
SegyTraceHeader.SourceX=fread(segyid,1,'int32');  %72
SegyTraceHeader.SourceY=fread(segyid,1,'int32');  %76
SegyTraceHeader.GroupX=fread(segyid,1,'int32');  %80
SegyTraceHeader.GroupY=fread(segyid,1,'int32');  %84

SegyTraceHeader.CoordinateUnits=fread(segyid,1,'int16');  %88
SegyTraceHeader.WeatheringVelocity=fread(segyid,1,'int16');  %90
SegyTraceHeader.SubWeatheringVelocity=fread(segyid,1,'int16');  %92

SegyTraceHeader.SourceUpholeTime=fread(segyid,1,'int16');  %94
SegyTraceHeader.GroupUpholeTime=fread(segyid,1,'int16');  %96
SegyTraceHeader.SourceStaticCorrection=fread(segyid,1,'int16');  %98
SegyTraceHeader.GroupStaticCorrection=fread(segyid,1,'int16');  %100
SegyTraceHeader.TotalStaticApplied=fread(segyid,1,'int16');  %102
SegyTraceHeader.LagTimeA=fread(segyid,1,'int16');  %104
SegyTraceHeader.LagTimeB=fread(segyid,1,'int16');  %106
SegyTraceHeader.DelayRecordingTime=fread(segyid,1,'int16');  %108

SegyTraceHeader.MuteTimeStart=fread(segyid,1,'int16');  %110
SegyTraceHeader.MuteTimeEND=fread(segyid,1,'int16');  %112

SegyTraceHeader.ns=fread(segyid,1,'uint16');  %114
SegyTraceHeader.dt=fread(segyid,1,'uint16');  %116

SegyTraceHeader.GainType=fread(segyid,1,'int16');  %118
SegyTraceHeader.InstrumentGainConstant=fread(segyid,1,'int16');  %120
SegyTraceHeader.InstrumentInitialGain=fread(segyid,1,'int16');  %%122
								
SegyTraceHeader.Correlated=fread(segyid,1,'int16');  %124

SegyTraceHeader.SweepFrequenceStart=fread(segyid,1,'int16');  %126
SegyTraceHeader.SweepFrequenceEnd=fread(segyid,1,'int16');  %128
SegyTraceHeader.SweepLength=fread(segyid,1,'int16');  %130
SegyTraceHeader.SweepType=fread(segyid,1,'int16');  %132
SegyTraceHeader.SweepTraceTaperLengthStart=fread(segyid,1,'int16');  %134
SegyTraceHeader.SweepTraceTaperLengthEnd=fread(segyid,1,'int16');  %136
SegyTraceHeader.TaperType=fread(segyid,1,'int16');  %138

SegyTraceHeader.AliasFilterFrequency=fread(segyid,1,'int16');  %140
SegyTraceHeader.AliasFilterSlope=fread(segyid,1,'int16');  %142
SegyTraceHeader.NotchFilterFrequency=fread(segyid,1,'int16');  %144
SegyTraceHeader.NotchFilterSlope=fread(segyid,1,'int16');  %146
SegyTraceHeader.LowCutFrequency=fread(segyid,1,'int16');  %148
SegyTraceHeader.HighCutFrequency=fread(segyid,1,'int16');  %150
SegyTraceHeader.LowCutSlope=fread(segyid,1,'int16');  %152
SegyTraceHeader.HighCutSlope=fread(segyid,1,'int16');  %154

SegyTraceHeader.YearDataRecorded=fread(segyid,1,'int16');  %156
SegyTraceHeader.DayOfYear=fread(segyid,1,'int16');  %158
SegyTraceHeader.HourOfDay=fread(segyid,1,'int16');  %160
SegyTraceHeader.MinuteOfHour=fread(segyid,1,'int16');  %162
SegyTraceHeader.SecondOfMinute=fread(segyid,1,'int16');  %164
SegyTraceHeader.TimeBaseCode=fread(segyid,1,'int16');  %166
if SegyTraceHeader.TimeBaseCode==1, SegyTraceHeader.TimeBaseCodeText='Local'; 
elseif SegyTraceHeader.TimeBaseCode==2, SegyTraceHeader.TimeBaseCodeText='GMT';
elseif SegyTraceHeader.TimeBaseCode==3, SegyTraceHeader.TimeBaseCodeText='Other';
elseif SegyTraceHeader.TimeBaseCode==4, SegyTraceHeader.TimeBaseCodeText='UTC';
else SegyTraceHeader.TimeBaseCodeText=''; end

SegyTraceHeader.TraceWeightningFactor=fread(segyid,1,'int16');  %170
SegyTraceHeader.GeophoneGroupNumberRoll1=fread(segyid,1,'int16');  %172
SegyTraceHeader.GeophoneGroupNumberFirstTraceOrigField=fread(segyid,1,'int16');  %174
SegyTraceHeader.GeophoneGroupNumberLastTraceOrigField=fread(segyid,1,'int16');  %176
SegyTraceHeader.GapSize=fread(segyid,1,'int16');  %178

SegyTraceHeader.OverTravel=fread(segyid,1,'int16');  %178

SegyTraceHeader.cdpX=fread(segyid,1,'int32');  %180
SegyTraceHeader.cdpY=fread(segyid,1,'int32');  %184

SegyTraceHeader.Inline3D=fread(segyid,1,'int32');  %188
SegyTraceHeader.Crossline3D=fread(segyid,1,'int32');  %192

SegyTraceHeader.ShotPoint=fread(segyid,1,'int32');  %196
SegyTraceHeader.ShotPointScalar=fread(segyid,1,'int16');  %200

SegyTraceHeader.TraceValueMeasurementUnit=fread(segyid,1,'int16');  %202
if SegyTraceHeader.TraceValueMeasurementUnit==-1, SegyTraceHeader.TraceValueMeasurementUnitText='Other';
elseif SegyTraceHeader.TraceValueMeasurementUnit==0, SegyTraceHeader.TraceValueMeasurementUnitText='Unknown';
elseif SegyTraceHeader.TraceValueMeasurementUnit==1, SegyTraceHeader.TraceValueMeasurementUnitText='Pascal (Pa)';
elseif SegyTraceHeader.TraceValueMeasurementUnit==2, SegyTraceHeader.TraceValueMeasurementUnitText='Volts (v)';
elseif SegyTraceHeader.TraceValueMeasurementUnit==3, SegyTraceHeader.TraceValueMeasurementUnitText='Millivolts (v)';
elseif SegyTraceHeader.TraceValueMeasurementUnit==4, SegyTraceHeader.TraceValueMeasurementUnitText='Amperes (A)';  
elseif SegyTraceHeader.TraceValueMeasurementUnit==5, SegyTraceHeader.TraceValueMeasurementUnitText='Meters (m)';  
elseif SegyTraceHeader.TraceValueMeasurementUnit==6, SegyTraceHeader.TraceValueMeasurementUnitText='Meters Per Second (m/s)';  
elseif SegyTraceHeader.TraceValueMeasurementUnit==7, SegyTraceHeader.TraceValueMeasurementUnitText='Meters Per Second squared (m/&s2)Other';  
elseif SegyTraceHeader.TraceValueMeasurementUnit==8, SegyTraceHeader.TraceValueMeasurementUnitText='Newton (N)';  
elseif SegyTraceHeader.TraceValueMeasurementUnit==8, SegyTraceHeader.TraceValueMeasurementUnitText='Watt (W)';  
else SegyTraceHeader.TraceValueMeasurementUnitText='Undefined'; end

SegyTraceHeader.TransductionConstantMantissa=fread(segyid,1,'int32');  %204
SegyTraceHeader.TransductionConstantPower=fread(segyid,1,'int16'); %208

SegyTraceHeader.TransductionUnit=fread(segyid,1,'int16');  %210

SegyTraceHeader.TraceIdentifier=fread(segyid,1,'int16');  %212

SegyTraceHeader.ScalarTraceHeader=fread(segyid,1,'int16');  %214

SegyTraceHeader.SourceType=fread(segyid,1,'int16');  %216

SegyTraceHeader.SourceEnergyDirectionMantissa=fread(segyid,1,'int32');  %218
SegyTraceHeader.SourceEnergyDirectionExponent=fread(segyid,1,'int16');  %222

SegyTraceHeader.SourceMeasurementMantissa=fread(segyid,1,'int32');  %224
SegyTraceHeader.SourceMeasurementExponent=fread(segyid,1,'int16');  %228

SegyTraceHeader.SourceMeasurementUnit=fread(segyid,1,'int16');  %230

SegyTraceHeader.UnassignedInt1=fread(segyid,1,'int32');  %232
SegyTraceHeader.UnassignedInt2=fread(segyid,1,'int32');  %236





if exist('ns')==0,
  ns=SegyTraceHeader.ns;
end


% GO TO POSITION OF DATA
fseek(segyid,TraceStart+240,'bof');
SegyTraceHeader.SegyMAT_TraceDataStart = ftell(segyid);

