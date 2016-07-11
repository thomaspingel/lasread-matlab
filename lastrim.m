%function [R] = lastrim(S,n)
%
%TRIMLAS
%Trim LAS geostructure randomly or by a selection.
%
%Syntax:
%ts = lastrim(s,10000);  % Select 10,000 random points
%ts = lastrim(s,.5);     % Select half the points
%ts = lastrim(s,find(s.classification==2)) % Select points of class 2
%ts = lastrim(s,boundingBox) % Select points within bounding box [min(x)
%min(y); max(x) max(y)]
%
%Appends index information to the output geostructure, where the index
%returns the value from the original geostructure.

function [s] = lastrim(gs,n)


if nargin~=2
    error('Wrong number of input arguments.');
end

% Total length of original dataset
t = length(gs.X);

if length(n)==1  % If n is a single value:
   
  % If a fraction, keep that fraction of points
  if n>0 && n<1
    n = round(n*length(gs.X));
  elseif n<=0
    error('Invalid value for n');
  % If an integer one or greater, take that many points (up to the size of the
  % dataset)
  elseif n>t
    n = t;
  end
  
  indx = randsample(t,n);
  
  
elseif size(n,1)==2 && size(n,2)==2  % trim by xy bounding box
  disp('Trimming by bounding box');
  indx = find(gs.X>=n(1,1) & gs.X<=n(2,1) & gs.Y>=n(1,2) & gs.Y<=n(2,2));

else  % Trim by a provided index
  indx = n;
end
clear n;


% Get fieldnames
fn = fieldnames(gs);

for i=1:length(fn)
    l = eval(['length(gs.',fn{i},')']);
    if l==t
      eval(['s.',fn{i},'=gs.',fn{i},'(indx)',';']);
    else
      eval(['s.',fn{i},'=gs.',fn{i},';']);
    end
end

s.BoundingBox = [min(gs.X) min(gs.Y); max(gs.X) max(gs.Y)];

% s.indx = uint32(indx);

