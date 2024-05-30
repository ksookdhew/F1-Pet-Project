# F1-Pet-Project
## Project Description
This app is designed for Formula 1 enthusiasts who wish to stay updated with the latest standings, race schedules, and historical records of the sport.

### Features:
#### Previous Race Results for the Current Season: 
Access quick and accurate results of races from the current season. This feature allows you to keep track of how drivers and teams are performing throughout the year.

<img width="464" alt="Results" src="https://github.com/ksookdhew/F1-Pet-Project/assets/164847404/5c58c985-db23-4185-8aa9-6096ed1d2585">
<img width="463" alt="race results" src="https://github.com/ksookdhew/F1-Pet-Project/assets/164847404/ad82409d-8ed7-48c3-8092-4973ebdc6de3">


#### Driver Standings: 
View the current standings of Formula 1 drivers, including their positions and points. Get detailed information about each driver, from background information to recent performance.

<img width="461" alt="driver standings" src="https://github.com/ksookdhew/F1-Pet-Project/assets/164847404/aaa1cc70-83e7-40d5-a6e2-0c759293bda4">
<img width="462" alt="driver" src="https://github.com/ksookdhew/F1-Pet-Project/assets/164847404/ccddeb36-767d-4254-8a79-26b08da38857">


#### Constructor Standings: 
Check out the latest constructor standings to see how your favorite teams are performing in the championship. This section includes positions, points, and detailed information about each constructor.

<img width="463" alt="constructor standings" src="https://github.com/ksookdhew/F1-Pet-Project/assets/164847404/f6bca772-c7b3-4c18-897e-5cdb010a5bc6">
<img width="464" alt="constructor" src="https://github.com/ksookdhew/F1-Pet-Project/assets/164847404/c62615ab-9d86-4549-beba-8f4ce91b2307">


#### Race Schedule: 
Stay informed about the Formula 1 calendar with a comprehensive race schedule and circuit information. This feature is divided into upcoming races and past events, ensuring you never miss out on the action.

<img width="466" alt="racing" src="https://github.com/ksookdhew/F1-Pet-Project/assets/164847404/f22707da-10fa-4edf-8ac3-e62f243b1afc">
<img width="467" alt="race shedule" src="https://github.com/ksookdhew/F1-Pet-Project/assets/164847404/15895e6b-ac96-44e8-8c1c-23271e9da431">


## Branching Strategy
- [Gitflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)
 <p >
    <img width="500"  src="https://drive.google.com/uc?export=view&id=1RyA8oq8HRugf5sQH-StnJqOvUtrWEcDu" alt="Gitflow branching strategy">
</p>

## Design

- [Figma](https://www.figma.com/file/6X4X3lU6A9CzDCG45yE74o/F1-Pet-project?type=design&node-id=6-1193&mode=design)

## Architecture 
### Model-View-ViewModel (MVVM)
Model: Responsible for holding and managing data.
View: Handles the UI representation, focusing solely on presenting data to the user. 
ViewModel: Manages business logic, acting as an intermediary between the Model and the View. It transforms raw data into a format that can be easily displayed in the View.
 
### Repository Pattern
Repositories encapsulate logic for accessing data sources, providing a centralized interface to interact with different data storage mechanisms and promoting a clean separation of concerns in the application architecture.
 
### Delegate Pattern
The Delegate Pattern simulates binding not easily accessible in Swift, facilitating communication between objects and allowing one object to notify others about changes or events.

## API
- The API being used is called [Ergast Developer API](http://ergast.com/mrd/), it is a Formula-1 API

## Getting Started

1. Xcode version 14.0 or above should be installed on your computer
2. Download the <b>F1</b> project files from the repository
3. Open the project files in Xcode
4. Run the active schema

The app should start up on the simulator directing you to the login page

## Usage

At this point in the apps development there isn't any authetican in order to gain access there are default creditiols
- Username: Admin
- Password: Password

Note: In later releases there will be proper authetican in place

## Tests
The project is tested using the bulit-in framework XCTest.
