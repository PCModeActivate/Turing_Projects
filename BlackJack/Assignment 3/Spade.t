unit
class Spade
    inherit Shape in "Shape.t"
    col := black
    body proc draw

	var x, y : array 1 .. 3 of int
	x (1) := centreX - width div 2
	y (1) := centreY - height div 8
	x (2) := centreX + width div 2
	y (2) := centreY - height div 8
	x (3) := centreX
	y (3) := centreY + height div 2
	Draw.FillPolygon (x, y, 3, col)
	Draw.FillArc (centreX - width div 4, centreY - height div 8, width div 4, height div 4, 180, 360, col)
	Draw.FillArc (centreX + width div 4, centreY - height div 8, width div 4,height div 4, 180, 360, col)
	Draw.FillBox (centreX - width div 15, centreY - height div 2, centreX + width div 15, centreY, col)
    end draw

end Spade
