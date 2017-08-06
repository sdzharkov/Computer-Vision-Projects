ECS174 PS3 Description
Author: Stephan Zharkov

Functions and Scripts

1) create_tf_idf_word.m 
this function creates a matrix of TF-IDF ratios that will be later used
to query regions. Initially, this function finds the top 300 "stop-words"
that will be deleted from the descriptors. It then find the inverse document
frequency. Returns a .mat file called 'tf_idf_weights.mat'

2) createHistogram.m
this function returns a histogram for a specific frame and its descriptors.

3) getAllFeatures.m
This function creates a object that holds 90,000 random specific descriptors.
It iterates through all of the frames, and selects 15 random descriptors from
each frame. It saves and returns a 'allFeatures3.mat' file.

4) getHistograms.m
This function creates a histogram for every single frame provided. It returns
and saves a file called 'frames.mat'. 

5) normalizedProduct.m
This function does the normalized product between two histograms.

6) fullFrameQueries.m
This function performs full frame query searches on 20 random images. 
It runs in a loop, creating and saving subplots after the query image. 
Be careful when running, it will save 20 full frame query searches.

7) rawDescriptorMatches.m
This function performs rawDescriptorMatching on the specified file 'twoFrameData'.
We set a threshold to better find descriptors in the specified region.

8) regionQueries.m
This function performs regionQueries on an image. It will randomly select an image,
and you will be required to select a region. It will output the query. 

9) visualizeVocabulary.m
This function will find words closest to a specified word. It runs in a loop of 20, 
finding 20 words nearest. 

10) weightingTF.m
This function performs the TF-IDF and word-stop region search. The user specifies the region
and the function will return the search with the implementation of tf-idf. 

MAT Files. 

To save time throughout the program, I saved .mat files to use time. If you are to run
a specific function, you will notice that I commented out the place where the function would
need to be run, and instead just loaded the file. 

1) allFeatures3.mat
This file stores 90,000 uniformly selected descriptors from all of the frames. The object
'allFeatures' is represented as: 
    descriptors: [93330�128 double]
        orients: [93330�1 double]
      positions: [93330�2 double]
         scales: [93330�1 double]
         origin: {93330�1 cell}
      
2) frames.mat
This file stores the histogram and location of each frame. The object Frames is represented as:
    histogram: [6612�1500 double]
     location: {6612�1 cell}
     
3) kMeans.mat
This file is the means done when we ran kMeans.

4) membership.mat
This is the file I used for the membership and means after running kMeans on my data.
It has two objects, 'membership' and 'means'

5) tf_idf_weights.mat
This file holds all of the updated histograms after running stop-words and ti-idf. The object is
called 'idf_weights'.

6) twoFrameData.mat
Given.

     



