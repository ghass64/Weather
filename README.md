# Weather
This repo holds the code for Ahoy test App

## About App

This is a simple app which basically fetches weather data for 10 days from the given API, and parses the JSON response into models which are `Codable` structs & ultimately displaying it in a tableview. Every cell is a weather information for a day which displays image for the weather, degree, date. On tapping any of the item, user can get into the detail screen.

## Note for the Reviewers

**Covered all required activities**
- [x] List of weather data for X number of days (Scrollable)
- [] Tapping on an item should open weather details view
- [x] Call an API to get the weather information
- [x] Use best practices for app architecture whenever possible - _(MVVM pattern followed)
- [] Unit tests using XCTest
- [] Simple UI tests using XCUITest
- [x] Should Support orientation
- [] Local Notifications to show weather alert
- [] Settings view to change from Centigrade to Fahrenheit and vice versa
- [] Offline/Local storage (preferably Realm Framework)
- [x] Presentable or Intuitive UI/UX
- [] Multiple variants for different environments (development-staging-production)
- [] Update weather info frequently in the background


## Running the app

Once you have clonned the app to your local system, you can fire-up the app by opening Weather.xcodeproj_ file.
