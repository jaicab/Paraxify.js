#Paraxify.js

Simple parallax lightweight plugin (less than **1.5kb gzipped**) built with Vanilla JS and CSS3 inspired by Spotify's website parallax effect. 

It's been thought as a progressive enhancing plugin, so don't expect it to work exactly the same on all browsers, but it does work in all of them, in one way or another.

I built this plugin because I couldn't find any other non-jquery plugins that fit my needs. 


##How does it work?

1. Start with a centered background image bigger than the element it's been set on.
2. Add the paraxify class to the elements that you want to paraxify.
```css
	.paraxify{
	  background-attachment: fixed;
	  background-position: center center;
	  background-size: cover;
	}

3. Now just start the JavaScript part:
```javascript
	myParaxify = paraxify();

4. Ready to go! You should see the background images parallaxing.

As long as the background is `fixed`, the images will scroll all the hidden part accordingly to the scroll position. This way you can control when it's active or not just switching the `background-attachment` property on CSS to scroll.

**The speed** is determined by the difference between the element's height and the image's.

I wanted the background to be fixed so it creates a nice pure CSS parallax effect in case the JavaScript is not supported or disabled in the browser. I had performance in mind when I built this plugin, so **only the visibe photos are scrolled**.

##Advanced use
You can set another selector class or any other actually. The `paraxify` function has two parameters:
	
	var myParaxify = paraxify('selector', {
		speed: 1
	});

On `selector` you can set any selector, but a class is more retro-compatible. Also, you can set a speed from 0 to 1. The lower the speed, the less distance the background is gonna move. This speed is always proportional to the difference between the image's height and the element's.

For now speed is the only thing you can configure, but there'll be more stuff on the future.

At last but not least, you can access all the background info that paraxify calculates on real time. Type this in your console and you'll see:

	myParaxify.photos


##TODO

- [I'M ON IT] Set up a isMobile() function or a modernizr shorthand: Fixed backgrounds are really buggy on mobile.
- [I'M ON IT] Detect URL image changes (responsive design or any other) and update `diff` accordingly.
- [HOLD] Fix buggy behaviour on +IE9: The scrolling is not smooth.
- [HOLD] Try debouncing scroll event so it doesn't launch a bizillion times per second.


##Contributing

Please, feel free to fork the project and modify it as you wish. Just try to keep it __light and working__. Send me a pull request and I'll review it as soon as possible. Any new feature is welcome aboard.

If you feel like discussing a new feature or you've found a bug, open an issue or contact me on twitter ([@jaicab_](http://twitter.com/jaicab_)) so we can talk about it.


##MIT License
Paraxify has been coded from scratch by [Jaime Caballero](http://jaicab.com) and it's licensed under **MIT License**.