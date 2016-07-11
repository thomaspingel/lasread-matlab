% function [h cmap] = lasview(s,attributeToColor)
%
% attributeToColor may be: 'rgb', 'classification', 'z', or 'i' (intensity)
%
function [h cmap] = lasview(s,attributeToColor)

if nargin<2
   a = fieldnames(s);
   if all([any(strcmp('r',a)) any(strcmp('g',a)) any(strcmp('b',a))])
       disp('Setting RGB as attribute to color.');
       attributeToColor = 'rgb';
   elseif any(strcmp('classification',a))
       disp('Setting classification as attribute to color.');
       attributeToColor = 'classification';
   else
       disp('Setting z as attribute to color.');
       attributeToColor = 'z';
   end
end

h = figure;
set(gcf,'Renderer','OpenGL');
dotsize = 5;

switch lower(attributeToColor)
    case {'rgb'}
        disp('Using RGB values to color.');
        crgb = reshape(double([s.r s.g s.b]),length(s.r),1,3)/255;  % create a false 'image'
        [c,cmap] = rgb2ind(crgb,256); % Translate that image to Index color, based on the current colormap divided into 256 colors (or whatever you prefer)
        colormap(cmap);
        scatter3(s.X,s.Y,s.Z,dotsize,c);
    case {'classification'}
        disp('Using Classification values to color.');
        uc = unique(s.classification);
        hold on;
        for i=1:length(uc);
            idx = find(s.classification==uc(i));
            switch uc(i)
                case 2 % Ground
                    plot3(s.X(idx),s.Y(idx),s.Z(idx),'.','markersize',dotsize,'markeredgecolor',[222 184 135]/255);
                case 3 % Vegetation
                    plot3(s.X(idx),s.Y(idx),s.Z(idx),'.','markersize',dotsize+2,'MarkerFaceColor','g','markeredgecolor','g');
                case 6 % Building
                    plot3(s.X(idx),s.Y(idx),s.Z(idx),'.','markersize',dotsize,'markeredgecolor','c');
                case 7 % Noise
                    plot3(s.X(idx),s.Y(idx),s.Z(idx),'.','markersize',dotsize,'markeredgecolor','r');
                case 9 % Water
                    plot3(s.X(idx),s.Y(idx),s.Z(idx),'.','markersize',dotsize,'markeredgecolor',[0 0 1]);
                case 30 % Temporary assignment
                    plot3(s.X(idx),s.Y(idx),s.Z(idx),'.','markersize',dotsize,'markeredgecolor','r');
                case 31 % Temporary assignment
                    plot3(s.X(idx),s.Y(idx),s.Z(idx),'.','markersize',dotsize,'markeredgecolor','m');
                case 32 % Temporary assignment
                    plot3(s.X(idx),s.Y(idx),s.Z(idx),'.','markersize',dotsize+2,'markeredgecolor','b');
                case 33 % Temporary assignment
                    plot3(s.X(idx),s.Y(idx),s.Z(idx),'.','markersize',dotsize,'markeredgecolor','c');
                case 34 % Temporary assignment
                    plot3(s.X(idx),s.Y(idx),s.Z(idx),'.','markersize',dotsize,'markeredgecolor','m');
                case 35 % Temporary assignment
                    plot3(s.X(idx),s.Y(idx),s.Z(idx),'.','markersize',dotsize,'markeredgecolor','k');
                case 40 % Temporary assignment
                    plot3(s.X(idx),s.Y(idx),s.Z(idx),'.','markersize',dotsize,'markeredgecolor',[0 .1 0]);
                case 41 % Temporary assignment
                    plot3(s.X(idx),s.Y(idx),s.Z(idx),'.','markersize',dotsize,'markeredgecolor',[0 .25 0]);
                case 42 % Temporary assignment
                    plot3(s.X(idx),s.Y(idx),s.Z(idx),'.','markersize',dotsize,'markeredgecolor',[0 .5 0]);
                case 43 % Temporary assignment
                    plot3(s.X(idx),s.Y(idx),s.Z(idx),'.','markersize',dotsize,'markeredgecolor',[0 .75 0]);
                case 44 % Temporary assignment
                    plot3(s.X(idx),s.Y(idx),s.Z(idx),'.','markersize',dotsize,'markeredgecolor',[0 1 0]);
      
                otherwise   
                    plot3(s.X(idx),s.Y(idx),s.Z(idx),'.','markersize',dotsize,'markeredgecolor',[.8 .8 .8]);
            end
            
        end
        hold off;
    case {'z'}
        disp('Using z-value to color.');
        scatter3(s.X,s.Y,s.Z,dotsize,s.Z);
        
%         cmap = .5*ones(32,3);
%         cmap(2,:) = [222 184 135]/255;  % ground
%         cmap(6,:) = [0 0 0]; % building
% %         classcolormap(:,1) = 1;
%         colormap(cmap);
%         scatter3(s.X,s.Y,s.Z,dotsize,s.classification);
    case {'i'}
        disp('Using intensity value to color.');
        scatter3(s.X,s.Y,s.Z,dotsize,tiedrank(s.intensity));
    otherwise
        disp('Using z-value to color.');
        scatter3(s.X,s.Y,s.Z,dotsize,s.Z);
%         disp('Rendering only points.');
%         plot3(s.X,s.Y,s.Z,'.','markeredgecolor',[.5 .5 .5]);
end

axis image;
% axis equal;
daspect([1,1,1]);

axis vis3d;