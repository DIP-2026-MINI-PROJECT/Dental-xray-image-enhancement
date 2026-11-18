%% 1. EXTRACT ZIP AND READ ALL PNG IMAGES

clc;
clear;
close all;

zipFile = 'DENTAL IMGS.zip';
imageFolder = 'Dental_Images';

% Check ZIP file
if ~exist(zipFile,'file')
    error('ZIP file not found! Check MATLAB Current Folder.');
end

% Create extraction folder
if ~exist(imageFolder,'dir')
    mkdir(imageFolder);
end

% Extract ZIP
unzip(zipFile,imageFolder);

% Search recursively inside all subfolders
allFiles = dir(fullfile(imageFolder,'**','*'));

% Select all PNG images (including uppercase .PNG)
files = [];

for k = 1:length(allFiles)

    if ~allFiles(k).isdir

        [~,~,ext] = fileparts(allFiles(k).name);

        if strcmpi(ext,'.png')
            files = [files; allFiles(k)];
        end

    end
end

% Display number of images
fprintf('\nTotal PNG images found: %d\n',length(files));

% Check images
if isempty(files)
    error('No PNG images found. Check ZIP folder structure.');
end

% Display filenames
disp('Images detected:');

for k = 1:length(files)
    fprintf('%d. %s\n',k,files(k).name);
end

%% 2. PROCESS ALL IMAGES

for imgIdx = 1:length(files)

    fprintf('\nProcessing Image %d: %s\n', ...
        imgIdx,files(imgIdx).name);

    imagePath = fullfile(files(imgIdx).folder, ...
                         files(imgIdx).name);

    I_rgb = imread(imagePath);

    if size(I_rgb,3) == 3
        I = rgb2gray(I_rgb);
    else
        I = I_rgb;
    end

    I_double = im2double(I);

    % KEEP ALL YOUR EXISTING AHP-1,
    % UNIT 3 AND UNIT 4 CODE HERE.

