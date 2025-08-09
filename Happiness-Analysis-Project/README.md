# 🌍 Global Happiness Report Analysis

This project explores and analyzes the factors influencing the happiness of countries using the **World Happiness Report** data.  
We perform **data analysis**, **visualization**, **regression modeling**, and build a simple **interactive Shiny dashboard**.

---

## 📚 Project Structure

```plaintext
Happiness-Analysis-Project/
├── data/
│   └── world-happiness-report.csv
├── app.R             # Shiny Dashboard Application
├── analysis.R        # Data Analysis and Modeling Script
├── README.md         # Project Documentation
```

## 🛠️ Tech Stack

R Programming Language

Libraries Used:

dplyr (data manipulation)

ggplot2 (visualization)

corrplot (correlation analysis)

shiny + shinydashboard (web dashboard)

caret (model evaluation)

## 📊 Features

Clean and preprocess the global happiness dataset

Perform exploratory data analysis (EDA)

Generate a correlation matrix and visualizations

Build a linear regression model to predict happiness score

Compare predicted vs actual happiness scores

Interactive Shiny dashboard:

Filter countries by GDP

Select variables for visualization

View summary statistics dynamically

## 📈 Key Findings

GDP per Capita, Social Support, and Healthy Life Expectancy are strong predictors of Happiness Score.

Countries with higher GDP generally report higher happiness, but other factors like freedom and social support are equally important.

Linear regression model achieved a reasonably high Adjusted R² value, showing a good fit.

## 🚀 How to Run

Clone the repository or download the project files.

Place the dataset inside the data/ folder.

Open RStudio.

Install required libraries (one-time):

r
Copy
Edit
install.packages(c("dplyr", "ggplot2", "corrplot", "shiny", "shinydashboard", "readr", "caret"))
Run analysis.R for data analysis and modeling.

Run app.R to launch the Shiny dashboard:

r
Copy
Edit
shiny::runApp()
The app will automatically open in your web browser.

## 📂 Dataset
Name: World Happiness Report

Source: Kaggle Dataset Link

## 📌 Future Enhancements
Implement clustering to group countries with similar happiness profiles

Add time-series analysis for multi-year happiness trends

Deploy the Shiny app online (using ShinyApps.io)

Integrate machine learning models for advanced prediction (Random Forests, XGBoost)




