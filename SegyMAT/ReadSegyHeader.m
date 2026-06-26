% ReadSegyHeader : Reads a SEG Y Binary Header
%
% Call :
% [SegyHeader]=ReadSegyHeader(filename);
%
% To read using little endian :
% [SegyHeader]=ReadSegyHeader(filename,'endian','l');

%
% (C) 2001-2004, Thomas Mejer Hansen, tmh@gfy.ku.dk/thomas@cultpenguin.com
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
%

function [SegyHeader]=ReadSegyHeader(filename,varargin);


if ~(exist(filename)==2'),
  SegymatVerbose([mfilename,' : ', filename,' does not exist !'])
  Data=[];SegyTraceHeaders=[];SegyHeader=[];HeaderInfo=[];
  return
end

ninput=nargin;
% NEXT TWO LINES TO ENUSRE THAT VARARGIN CAN BE PASSED TO FUNCTION
if ninput==2
    % CALL USING VARARGIN
    ninput=1+length(varargin{1});
    varargin=varargin{1};
else
    % DIRECT CALL
    ninput=length(varargin);
end


% TRANSFORM VARARGING INTO PARAMETERS
cargin=1;
while (cargin<ninput)
    
    if strcmp(varargin{cargin},'jump')
       cargin=cargin+1;
       eval(['jump=',num2str(varargin{cargin}),';']);
       SegymatVerbose(['JUMP : Read only every ',num2str(jump),'th trace'])
    end

    if strcmp(varargin{cargin},'minmax')
       cargin=cargin+1;
       eval(['header=''',varargin{cargin},''';']);
       cargin=cargin+1;
       eval(['headermin=',num2str(varargin{cargin}),';']);
       cargin=cargin+1;
       eval(['headermax=',num2str(varargin{cargin}),';']);
       SegymatVerbose(['MIN MAX : Using header ',header,' from ',num2str(headermin),' to ',num2str(headermax)])
    end    

    if strcmp(varargin{cargin},'trange')
       cargin=cargin+1;
       eval(['tmin=',num2str(varargin{cargin}),';']);
       cargin=cargin+1;
       eval(['tmax=',num2str(varargin{cargin}),';']);
       SegymatVerbose(['TRANGE : tmin=',num2str(tmin),' tmax=',num2str(tmax)])
    end    

    if strcmp(varargin{cargin},'revision')
       cargin=cargin+1;
       eval(['revision=',num2str(varargin{cargin}),';']);
       SegymatVerbose(['USING REVISION : rev=',num2str(revision)])
    end    
    
    if strcmp(varargin{cargin},'dsf')
       cargin=cargin+1;
       eval(['dsf=',num2str(varargin{cargin}),';']);
       SegymatVerbose(['USING Data Sample Format : dsf=',num2str(dsf)])
    end    

    if strcmp(varargin{cargin},'SegyHeader')
       cargin=cargin+1;
       SegyHeader=varargin{cargin};
       SegymatVerbose(['USING LOADED SEGYHEADER'])
    end    

    % ENDIAN FORMAT 
    endian='ieee-be'; % Big Endian is default
    if strcmp(varargin{cargin},'endian')
       cargin=cargin+1;
       eval(['endian_tight=varargin{cargin};'])
       if endian_tight=='l',
         SegymatVerbose(['USING LITTLE ENDIAN TYPE'])
         endian='ieee-le';
       else
         SegymatVerbose(['USING BIG ENDIAN TYPE'])
       end
    end    

    cargin=cargin+1;
    
end

if exist('SkipData')==0,
    SkipData=0; % [0] READ ONLY HEADER VALUES, [1] READ IN ALL DATA
end

if SkipData==1, SegymatVerbose(['Not reading data - headers only']), end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OPEN FILE HANDLE

if exist('endian')==1,
  segyid = fopen(filename,'r',endian);   
else
  segyid = fopen(filename,'r','ieee-be');  % ALL DISK FILES ARE IN BIG
end                                        % ENDIAN FORMAT, ACCORDING TO 
                                           % SEGY Y rev 1


SegyHeader=GetSegyHeader(segyid);

fclose(segyid);
