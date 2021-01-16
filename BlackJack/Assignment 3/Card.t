unit
class Card
    import Spade in "Spade.t", Heart in "Heart.t", Club in "Club.t", Diamond in "Diamond.t"

    export getSuit, getValue, getFace, setCard, setCentre, setFace, draw, erase
    
    var spade : ^Spade
    var heart : ^Heart
    var club : ^Club
    var diamond : ^Diamond
    new spade
    new heart
    new club
    new diamond

    var cardX : int := 320
    var cardY : int := 200
    var cardHeight : int := 200
    %%% Legend:
    %%% cardSuit: 1 = Spade, 2 = Heart, 3 = Club, 4 = Diamond
    %%% cardValue: 1 = ¡°A¡±, 2 = ¡°2¡±, ..., 10 = ¡°10¡±, 11 = ¡°J¡±, 12 = ¡°Q¡±, 13 = ¡°K¡±
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

    proc setFace (face:boolean)
	cardFace := face
    end setFace

    function getFace : boolean
	result cardFace
    end getFace
    
    proc setCentre (x, y : int)
	cardX := x
	cardY := y
	^spade.setCentre (cardX, cardY)
	^heart.setCentre (cardX, cardY)
	^club.setCentre (cardX, cardY)
	^diamond.setCentre (cardX, cardY)
    end setCentre

    function getSuit : int
	result cardSuit
    end getSuit

    function getValue : int
	result cardValue
    end getValue
    
    function converter : string
	if cardValue = 1 then
	    result "A"
	elsif cardValue = 10 then
	    result "10"
	elsif cardValue = 11 then
	    result "J"
	elsif cardValue = 12 then 
	    result "Q"
	elsif cardValue = 13 then
	    result "K"
	else 
	    result intstr (cardValue)
	end if
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
	end if
    end erase

    proc draw
	Draw.FillBox(cardX - (cardHeight * 0.7 div 2), cardY - (cardHeight div 2), cardX + (cardHeight * 0.7 div 2), cardY + (cardHeight div 2), white)
	Draw.Box(cardX - (cardHeight * 0.7 div 2), cardY - (cardHeight div 2), cardX + (cardHeight * 0.7 div 2), cardY + (cardHeight div 2), black)
	if cardSuit = 1 then
	    ^spade.draw
	    Draw.Text(converter(), cardX-(cardHeight * 0.7 div 2)+5, cardY + (cardHeight div 2)-15, font, black)
	elsif cardSuit = 2 then
	    ^heart.draw
	    Draw.Text(converter(), cardX-(cardHeight * 0.7 div 2)+5, cardY + (cardHeight div 2)-15, font, red)
	elsif cardSuit = 3 then
	    ^club.draw
	    Draw.Text(converter(), cardX-(cardHeight * 0.7 div 2)+5, cardY + (cardHeight div 2)-15, font, black)
	elsif cardSuit = 4 then
	    ^diamond.draw
	    Draw.Text(converter(), cardX-(cardHeight * 0.7 div 2)+5, cardY + (cardHeight div 2)-15, font, red)
	end if
	if not cardFace then
	    Draw.FillBox(cardX - (cardHeight * 0.7 div 2), cardY - (cardHeight div 2), cardX + (cardHeight * 0.7 div 2), cardY + (cardHeight div 2), black)
	    Draw.Text("L00ks Funny", cardX - (cardHeight * 0.7 div 2)+25, cardY, font, white)
	end if
    end draw

end Card
