# lasread-matlab
Simple program to read binary LAS-formatted LIDAR data into Matlab. The returned structure is not a standard geostructure. 

Sample Code: 

[S] = lasread('MntStHelens-20041120.las','xyzi'); 
lasview(lastrim(S,50000),'z');
