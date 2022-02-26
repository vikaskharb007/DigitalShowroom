# Digital Showroom
The app enables the user to view a list of available Vehicles in a tableview and explore the details on the vehicle. 
The Detail screen lets the user click on the lock to update the state. (The updates are only UI specific and are not updated to the backend)

App has following implementations

- Makes backend call for downloading all the Vehicle and Overview details related to the vehicle.
- Basic call failures have been handled
- Data cleansing has not been handled

UI:
UI has been created programmatically. Auto layout has been utilised.
Image size optimisation for resizing has not been done.

Architecture: 
- The app uses MVVM and some combine features for binding

Testing:
- Major components of the app have been covered with unit testing. View models and controllers have been tested by injecting mock network manager to demonstrate decoupled testing.
- There are no UI tests 

Note: Although the app is universal and supports all form factors and orientations, it best works in iPhone 12 with minimum deployment target iOS13


