unit
class Dice
    inherit Shape in "Shape.t"

    proc setValue (v:int)
	if v > 6 or v < 1 then
	    put "Invalid Integer, set to 1"
	    value := 1
	else 
	    value := v
	end if    
    end setValue

    proc setColor (v:int)
	if v > 255 or v < 0 then
	    put "Invalid Integer, set to black"
	    colr := black
	else 
	    colr := v
	end if
    end setColor
    
    proc setSize (v:int)
	sz := v
    end setSize

    function getSize : int 
	result sz
    end getSize

    function getValue : int
	result value
    end getValue

    body proc draw
	Draw.FillBox(centerX-sz, centerY-sz, centerX+sz, centerY+sz,  white)
	Draw.Box(centerX-sz, centerY-sz, centerX+sz, centerY+sz, black)
	if value = 1 then
	    Draw.FillOval(centerX, centerY, 5, 5, colr)
	elsif value = 2 then
	    Draw.FillOval(centerX-sz div 2, centerY, 5, 5, colr)
	    Draw.FillOval(centerX+sz div 2, centerY, 5, 5, colr)
	elsif value = 3 then
	    Draw.FillOval(centerX, centerY, 5, 5, colr)
	    Draw.FillOval(centerX-sz div 2, centerY, 5, 5, colr)
	    Draw.FillOval(centerX+sz div 2, centerY, 5, 5, colr)  
	elsif value = 4 then
	    Draw.FillOval(centerX-sz div 2, centerY-sz div 2, 5, 5, colr)
	    Draw.FillOval(centerX-sz div 2, centerY+sz div 2, 5, 5, colr)
	    Draw.FillOval(centerX+sz div 2, centerY-sz div 2, 5, 5, colr)
	    Draw.FillOval(centerX+sz div 2, centerY+sz div 2, 5, 5, colr)  
	elsif value = 5 then 
	    Draw.FillOval(centerX, centerY, 5, 5, colr)
	    Draw.FillOval(centerX-sz div 2, centerY-sz div 2, 5, 5, colr)
	    Draw.FillOval(centerX-sz div 2, centerY+sz div 2, 5, 5, colr)
	    Draw.FillOval(centerX+sz div 2, centerY-sz div 2, 5, 5, colr)
	    Draw.FillOval(centerX+sz div 2, centerY+sz div 2, 5, 5, colr)
	elsif value = 6 then
	    Draw.FillOval(centerX-sz div 2, centerY, 5, 5, colr)
	    Draw.FillOval(centerX+sz div 2, centerY, 5, 5, colr)
	    Draw.FillOval(centerX-sz div 2, centerY-sz div 2, 5, 5, colr)
	    Draw.FillOval(centerX-sz div 2, centerY+sz div 2, 5, 5, colr)
	    Draw.FillOval(centerX+sz div 2, centerY-sz div 2, 5, 5, colr)
	    Draw.FillOval(centerX+sz div 2, centerY+sz div 2, 5, 5, colr) 
	end if
    end draw

end Dice
