# predict_next_word_app

This is the source code of an application predicting the next word based on previously typed words/phrases.
https://nguyenlong923.shinyapps.io/predict_next_word_app/  
Such application will facilitate typing on smart phone.  
This application was built for the final Capstone project of the "Data Science Specialization" of Jons Hopkins University on Coursera.  

The algorithm used to make the prediction is built based on the Coursera-Swiftkey dataset.  
The dataset is from a Corpus that collected corpora from publicly available sources (i.e. blogs, news, twitter) by a web crawler  
(click [here](https://www.coursera.org/learn/data-science-project/supplement/4phKX/about-the-copora) for more information).  

First, I explored and summarised the data to determine a prediction method.  
The prediction can be made using a N-gram models built from 0.5% of the Coursera-Swiftkey dataset.  
The code used for exploration and investigation of the data is in the R Markdown files "milestone_report".  
An HTML version of the report can be found here: https://rpubs.com/nguyenlong923/446207.  

In the second step, I built the application focusing on the simplicity and speed.
Users can just type on the blank an unfinished English phrase and three predicted next words will automatically display.  
Each word is clickable and after clicking, the word will be added to your phrase.  
Of course, three new predictions will appear automatically afterward.
