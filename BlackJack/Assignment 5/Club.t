unit
class Club
    inherit Shape in "Shape.t"
    
    body proc draw
    
    col := black
	Draw.FillOval (centreX - width div 4, centreY - height div 8, width div 4,height div 4, col)
	Draw.FillOval (centreX + width div 4, centreY - height div 8, width div 4,height div 4, col)
	Draw.FillOval (centreX, centreY + height div 4, width div 4, height div 4,col)
	Draw.FillBox (centreX - width div 15, centreY - height div 2, centreX + width div 15, centreY, col)
    end draw

end Club
