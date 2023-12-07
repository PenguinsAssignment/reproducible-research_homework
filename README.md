# Reproducible research: version control and R

## Question 4

### i) Observations: executing the code to generate random walks

The code provided models random motion to generate a path - a random walk. The code generates two plots of random walks in 500 steps with paths mapped out in space on a two dimensional coordinate grid. A blue colour gradient illustrates the course of the path in time steps.  At time step 1, the coordinate position of the random walk is set to (0,0). A loop then runs between steps 2 and n (set here as n_steps = 500); the size of the steps is set (h = 0.25) and a random angle of the next steps direction in space is generated within the bounds of 0 and 2π (a complete circle). The code creates two plots to show two walks simulations. Each time the code is run, a different random walk is simulated and the output plots observed are different.

#### Example of two random walks from the code output 
<img width="956" alt="image" src="https://github.com/PenguinsAssignment/reproducible-research_homework/assets/150163891/e329913f-b009-4732-b705-47a24005a51e">


### ii) Using random seeds

A random seed is an integer, or a set of integers that set an initial starting point in computational random number generation (James _et al_. 2013). Setting a seed will ensure that when generating a set of random nubers, the exact same set of random numbers can be generated again (James _et al_. 2013). This has key applications for consistency and reproducibility when trying to repeat code that incorporates random number generation, and in sharing this code. The receiver of the shared code should generate the same output. The set.seed() function on R is the standard method to specify seeds when randomly generating numbers (Adler, 2012). The function is able to take on any arbitrary integer as a value passed to into it. Reproducibility in the random walk script would be acheived by controlling for randomness in repeat code runs with an edit to add in set.seed().

### iii) Script edit:  generating a reproducible simulation of Brownian motion

(link to script here)

### iv) Script edit: showing the modification in comparison view

The edit I added: 
```
set.seed(2024)
```


## Question 5

### i) Investigating the Cui _et al_. (2014) data 

### ii) Applying a transformation to fit a linear model 

### iii) Finding the exponent and scaling factor

### iv) Code to produce figure 

#### Code

#### Output


## Bonus Question

### Reproducibility vs replicability in scientific research

(The Turing Way Community. 2022)

# References

Joseph Adler (2012). R in a Nutshell, 2nd Edition. Sebastopol :O'Reilly Media, Inc.

Gareth James, Daniela Witten, Trevor Hastie, Robert Tibshirani. (2013). An introduction to statistical learning : with applications in R. New York :Springer.

The Turing Way Community. (2022). The Turing Way: A handbook for reproducible, ethical and collaborative research. Zenodo. doi: 10.5281/zenodo.3233853.

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
