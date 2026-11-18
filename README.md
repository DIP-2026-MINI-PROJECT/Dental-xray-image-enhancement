# Dental X-Ray Image Enhancement and Abnormal Region Segmentation

## Project Description
This project implements a Digital Image Processing (DIP) system using MATLAB to enhance dental X-ray images and perform segmentation of image regions. It applies grayscale conversion, image transformations, contrast enhancement, spatial and frequency-domain filtering, thresholding and morphological operations to improve image visibility and extract boundaries.

## Summary
The project processes dental X-ray images using classical image-processing techniques without machine learning. It enhances image contrast using CLAHE, applies different filters to reduce noise and improve details, and uses adaptive thresholding and morphological operations to segment regions. Connected-component analysis is used to identify and measure separate regions.

## Course Concepts Used
- Digital Image Fundamentals
- Image acquisition and grayscale conversion
- Pixel representation and matrix operations
- Histogram analysis
- Discrete Fourier Transform (DFT) and Discrete Cosine Transform (DCT)
- Inverse DFT and inverse DCT
- Image enhancement and restoration
- Histogram equalization and CLAHE
- Mean, median and Gaussian filtering
- Butterworth low-pass and high-pass filtering
- Image thresholding and segmentation
- Morphological operations

## Additional Concepts Used
- MATLAB Image Processing Toolbox
- Adaptive thresholding
- Morphological gradient
- Boundary extraction
- Hit-or-miss transformation
- Connected-component analysis
- Region property measurement using area, centroid and bounding box

## Dataset
The project uses dental X-ray images stored in `Dataset.zip`.

The MATLAB program extracts the ZIP archive, searches recursively for PNG images and processes them individually.

## Novelty
The project combines multiple classical Digital Image Processing techniques into a single workflow for dental X-ray enhancement and region segmentation. It integrates contrast enhancement, spatial and frequency-domain filtering, and morphological processing to provide visual comparison between original, enhanced and segmented images.

## Contributors
- Shraddha MS
- Ruqiya Khanum
- Harshitha SS

## Steps
1. Load the dental X-ray dataset.
2. Extract the ZIP file and identify PNG images.
3. Read the images and convert RGB images into grayscale.
4. Analyse image dimensions, pixel values and histograms.
5. Apply image transformations and contrast enhancement.
6. Perform spatial filtering using mean, median and Gaussian filters.
7. Apply Butterworth low-pass and high-pass filtering.
8. Perform adaptive thresholding on the enhanced image.
9. Apply erosion, dilation, opening and closing.
10. Extract boundaries and perform connected-component analysis.
11. Display and save the processed output images.

## Outputs
The system generates the following output images:

- Original dental X-ray
- Grayscale image
- CLAHE-enhanced image
- Median-filtered image
- Gaussian-filtered image
- Sharpened image
- Butterworth-filtered image
- Threshold-segmented image
- Morphological processing results
- Extracted boundary image
- Connected-component visualisation

The processed PNG images are stored in the `outputs` folder.

## References
1. MathWorks – MATLAB Image Processing Toolbox: https://www.mathworks.com/help/images/
2. MathWorks – Image Acquisition and Processing: https://www.mathworks.com/help/matlab/
3. MathWorks – CLAHE (`adapthisteq`): https://www.mathworks.com/help/images/ref/adapthisteq.html
4. MathWorks – Morphological Image Processing: https://www.mathworks.com/help/images/morphological-filtering.html

## Limitations and Future Work

### Limitations
- Segmentation results depend on threshold sensitivity and structuring-element size.
- Some normal anatomical structures may also appear as segmented regions.
- Filtering may cause loss of fine image details.
- The extracted boundaries may contain noise and unwanted regions.
- The system is not clinically validated and cannot provide a medical diagnosis.

### Future Work
- Improve segmentation accuracy by optimising threshold parameters.
- Reduce unwanted noise in the segmented output.
- Improve boundary extraction to obtain clearer regions.
- Evaluate the system on a larger and more diverse dental X-ray dataset.
- Explore additional image-processing techniques for improved visualisation.
