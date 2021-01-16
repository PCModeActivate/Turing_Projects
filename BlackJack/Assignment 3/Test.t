%%%%% CLASS FILE IMPORT %%%%%
import Card in "Card.t"
%%%%% VARIABLES %%%%%
var card1 : ^Card
new card1
var card2 : ^Card
new card2
var card3 : ^Card
new card3

%%%%% MAIN CODE %%%%%
^card1.setCentre(120,200)
^card1.setCard(2,12)
^card1.draw
delay(500)
^card1.erase
^card2.setCentre(320,200)
^card2.setCard(4,1)
^card2.draw
delay(500)
^card2.erase
^card3.setCentre(520,200)
^card3.setCard(1,8)
^card3.draw
delay(500)
^card3.erase
delay(500)
^card1.draw
^card2.draw
^card3.draw
delay(500)
^card1.erase
^card1.setFace(true)
^card1.draw
delay(500)
^card2.erase
^card2.setFace(true)
^card2.draw
delay(500)
^card3.erase
^card3.setFace(true)
^card3.draw
