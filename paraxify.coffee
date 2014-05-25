
###
 Paraxify.js - v0.1
 @author Jaime Caballero
 MIT license
###

"use strict"

posY = 0
screenY = 0
porcentaje = 0
position = "center"
fotos = 0
speed = 1




window.calcParallax = (el) ->
   

  porcentaje = (posY - el.offsetTop+screenY)*100 / (el.offsetHeight + screenY)
  
  porcentaje = 0 if porcentaje < 0
  porcentaje = 100 if porcentaje > 100

  return Math.round(((el.diferencia * speed)  * (porcentaje - 50) / 100) * 100) / 100




window.checkDimensions = (i) ->
  
  if fotos[i].image.height < fotos[i].offsetHeight
    console.log("The image "+ fotos[i].url +" (" + fotos[i].image.height + "px) is too short for that container ("+ fotos[i].offsetHeight +"px).")

  else
    console.log("It's ok")
    fotos[i].diferencia = -(fotos[i].image.height - fotos[i].offsetHeight)

  return




animateParallax = () ->

  posY = if window.pageYOffset != undefined then window.pageYOffset else (document.documentElement || document.body.parentNode || document.body).scrollTop

  i = 0
  while i < fotos.length

    #Do de parallax ONLY AND ONLY IF the image is bigger than the container AND the container is visible
    if (
      fotos[i].image.height > fotos[i].offsetHeight and
      ((posY + screenY) > fotos[i].offsetTop) and
      window.getComputedStyle(fotos[i],false).backgroundAttachment == "fixed"
      )
      position = calcParallax(fotos[i])

    else
      position = "center"

    
    fotos[i].style.backgroundPosition = "center " + position + "px"
    

    i++

  return




window.onresize = () ->

  screenY =  window.innerHeight

  return




window.onload = () ->

  #Get values on load
  screenY = window.innerHeight
  fotos = document.getElementsByClassName('paraxify')
      
  i = 0
  while i < fotos.length

    fotos[i].url = window.getComputedStyle(fotos[i],false)
                      .backgroundImage
                       .replace(/url\((['"])?(.*?)\1\)/gi, '$2')
                        .split(',')[0]

    fotos[i].image = new Image()
    fotos[i].image.onload = setTimeout("checkDimensions("+i+")", 0)
    fotos[i].image.src = fotos[i].url

    #Make sure it's fixed
    window.getComputedStyle(fotos[i],false).backgroundAttachment = "fixed" if window.getComputedStyle(fotos[i],false).backgroundAttachment != "fixed"

    i++
    
  window.onscroll = animateParallax

  return



