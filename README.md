# Computer-Vision-Projects

## SIFT: Using a bag-of-words for Video Search
This project allows a user to search within the frames of a video for the nearest object. A user selects the item or region of interests, which corresponds to a bag-of-words corresponding to the item. Items are compared using SIFT (Scale Invariant Feature Transform) descriptors. 

### How it Works
The code uses a visual vocabulary of 90,000 words using a random sample of 15 frames from each provided frame. Using the SIFT descriptor of a given frame, we create a histogram that model the distance of each descriptor to a visual word. These histograms can then be compared against one another to find similar distances. We use the Euclidean distance and k-Means to best associate features. This program was also optimized using tf-idf weighing (removing common words and using a matrix of weights to better associate frames). 

## Seam Carving: Removing Low Intensity pixels to reduce Image Size
This project is able to cut down the width and height of an image by removing low intensity pixels. This is achieved through a dynamic programming approach that analyzes similarity between nearby pixels, and cutting the optimal collection of pixels from an image. 

## Homography: Morphing Images Together Without Photoshop
This program is able to combine multiple images using a homography matrix computed between the two images. 
