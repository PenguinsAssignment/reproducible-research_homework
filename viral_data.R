# cui_etal2014.csv is available from: 
  # https://github.com/PenguinsAssignment/reproducible-research_homework/blob/main/question-5-data/Cui_etal2014.csv


#install.packages(dplyr)
library(dplyr)
  #includes functions used here including glimpse() and pipe operator %>% 


data <- read.csv("cui_etal2014.csv")

glimpse(data)

# Rows and columns 

nrow(data) #33

ncol(data) #13

# Log transform to linearise the data and fit a linear model 

data_loglog <-  data %>%
  mutate_at(vars(Virion.volume..nm.nm.nm., Genome.length..kb.), log) %>% 
  rename("log_volume" = Virion.volume..nm.nm.nm.,
         "log_length" = Genome.length..kb.)

data_loglog 
  #prints to check that both variables have been logged in the transformed data


# Create a linear model from the log transformed data 
linear_model <- lm(log_volume ~ log_length, data =  data_loglog)

summary(linear_model) # calls lm() and prints results table

# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)   7.0748     0.7693   9.196 2.28e-10 ***
#   log_length    1.5152     0.1725   8.784 6.44e-10 ***

linear_model # calls lm() prints key coefficients in model only 

  # Intercept = 7.075, log_length = 1.15
    # See table above: both values are statistically significant, p < 0.001(***)

# Recall V = BL log transformed by exponent a (denoting alpha) is log(v) = log(B) + a*log(L)

  #log(v) = 7.0748 + 1.5152*log(L)

# To then back transform

  # the intercept
exp(7.0748) # = 1181.807


# Generating a plot 

#install.packages("ggplot2")
library(ggplot2)

plot <- ggplot(data = data_loglog, aes(x=log_length, y=log_volume)) +

    geom_point() +
    geom_smooth(method='lm') +
    labs(x = "log[Genome length (kb)]", y= "log[Virion volume (nm3)]") +
    theme_bw() +
    theme(axis.title = element_text(face = "bold"))
            
plot 
  #prints the plot

# If necessary to save the plot as a PNG file use:
  #ggsave("plot.png", plot, width = 6, height = 5, dpi = 300)



