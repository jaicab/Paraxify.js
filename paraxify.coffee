
###
 Paraxify.js - v0.1
 @author Jaime Caballero
 MIT license
###

((document, window, index) ->

  "use strict"

  paraxify = (el, options) ->

    posY = 0
    screenY = 0
    i = 0
    opt = {}
    pho = []
    contador = 0

    Paraxify = (el, options) ->

      this.options = {
        speed: 1,
        boost: 0
      }

      # User defined options
      for i of options
        @options[i] = options[i]

      this.options.speed = 1 if this.options.speed < 0 || this.options.speed > 1

      # By default, paraxify class
      el = 'paraxify' if !el

      # Classes
      if document.getElementsByClassName(el.replace('.',''))
        this.photos = document.getElementsByClassName(el.replace('.',''))

      # Now query selector
      else if document.querySelector(el)!=false
        this.photos = querySelector(el)

      # The elements don't exist
      else
        throw new Error("The elements you're trying to select don't exist.")

      # For minification
      opt = this.options
      pho = this.photos


      this._init(this)

      return


    Paraxify.prototype = {

      # Public methods
      update: () ->

        screenY =  window.innerHeight

        i = 0
        while i < pho.length
           
          pho[i].style.backgroundPosition = "center center"

          # Update the URL
          pho[i].url = window.getComputedStyle(pho[i],false)
                            .backgroundImage
                             .replace(/url\((['"])?(.*?)\1\)/gi, '$2')
                              .split(',')[0]
          
          # Check if new or update
          if !pho[i].img
            pho[i].img = new Image()

          if pho[i].url != pho[i].img.src
            this._check(i)
            pho[i].img.src = pho[i].url

          i++

        this._animate()
        return

      # Private methods

      _init: ->

        #Get values on load
        this.update()
          
        window.onscroll = (->
          this._animate()
          return
        ).bind(this)

        window.onresize = (->
          this.update()
          return
        ).bind(this)

        return


      _check: (i) ->

        main = pho[i]
        main.ok = true
        main.bgSize = window.getComputedStyle(main,false).backgroundSize
        actualHeight = screenY

        pho[i].img.onload = ->
          
          if main.bgSize == '' or main.bgSize == 'auto'

            if this.height < main.offsetHeight
              main.ok = false
              throw new Error("The image " + main.url + " (" + this.height + "px) is too short for that container (" + main.offsetHeight + "px).")

            else
              actualHeight = this.height

              # If the image is smaller than the screen, we need to add that difference
              actualHeight = actualHeight + ((screenY - main.offsetHeight) * opt.speed) if this.height < screenY


          else if main.bgSize == 'cover'

            if screenY < main.offsetHeight
              main.ok = false
              throw new Error("The container (" + main.offsetHeight + "px) can't be bigger than the image (" + screenY + "px).")


          else
            window.getComputedStyle(main,false).backgroundSize == 'cover'
            this._check(i)


          # Initial difference - Minimum parallax
          main.diff = -(actualHeight - main.offsetHeight) * opt.speed

          #Speed up! - From 0 to 100% of the container
          main.diff = main.diff - (main.offsetHeight * opt.boost)

          return


        return

      _visible: (i) ->
        if ((posY + screenY) > pho[i].offsetTop) and ((posY) < pho[i].offsetTop + pho[i].offsetHeight)
          return true
        return false

      _animate: ->
        if window.pageYOffset != undefined
          posY = window.pageYOffset
        else
          posY = (document.documentElement || document.body.parentNode || document.body).scrollTop

        i = 0
        while i < pho.length

          this._check(i)

          #Do de parallax ONLY AND ONLY IF the image is bigger than the container AND the container is visible
          if (pho[i].ok and window.getComputedStyle(pho[i],false).backgroundAttachment == "fixed" and this._visible(i))

            # Percentage of the position
            per = (posY - pho[i].offsetTop + screenY ) / (pho[i].offsetHeight + screenY)

            # Removes 50% so it shares the scroll between the top and the bottom
            position = pho[i].diff * (per - 0.5)

            # If it's not cover, center it
            position = position + ((screenY - pho[i].img.height) / 2) if pho[i].bgSize != 'cover'

            # Round it up!
            position = Math.round(position * 100) / 100

          else
            position = "center"

          # Here's the result
          pho[i].style.backgroundPosition = "center " + position + "px"
        
          i++

        return

    }

    return new Paraxify(el, options)

  window.paraxify = paraxify

  return

) document, window, 0