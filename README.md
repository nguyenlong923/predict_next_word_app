# predict_next_word_app

This is the source code of an application predicting the next word based on previously typed words/phrases.
https://nguyenlong923.shinyapps.io/predict_next_word_app/  
Such application will facilitate typing on smart phone.  
This application was built for the final Capstone project of the "Data Science Specialization" of Jons Hopkins University on Coursera.  

The algorithm used to make the prediction is built based on the Coursera-Swiftkey dataset.  
The dataset is from a Corpus that collected corpora from publicly available sources (i.e. blogs, news, twitter) by a web crawler  
(click [here](https://www.coursera.org/learn/data-science-project/supplement/4phKX/about-the-copora) for more information).  

The application, specialized for English language, predicts the next word using a N-gram models.  
This model is made from 0.5% of the Coursera-Swiftkey dataset.  
The predict_next_word_app is simple and easy to use.
Just type on the blank an unfinished English phrase and three predicted next words will automatically display.  
Each word is clickable and after clicking, the word will be added to your phrase.  
Of course, three new predictions will appear automatically afterward.
