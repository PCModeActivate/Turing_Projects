%%%%% Importation %%%%%
import Dice in "Dice.t"
%%%%% Global Variables %%%%%
var dice : ^Dice
var userinput1 : string (1)
var userinput2 : int
var userinput3 : int
%%%%% Main Code %%%%%
locatexy (155, 210)
put "In this program, we will test out the Dice"
locatexy (150, 190)
put "class and some of the methods we have written"
delay (4000)
cls
new dice
loop
    ^dice.draw
    put "What would you like to do with the die?"
    put "Press 1 to set centre coordinates"
    put "Press 2 to set die colour"
    put "Press 3 to set die value"
    put "Press 4 to set die size"
    getch (userinput1)
    if userinput1 = "1" then
	put "Please enter new centre x coordinates: " ..
	get userinput2
	put "Please enter new centre y coordinates: " ..
	get userinput3
	^dice.setCentre (userinput2, userinput3)
    elsif userinput1 = "2" then
	put "Please enter new colour code: " ..
	get userinput2
	^dice.setColour (userinput2)
    elsif userinput1 = "3" then
	put "Please enter new die value: " ..
	get userinput2
	^dice.setDieValue (userinput2)
    elsif userinput1 = "4" then
	put "Please enter new size: " ..
	get userinput2
	^dice.setSize (userinput2)
    end if
    cls
end loop
