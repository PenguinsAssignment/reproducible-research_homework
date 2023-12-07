# Reproducible research: version control and R

## Question 4

### i) Observations: executing the code to generate random walks

The code provided models random motion to generate a path - a random walk. The code generates two plots of random walks in 500 steps with paths mapped out in space on a two dimensional coordinate grid. A blue colour gradient illustrates the course of the path in time steps.  At time step 1, the coordinate position of the random walk is set to (0,0). A loop then runs between steps 2 and n (set here as n_steps = 500); the size of the steps is set (h = 0.25) and a random angle of the next steps direction in space is generated within the bounds of 0 and 2π (a complete circle). The code creates two plots to show two walks simulations. Each time the code is run, a different random walk is simulated and the output plots observed are different.

#### Example of two random walks from the code output 
<img width="956" alt="image" src="https://github.com/PenguinsAssignment/reproducible-research_homework/assets/150163891/e329913f-b009-4732-b705-47a24005a51e">


### ii) Using random seeds

A random seed is an integer, or a set of integers that set an initial starting point in computational random number generation (James _et al_. 2013). Setting a seed will ensure that when generating a set of random nubers, the exact same set of random numbers can be generated again (James _et al_. 2013). This has key applications for consistency and reproducibility when trying to repeat code that incorporates random number generation, and in sharing this code. The receiver of the shared code should generate the same output. The set.seed() function on R is the standard method to specify seeds when randomly generating numbers (Adler, 2012). The function is able to take on any arbitrary integer as a value passed to into it. Reproducibility in the random walk script would be acheived by controlling for randomness in repeat code runs with an edit to add in set.seed().

### iii) Script edit:  generating a reproducible simulation of Brownian motion

The edits I added used the code: 
```R
set.seed()
```

1) First I added set.seed (2024) just once to the document (to line 7). 

2) I realised there may be issues in running reproducible code if that line was omitted accidentally. I then added set.seed() twice; once before creating data1 and once before creating data2 to feed into plot1 and plot2 respectively.

   Link to script following edit 2: https://github.com/PenguinsAssignment/reproducible-research_homework/blob/main/question-4-code/random_walk.R

 #### Random walk output of the reproducible code
 <img width="954" alt="image" src="https://github.com/PenguinsAssignment/reproducible-research_homework/assets/150163891/19e2bb20-b51f-4255-8e35-74c605188e51">
   (The plots above will be the same any time all of the code is run)

### iv) Script edit: showing the modification in comparison view

#### Edit 1

<img width="461" alt="image" src="https://github.com/PenguinsAssignment/reproducible-research_homework/assets/150163891/0db5be83-ad4f-4cc6-a1e4-d7dfc1d4fd71">

Link to edit 'Update random_walk.R': https://github.com/PenguinsAssignment/reproducible-research_homework/commit/0e4fe06d44657118f7a1d53d77e499ceefbe58bf

#### Edit 2

<img width="456" alt="image" src="https://github.com/PenguinsAssignment/reproducible-research_homework/assets/150163891/228d7f0e-b0f9-4f96-9fa9-ad340e21df9b">

Link to edit 'Update random_walk_2.R': https://github.com/PenguinsAssignment/reproducible-research_homework/commit/128f0001db502f2f4b9be9e2c386cf014f62d0bf

#### Commit History

Version control allows both these edits to be viewed in the commit history. 

<img width="456" alt="image" src="https://github.com/PenguinsAssignment/reproducible-research_homework/assets/150163891/0f18d045-4a80-4fbd-890e-61272d14214c">

Link to history: https://github.com/PenguinsAssignment/reproducible-research_homework/commits/main/question-4-code


## Question 5

### i) Investigating the Cui _et al_. (2014) data 

The data table has 33 rows and 13 columns. 

```R
#install.packages(dplyr)
library(dplyr)

data <- read.csv("cui_etal2014.csv")
glimpse(data)
nrow(data) #33
ncol(data) #13
```

### ii) Applying a transformation to fit a linear model 

A log transformation can be applied to linearise the data such that it is appropriate to fit a linear model. Log transformations are frequently appliead to linearise exponential data that spans mutliple magnitudes. 

