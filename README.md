# WeatherAppSwensonHe

Weather app is an app that show for user his current temp.
and some infromation like wind and droplet, with at it gives forecast for the next 3 days.

At the the beginning App will ask user to give him authorization for location, 
so it can know his current place and show the weather based on that location.

user can search for certain countries, cities and App will show countries based on his typing and when select country it will display its weather info.

# APP STRUCTURE

I used MVVM architecture for more reusability and seperations layers, 
for that I decided to create project on different frameWorks
it may not add match on this project scale but 
I decided to seperate the modules so it can be reusable on any project that will use same dataLayers
or UI-Components

# FRAMEWORK
App have main project that call weatherAppSwenson -> 
this contains the mainScreen and the flow of view also I use injection dependency and dependency container with small hack of coordinator pattern
to control the navigations, view state and remove some of viewcontroller's responses

the second framework is called APPUIKit ->
and this framework is responsable for any UI components, extensions and custom cells which makes this framework helpful in any other project
as extensions and custom cells can be reuse easily and not coupled with the main project files

the third and last framework is called CoreKit ->
it's reponsable for any thing that related for data manipulation -> API layers, viewModels and model
I may do some seperation layers in api layers -> repository layer that will call api layer which will call the service layer
for service layer its the low level for any thing that api need of data, parameters.
for repository layer it is the cleanest layer that can call from viewModel.

# THIRD PARTIES
I used some third parties that can make work more faster like
kingFisher -> for loading Images from URL
snapKit -> for better UI constraints
combineCocoa -> for better combine functions call like tapPublisher, tableviewDidTapPublisher, textPublisher for textfield changes in text
Alamofire -> for API requests

# ENHANCEMENT
I'm sorry but this task was in the middle of a lot of releases I'm working on right now, which make the time a bit tight with me.
if I was looking for enhancement I would create custom cell for search tableview, also enhance some of view controller calls of its methods

# TASK TIME
it took around 8 hours from me 
half hour in structure of folders
about hour and half in creating the api calls and its layers
and about 6 hours for UI components and depenedency containers and coordinator layer for navigations

It would be great to hear back from your side the soones

THANK YOU,
