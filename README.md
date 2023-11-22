#  Simply Weather

## Using the app

To use the app, simply enter either a city name or a set of coordinates into the text field. A set of weather conditions will update the UI each time a request is made. You can also use the current location button in the upper leftmost corner to get weather data based on current location.

## Supported features
* Dark mode with a background that changes depending on current mode
* Icons displaying current weather conditions
* Unit conversion toggle
* Accessible UI

## Code review
* During the development process, the initial function for weather fetching was broken up into multiple functions and later included in a WeatherDataManager class for modularity.
* The MVC design pattern was implemented for a better structured code.
* The delegate design pattern was also used for reusability purposes.
* Some error handling was also done to ensure the app doesn't unexpectedly crash.
* Given more time, even better modularity could be achieved by splitting several cases of inheritance into extensions.