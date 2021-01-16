%%%%% Importation %%%%%
import Deck in "Deck.t", Card in "Card.t"
%%%%% Global Variables %%%%%
var deck : ^Deck
var card : ^Card := nil
%%%%% Main Code %%%%%
locatexy (150, 210)
put "In this program, we will show you how"
locatexy (150, 190)
put "the methods we have just written works"
delay (4000)
cls
new deck
%%% Set all the cards to the centre coordinates (200,200)
for i : 1 .. 52
^ ( ^deck.getCard (i)).setCentre (200, 200)
end for
loop
%%% Exit the loop if there are no more cards in the deck
if ^deck.getDeckSize = 0 then
exit
end if
var userinput : string (1)
put "The deck currently has ", ^deck.getDeckSize, " cards"
put "What would you like to do with the deck?"
put "Press 1 to shuffle the deck"
put "Press 2 to discard the top card"
put "Press 3 to draw the top card **Note** The drawn card will be displayed"
%%% This draws the backside of the card to the left of the screen
^ ( ^deck.getCard (1)).draw

%%% If the user has chosen to draw a card from before, the card will be drawn
if card ~= nil then
^card.draw
end if
getch (userinput)
if userinput = "1" then
%^deck.shuffleDeck
elsif userinput = "2" then
^deck.discardCard
elsif userinput = "3" then
card := ^deck.drawCard
^card.setCentre (440, 200)
^card.setFace (true)
^card.draw
end if
cls
end loop
put "The deck has no more cards!"
if card ~= nil then
^card.draw
end if
