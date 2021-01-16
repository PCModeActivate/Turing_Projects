unit
class Heart
    export draw
    var centreX, centreY, width, height, col : int
    centreX := 320
    centreY := 200
    width := 40
    height := 50
    col := red
    proc draw
	var x, y : array 1 .. 3 of int
	x (1) := centreX - width div 2
	y (1) := centreY + height div 8
	x (2) := centreX + width div 2
	y (2) := centreY + height div 8
	x (3) := centreX
	y (3) := centreY - height div 2
	Draw.FillPolygon (x, y, 3, col)
	Draw.FillArc (centreX - width div 4, centreY + height div 8, width div 4, height
	    * 3 div 8, 0, 180, col)
	Draw.FillArc (centreX + width div 4, centreY + height div 8, width div 4, height
	    * 3 div 8, 0, 180, col)
    end draw


end Heart
