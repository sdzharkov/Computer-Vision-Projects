function [ idf_weights ] = create_tf_idf_word( Frame )
%% 
% this function creates a matrix of TF-IDF ratios that will be later used
% to query regions. Initially, this function finds the top 300 "stop-words"
% that will be deleted from the descriptors. It then find the inverse document
% frequency. 

%% Delete the stop words 

[m,n] = size(Frame.histogram);
totalWords = m*n;

idf_weights = zeros(m,n);
sums = sum(Frame.histogram);

[x,y] = sort(sums, 'descend');

deletedWords = y(1:300); % delete the top 300 most prominent stop-words

histogram = Frame.histogram;
histogram(:,deletedWords) = 1; % deleted words

sums = sum(histogram); % recalculate the sums

%% Create the tf-idf constant 

for i=1:m
    for j=1:n
        idf_weights(i,j) = ((histogram(i,j)/sum(histogram(i,:))) * log(totalWords / sums(j)));
    end
end

save('tf_idf_weights.mat', 'idf_weights');


end

