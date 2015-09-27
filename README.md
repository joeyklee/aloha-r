# An intoduction to R:
<!--

<img src="http://spatialanalysis.co.uk/wp-content/uploads/2012/06/flights_sml.jpg">

Run Keeper Data - Boston, Nathan Yau (http://flowingdata.com/2014/02/05/where-people-run/)
<img src ="http://flowingdata.com/wp-content/uploads/2014/02/Boston.png">

<img src="http://spatial.ly/wp-content/uploads/2014/11/commute_flows_before_after.jpg">

<img src = "http://spatial.ly/wp-content/uploads/2014/11/relationship_status_before_after.jpg">

<img src="https://gastonsanchez.files.wordpress.com/2013/02/miserables_arcplot.png">

<img src = "http://spatial.ly/wp-content/uploads/2014/11/london_inspired_before_after.jpg"> -->

## About
This is an intro to the R programming language which we will use throughout the rest of the course and hopefully you'll use when you leave UBC and start your lives in research, industry, and beyond!

##S2: Requirements:

* First: download and install [R](http://cran.stat.sfu.ca/) - make sure you download the right one for your system.
	* For Windows users, you can choose between 32-bit and 64-bit versions of R, you need to choose which one is right for your computer. If you're really unsure, then choose the 32-bit, BUT if you don't mind google searching "32-bit or 64-bit windows for <insert computer model here>" 
* Second: download and install [R studio](https://www.rstudio.com/products/RStudio/#Desktop) (make sure to install R first!)


## Outline
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


<!-- END doctoc generated TOC please keep comment here to allow auto update -->


## Why are we learning R?

Why are we using R after spending all that time learning Processing? Well, first I would go back to the fact that programming languages are like materials, each with a distinct qualities, benefits, and limitations. In this way, it doesn't make sense to say one language is better or worse than another, rather that  they are just different. So why learn R? Here's why I chose to introduce R in this course:

* **High Level Programming Language**: R is what we consider a high level programming language. With a few lines of code, you can do *a lot* of stuff which is super nice when we're learning.
* **Easy to setup and has a nice Integrated Development Environment** (IDE): R is nice because it sort of lives within itself - it is easy to download, install, and setup, it is cross platform (it can be used in Windows, Mac OS, etc), and has a nice IDE called RStudio which we will use to help us write our code.
* **Large user community**: Like Processing, R has a HUGE user community that has grown to include domains of all sorts. This means also if you have a specific question that most likely someone has already found the answer and posted it online. The New York Times Data team is using R (among other things), for example! 
* **Super handy packages**: Because of the large user community people have developed packages for doing all sorts of cool things. Want to make an interactive map? Bam! There's an R package for that. Want to make a hillshade of a DEM in R? There's a package for that too! You'll start to see that packages will be your best friend, so use your favorite search engine and find the right packages for you!
* **Nice plots**: R kicks ass for plotting - and this is a data visualization class after all. With one line of code you can already start looking at your data, add a few more and you already have something pretty to look at. As a way of exploring and displaying your data, R is a nice way to go. 
* **Local expertise**: Its always handy to have people around to help you if you get stuck. There are plenty of people teaching R at UBC and also some expert grad students and faculty in Geography. 
* **Open source mapping**: When we dive further into R we'll start to see that we can start to do some really fancy geoprocessing in R - Basically your own, free, GIS :) When you leave UBC and no longer have access to proprietary software, you'll be happy to know that you have the tools to continue mapping away. 



# Getting Started

Throughout this workshop, try your best to make connections between what you learned in the intro to Processing to what R has to offer. There are some fundamental differences you will begin to notice, but you'll really quickly begin to see the advantages (and disadvantages) of using R. 

***
## R Studio IDE:

This is the R studio IDE. We will use R studio as our environment for running our code, making our scripts, and viewing our plots. It's sort of like our Processing PDE, with the major difference being that R is an ***interpreted*** language meaning we can run our code line-by-line versus Processing which is ***compiled*** which means Processing runs all of the code at once. You'll see why this is advantages for working with and exploring data. Anyways, because of this key difference, R studio is setup to help us explore our data line-by-line.

![](assets/img/rstudio.png)

Your typical R studio IDE will look like the above and includes:

* **Script window**:A place to put your script (your entire code)
* **R console**: every line of code your run from your script will be run, evaluated and printed here. 
* **Global Environment**: This will show all the variables you declare and assign. The fancy thing about R studio is that it will tell you what kind of variable it is and even let your preview your data that you read in!
* **Plot, Packages, Help, & more**: Your plots will be shown here. Also you will be able to find packages and access R's help documentation.

***
## Focus Things:
+ Print everything - check that things are working and see how you change and manipulate data with functions and operations.
+ Plot everything - again, check that things are working and see how you change and manipulate data with functions and operations.
+ Help your classmates and friends - these will be the people you work with in the future - this is your network! The stronger you guys are and closer you are, the better connections you'll have. 
+ (on the above point) the success of this workshop will be how the group collectively grows and learns so work together!  

***
# Quick Syntax review:
##S5.1:Mathematical operators in R
 While most of the mathematical operators are the same as in Processing, there's a few differences. Let's check out those mathematical operators in R again.

	Operator		Description
	+				addition
	-				subtraction
	*				multiplication
	/				division
	^ or **			exponentiation
	x %% y			modulus (x mod y) 5%%2 is 1
	x %/% y			integer division 5%/%2 is 2

***
##S5.2:Logical Operators in R

	Operator		Description
	<				less than
	<=				less than or equal to
	>				greater than
	>=				greater than or equal to
	==				exactly equal to
	!=				not equal to
	!x				Not x
	x | y			x OR y
	x & y			x AND y
	isTRUE(x)		test if X is TRUE

See, not so different from what we already know. We added a few changes and new operators like the **exponentation** and the **modulo which takes two %%**.

***
# Gettin' down and di-R-ty: 
After learning about the fundamental building blocks of programming (and the data visualization pipeline), the goal now is to apply our understanding by taking code and data and producing visual output.

Instead of learning how to code R from the bottom up (which we did with Processing), we will go from the top down, meaning: we are going to learn by running examples and in the process train ourselves to deconstruct the patterns and functions we pick up along the way. 

But before we get into some examples, let's do a quick tour of running code in R, some R systax and data types!
***
## Your First R commands: "Hello World" 
Let's start by just running a few commands in the **R Console**. **To run a command in the console window**, simply: 

* type your statement and 
* **press [enter]**. 

In the console window, let's write 3 statements and run them. Here's the result of running the 3 examples below. 

![](assets/img2/r-intro.png)

Try remixing these statements to produce different results:

* **Addition**

		5 + 3

* **Logical Operation**

		100 < 200

* **String**

		"Oops I did it again"

***
## Running code from the script window
Now that you've seen how R **reads**, **evaluates**, and **prints** the statements you feed it ***line-by-line***, . 

When running code line-by-line in the script window you:

1. Highlight the lines you want to run:

![](assets/img2/highlight.png)

2. then "run the code" by pressing at the same time:
	* On **Mac**: 		[cmd] 	+ [enter]
	* On **Windows**:	[ctrl]	+ [enter]  

The results will then be "printed" to the console:

![](assets/img2/script-print.png)

Now, to familiarize yourself with running code line-by-line from the script window, let's write another 3 statements, but this time **insert a comment** between each of the statements to neatly organize your code.

**NOTE: In R, comments are made by using the hash symbol (#)**


Try writing 3 examples of your own in the script window and seeing what is printed to the console:

* **Commenting**:

		# --- Gettin' Down and di-R-ty: an intro to R --- #
		# remember anything after the comment symbol is not evaluated

* **Multiplication**

		# Multiplication
		6 * 5

* **Exponentation**

		# Exponents
		5**2

* **String**

		# Strings
		"Hello World"

FYI, we can also use the *print()* function to print statements for us like this:

	# --- heres another way to print in R --- #
	print("Hello World!")
	print(5*10)
	print(10-3)

Run this and see that it return the same thing! Pretty neat stuff.

**NOTICE SOMETHING? WE DON'T NEED TO USE SEMI-COLONS (;) IN R!** This means that R doesn't use semi-colons to signify the end of a statement in contrast to Processing. Rather R uses line breaks to interpret each statement. Excited? Sad? Indifferent? In any case, just remember you **don't need semi-colons** to end statements in R. Are you beginning to see how programming languages all have their own flavor?

Now that you see how to run code line-by-line, let's dive further into some more exciting stuff.

***
## Variables, Data, & Plotting
Before we take a leap into a real-world example, it's worth noting a few fundamental things about R variables, data, and plotting.

### R Variables:
Unlike in Processing which is strongly typed, R is **losely typed** meaning that we don't need to specify the type of data that we are assigning to each variable - **notice we don't have to specify "int" or "float" or "String"** - R knows that type of data we are assigning!:

	# I'm an integer variable:
	x = 12
	print(x)
	
	# I'm a float variable:
	y = 16.5
	print(y)
	
	# I'm a string variable:
	z = "Hello"
	print(z)

### Fundamental R Data Types:
Here are a number of **fundamental R data types** that over time you will come to fully understand what they are, what makes them special, and when and where you would use them. For the 4 major data types below, all we need to now is that:

###Vectors (pretty much just a 1-D Array):
A vector in R is basically a collection of elements of the **same** datatype (e.g numeric, character, boolean.) - a 1-D array. We create a vector in R by using the **c()** function. The **c()** is short for "concatenate" which means "paste together or chain together in a series".
	
Here's 2 examples of a vectors: 
		
	# Here's some data of months of the year and the precipitation in Vancouver
	months = c(1, 2, 3, 4, 5, 6, 7, 8, 9 , 10, 11, 12)
	precipitation = c(186, 94, 118, 85, 60, 59, 38, 39, 48, 126, 183, 177)
	
And the cool thing is you can plot these bad boys:
	
plot the monthly precipitation data as a scatterplot:
		
	# A simple scatterplot:
	plot(x = months, y = precipitation)
		
![](assets/img2/precip-p.png)
	
Or how about a line plot:
		
	# a line plot:
	plot(x = months,y = precipitation, type="l")
	
![](assets/img2/precip-l.png)
	
Or how about both lines and points:
		
	# scatterplot with lines - "b" stands for both:
	plot(x = months,y = precipitation, type="b")

![](assets/img2/precip-b.png)
Or how about a barplot:
		
	# plot it as a bar plot
	barplot(height = precipitation, names.arg = months)
![](assets/img2/precip-bar.png)
	
How easy and great is that? Sure sure, you're probably thinking "This is lame, I could do this in Excel" - but what if you had to make these graphs for every year in Vancouver since 1965? You could write a *loop* to automate that in R instead of clicking over and over again in Excel... AND if you needed to change a color or an axis label, you could just run your script again... just sayin'.
	
### Lists
An R list is a collection of elements (similar to a vector) BUT the key difference is that a list can contain different data types. Lists can be created by using the **list()** function and filling in values to be stored in the list. The key differene between vectors and lists is that **lists are not recursive**.
	
Here's an example of a list of all the same values:

	# Hey I'm a list:
	my_list = list(3, 6, 9, 12,15)

Here's a list of lists of mixed data types:

	# ---- a list of lists ---- #
	twitterLikes = list( 
	    Ellie = list(
	            Handle = "@smellyEllie", 
	            Posts = 134,
	            Location = "London, UK",
	            Description = "Maps are my lyfe"
	            ),
	    Joey = list(
	            Handle = "@leejoeyk", 
	            Posts = 365,
	            Location = "San Francisco, BC",
	            Description = "Maps are my lyfe"
	            ),
	    Sally = list(
	            Handle = "@sallyseashore", 
	            Posts = 15,
	            Location = "Vancouver, BC",
	            Description = "Loving Maps since day 1")
	)
	print(twitterLikes)

As you can see, depending on your data, this could be useful way of organizing and structuring your data. Looking kind of like Javascript Object Notation (JSON) with those keys and values, eh? 
		
### Dataframes

A dataframe is essentially data in a tabular form (think an excel spreadsheet) - it is composed of rows and columns of equal length. Each column is a vector ( aka 1-D array), meaning it contains all of the same data type (except for the header row) and is recursive, meaning that we can apply functions and mathematical operations on each column. Holy guacamole, does this mean R is really great at processing tabular data like excel sheets, csv files, and maybe even shapefiles? Yes! That is exactly right!

Very generally, dataframes are composed of vectors, which are like each column. OH! That means we can take our**month** and **precipitation** data and create a data frame?! yes! All we have to do is use the **data.frame()** function:
	
A dataframe of the rain data:

	# Here's some data of months of the year and the precipitation in Vancouver
	months = c(1, 2, 3, 4, 5, 6, 7, 8, 9 , 10, 11, 12)
	precipitation = c(186, 94, 118, 85, 60, 59, 38, 39, 48, 126, 183, 177)

	# rain dataframe
	rain_data = data.frame(months, precipitation)
	print(rain_data)

This gives us a nice tabular dataset :)

![](assets/img2/precip-df.png)

We use R's selector operator ($) to select each column:

	# select the precpitation column and calculate the annual average
	mean_precip = mean( rain_data$precipitation )
	print(mean_precip)

And we see that the mean precipitation in Vancouver is **101.0833 mm**

Say, we wanted to plot the annual average on top of the monthly values, we could do something like this:

	# create the plot:
	plot(x = rain_data$month, y = rain_data$precipitation, type = "b" )
	
	# add the mean line:
	abline(h= mean_precip)

![](assets/img2/precip-mean.png)

**NOTE: We usually won't be making our own dataframes, but rather reading them in the form of delimited text files like .csv's .xls, .tsv, .dat, etc. **


### Matrices:
Think of matrices as a raster or bitmap image. While the x and y dimensions can be different (e.g. like a photograph) all the columns must be the same data type.

As a quick example, let's use one of R's preloaded datasets - a matrix (e.g. raster) of Auckland's Maunga Whau Volcano:

	# store the volcano data to a variable:
	cano = volcano
	print(cano)

Whoa! we get a bunch of print outs that essentially show this structure/numbers which represent the topography of this volcano:
![](assets/img2/cano-ex.png)

Now let's plot it, but instead of using **plot()** let's use the **image()** function:

	# image() fuction to plot the cano
	image(cano)

Wow! Such colors!

![](assets/img2/cano-img.png)

What other goodies can we plot? How about some contours?

	# contour lines of matrix
	contour(cano)

![](assets/img2/cano-contours.png)

And believe it or not, enter the 3rd dimension:

	# Get some perspective
	persp(cano, expand = 0.3, phi=35, theta=10)

![](assets/img2/cano-persp.png)

***
## Reading Dataframes from files:
We just saw how to *make* a dataframe using the **data.frame()** function using a set of **vectors**. Now let's *read in* data from a file as a *dataframe* using R's **read.csv()** function:

	# --- reading in data from a csv file --- #
	# store the filename & path to a variable
	fileName = '/Users/Jozo/Projects/Github-local/Workshop/aloha-r/data/rain.csv'
	
	# pass the filename variable to the "read.csv()" function
	# use "header=TRUE" if there's a header
	rain_csv = read.csv(fileName, header=TRUE) 

If we look at the data again, we see that it looks exactly like the dataframe we created earlier:

![](assets/img2/precip-df.png)

Now, we can do exactly the same steps as before **EXCEPT** we need to change the data name from **rain_data** to **rain_csv**:

	# select the precpitation column and calculate the annual average
	mean_precip = mean( rain_csv$precipitation )
	print(mean_precip)
	
	# create the plot:
	plot(x = rain_csv$month, y = rain_csv$precipitation, type = "b" )
	
	# add the mean line:
	abline(h= mean_precip)
	
![](assets/img2/rain-csv-plot.png)


***

## R Packages (aka libraries)
R packages (aka libraries) may be one of the most useful things about R. Libraries are basically bundled up scripts that people (software developers, researchers, designers, artists, etc) have written to help take complicated tasks or computations, wrapped up in simple(r) to use functions to make programming easier, more fun, and easy to read. 

In this way, you can say that Processing is a language and also a "library" because it makes functions available (e.g. ellipse() and rect()) which would take 10 to 20 lines of code in Java and puts them into an easy to use function.

In R, we have countless numbers of libraries to help us to tasks. Remember earlier I mentioned that there are R packages that can help you do geoprocessing and even make your own interactive web map? Well, now we're going to introduce a package that allows us to **read in shapefile** into R so that we can use it as a basemap for our crime plot. 

**NOTE: It may seem like R libraries are just doing magic behind the scenes, but they are simply making more functions available to you to use that aren't already included in the base R library - think of it as an actually library, you go there to get books that you don't have at home ;)** 

SO to start, we need to **install** the package we want to use. After doing a few google serches, I found an R package called "GISTools" that allows us to read shapefiles into R, make chropleth maps, do geoprocessing, etc - essentially your own, free and open source GIS. 


### installing and adding a library
We install packages in R by using the *install.packages()* function:

	# ---------- Using our first R package to display a shapefile! ---------- #
	# install the maptools library
	install.packages("GISTools")

After we install our R package, we need to import it to our script. We do so using the *library()* function:
	
	# import the maptools functions by calling the library() function
	library(GISTools)

Now that we have our library imported, we have can read in some shapefiles that are conveniently sitting in our data folder. Similar to how we read in our .csv file, we just have to include the path name to each of our .shp files.

	# --- read in shps --- #
	# Building shp
	fname_buildings ="/Users/Jozo/Projects/Github-local/Workshop/aloha-r/data/shp/buildings.shp"
	buildings = readShapeSpatial(fname_buildings)
	plot(buildings) # plot to inspect
	
	# Roads shp
	fname_roads = "/Users/Jozo/Projects/Github-local/Workshop/aloha-r/data/shp/roads.shp"
	roads = readShapeSpatial(fname_roads)
	plot(roads) # plot to inspect
	
	# Vehicle paths
	fname_paths = "/Users/Jozo/Projects/Github-local/Workshop/aloha-r/data/shp/paths.shp"
	paths = readShapeSpatial(fname_paths)
	plot(paths)

By plotting the data, we can see what we have! Now, let's combine the plots together to make a very basic map:
	
	# Plot the buildings
	plot(buildings, 
	     col = "#4f4f4f", 
	     lwd= 0.5,
	     border="#494949",
	     bg ="#404040",
	     main ="Vehicle Paths Downtown Vancouver")
	
	# Add the roads to the plot with "add = TRUE"
	plot(roads,
	     col="#383838",
	     lwd=2,
	     add=TRUE)
	     
	# Add the Paths to the plot with "add = TRUE"
	plot(paths,
	     col="#d0d0b9",
	     alpha=1,
	     lwd=1,
	     add=TRUE)

We can even add a north arrow in R (or later in Illustrator):

	# We can even add a north arrow:
	north.arrow(xb= -123.144035, yb=49.273001, len=0.0005)

And a scale bar:

	# scale bar:
	map.scale(xc= -123.151295, 49.271729, len=0.01, ndivs= 2,subdiv=3, units="test")


***Now you're more than primed to construct and deconstruct our first real-world R project!***

***
# Project: What are Vancouverites Complaining About?
## Brief:
The City of Vancouver releases a dataset of the 3-1-1 phone calls - the general hotline regarding maintenance issues in the city. Currently there is no tool to visualize and access the data. How can citizens engage the city for these matters if there's no way to work with the data?  In the name of civic "hacking", the project brief is to develop a project that:

1. can parse and handle the BIG data being delivered by the city.
2. shows the 3-1-1 data and potentially highlights insights derived from the data in an accessible web application.

## Requirements:
As a data and design team, you must deliver:

1. a script written in an open source programming language that can parse, filter, and mine the 3-1-1 data - you will work with the 2014 data.
2. a web application that allows citizens of Vancouver to visualize the spatial and temporal aspects of the data as well as any insights derived from the data mining.
3. the code must be open and shared (e.g. Github)

## Timeline:
The timeline for the project is 3 weeks:
1. Week 1: Data Handling with R - acquire, parse, filter, & mine 3-1-1 data.
2. Week 2: Data Handling Continued / Interactive Web Mapping
3. Week 3: Interactive Web Mapping Project Synthesis

## Overview:
We will use this project to go through Ben Fry's Data Visualization Pipeline. 






***

