# Assignment:

We've gone through the whole data viz pipeline and now you're equipped with a bunch of code to fetch some data, do some stuff with it, and then visualize it. It's time to go off-roading and learn how to tweak the code and workflow to a new dataset - the [Vancouver Crime Data](http://data.vancouver.ca/datacatalogue/crime-data-details.htm). 

***
<!--## Your Task:

![http://joeyklee.github.io/temp/rleaflet/](assets/img2/rleaflet-final.png)

Using the skills you picked up from the last 3 weeks, choose 1 year of data from 2003 to 2014 of **crime data** from the **Vancouver Open Data Catalog** and generate a visualization with the functionality of the interactive map above. Instead of the 3-1-1 call categories, you would imagine that crime types might fill their place. 

You should be able to tell some sort of narrative with your visualization. -->

## Web map requirements:

![http://joeyklee.github.io/temp/rleaflet/](assets/img2/rleaflet-final.png)

Using the skills you picked up from the last 3 weeks, choose 1 year of data from 2003 to 2014 of **crime data** from the **Vancouver Open Data Catalog** and generate a visualization with the functionality of the interactive map above. Instead of the 3-1-1 call categories, you would imagine that crime types might fill their place. 

Your web map will include:

1. toggle-able **point** layers for the different crime types (feel free to classify the different crimes into groups if you can justify it)
	* with a popup on click 
2. a toggle-able **polygon** layer for the crime density for your year using the hex bin.
	* a legend showing the scale of the crime densities.
	* with a popup on click 
3. suitable basemap tiles
4. appropriate colors and point sizing


***
## Deliverables:

1. an **.html** file:
	* that you will export from R Studio and name it with this naming convention:
				
			vancrimeYYYY_firstname_lastname.html
			
		for example, Joey Lee would turn in:
		
			vancrime2014_joey_lee.html
				
	* and email to Joey (joseph.lee@geog.ubc.ca) and Sally (sally.hermansen@ubc.ca)
2. your **code**:
	* Generic Solution: Posted to your blog page using the **pre** tags in the html editor of your blog. In the **html** editor of your blog page you would type:  

			<pre> <!-- you need an opening pre tag -->
			
			# install the leaflet library
			devtools::install_github("rstudio/leaflet")
			
			# add the leaflet library to your script
			library(leaflet)
			
			# initiate the leaflet instance and store it to a variable
			m <- leaflet()
			
			# we want to add map tiles so we use the addTiles() function - the default is openstreetmap
			m <- addTiles(m)
			
			# we can add markers by using the addMarkers() function
			m <- addMarkers(m, lng=-123.256168, lat=49.266063, popup="T")
			
			# we can "run"/compile the map, by running the printing it
			print(m)			
		
			</pre> <!-- and a closing pre tag -->

	* For Wordpress: if you're using wordpress, you can simply wrap your code with these [code:language="r"][/code] commands on the **visual** editor,
	
			[code language="r"]
			
			# install the leaflet library
			devtools::install_github("rstudio/leaflet")
			
			# add the leaflet library to your script
			library(leaflet)
			
			# initiate the leaflet instance and store it to a variable
			m <- leaflet()
			
			# we want to add map tiles so we use the addTiles() function - the default is openstreetmap
			m <- addTiles(m)
			
			# we can add markers by using the addMarkers() function
			m <- addMarkers(m, lng=-123.256168, lat=49.266063, popup="T")
			
			# we can "run"/compile the map, by running the printing it
			print(m)
			
			
			[/code]	

3. A write up about your **process** and some **insights from your visualization**:
	* **Process**: 
		* You will need to demonstrate that you understand each step of the process of the data visualization pipeline as it relates to the work you've done. 
		* For each chunk of code that you've written, you will need to explain in writing on your blog what each step is doing - imagine if you needed to go step by step with your methods to the City of Vancouver Open Data Department, how would you document each step? 
		* This is **in addition to** commenting your code.
	* **Visualization**: 
		* You will need to write about some insights you've found in your visualization upon using it. Please speak to themes such as the spatial distribution, the time of year, what other data might be useful in this context, the interactivity - is it useful or not, etc? 
		* Be creative and thoughtful in your responses.   
			
4. your **data**:
	* please send your processed **.csv** file with the lat/lon coordinates that your geocoded. Follow the naming convention below:
	
			vancrimeYYYY_firstname_lastname.csv 
		
		so Joey Lee's would be:
	
			vancrime2014_joey_lee.csv

## Marking :

You will be marked on:

1. successful submission of the .html file
2. your map aesthetics and functionality
3. your code - well commented and runs
4. your documentation - is your code well explained? do you demonstrate an understanding of the data viz process?
5. your insight - is your insight regarding the visualization thoughtful and justified? 

## Things to keep in mind:

* You will use R to make your mini-project.
* This is a quick mini-project and should not take more than 3 hours of class time + a few hours outside of class. Stay focused.
* Comment your code and make sure it is clean and readable -and that it runs! 

## Sign up Sheet:

1. 2014:
	* .
	* .
	* . 
2. 2013:
	* .
	* .
	* .
3. 2012:
	* Alex Graham
	* .
4. 2011:
	* .
	* .
5. 2010:
	* .
	* .
6. 2009:
	* .
	* .
7. 2008:
	* .
	* .
8. 2007:
	* .
	* .
9. 2006:
	* .
	* .
10. 2005:
	* .
	* .
11. 2004:
	* .
	* .
12. 2003:
	* .
	* .

<!--https://www.ostraining.com/blog/coding/github-pages/-->




<!--# Assignment:

We've gone through the whole data viz pipeline and now you're equipped with a bunch of code to fetch some data, do some stuff with it, and then visualize it. It's time to go off-roading and learn how to tweak the code and workflow to the other 11 months of data. 

## Your Task:

Using the skills you picked up from the last 3 weeks, choose 1 month of data from 2014 of **3-1-1 data** and generate a visualization / series of visualizations showing aspects of the data. 

You should be able to tell some sort of narrative with your visualization-->