unit
class Dice
    inherit Shape in "Shape.t"
    export setColour, setDieValue, getValue, setSize
    var value : int := 1
    proc setColour (v:int)
	if v > 255 or v < 0 then
	    put "Invalid Integer, set to black"
	    col := black
	else 
	    col := v
	end if
    end setColour

    proc setDieValue(v:int)
	if v > 6 or v < 1 then
	    put "Invalid Integer, set to 1"
	    value := 1
	else 
	    value := v
	end if  
    end setDieValue
    
    function getValue : int
	result value
    end getValue

    proc setSize(v:int)
	height:=v
    end setSize

    body proc draw
	var dotsize : int := height div 5
	Draw.FillBox(centreX-height, centreY-height, centreX+height, centreY+height,  white)
	Draw.Box(centreX-height, centreY-height, centreX+height, centreY+height, black)
	if value = 1 then
	    Draw.FillOval(centreX, centreY, dotsize, dotsize, col)
	elsif value = 2 then
	    Draw.FillOval(centreX-height div 2, centreY, dotsize, dotsize, col)
	    Draw.FillOval(centreX+height div 2, centreY, dotsize, dotsize, col)
	elsif value = 3 then
	    Draw.FillOval(centreX, centreY, dotsize, dotsize, col)
	    Draw.FillOval(centreX+height div 2, centreY-height div 2, dotsize, dotsize, col)
	    Draw.FillOval(centreX-height div 2, centreY+height div 2, dotsize, dotsize, col)  
	elsif value = 4 then
	    Draw.FillOval(centreX-height div 2, centreY-height div 2, dotsize, dotsize, col)
	    Draw.FillOval(centreX-height div 2, centreY+height div 2, dotsize, dotsize, col)
	    Draw.FillOval(centreX+height div 2, centreY-height div 2, dotsize, dotsize, col)
	    Draw.FillOval(centreX+height div 2, centreY+height div 2, dotsize, dotsize, col)  
	elsif value = 5 then 
	    Draw.FillOval(centreX, centreY, dotsize, dotsize, col)
	    Draw.FillOval(centreX-height div 2, centreY-height div 2, dotsize, dotsize, col)
	    Draw.FillOval(centreX-height div 2, centreY+height div 2, dotsize, dotsize, col)
	    Draw.FillOval(centreX+height div 2, centreY-height div 2, dotsize, dotsize, col)
	    Draw.FillOval(centreX+height div 2, centreY+height div 2, dotsize, dotsize, col)
	elsif value = 6 then
	    Draw.FillOval(centreX-height div 2, centreY, dotsize, dotsize, col)
	    Draw.FillOval(centreX+height div 2, centreY, dotsize, dotsize, col)
	    Draw.FillOval(centreX-height div 2, centreY-height div 2, dotsize, dotsize, col)
	    Draw.FillOval(centreX-height div 2, centreY+height div 2, dotsize, dotsize, col)
	    Draw.FillOval(centreX+height div 2, centreY-height div 2, dotsize, dotsize, col)
	    Draw.FillOval(centreX+height div 2, centreY+height div 2, dotsize, dotsize, col) 
	end if
    end draw

end Dice