```R
data_loglog <-  data %>%
  mutate_at(vars(Virion.volume..nm.nm.nm., Genome.length..kb.), log) %>% 
  rename("log_volume" = Virion.volume..nm.nm.nm.,
         "log_length" = Genome.length..kb.)

data_loglog
 #prints to check that both variables have been logged in the transformed data
```

### iii) Finding the exponent and scaling factor

#### On fitting a linear model to log transformed data: 

- Exponent (a) = 1.5152
- Scaling factor (B)
  - log-transformed = 7.0748
  - back-transformed =  1181.807
    
#### On comparing the model values to the paper 

- Exponent = 1.52 ( to 3 significant figures); this is the value the paper reported for dsDNA viruses.
- Scaling factor = 1182 ( to 4 significant figures ); this is the value the paper reported for dsNA viruses.

```R
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

# To then back transform  the intercept
exp(7.0748) # = 1181.807

```

### iv) Code to produce figure 

#### Code

```R
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
```
(see output in question five of the instructions below)

Link to all code printed above in one R script 'viral_data.R' (within this repository): https://github.com/PenguinsAssignment/reproducible-research_homework/blob/main/viral_data.R

### v) estimated volume of a 300 kb dsDNA virus

The estimated volume based on the model estimates = 6697006 nm^3

```R
# Define the parameters 
  # These are based on estimates from the linear model
B <- 1181.807 
a =  1.5152  

# Define the function
estimate_vol <- function(L) {
  (V = B*L^a)
  return(V)}

# Call on the function at L = 300
V300 <- estimate_vol(300)

V300 # = 6697006
  #Prints result
```

## Bonus Question

### Reproducibility vs replicability in scientific research

Having clear, concise, and agreed-upon definitions of reproducibility and replicability is important to the scientific community; they are two principles that advance the wider field of research. Definitions have in the past varied between those set out by Claerbout and Karenbach (1992) to those set out by the Association for Computing Machinery, ACM (2013) (The Turing Way Community. 2022).I will employ the definitions as set out by The Turing Way Community. (2022). 

Reproducibility refers to the principle of generating precisely the same results the original researcher achieves using the same data file and same processing and analytical methods. Other researchers should be able to reach this same result, controlling for the possible effect that the results generated are contingent on the analysis. Contrastingly, replicability refers to the ability to generate results that are not precisely the same but are consistent, when the analysis is the same however the input data is different. The difference of the input data its what sets replicability apart from reproducibility. Consistent results are defined as those that while not precisely the same, are similar in a qualitative manner. 

Beyond reproducibility and replicability, robustness and generalisability are also assets of high quality research. A dataset that can generate the same results when different analytical processes are applied, produces a robust result. Generalisable results combine multiple datasets, and analytical work flows to assess the overall state of research in answering the over-arching research question. 

Git and GiHhub facilitate reproducibility and replicability in computationally-assisted research. Workflows are generated where it is possible for users to see where edits to code were made in time to see how a final result-generating pipeline is reached. As demonstrated in this assignment, it is possible to share code and fork a researchers repository to replicate it make changes locally. Local changes, can also be merged back into the original repository meaning data pipelines can be built upon and developed by multiple collaborators simultaneously. Finally, the ability to upload folders of raw data, scripts, and detailed README markdown's is valuable for approaching somebody else's code.

Possible limitations to using Git and GitHub include the principle that scripts and pipelines use packages that are available with software versions and packages available at the time. For example, new versions of R are released relatively frequently with new packages and updates available. This is not necessarily a limitation, if a research community takes responsibility for keeping pipelines and scripts up to date with software developments. An additional wider limitation to the use of a platform like GitHub to ensure reproducibility and replicability of the scientific method is that that computational processing and analysis may be just one component of the overall method. For example, in this assignment, little data was provided on the exact laboratory conditions in which the bacterial cultures were grown in Q1-3. Protocols.io seems to facilitate the review of more steps of this process for biotechnological and pharmaceutical research. All aspects of data collection, experimental design and hypothesis configuration should be considered when assessing the quality of research whether they be lab or field protocols to generate results. Finally, caution should be employed with uploading analysis that concerns sensitive data; GDPR laws should be adhered to at all times. 


## References

1) Joseph Adler (2012). R in a Nutshell, 2nd Edition. Sebastopol :O'Reilly Media, Inc.

