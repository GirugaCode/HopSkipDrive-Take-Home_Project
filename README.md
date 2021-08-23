# HopSkipDrive Take Home Project

# Tech Stack

* [Swift 5](https://developer.apple.com/swift/)
* [Xcode 11.7](https://developer.apple.com/xcode/)
* [CocoaPods](https://guides.cocoapods.org/terminal/commands.html)
    * [SnapKit](https://https://snapkit.io/)

![MyRidesImage](/images/my-rides-screen.png)
![RideDetailsImage](/images/ride-details-screen.png)

<!-- GETTING STARTED -->
# Getting Started

To get a local copy up and running follow these simple steps.

## Prerequisites

I've used the Snapkit pod to help put together the autolayout of the app. 

Make sure you have cocoapods installed in your local machine.
[CocoaPods](https://cocoapods.org/)
```sh
$ sudo gem install cocoapods
```

# Installation

1. Clone the repo
```sh
git clone https://github.com/GirugaCode/HopSkipDrive-Take-Home_Project.git
```
2. Install Pods 
```sh
pod install
```

3. Open the .xcworkspace file
```sh
HopSkipDrive-Take-Home-Project.xcworkspace
```

4. Build and Run

# Objectives

## My Rides

### Trip header
- [x] The trip header summarizes the cards below it.
- [x] The time range (e.g., 4:18a - 4:26p) ranges from the earliest to latest time in the section.
- [x] The estimated earnings is the sum of all trip earnings below that section header.

### Trip card

- [x] The rider/booster description text (2 riders) is used to describe the total number of riders on the trip and also how many of those riders require booster seats.
- [x] If no riders require booster seats then the format would be (X rider).
- [x] If N riders require booster seats then the format would be (X rider • N booster).  Pluralize accordingly.


## Ride Details

### Map (optional)

- [x] The map shows only the start and end waypoint locations.

### Repeating series status

- [x] If the ride is part of a repeating series (in_series) then show the text "This trip is part of a series."
- [x] If the ride is not part of a repeating series then hide this section.

### Address list

- [x] Below the series status is a list of waypoint addresses along with the anchor type (pickup/drop-off).
- [x] All waypoints except the last one will be a pickup waypoint.
- [x] If the waypoint is an anchor then show the diamond icon.
- [x] If the waypoint is not an anchor then show the circle icon.

# Notes & Improvments

### Notes
* There were ordered_waypoints with anchor's set to false in the API when it could be true to mark a stop rather then a drop-off
    * This led to some of the waypoints in the Ride Details view to have two drop-off locations
* The lat and lng in some locations did not correspond with the location address
    * The map annotations only corresponded with the lat and lng of the API

### Improvments
* Adding Unit Tests
* Highlighting the destions from point to point in the map view

