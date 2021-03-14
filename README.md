## Assignment explanations:

### Features implemented:
    1. Display steps, calories and daily progress
    2. Set daily goal, stored in shared prefs
    3. Display notification when enabled


### Notes:
1. On enable notification I’m setting an alarm to display notification in 5 seconds instead of 8pm, for testing purposes
2. Not much documentation can be found, I think naming is expressive enough 🤞
3. Notice Resizable text in progress indicator :)


### Imperfections:
1. Back arrow not doing anything, since there’s only one screen
2. Implemented fake data source for steps and calories, too much hassle to register with Android :/
3. Bottom progress bar not implemented, didn’t get the logic of it
4. On first load when no daily goal is set you have to manually press DailyGoal button, I was lazy to implement a bus to invoke it from the Bloc and didn’t want to implement poor solution invoking it from widget itself 🤷‍♀️



