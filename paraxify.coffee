
###
 Paraxify.js - v0.1
 @author Jaime Caballero
 MIT license
###

((document, window, index) ->

  "use strict"

  paraxify = (el, options) ->

    computed = !!window.getComputedStyle
      
    # getComputedStyle polyfill
    if (!computed)
      window.getComputedStyle = (el) ->

        this.el = el
        
        this.getPropertyValue = (prop) ->
          re = /(\-([a-z]){1})/g
          if prop == "float"
            prop = "styleFloat"
          if re.test(prop)
            prop = prop.replace(re, ->
              return arguments[2].toUpperCase()
            )
          return el.currentStyle[prop]

        return this


    posY = 0
    screenY = 0
    i = 0
    opt = {}
    pho = []
    contador = 0

    Paraxify = (el, options) ->

      this.options = {
        speed: 1
      }

      # User defined options
      for i of options
        @options[i] = options[i]

      this.options.speed = 1 if this.options.speed < 0 || this.options.speed > 1

      # Classes
      if document.getElementsByClassName(el.replace('.',''))
        this.photos = document.getElementsByClassName(el.replace('.',''))

      # Now query selector
      else if document.querySelector(el)!=false
        this.photos = querySelector(el)

      # The element doesn't exist
      else
        throw new Error("The elements you're trying to select don't exist.")

      # For minification
      opt = this.options
      pho = this.photos


      this._init(this)

      return


    Paraxify.prototype = {

      # Private methods

      _init: ->
        #Get values on load
        screenY = window.innerHeight
        i = 0
        while i < pho.length

          pho[i].url = window.getComputedStyle(pho[i],false)
                            .backgroundImage
                             .replace(/url\((['"])?(.*?)\1\)/gi, '$2')
                              .split(',')[0]

          pho[i].img = new Image()
          this._check(i)
          pho[i].img.src = pho[i].url

          i++
          
        
        #addEvent(window, "scroll", this, false)
        #addEvent(window, "resize", this, false)
        window.onscroll = (->
          this._animate()
          return
        ).bind(this)

        return


      _update: () ->

        screenY =  window.innerHeight
        i = 0
        while i < pho.length

          this._check(i)

          i++

        return


      _check: (i) ->

        main = pho[i]

        pho[i].img.onload = ->
          if this.height < main.offsetHeight
            throw new Error("The image "+ main.url +" (" + this.height + "px) is too short for that container ("+ main.offsetHeight +"px).")
          else
            main.diff = -(this.height - main.offsetHeight)
          return


        return

      _animate: ->
        if window.pageYOffset != undefined
          posY = window.pageYOffset
        else
          posY = (document.documentElement || document.body.parentNode || document.body).scrollTop

        i = 0
        while i < pho.length
          #Do de parallax ONLY AND ONLY IF the image is bigger than the container AND the container is visible
          if (pho[i].img.height > pho[i].offsetHeight and ((posY + screenY) > pho[i].offsetTop) and window.getComputedStyle(pho[i],false).backgroundAttachment == "fixed")

            per = (posY - pho[i].offsetTop + screenY ) * 100 / (pho[i].offsetHeight + screenY)

            per = 0 if per < 0
            per = 100 if per > 100

            position = Math.round(((pho[i].diff * opt.speed)  * (per - 50) / 100) * 100) / 100

          else
            position = "center"

          pho[i].style.backgroundPosition = "center " + position + "px"
        
          i++



        return

    }

    return new Paraxify(el, options)

  window.paraxify = paraxify
  window.onload = paraxify('.paraxify') if !el

  return

) document, window, 0