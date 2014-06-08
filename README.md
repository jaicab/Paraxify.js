#[Paraxify.js](http://jaicab.github.io/Paraxify.js)

Simple lightweight parallax plugin (around **2kb gzipped**) built with Vanilla JS and CSS3 inspired by Spotify's website parallax effect. 

It's been thought as a **progressive enhancing** plugin, so don't expect it to work exactly the same on all browsers, but it does work in all of them, in one way or another.

I built this plugin because I couldn't find any other non-jquery plugins that fit my needs. 


##How does it work?

- Start with a centered background image **bigger** than the element it's been set on.
- Add the paraxify class to the elements that you want to paraxify.

```css
.paraxify{
  background-attachment: fixed;
  background-position: center center;
  background-size: cover;
}
```

- Now just start the JavaScript part:

```javascript
myParaxify = paraxify('.paraxify');
```

- Ready to go! You should see the background images parallaxing.

IMPORTANT: Parallax and touch devices usually don't get along. So I highly suggest you to use [modernizr's](http://modernizr.com/download/) touch events. For example:

```javascript
if(!Modernizr.touch){
	myParaxify = paraxify('.paraxify');
}
```

As long as the background is `fixed`, the images will scroll all the hidden part accordingly to the scroll position. This way **you can control** when it's active or not just switching the `background-attachment` property on CSS to `scroll`.

I wanted the background to be fixed so it creates a nice pure CSS parallax effect in case the JavaScript is not supported or disabled in the browser. I had performance in mind when I built this plugin, so **only the visibe photos are scrolled**.

##Advanced use
You can set any other selector actually. The `paraxify` function has two parameters:
	
	var myParaxify = paraxify('selector', {
		speed: 1,
		boost: 0
	});

On `selector` you can set any selector, but a class is more retro-compatible. Also, you can set a speed from 0 to 1. The lower the speed, the less distance the background is gonna move. This speed is always proportional to the difference between the image's height and the element's.

The speed is determined by the difference between the element's height and the image's. However, you can slow it down or boost it up using the options' array avalible:

- `speed` (float, 0 to 1, 1 by default): It's proportional to the hidden part of the image.
	- 0: It would be completely stopped.
	- 1: It would scroll all the hidden part of the background image.
- `boost` (float, 0 to 1, 0 by default): Boost uses the visible part of the image to speed the scroll speed a bit.
	- 0: There wouldn't be a boost.
	- 1: It would scroll all the visible part of the background image.

So **by default** it scrolls all the hidden part but none of the visible.

At last but not least, you can access all the background info that paraxify calculates on real time. Type this in your console and you'll see:

	myParaxify.photos


##TODO

- [I'M ON IT] Detect URL image changes (responsive design or any other) and update `diff` accordingly.
- [HOLD] Fix buggy behaviour on +IE9: The scrolling is not smooth.
- [HOLD] Try debouncing scroll event so it doesn't launch a bizillion times per second.
- [HOLD] Option to scroll horizontally as well as vertically.

##Contributing

Please, feel free to fork the project and modify it as you wish. Just try to keep it __light and working__. Send me a pull request and I'll review it as soon as possible. Any new feature is welcome aboard.

If you feel like discussing a new feature or you've found a bug, open an issue or contact me on twitter ([@jaicab_](http://twitter.com/jaicab_)) so we can talk about it.


##MIT License
Paraxify has been coded from scratch by [Jaime Caballero](http://jaicab.com) and it's licensed under **MIT License**.