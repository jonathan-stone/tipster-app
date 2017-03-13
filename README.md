# Pre-work - *Tipster*

**Tipster** is a tip calculator application for iOS.

Submitted by: **Jonathan Stone**

Time spent: **8** hours spent in total

## User Stories

The following **required** functionality is complete:

* [x] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [x] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [ ] UI animations
* [ ] Remembering the bill amount across app restarts (if <10mins)
* [x] Using locale-specific currency and currency thousands separators.
* [x] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:
- [x] Custom icon
- [x] Custom title image on navigation controller
- [x] Custom launch screen
- [x] Suppressed the keyboard animation on launch. Keyboard is always there and it was distracting.
- [x] Added **The Mood Slider**. 

* Are you a very generous person? 20% tip not enough to communicate your blossoming sense of generosity?
***Hit the Mood Slider*** to choose from 20 to 40% tips!
* In a crappy mood? 10% still too much tip to give out? You can probably calculate a zero percent tip on your own, but if you want to express your disdain with a nice low 2% tip, **the mood slider** will help you out there too. 
 

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/Ad4LQfB.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

### Challenges
* Rounding: When converting the mood slider value (a double) to percentages (17%/22% etc.), the results didn't land exactly on a whole percentage value. Rounding off for displaying the percent value was straightforward string formatting, but then the Tip amount would not match the displayed percentage; instead of 17%, the calculated percent value would be something like 17.124%. Solved by rounding the percent down to two decimal places, to match what is displayed in the UI. 
* Keyboard not coming back: With the code to automatically show the keyboard in the initial viewcontroller, after switching to the settings view, the keyboard would disappear when returning to the initial view. Solved by closing the keyboard before moving to the settings screen.
* Tipster was coded as a quick prototype, so it lacks certain maintainability aspects. Were this a production app, here are some things I'd be keen to do:

    * Test-driven development: Test-first coding so that all code is tested all the time. 
    * Better encapsulation: I'd make TipPercentChooser into a component/control instead of a set of static functions.
    * Better encapsulation: I'd separate the tip calculator code from the page nav code more completely.
    * UI: I'd sure make it look a lot nicer.
    * Responsiveness: This thing only works on one screen size.
    * UX: The mood slider can result in the same percentages appearing twice (e.g. 2%, 2%, 3%). Instead of a scale, I'd use predefined sets of percentages for a fixed number of "moods" or personality types (judmental, forgiving, ???).
    * Bill splitter: support for number of people among which to divide up the bill. 
    * Venmo Connectivity: I'd like to hook into Venmo to start a payment right from Tipster.

## License

Copyright 2017 Jonathan Stone

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.


