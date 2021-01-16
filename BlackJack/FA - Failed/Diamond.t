unit
class Diamond
   
    inherit Shape in "Shape.t"

    body proc draw
 
    col := red

	var x, y : array 1 .. 4 of int
	x (1) := centreX 
	y (1) := centreY + height div 2
	x (2) := centreX + width div 2
	y (2) := centreY 
	x (3) := centreX 
	y (3) := centreY - height div 2
	x (4) := centreX - width div 2
	y (4) := centreY - height div 2
	Draw.FillPolygon (x, y, 4, col)
    end draw
    
end Diamond
