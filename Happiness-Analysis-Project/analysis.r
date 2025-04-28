# analysis.R

# Load libraries
library(dplyr)
library(ggplot2)
library(corrplot)
library(readr)
library(caret)

# Load data
happiness <- read_csv("data/world-happiness-report.csv")

# Data Cleaning
happiness <- happiness %>%
  select(Country, Happiness_Score, GDP_per_Capita, Social_Support, Healthy_Life_Expectancy, Freedom, Generosity, Corruption)

# Remove missing values
happiness <- na.omit(happiness)

# View the cleaned data
head(happiness)
summary(happiness)

# ========================
# Exploratory Data Analysis
# ========================

# 1. Correlation Matrix
cor_matrix <- cor(happiness[,2:8])

# Visualize correlation
corrplot(cor_matrix, method = "color", type = "upper", tl.cex = 0.8)

# 2. Pairwise Scatterplots
pairs(happiness[,2:5], main = "Scatterplot Matrix")

# 3. GDP vs Happiness Score Plot
ggplot(happiness, aes(x = GDP_per_Capita, y = Happiness_Score)) +
  geom_point(color = "steelblue") +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Happiness Score vs GDP per Capita",
       x = "GDP per Capita (Log Scale)",
       y = "Happiness Score") +
  theme_minimal()

# 4. Boxplot: Happiness by High/Low GDP
happiness <- happiness %>%
  mutate(GDP_Category = ifelse(GDP_per_Capita > median(GDP_per_Capita), "High GDP", "Low GDP"))

ggplot(happiness, aes(x = GDP_Category, y = Happiness_Score, fill = GDP_Category)) +
  geom_boxplot() +
  labs(title = "Happiness Score by GDP Category",
       x = "GDP Category",
       y = "Happiness Score") +
  theme_minimal() +
  scale_fill_manual(values = c("Low GDP" = "#F1948A", "High GDP" = "#5DADE2"))

# ========================
# Modeling
# ========================

# Linear Regression Model
model <- lm(Happiness_Score ~ GDP_per_Capita + Social_Support + Healthy_Life_Expectancy +
              Freedom + Generosity + Corruption, data = happiness)

# Model Summary
summary(model)

# Predicting Happiness (optional)
happiness$Predicted_Happiness <- predict(model, newdata = happiness)

# Scatter Plot: Actual vs Predicted Happiness
ggplot(happiness, aes(x = Happiness_Score, y = Predicted_Happiness)) +
  geom_point(color = "darkgreen") +
  geom_abline(slope = 1, intercept = 0, color = "red") +
  labs(title = "Actual vs Predicted Happiness Score",
       x = "Actual Happiness Score",
       y = "Predicted Happiness Score") +
  theme_minimal()

# Save important outputs (optional)
write.csv(happiness, "data/happiness_predictions.csv", row.names = FALSE)

# End of Analysis
