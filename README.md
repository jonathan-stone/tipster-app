# Tipster

A tip-calculating app that calculates the tip that matches your mood.

## The Mood Slider
Are you a very generous person? 20% tip not enough to communicate your blossoming sense of generosity?
Hit the Mood Slider to choose from 20 to 40% tips!

In a crappy mood? 10% still too much tip to give out? You can probably calculate a zero percent tip on your own, but if you want to express your disdain with a nice low 2% tip, the mood slider will help you out there too. 

# Demo
![](http://i.imgur.com/L7PRcrD.gif)

## Developer notes
Tipster was coded as a quick prototype, so it lacks certain maintainability aspects. Were this a production app, here are some things I'd insist on doing:


* Test-driven development: Test-first coding so that all code is tested all the time.
* Better encapsulation: I'd make TipPercentChooser into a component/control instead of a set of static functions.
* Better encapsulation: I'd separate the tip calculator code from the page nav code more completely.
* UI: I'd sure make it look a lot nicer.
* UX: The mood slider can result in the same percentages appearing twice (e.g. 2%, 2%, 3%). Instead of a scale, I'd use predefined sets of percentages for a fixed number of "moods" or personality types (judmental, forgiving, ???).
* Bill splitter: support for number of people among which to divide up the bill.
* Venmo Connectivity: I'd like to hook into Venmo to start a payment right from Tipster.
