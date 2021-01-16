unit
class Shape
    export setCentre, getCentreX, getCentreY, getWidth, getHeight, getColour, erase
    
    var centreX : int := 320
    var centreY : int := 200
    var width : int := 40
    var height : int := 50
    var col : int := red

    deferred proc draw
    
    procedure setCentre (x:int, y:int) 
	centreX := x 
	centreY := y
    end setCentre

    function getCentreX : int 
	result centreX
    end getCentreX

    function getCentreY : int 
	result centreY
    end getCentreY
    
    function getWidth : int 
	result width
    end getWidth

    function getHeight : int 
	result height
    end getHeight

    function getColour : int 
	result col
    end getColour

    procedure erase
	var oldcol : int := getColour
	col := 0
	draw
	col := oldcol
    end erase

end Shape
