#Paraxify.js

Simple parallax lightweight plugin (less than **1.5kb gzipped**) built with Vanilla JS and CSS3 inspired by Spotify's website parallax effect. 

It's been thought as a progressive enhancing plugin, so don't expect it to work exactly the same on all browsers, but it does work in all of them, in one way or another.

I built this plugin because I couldn't find any other non-jquery plugins that fit my needs. 


##How does it work?

1. Start with a centered background image bigger than the element it's been set on.
2. Add the `paraxify` class to the elements that you want to __paraxify__.
3. As long as the background is `fixed`, the images will **scroll all the hidden part** accordingly to the scroll position.

This way you can control when it's active or not just switching the `background-attachment` property on CSS to scroll. And the speed is determined by the difference between the element's height and the image's.


##TODO

- Fix buggy behaviour on +IE9: The scrolling is not smooth. Check the following:
	- Updating background position on real time.
	- Not debouncing the scroll (too many calls).
- Try debouncing scroll event so it doesn't launch a bizillion times per second.
- Detect URL image changes (responsive design or any other) and update `diff` accordingly.
- Make it work as a function with a default class of `paraxify` but also the option to set one.
- Do some research about speed and give the option to set it.
- Set up a isMobile() function or a modernizr shorthand: Fixed backgrounds are really buggy on mobile.


##Contributing

Please, feel free to fork the project and modify it as you wish. Just try to keep it __light and working__. Send me a pull request and I'll review it as soon as possible. Any new feature is welcome aboard.

If you feel like discussing a new feature or you've found a bug, open an issue or contact me on twitter ([@jaicab_](http://twitter.com/jaicab_)) so we can talk about it.


##MIT License
Paraxify has been coded from scratch by [Jaime Caballero](http://jaicab.com) and it's licensed under **MIT License**.