end


    %% IMAGE ACQUISITION

    I_rgb = imread(imagePath);

    if size(I_rgb,3) == 3
        I = rgb2gray(I_rgb);
    else
        I = I_rgb;
    end

    I_double = im2double(I);

    %% AHP-1 IMPLEMENTATION

    %% 1. IMAGE ACQUISITION AND GRAYSCALE

    figure('Name',['Image Acquisition - ',files(imgIdx).name]);

    subplot(1,2,1);
    imshow(I_rgb);
    title('Original Image');

    subplot(1,2,2);
    imshow(I);
    title('Grayscale Image');

    %% 2. DIGITAL IMAGE REPRESENTATION

    [M,N] = size(I);
    total_pixels = numel(I);

    fprintf('\nImage Size: %d x %d pixels\n',M,N);
    fprintf('Total Pixels: %d\n',total_pixels);

    r = min(100,M);
    c = min(100,N);

    disp('Sample Pixel Values:');
    disp(I(r:min(r+5,M),c:min(c+5,N)));

    row = min(250,M);
    col = min(250,N);

    fprintf('First pixel of row %d = %d\n',row,I(row,1));
    fprintf('Pixel at (%d,%d) = %d\n',row,col,I(row,col));

    %% 3. HISTOGRAM ANALYSIS

    figure('Name',['Histogram Analysis - ',files(imgIdx).name]);

    subplot(1,3,1);
    imhist(I);
    title('Histogram - 256 Bins');

    subplot(1,3,2);
    imhist(I,5);
    title('Histogram - 5 Bins');

    subplot(1,3,3);
    imhist(I,16);
    title('Histogram - 16 Bins');

    %% 4. IMAGE FORMAT INFORMATION

    info = imfinfo(imagePath);

    fprintf('\nImage Format Information:\n');
    fprintf('Format: %s\n',info.Format);
    fprintf('Width: %d pixels\n',info.Width);
    fprintf('Height: %d pixels\n',info.Height);
    fprintf('Bit Depth: %d bits/pixel\n',info.BitDepth);

    %% 5. ELEMENT-WISE VS MATRIX MULTIPLICATION

    P = [1 2 3 5; 5 6 7 9; 9 9 9 9];
    Q = [2 4 5 4; 4 6 7 1; 1 1 1 1];

    P_dot_times_Q = P .* Q;
    P_times_Q = P * Q';

    disp('P .* Q:');
    disp(P_dot_times_Q);

    disp('P * Q transpose:');
    disp(P_times_Q);

    %% 6. PIXEL LEVEL MANIPULATION

    I_thresh = I;
    I_thresh(I < 127) = 255;
    I_thresh(I >= 127) = 0;

    I_div5_white = I;
    I_div5_white(mod(double(I),5) == 0) = 255;

    I_div5_black = I;
    I_div5_black(mod(double(I),5) == 0) = 0;

    figure('Name',['Pixel Manipulation - ',files(imgIdx).name]);

    subplot(2,2,1);
    imshow(I);
    title('Original');

    subplot(2,2,2);
    imshow(I_thresh);
    title('Binary Threshold');

    subplot(2,2,3);
    imshow(I_div5_white);
    title('Divisible by 5 - White');

    subplot(2,2,4);
    imshow(I_div5_black);
    title('Divisible by 5 - Black');

    %% AHP-1 SUMMARY

    figure('Name',['AHP-1 Summary - ',files(imgIdx).name]);

    subplot(2,3,1);
    imshow(I_rgb);
    title('Original Image');

    subplot(2,3,2);
    imshow(I);
    title('Grayscale');

    subplot(2,3,3);
    imhist(I,16);
    title('Histogram');

    subplot(2,3,4);
    imshow(I_thresh);
    title('Thresholding');

    subplot(2,3,5);
    imshow(I_div5_white);
    title('Div-5 White');

    subplot(2,3,6);
    imshow(I_div5_black);
    title('Div-5 Black');

    sgtitle(['AHP-1 Summary: ',files(imgIdx).name]);

    %% UNIT 3: IMAGE ENHANCEMENT AND RESTORATION

    %% 1. GRAY LEVEL TRANSFORMATIONS

    I_negative = imcomplement(I);
    I_log = mat2gray(log(1 + I_double));
    I_gamma = imadjust(I,[],[],0.6);

    figure('Name',['Gray Level Transformations - ',files(imgIdx).name]);

    subplot(2,2,1);
    imshow(I);
    title('Original Image');

    subplot(2,2,2);
    imshow(I_negative);
    title('Image Negative');

    subplot(2,2,3);
    imshow(I_log);
    title('Log Transformation');

    subplot(2,2,4);
    imshow(I_gamma);
    title('Gamma Correction');

    %% 2. HISTOGRAM EQUALIZATION AND CLAHE

    I_histeq = histeq(I);
    I_clahe = adapthisteq(I);

    figure('Name',['Histogram Enhancement - ',files(imgIdx).name]);

    subplot(2,2,1);
    imshow(I);
    title('Original Image');

    subplot(2,2,2);
    imshow(I_histeq);
    title('Histogram Equalization');

    subplot(2,2,3);
    imshow(I_clahe);
    title('CLAHE');

    subplot(2,2,4);
    imhist(I_clahe);
    title('CLAHE Histogram');

    %% 3. SPATIAL DOMAIN FILTERING

    h_mean = fspecial('average',[3 3]);
    I_mean = imfilter(I,h_mean,'replicate');

    I_median = medfilt2(I,[3 3]);

    I_gaussian = imgaussfilt(I,1);

    figure('Name',['Spatial Filtering - ',files(imgIdx).name]);

    subplot(2,2,1);
    imshow(I);
    title('Original Image');

    subplot(2,2,2);
    imshow(I_mean);
    title('Mean Filter');

    subplot(2,2,3);
    imshow(I_median);
    title('Median Filter');

    subplot(2,2,4);
    imshow(I_gaussian);
    title('Gaussian Filter');

    %% 4. IMAGE SHARPENING

    I_sharpen = imsharpen(I,'Radius',1,'Amount',1);

    figure('Name',['Image Sharpening - ',files(imgIdx).name]);

    subplot(1,2,1);
    imshow(I);
    title('Original Image');

    subplot(1,2,2);
    imshow(I_sharpen);
    title('Sharpened Image');

    %% 5. FREQUENCY DOMAIN BUTTERWORTH FILTERING

    [M,N] = size(I);

    [u,v] = meshgrid(-floor(N/2):ceil(N/2)-1, ...
                     -floor(M/2):ceil(M/2)-1);

    D = sqrt(u.^2 + v.^2);

    D0 = 30;
    order = 2;

    H_low = 1 ./ (1 + (D./D0).^(2*order));
    H_high = 1 - H_low;

    F_filter = fftshift(fft2(I_double));

    G_low = F_filter .* H_low;
    G_high = F_filter .* H_high;

    I_butter_low = real(ifft2(ifftshift(G_low)));
    I_butter_high = real(ifft2(ifftshift(G_high)));

    figure('Name',['Butterworth Filtering - ',files(imgIdx).name]);

    subplot(2,2,1);
    imshow(I);
    title('Original Image');

    subplot(2,2,2);
    imshow(H_low,[]);
    title('Butterworth Low Pass Filter');

    subplot(2,2,3);
    imshow(mat2gray(I_butter_low));
    title('Low Pass Filtered Image');

    subplot(2,2,4);
    imshow(mat2gray(I_butter_high));
    title('High Pass Filtered Image');

    %% UNIT 3 SUMMARY

    figure('Name',['Unit 3 Summary - ',files(imgIdx).name]);

    subplot(2,3,1);
    imshow(I);
    title('Original');

    subplot(2,3,2);
    imshow(I_clahe);
    title('CLAHE');

    subplot(2,3,3);
    imshow(I_median);
    title('Median Filter');

    subplot(2,3,4);
    imshow(I_gaussian);
    title('Gaussian Filter');

    subplot(2,3,5);
    imshow(I_sharpen);
    title('Sharpened');

    subplot(2,3,6);
    imshow(mat2gray(I_butter_low));
    title('Butterworth Low Pass');

    sgtitle(['Unit 3 Summary: ',files(imgIdx).name]);

    %% UNIT 4: MORPHOLOGICAL PROCESSING AND SEGMENTATION

    %% 1. ADAPTIVE THRESHOLDING

    BW = imbinarize(I_clahe,'adaptive', ...
        'ForegroundPolarity','bright','Sensitivity',0.45);

    figure('Name',['Binary Segmentation - ',files(imgIdx).name]);

    subplot(1,2,1);
    imshow(I_clahe);
    title('Enhanced Dental X-ray');

    subplot(1,2,2);
    imshow(BW);
    title('Adaptive Thresholding');

    %% 2. EROSION AND DILATION

    SE = strel('disk',3,0);

    BW_eroded = imerode(BW,SE);
    BW_dilated = imdilate(BW,SE);

    figure('Name',['Erosion and Dilation - ',files(imgIdx).name]);

    subplot(1,3,1);
    imshow(BW);
    title('Original Binary Image');

    subplot(1,3,2);
    imshow(BW_eroded);
    title('Erosion');

    subplot(1,3,3);
    imshow(BW_dilated);
    title('Dilation');

    %% 3. OPENING AND CLOSING

    BW_open = imopen(BW,SE);
    BW_close = imclose(BW,SE);

    figure('Name',['Opening and Closing - ',files(imgIdx).name]);

    subplot(1,3,1);
    imshow(BW);
    title('Original Binary Image');

    subplot(1,3,2);
    imshow(BW_open);
    title('Opening');

    subplot(1,3,3);
    imshow(BW_close);
    title('Closing');

    %% 4. MORPHOLOGICAL GRADIENT

    BW_gradient = imdilate(BW,SE) & ~imerode(BW,SE);

    figure('Name',['Morphological Gradient - ',files(imgIdx).name]);

    subplot(1,2,1);
    imshow(BW);
    title('Original Binary Image');

    subplot(1,2,2);
    imshow(BW_gradient);
    title('Morphological Gradient');

    %% 5. BOUNDARY EXTRACTION

    BW_boundary = bwperim(BW_close);

    figure('Name',['Boundary Extraction - ',files(imgIdx).name]);

    subplot(1,2,1);
    imshow(BW_close);
    title('Processed Binary Image');

    subplot(1,2,2);
    imshow(BW_boundary);
    title('Extracted Boundaries');

    %% 6. HIT OR MISS TRANSFORMATION

    SE_hit = strel('arbitrary', ...
        [0 1 0; 1 1 1; 0 1 0]);

    SE_miss = strel('arbitrary', ...
        [1 0 1; 0 0 0; 1 0 1]);

    BW_hitmiss = bwhitmiss(BW,SE_hit,SE_miss);

    figure('Name',['Hit or Miss - ',files(imgIdx).name]);

    subplot(1,2,1);
    imshow(BW);
    title('Binary Image');

    subplot(1,2,2);
    imshow(BW_hitmiss);
    title('Hit-or-Miss Result');

    %% 7. CONNECTED COMPONENT ANALYSIS

    CC = bwconncomp(BW_close);

    stats = regionprops(CC,'Area','Centroid','BoundingBox');

    BW_components = labelmatrix(CC);

    figure('Name',['Connected Components - ',files(imgIdx).name]);

    subplot(1,2,1);
    imshow(BW_close);
    title('Segmented Image');

    subplot(1,2,2);
    imshow(label2rgb(BW_components,'jet','k','shuffle'));
    title('Connected Components');

    fprintf('\nConnected Components Analysis:\n');
    fprintf('Number of detected regions: %d\n',CC.NumObjects);

    for k = 1:length(stats)
        fprintf('Region %d: Area = %.0f pixels\n', ...
            k,stats(k).Area);
    end

    %% UNIT 4 SUMMARY

    figure('Name',['Unit 4 Summary - ',files(imgIdx).name]);

    subplot(2,3,1);
    imshow(I);
    title('Original X-ray');

    subplot(2,3,2);
    imshow(BW);
    title('Threshold Segmentation');

    subplot(2,3,3);
    imshow(BW_eroded);
    title('Erosion');

    subplot(2,3,4);
    imshow(BW_dilated);
    title('Dilation');

    subplot(2,3,5);
    imshow(BW_open);
    title('Opening');

    subplot(2,3,6);
    imshow(BW_close);
    title('Closing');

    sgtitle(['Unit 4 Summary: ',files(imgIdx).name]);

    %% FINAL PROJECT OUTPUT

    figure('Name',['Final Dental X-ray Output - ',files(imgIdx).name]);

    subplot(1,3,1);
    imshow(I);
    title('Original X-ray');

    subplot(1,3,2);
    imshow(I_clahe);
    title('Enhanced X-ray');

    subplot(1,3,3);
    imshow(BW_boundary);
    title('Segmented Boundaries');

    sgtitle(['Dental X-ray Project: ',files(imgIdx).name]);

    %% COMPLETION STATUS

    fprintf('\nCompleted Image %d of %d\n', ...
        imgIdx,length(files));

fprintf('\n====================================\n');
fprintf('ALL DENTAL IMAGES PROCESSED!\n');
fprintf('Total Images: %d\n',length(files));
fprintf('AHP-1, UNIT 3 AND UNIT 4 COMPLETED.\n');
fprintf('====================================\n');