2) Gareth James, Daniela Witten, Trevor Hastie, Robert Tibshirani. (2013). An introduction to statistical learning : with applications in R. New York :Springer.

3) Cui, J., Schlub, T. E., & Holmes, E. C. (2014). An Allometric Relationship between the Genome Length and Virion Volume of Viruses. Journal of Virology, 88(11), 6403–6410. https://doi.org/10.1128/jvi.00362-14

4) The Turing Way Community. (2022). The Turing Way: A handbook for reproducible, ethical and collaborative research. Zenodo. doi: 10.5281/zenodo.3233853.


------------------ 
## Instructions

The homework for this Computer skills practical is divided into 5 questions for a total of 100 points (plus an optional bonus question worth 10 extra points). First, fork this repo and make sure your fork is made **Public** for marking. Answers should be added to the # INSERT ANSWERS HERE # section above in the **README.md** file of your forked repository.

Questions 1, 2 and 3 should be answered in the **README.md** file of the `logistic_growth` repo that you forked during the practical. To answer those questions here, simply include a link to your logistic_growth repo.

**Submission**: Please submit a single **PDF** file with your candidate number (and no other identifying information), and a link to your fork of the `reproducible-research_homework` repo with the completed answers. All answers should be on the `main` branch.

## Assignment questions 

1) (**10 points**) Annotate the **README.md** file in your `logistic_growth` repo with more detailed information about the analysis. Add a section on the results and include the estimates for $N_0$, $r$ and $K$ (mention which *.csv file you used).
   
2) (**10 points**) Use your estimates of $N_0$ and $r$ to calculate the population size at $t$ = 4980 min, assuming that the population grows exponentially. How does it compare to the population size predicted under logistic growth? 

3) (**20 points**) Add an R script to your repository that makes a graph comparing the exponential and logistic growth curves (using the same parameter estimates you found). Upload this graph to your repo and include it in the **README.md** file so it can be viewed in the repo homepage.
   
4) (**30 points**) Sometimes we are interested in modelling a process that involves randomness. A good example is Brownian motion. We will explore how to simulate a random process in a way that it is reproducible:

   - A script for simulating a random_walk is provided in the `question-4-code` folder of this repo. Execute the code to produce the paths of two random walks. What do you observe? (10 points)
   - Investigate the term **random seeds**. What is a random seed and how does it work? (5 points)
   - Edit the script to make a reproducible simulation of Brownian motion. Commit the file and push it to your forked `reproducible-research_homework` repo. (10 points)
   - Go to your commit history and click on the latest commit. Show the edit you made to the code in the comparison view (add this image to the **README.md** of the fork). (5 points)

5) (**30 points**) In 2014, Cui, Schlub and Holmes published an article in the *Journal of Virology* (doi: https://doi.org/10.1128/jvi.00362-14) showing that the size of viral particles, more specifically their volume, could be predicted from their genome size (length). They found that this relationship can be modelled using an allometric equation of the form **$`V = \beta L^{\alpha}`$**, where $`V`$ is the virion volume in nm<sup>3</sup> and $`L`$ is the genome length in nucleotides.

   - Import the data for double-stranded DNA (dsDNA) viruses taken from the Supplementary Materials of the original paper into Posit Cloud (the csv file is in the `question-5-data` folder). How many rows and columns does the table have? (3 points)
   - What transformation can you use to fit a linear model to the data? Apply the transformation. (3 points)
   - Find the exponent ($\alpha$) and scaling factor ($\beta$) of the allometric law for dsDNA viruses and write the p-values from the model you obtained, are they statistically significant? Compare the values you found to those shown in **Table 2** of the paper, did you find the same values? (10 points)
   - Write the code to reproduce the figure shown below. (10 points)

  <p align="center">
     <img src="https://github.com/josegabrielnb/reproducible-research_homework/blob/main/question-5-data/allometric_scaling.png" width="600" height="500">
  </p>

  - What is the estimated volume of a 300 kb dsDNA virus? (4 points)

**Bonus** (**10 points**) Explain the difference between reproducibility and replicability in scientific research. How can git and GitHub be used to enhance the reproducibility and replicability of your work? what limitations do they have? (e.g. check the platform [protocols.io](https://www.protocols.io/)).
