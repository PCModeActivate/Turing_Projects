unit
class Diamond
    export draw
    var centreX, centreY, width, height, col : int
    centreX := 320
    centreY := 200
    width := 40
    height := 50
    col := red
    proc draw

	var x, y : array 1 .. 4 of int
	x (1) := centreX 
	y (1) := centreY + height div 2
	x (2) := centreX - width div 2
	y (2) := centreY 
	x (3) := centreX 
	y (3) := centreY - height div 2
	x (4) := centreX + width div 2
	y (4) := centreY 
	Draw.FillPolygon (x, y, 4, col)
    end draw

end Diamond
