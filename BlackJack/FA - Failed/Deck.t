class Deck

%% Full Deck
import Card in Card.t

var deck : flexible array 1 .. 0 of ^Card

%%% Loop Through Suits %%%
for j : 1 .. 4
%%% Loop Through Values %%%
    for i : 1 .. 13
%%% Extend the Flexible Array %%%
	new deck, (j-1)*13 + i
%%% Create a Card Object at Array Position (j-1)*13 + i %%%
	new deck ((j-1)*13 + i)
%%% Set the Cards %%%
	^ (deck ((j-1)*13 + i)).setCard(j, i)
    end for
end for

function getDeckSize : int
    result upper(deck)
end drawCard

proc discardCard
    new deck, upper(deck)-1
end discardCard

function drawCard : ^Card
    result deck(upper(deck))
end drawCard

function getCard (index : int): ^Card
    result deck(index)
end getCard

proc shuffleDeck
    # WIP
end shuffleDeck
