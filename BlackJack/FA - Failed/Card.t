unit
class Card

import Spade in "Spade.t", Heart in "Heart.t", Club in "Club.t", Diamond in "Diamond.t"
    
export setCard, setFace, getFace, setCentre, getSuit, getValue, draw, erase    

    var Spade : ^Spade
    var Heart : ^Heart
    var Club : ^Club
    var Diamond : ^Diamond
    new spade
    new heart
    new club
    new diamond

    var cardX : int := 320
    var cardY : int := 200
    var cardHeight : int := 200
    %%% Legend:
    %%% cardSuit: 1 = Spade, 2 = Heart, 3 = Club, 4 = Diamond
    %%% cardValue: 1 = â€œAâ€, 2 = â€œ2â€, ..., 10 = â€œ10â€, 11 = â€œJâ€, 12 = â€œQâ€, 13 = â€œKâ€
    %%% We will pre-set the card to be Ace of Spade
    var cardSuit : int := 1
    var cardValue : int := 1
    var font : int %font
    font := Font.New ("serif:12") %font
    var cardFace : boolean := false

    proc setCard (suit, num : int)
	cardSuit := suit
	cardValue := num
    end setCard

    proc setFace (boolean face)
	cardFace := face
    end setFace

    function getFace 
	return cardFace
    end getFace

    proc setCentre(x, y : int)
	cardX := x
	cardY := y
	^spade.setCentre(cardX, cardY)
	^heart.setCentre(cardX, cardY)
	^club.setCentre(cardX, cardY)
	^diamond.setCentre(cardX, cardY)
    end setCentre

    function getSuit : int
	result cardSuit
    end getSuit

    function getValue : int
	result cardValue
    end getValue

    function converter : string
	if cardValue = 1
	    return "A"
	elsif cardValue = 10
	    return "10"
	elsif cardValue = 11
	    return "J"
	elsif cardValue = 12
	    return "Q"
	elsif cardValue = 13
	    return "K"
	else 
	    return strint (cardValue)
    end converter

    proc erase
	Draw.FillBox(cardX - (cardHeight * 0.7 div 2), cardY - (cardHeight div 2), cardX + (cardHeight * 0.7 div 2)+1, cardY + (cardHeight div 2)+1, white)
	if cardSuit = 1 then
	    ^spade.erase
	elsif cardSuit = 2 then
	    ^heart.erase 
	elsif cardSuit = 3 then
	    ^club.erase
	elsif cardSuit = 4 then
	    ^diamond.erase
    end erase

    proc draw
	Draw.FillBox(cardX - (cardHeight * 0.7 div 2), cardY - (cardHeight div 2), cardX + (cardHeight * 0.7 div 2), cardY + (cardHeight div 2), white)
	Draw.Box(cardX - (cardHeight * 0.7 div 2), cardY - (cardHeight div 2), cardX + (cardHeight * 0.7 div 2), cardY + (cardHeight div 2), black)
	if cardSuit = 1 then
	    ^spade.draw
	    Draw.Text(converter(cardValue), cardX(cardHeight * 0.7 div 2)+5, cardY + (cardHeight div 2)-5, font, black)
	elsif cardSuit = 2 then
	    ^heart.draw
	    Draw.Text(converter(cardValue), cardX(cardHeight * 0.7 div 2)+5, cardY + (cardHeight div 2)-5, font, red)
	elsif cardSuit = 3 then
	    ^club.draw
	    Draw.Text(converter(cardValue), cardX(cardHeight * 0.7 div 2)+5, cardY + (cardHeight div 2)-5, font, black)
	elsif cardSuit = 4 then
	    ^diamond.draw
	    Draw.Text(converter(cardValue), cardX(cardHeight * 0.7 div 2)+5, cardY + (cardHeight div 2)-5, font, red)
	end if
	if not cardFace then
	    Draw.FillBox(cardX - (cardHeight * 0.7 div 2), cardY - (cardHeight div 2), cardX + (cardHeight * 0.7 div 2), cardY + (cardHeight div 2), black)
	    Draw.Text("L00ks Funny", cardX - (cardHeight * 0.7 div 2), CardY, font)
	end if
    end draw
end Card
