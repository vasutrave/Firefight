# Firefight
Data analytics-2017 Project 


This project is mainly aimed at analysing wildfires in the US 1992-2015

#Exploratory Analysis:
(exploratoryanalysis.r)
The number of fires over the years are categorrixed on the basis of the state 
they occured in, counties, what were they caused by, what was the share of 
large fires etc .
(firefight.r)
Here we tried to plot heat maps and a geographical map showing the density of number
of fires in that particular state.

#Classification and Regression :

Logistic regression model was applied to see how we could predict the cause of the fire
given where it occured, how huge it was and in when it occured. Hence we found out 
that logistic regression doesnt really perform well on this prediction.
(logistic.r)

(Running these models takes 10mins-20mins depending on the system)
We used decision trees to classify the given fires according to the season when the
size of the fire,cause of the fire and the state in which the fire occurs is given.
After decision trees we used random forest to test the same and found out that 
the decision tree performs better than the random forest model .
(DTFinal.R)

Outputs.txt has the observations for both the above models  

#TimeSeries
When the data of number of fires over the given time was observed, we found that 
there is a particular seasonality and that the number of fires have reduced 
over the time. there are two peaks every year around February and July-September
(TimeSeries .R)

