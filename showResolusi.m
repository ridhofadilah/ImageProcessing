function [resolusi] = showResolusi(image)
    row = size(image,1);
    column = size(image,2);
    string1 = int2str(row);
    string2 = int2str(column);
    imshow(image);
    resolusi = strcat('Resolusi = ',string1,'X',string2);
    
end