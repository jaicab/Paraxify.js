/**
 * Paraxify 0.1
 * @author Jaime Caballero
 * MIT license
 */

/*jslint vars: true, plusplus: true, devel: true, nomen: true, indent: 4, maxerr: 50 */

var getWindowSize = (function() {
    var docEl = document.documentElement,
        IS_BODY_ACTING_ROOT = docEl && docEl.clientHeight === 0,
        b = document.body;

    // Used to feature test Opera returning wrong values
    // for documentElement.clientHeight.

    function isDocumentElementHeightOff() {
      var d = document,
          div = d.createElement('div'),
          r;
      div.style.height = "50000px";
      d.body.insertBefore(div, d.body.firstChild);
      r = d.documentElement.clientHeight > 49000;
      d.body.removeChild(div);
      return r;
    }

    if (typeof document.clientWidth === "number") {
      return function() {
        return {
          width: document.clientWidth,
          height: document.clientHeight
        };
      };
    } else if (IS_BODY_ACTING_ROOT || isDocumentElementHeightOff()) {
      return function() {
        return {
          width: b.clientWidth,
          height: b.clientHeight
        };
      };
    } else {
      return function() {
        return {
          width: docEl.clientWidth,
          height: docEl.clientHeight
        };
      };
    }
  })();




var posY = 0, 
    screenY = getWindowSize().height,
    porcentaje = 0,
    position = "center",
    fotos;




function calcParallax(el){
   
  porcentaje = (posY-el.offsetTop+screenY)*100/(el.offsetHeight+screenY);
  
  if(porcentaje<0){
    porcentaje = 0;
  }
  else if(porcentaje>100){
    porcentaje = 100;
  }

  return (el.diferencia*(porcentaje-50)/100);
}



var checkDimensions = (function(i) {
  
  if(fotos[i].image.height<fotos[i].offsetHeight){
    console.log("The image "+ fotos[i].url +" (" + fotos[i].image.height + "px) is too short for that container ("+ fotos[i].offsetHeight +"px).");
  }
  else{
    console.log("It's ok");
    fotos[i].diferencia = -(fotos[i].image.height - fotos[i].offsetHeight);
  }

});



window.onresize = function(){

  screenY = getWindowSize().height;

};



window.onload = function() {

  fotos = document.getElementsByClassName('paraxify');
      

  for(var i=0; i<fotos.length; i++){

    fotos[i].url = window.getComputedStyle(fotos[i],false)
                      .backgroundImage
                       .replace(/url\((['"])?(.*?)\1\)/gi, '$2')
                        .split(',')[0];

    fotos[i].image = new Image();
    fotos[i].image.onload = setTimeout("checkDimensions("+i+")", 0); 
    fotos[i].image.src = fotos[i].url;
    console.log(fotos[i].image.height);    

  }

  
  window.onscroll = function() {
    posY = (window.pageYOffset !== undefined) ? window.pageYOffset : (document.documentElement || document.body.parentNode || document.body).scrollTop;

    for(i=0; i<fotos.length; i++){

      if(fotos[i].image.height>fotos[i].offsetHeight){
        position = calcParallax(fotos[i]);
      }
      else{
        position = "center";
      }

      fotos[i].style.backgroundPosition = "center " + position + "px"; 
      //fotos[i].style.backgroundAttachment = "scroll";
      }
  };

};