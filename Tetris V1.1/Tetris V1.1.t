setscreen ("graphics:600;600")
process DoMusic
    loop
	Music.PlayFile ("Tetris.MP3")
    end loop
end DoMusic
var pointin, pointout, highscore, currentscore : int
currentscore := 0
var number : string
open : pointin, "Score.txt", get
loop
    get : pointin, number
    exit when eof (pointin)
end loop
highscore := strint (number)
function keystrikes : int
    var a : int := 0
    var chars : array char of boolean
    Input.KeyDown (chars)
    if chars (KEY_RIGHT_ARROW) then
	a += 30
	result a
    elsif chars (KEY_LEFT_ARROW) then
	a += -30
	result a
    else
	result a
    end if
end keystrikes
function updown : int
    var b : int := 0
    var chars : array char of boolean
    Input.KeyDown (chars)
    if chars (KEY_DOWN_ARROW) then
	b := -30
	result b
    else
	result 0
    end if
end updown
var board : array 1 .. 10 of array 1 .. 18 of int
for i : 1 .. 10
    for j : 1 .. 18
	board (i) (j) := 0
    end for
end for
procedure printBox
    for i : 1 .. 10
	for j : 1 .. 18
	    if board (i) (j) = 1 then
		Draw.FillBox ((i - 1) * 30 + 50, j * 30, i * 30 + 50, j * 30 + 30, 7)
	    end if
	end for
    end for
end printBox
procedure checker
    var acc : int := 0
    var emp : int := 0
    for j : 1 .. 18
	acc := 0
	for i : 1 .. 10
	    acc += board (i) (j)
	    if acc = 10 then
		currentscore += 1
		for k : 1 .. 10
		    board (k) (j) := 0
		end for
	    end if
	end for
    end for
    for l : 1 .. 17
	for o : 1 .. 10
	    if board (o) (l) = 0 then
		emp += 1
	    else
		if emp div 10 > 0 then
		    for n : l .. 17
			for p : 1 .. 10
			    board (p) (n - emp div 10) := board (p) (n)
			end for
		    end for
		end if
		emp := 0
	    end if
	end for
    end for
end checker
var leftv : int := 200
var rightv : int := 230
var centerv : int := 200
var vert : int := 540
var vertup : int := 570
var c : int := 0
var choose : int := 0
var vc : boolean := false
var randb : int := 1
var randr : int
var endgame : boolean := false
var bcolor : int := 1
procedure leftright
    var tm := Time.Elapsed
    leftv += keystrikes ()
    rightv += keystrikes ()
    centerv += keystrikes ()
    if randb < 3 then
	for v : vert + 1 .. vertup - 1
	    if whatdotcolor (rightv - 29, v) = 7 or whatdotcolor (leftv + 29, v) = 7 then
		leftv -= keystrikes ()
		rightv -= keystrikes ()
		centerv -= keystrikes ()
		exit
	    end if
	end for
    elsif randb = 3 then
	case randr mod 4 of
	    label 0 :
		for v : vert + 1 .. vert + 29
		    if whatdotcolor (rightv - 29, v) = 7 or whatdotcolor (leftv + 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
		for v : vertup + 29 .. vertup - 1
		    if whatdotcolor (leftv + 29, v) = 7 or whatdotcolor (rightv - 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
	    label 1 :
		for v : vert + 31 .. vert + 59
		    if whatdotcolor (rightv - 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
		for w : vert + 1 .. vertup - 1
		    if whatdotcolor (leftv + 29, w) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
	    label 2 :
		for v : vert + 31 .. vertup - 1
		    if whatdotcolor (leftv + 29, v) = 7 or whatdotcolor (rightv - 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
		for v : vert + 1 .. vert + 29
		    if whatdotcolor (leftv + 29, v) = 7 or whatdotcolor (rightv - 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
	    label 3 :
		for v : vert + 1 .. vertup - 1
		    if whatdotcolor (rightv - 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
		for w : vert + 31 .. vertup - 31
		    if whatdotcolor (leftv + 29, w) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
	end case
    elsif randb = 4 then
	case randr mod 4 of
	    label 0 :
		for v : vert + 1 .. vert + 29
		    if whatdotcolor (rightv - 59, v) = 7 or whatdotcolor (leftv + 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
		for v : vertup - 29 .. vertup - 1
		    if whatdotcolor (leftv + 59, v) = 7 or whatdotcolor (rightv - 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
	    label 1 :
		for v : vert + 31 .. vert + 59
		    if whatdotcolor (rightv - 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
		for w : vert + 1 .. vert + 59
		    if whatdotcolor (leftv + 29, w) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
	    label 2 :
		for v : vert + 31 .. vertup - 1
		    if whatdotcolor (rightv - 59, v) = 7 or whatdotcolor (leftv + 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
		for v : vert + 1 .. vert + 29
		    if whatdotcolor (leftv + 59, v) = 7 or whatdotcolor (rightv - 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
	    label 3 :
		for v : vert + 1 .. vert + 59
		    if whatdotcolor (leftv + 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
		for w : vert + 31 .. vertup - 1
		    if whatdotcolor (rightv - 29, w) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
	end case
    elsif randb = 5 then
	case randr mod 4 of
	    label 0 :
		for v : vert + 1 .. vert + 29
		    if whatdotcolor (leftv + 59, v) = 7 or whatdotcolor (rightv - 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
		for v : vertup - 29 .. vertup - 1
		    if whatdotcolor (rightv - 59, v) = 7 or whatdotcolor (leftv + 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
	    label 1 :
		for v : vert + 31 .. vert + 59
		    if whatdotcolor (leftv + 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
		for w : vert + 1 .. vert + 59
		    if whatdotcolor (rightv - 29, w) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
	    label 2 :
		for v : vert + 31 .. vertup - 1
		    if whatdotcolor (leftv + 59, v) = 7 or whatdotcolor (rightv - 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
		for v : vert + 1 .. vert + 29
		    if whatdotcolor (rightv - 59, v) = 7 or whatdotcolor (leftv + 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
	    label 3 :
		for v : vert + 1 .. vert + 59
		    if whatdotcolor (rightv - 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
		for w : vert + 31 .. vertup - 1
		    if whatdotcolor (leftv + 29, w) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
	end case
    elsif randb = 6 then
	case randr mod 4 of
	    label 0 :
		for v : vert + 1 .. vert + 29
		    if whatdotcolor (rightv - 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
		for v : vertup - 29 .. vertup - 1
		    if whatdotcolor (rightv - 89, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
		for v : vert + 1 .. vertup - 1
		    if whatdotcolor (leftv + 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
	    label 1 :
		for v : vert + 1 .. vert + 59
		    if whatdotcolor (rightv - 59, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
		for v : vertup - 29 .. vertup - 1
		    if whatdotcolor (rightv - 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
		for v : vert + 1 .. vertup - 1
		    if whatdotcolor (leftv + 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
	    label 2 :
		for v : vert + 1 .. vert + 29
		    if whatdotcolor (leftv + 89, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
		for v : vertup - 29 .. vertup - 1
		    if whatdotcolor (leftv + 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
		for v : vert + 1 .. vertup - 1
		    if whatdotcolor (rightv - 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
	    label 3 :
		for v : vert + 1 .. vert + 29
		    if whatdotcolor (leftv + 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
		for v : vertup - 59 .. vertup - 1
		    if whatdotcolor (leftv + 59, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
		for v : vert + 1 .. vertup - 1
		    if whatdotcolor (rightv - 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
	end case
    elsif randb = 7 then
	case randr mod 4 of
	    label 0 :
		for v : vert + 1 .. vert + 29
		    if whatdotcolor (leftv + 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
		for v : vertup - 29 .. vertup - 1
		    if whatdotcolor (leftv + 89, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
		for v : vert + 1 .. vertup - 1
		    if whatdotcolor (rightv - 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
	    label 1 :
		for v : vert + 1 .. vert + 29
		    if whatdotcolor (rightv - 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
		for v : vertup - 59 .. vertup - 1
		    if whatdotcolor (rightv - 59, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
		for v : vert + 1 .. vertup - 1
		    if whatdotcolor (leftv + 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
	    label 2 :
		for v : vert + 1 .. vert + 29
		    if whatdotcolor (rightv - 89, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
		for v : vertup - 29 .. vertup - 1
		    if whatdotcolor (rightv - 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
		for v : vert + 1 .. vertup - 1
		    if whatdotcolor (leftv + 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
	    label 3 :
		for v : vert + 1 .. vert + 59
		    if whatdotcolor (leftv + 59, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
		for v : vertup - 29 .. vertup - 1
		    if whatdotcolor (leftv + 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
		for v : vert + 1 .. vertup - 1
		    if whatdotcolor (rightv - 29, v) = 7 then
			leftv -= keystrikes ()
			rightv -= keystrikes ()
			centerv -= keystrikes ()
		    end if
		end for
	end case
    end if
end leftright
procedure vertcheck
    vc := false
    if vert > 59 then
	if randb < 3 then
	    for i : leftv + 1 .. rightv - 1 by 30
		if whatdotcolor (i, vert - 5) = 7 then
		    vc := true
		end if
	    end for
	elsif randb = 3 then
	    case randr mod 4 of
		label 0 :
		    for i : leftv + 1 .. rightv - 1 by 30
			if whatdotcolor (i, vert - 5) = 7 then
			    vc := true
			end if
		    end for
		label 1 :
		    if whatdotcolor (leftv + 5, vert - 5) = 7 or whatdotcolor (rightv - 5, vert + 35) = 7 then
			vc := true
		    end if
		label 2 :
		    if whatdotcolor (leftv + 5, vert + 5) = 7 or whatdotcolor (rightv - 5, vert + 5) = 7 or whatdotcolor (rightv - 45, vert - 5) = 7 then
			vc := true
		    end if
		label 3 :
		    if whatdotcolor (rightv - 5, vert - 5) = 7 or whatdotcolor (leftv + 5, vert + 5) = 7 then
			vc := true
		    end if
	    end case
	elsif randb = 4 then
	    case randr mod 4 of
		label 0 :
		    if whatdotcolor (leftv + 5, vert - 5) = 7 or whatdotcolor (leftv + 35, vert - 5) = 7 or whatdotcolor (rightv - 5, vert + 5) = 7 then
			vc := true
		    end if
		label 1 :
		    if whatdotcolor (leftv + 5, vert - 5) = 7 or whatdotcolor (rightv - 5, vert + 5) = 7 then
			vc := true
		    end if
		label 2 :
		    if whatdotcolor (leftv + 5, vert + 5) = 7 or whatdotcolor (leftv + 35, vert - 5) = 7 or whatdotcolor (rightv - 5, vert - 5) = 7 then
			vc := true
		    end if
		label 3 :
		    if whatdotcolor (rightv - 5, vert + 5) = 7 or whatdotcolor (leftv + 5, vert - 5) = 7 then
			vc := true
		    end if
	    end case
	elsif randb = 5 then
	    case randr mod 4 of
		label 0 :
		    if whatdotcolor (leftv + 5, vert + 5) = 7 or whatdotcolor (leftv + 35, vert - 5) = 7 or whatdotcolor (rightv - 5, vert - 5) = 7 then
			vc := true
		    end if
		label 1 :
		    if whatdotcolor (leftv + 5, vert + 5) = 7 or whatdotcolor (rightv - 5, vert - 5) = 7 then
			vc := true
		    end if
		label 2 :
		    if whatdotcolor (leftv + 5, vert - 5) = 7 or whatdotcolor (leftv + 35, vert + 5) = 7 or whatdotcolor (rightv - 5, vert + 5) = 7 then
			vc := true
		    end if
		label 3 :
		    if whatdotcolor (rightv - 5, vert - 5) = 7 or whatdotcolor (leftv + 5, vert + 5) = 7 then
			vc := true
		    end if
	    end case
	elsif randb = 6 then
	    case randr mod 4 of
		label 0 :
		    for i : leftv + 1 .. rightv - 1 by 30
			if whatdotcolor (i, vert - 5) = 7 then
			    vc := true
			end if
		    end for
		label 1 :
		    if whatdotcolor (leftv + 5, vert - 5) = 7 or whatdotcolor (rightv - 5, vert + 35) = 7 then
			vc := true
		    end if
		label 2 :
		    if whatdotcolor (leftv + 5, vert + 5) = 7 or whatdotcolor (leftv + 35, vert + 5) = 7 or whatdotcolor (rightv - 5, vert - 5) = 7 then
			vc := true
		    end if
		label 3 :
		    for i : leftv + 1 .. rightv - 1 by 30
			if whatdotcolor (i, vert - 5) = 7 then
			    vc := true
			end if
		    end for
	    end case
	elsif randb = 7 then
	    case randr mod 4 of
		label 0 :
		    for i : leftv + 1 .. rightv - 1 by 30
			if whatdotcolor (i, vert - 5) = 7 then
			    vc := true
			end if
		    end for
		label 1 :
		    for i : leftv + 1 .. rightv - 1 by 30
			if whatdotcolor (i, vert - 5) = 7 then
			    vc := true
			end if
		    end for
		label 2 :
		    if whatdotcolor (leftv + 5, vert - 5) = 7 or whatdotcolor (leftv + 35, vert + 5) = 7 or whatdotcolor (rightv - 5, vert + 5) = 7 then
			vc := true
		    end if
		label 3 :
		    if whatdotcolor (leftv + 5, vert + 35) = 7 or whatdotcolor (rightv - 5, vert - 5) = 7 then
			vc := true
		    end if
	    end case
	end if
    else
	vc := true
    end if
    if vc = false then
	vert += updown ()
	vertup += updown ()
    end if
    if vert > 59 then
	if randb < 3 then
	    for i : leftv + 1 .. rightv - 1 by 30
		if whatdotcolor (i, vert - 5) = 7 and randb < 3 then
		    vc := true
		end if
	    end for
	elsif randb = 3 then
	    case randr mod 4 of
		label 0 :
		    for i : leftv + 1 .. rightv - 1 by 30
			if whatdotcolor (i, vert - 5) = 7 then
			    vc := true
			end if
		    end for
		label 1 :
		    if whatdotcolor (leftv + 5, vert - 5) = 7 or whatdotcolor (rightv - 5, vert + 5) = 7 then
			vc := true
		    end if
		label 2 :
		    if whatdotcolor (leftv + 5, vert + 5) = 7 or whatdotcolor (rightv - 5, vert + 5) = 7 or whatdotcolor (rightv - 40, vert - 5) = 7 then
			vc := true
		    end if
		label 3 :
		    if whatdotcolor (rightv - 5, vert - 5) = 7 or whatdotcolor (leftv + 5, vert + 5) = 7 then
			vc := true
		    end if
	    end case
	elsif randb = 4 then
	    case randr mod 4 of
		label 0 :
		    if whatdotcolor (leftv + 5, vert - 5) = 7 or whatdotcolor (leftv + 35, vert - 5) = 7 or whatdotcolor (rightv - 5, vert + 5) = 7 then
			vc := true
		    end if
		label 1 :
		    if whatdotcolor (leftv + 5, vert - 5) = 7 or whatdotcolor (rightv - 5, vert + 5) = 7 then
			vc := true
		    end if
		label 2 :
		    if whatdotcolor (leftv + 5, vert + 5) = 7 or whatdotcolor (leftv + 35, vert - 5) = 7 or whatdotcolor (rightv - 5, vert - 5) = 7 then
			vc := true
		    end if
		label 3 :
		    if whatdotcolor (rightv - 5, vert + 5) = 7 or whatdotcolor (leftv + 5, vert - 5) = 7 then
			vc := true
		    end if
	    end case
	elsif randb = 5 then
	    case randr mod 4 of
		label 0 :
		    if whatdotcolor (leftv + 5, vert + 5) = 7 or whatdotcolor (leftv + 35, vert - 5) = 7 or whatdotcolor (rightv - 5, vert - 5) = 7 then
			vc := true
		    end if
		label 1 :
		    if whatdotcolor (leftv + 5, vert + 5) = 7 or whatdotcolor (rightv - 5, vert - 5) = 7 then
			vc := true
		    end if
		label 2 :
		    if whatdotcolor (leftv + 5, vert - 5) = 7 or whatdotcolor (leftv + 35, vert + 5) = 7 or whatdotcolor (rightv - 5, vert + 5) = 7 then
			vc := true
		    end if
		label 3 :
		    if whatdotcolor (rightv - 5, vert - 5) = 7 or whatdotcolor (leftv + 5, vert + 5) = 7 then
			vc := true
		    end if
	    end case
	elsif randb = 6 then
	    case randr mod 4 of
		label 0 :
		    for i : leftv + 1 .. rightv - 1 by 30
			if whatdotcolor (i, vert - 5) = 7 then
			    vc := true
			end if
		    end for
		label 1 :
		    if whatdotcolor (leftv + 5, vert - 5) = 7 or whatdotcolor (rightv - 5, vert + 65) = 7 then
			vc := true
		    end if
		label 2 :
		    if whatdotcolor (leftv + 5, vert + 35) = 7 or whatdotcolor (leftv + 35, vert + 35) = 7 or whatdotcolor (rightv - 5, vert - 5) = 7 then
			vc := true
		    end if
		label 3 :
		    for i : leftv + 1 .. rightv - 1 by 30
			if whatdotcolor (i, vert - 5) = 7 then
			    vc := true
			end if
		    end for
	    end case
	elsif randb = 7 then
	    case randr mod 4 of
		label 0 :
		    for i : leftv + 1 .. rightv - 1 by 30
			if whatdotcolor (i, vert - 5) = 7 then
			    vc := true
			end if
		    end for
		label 1 :
		    for i : leftv + 1 .. rightv - 1 by 30
			if whatdotcolor (i, vert - 5) = 7 then
			    vc := true
			end if
		    end for
		label 2 :
		    if whatdotcolor (leftv + 5, vert - 5) = 7 or whatdotcolor (leftv + 35, vert + 5) = 7 or whatdotcolor (rightv - 5, vert + 5) = 7 then
			vc := true
		    end if
		label 3 :
		    if whatdotcolor (leftv + 5, vert + 35) = 7 or whatdotcolor (rightv - 5, vert - 5) = 7 then
			vc := true
		    end if
	    end case
	end if
    else
	vc := true
    end if
end vertcheck
procedure spawn (shape : int, rotation : int)
    %var left, right, vertical: int
    case shape of
	label 1 :
	    case rotation mod 4 of
		label 1 :
		    leftv := centerv - 60
		    rightv := centerv + 60
		    vertup := 30 + vert
		label 2 :
		    vertup := 120 + vert
		    leftv := centerv - 30
		    rightv := centerv
		label 3 :
		    leftv := centerv - 60
		    rightv := centerv + 60
		    vertup := 30 + vert
		label 0 :
		    vertup := 120 + vert
		    leftv := centerv - 30
		    rightv := centerv
	    end case
	label 2 :
	    case rotation mod 1 of
		label 0 :
		    leftv := centerv - 30
		    rightv := centerv + 30
		    vertup := vert + 60
	    end case
	label 3 :
	    case rotation mod 4 of
		label 0 :
		    leftv := centerv - 30
		    rightv := centerv + 60
		    vertup := vert + 60
		label 1 :
		    leftv := centerv
		    rightv := centerv + 60
		    vertup := vert + 90
		label 2 :
		    leftv := centerv - 30
		    rightv := centerv + 60
		    vertup := vert + 60
		label 3 :
		    leftv := centerv - 30
		    rightv := centerv + 30
		    vertup := vert + 90
	    end case
	label 4 :
	    case rotation mod 4 of
		label 0 :
		    leftv := centerv - 30
		    rightv := centerv + 60
		    vertup := vert + 60
		label 1 :
		    leftv := centerv
		    vertup := vert + 90
		    rightv := centerv + 60
		label 2 :
		    leftv := centerv - 30
		    rightv := centerv + 60
		    vertup := vert + 60
		label 3 :
		    leftv := centerv - 30
		    rightv := centerv + 30
		    vertup := vert + 90
	    end case
	label 5 :
	    case rotation mod 4 of
		label 0 :
		    leftv := centerv - 30
		    rightv := centerv + 60
		    vertup := vert + 60
		label 1 :
		    leftv := centerv
		    vertup := vert + 90
		    rightv := centerv + 60
		label 2 :
		    leftv := centerv - 30
		    rightv := centerv + 60
		    vertup := vert + 60
		label 3 :
		    leftv := centerv - 30
		    rightv := centerv + 30
		    vertup := vert + 90
	    end case
	label 6 :
	    case rotation mod 4 of
		label 0 :
		    leftv := centerv - 30
		    rightv := centerv + 60
		    vertup := vert + 60
		label 1 :
		    leftv := centerv
		    rightv := centerv + 60
		    vertup := vert + 90
		label 2 :
		    leftv := centerv - 30
		    rightv := centerv + 60
		    vertup := vert + 60
		label 3 :
		    leftv := centerv - 30
		    rightv := centerv + 30
		    vertup := vert + 90
	    end case
	label 7 :
	    case rotation mod 4 of
		label 0 :
		    leftv := centerv - 30
		    rightv := centerv + 60
		    vertup := vert + 60
		label 1 :
		    leftv := centerv
		    rightv := centerv + 60
		    vertup := vert + 90
		label 2 :
		    leftv := centerv - 30
		    rightv := centerv + 60
		    vertup := vert + 60
		label 3 :
		    leftv := centerv - 30
		    rightv := centerv + 30
		    vertup := vert + 90
	    end case
    end case
end spawn
procedure dr
    if randb > 2 then
	case randb of
	    label 3 :
		case randr mod 4 of
		    label 0 :
			Draw.FillBox (leftv, vert, rightv, vertup - 30, bcolor)
			Draw.FillBox (centerv, vertup - 30, centerv + 30, vertup, bcolor)
		    label 1 :
			Draw.FillBox (leftv, vertup, rightv - 30, vert, bcolor)
			Draw.FillBox (rightv - 30, vert + 30, rightv, vertup - 30, bcolor)
		    label 2 :
			Draw.FillBox (leftv, vert + 30, rightv, vertup, bcolor)
			Draw.FillBox (centerv, vert, centerv + 30, vert + 30, bcolor)
		    label 3 :
			Draw.FillBox (leftv + 30, vert, rightv, vertup, bcolor)
			Draw.FillBox (leftv + 30, vert + 30, leftv, vertup - 30, bcolor)
		end case
	    label 4 :
		case randr mod 4 of
		    label 0 :
			Draw.FillBox (leftv, vert, centerv + 30, vert + 30, bcolor)
			Draw.FillBox (centerv, vert + 30, rightv, vertup, bcolor)
		    label 1 :
			Draw.FillBox (leftv, vert, centerv + 30, vertup - 30, bcolor)
			Draw.FillBox (centerv + 30, vert + 30, rightv, vertup, bcolor)
		    label 2 :
			Draw.FillBox (leftv, vert + 30, centerv + 30, vertup, bcolor)
			Draw.FillBox (centerv, vert, rightv, vert + 30, bcolor)
		    label 3 :
			Draw.FillBox (leftv, vert, centerv, vertup - 30, bcolor)
			Draw.FillBox (centerv, vert + 30, rightv, vertup, bcolor)
		end case
	    label 5 :
		case randr mod 4 of
		    label 0 :
			Draw.FillBox (leftv, vert + 30, centerv + 30, vertup, bcolor)
			Draw.FillBox (centerv, vert, rightv, vert + 30, bcolor)
		    label 1 :
			Draw.FillBox (leftv, vert + 30, centerv + 30, vertup, bcolor)
			Draw.FillBox (centerv + 30, vertup - 30, rightv, vert, bcolor)
		    label 2 :
			Draw.FillBox (leftv, vert, centerv + 30, vert + 30, bcolor)
			Draw.FillBox (centerv, vert + 30, rightv, vertup, bcolor)
		    label 3 :
			Draw.FillBox (leftv, vert + 30, centerv, vertup, bcolor)
			Draw.FillBox (centerv, vert, rightv, vertup - 30, bcolor)
		end case
	    label 6 :
		case randr mod 4 of
		    label 0 :
			Draw.FillBox (leftv, vert, rightv, vertup - 30, bcolor)
			Draw.FillBox (leftv, vertup - 30, centerv, vertup, bcolor)
		    label 1 :
			Draw.FillBox (leftv, vertup, rightv - 30, vert, bcolor)
			Draw.FillBox (rightv - 30, vertup - 30, rightv, vertup, bcolor)
		    label 2 :
			Draw.FillBox (leftv, vertup, rightv, vertup - 30, bcolor)
			Draw.FillBox (centerv + 30, vert + 30, rightv, vert, bcolor)
		    label 3 :
			Draw.FillBox (leftv + 30, vert, rightv, vertup, bcolor)
			Draw.FillBox (leftv + 30, vert, leftv, vert + 30, bcolor)
		end case
	    label 7 :
		case randr mod 4 of
		    label 0 :
			Draw.FillBox (leftv, vert, rightv, vertup - 30, bcolor)
			Draw.FillBox (centerv + 30, vertup - 30, rightv, vertup, bcolor)
		    label 1 :
			Draw.FillBox (leftv, vertup, rightv - 30, vert, bcolor)
			Draw.FillBox (rightv - 30, vert, rightv, vert + 30, bcolor)
		    label 2 :
			Draw.FillBox (leftv, vertup, rightv, vertup - 30, bcolor)
			Draw.FillBox (leftv, vert + 30, centerv, vert, bcolor)
		    label 3 :
			Draw.FillBox (leftv + 30, vert, rightv, vertup, bcolor)
			Draw.FillBox (leftv + 30, vertup - 30, leftv, vertup, bcolor)
		end case
	end case
    end if
    %put randb, randr
end dr
procedure rotate
    var chars : array char of boolean
    Input.KeyDown (chars)
    if chars (KEY_UP_ARROW) then
	randr += 1
	spawn (randb, randr)
	for i : leftv + 1 .. rightv - 1
	    for v : vert + 1 .. vertup - 1
		if whatdotcolor (i, v) = 7 then
		    randr -= 1
		    spawn (randb, randr)
		    if randb = 3 and whatdotcolor (rightv - 29, vert + 40) = 7 then
			randr -= 1
			spawn (randb, randr)
		    elsif randb = 3 and whatdotcolor (leftv + 29, vert + 40) = 7 then
			randr -= 1
			spawn (randb, randr)
		    end if
		    if randb = 4 and whatdotcolor (rightv - 29, vert + 40) = 7 then
			randr -= 1
			spawn (randb, randr)
		    elsif randb = 4 and whatdotcolor (leftv + 29, vert + 40) = 7 then
			randr -= 1
			spawn (randb, randr)
		    end if
		    if randb = 5 and whatdotcolor (rightv - 29, vert + 40) = 7 then
			randr -= 1
			spawn (randb, randr)
		    elsif randb = 5 and whatdotcolor (leftv + 29, vert + 40) = 7 then
			randr -= 1
			spawn (randb, randr)
		    end if
		    if randb = 6 and whatdotcolor (rightv - 29, vert + 70) = 7 then
			randr -= 1
			spawn (randb, randr)
		    elsif randb = 6 and whatdotcolor (leftv + 29, vert + 10) = 7 then
			randr -= 1
			spawn (randb, randr)
		    end if
		    if randb = 7 and whatdotcolor (leftv + 29, vert + 70) = 7 then
			randr -= 1
			spawn (randb, randr)
		    elsif randb = 7 and whatdotcolor (rightv - 29, vert + 10) = 7 then
			randr -= 1
			spawn (randb, randr)
		    end if
		end if
	    end for
	end for
    end if
end rotate
procedure store
    for j : 35 .. 549 by 30
	for i : 55 .. 349 by 30
	    if whatdotcolor (i, j) ~= 0 then
		board ((i - 20) div 30) (j div 30) := 1
	    end if
	end for
    end for
end store
loop
    fork DoMusic
    loop
	randint (randr, 1, 4)
	randint (randb, 1, 7)
	spawn (randb, randr)
	randint (bcolor, 1, 14)
	loop
	    vert -= 30
	    vertup -= 30
	    spawn (randb, randr)
	    loop
		c += 1
		delay (100)
		loop
		    cls
		    Draw.Box (49, 30, 351, 540, 7)
		    Draw.Line (49, 540, 351, 540, 5)
		    var tm : int := Time.Elapsed
		    printBox ()
		    if vc = false then
			rotate ()
		    end if
		    leftright ()
		    vertcheck ()
		    put "Current Score: ", currentscore, " lines; Highscore: ", highscore, " lines"
		    if randb < 3 then
			Draw.FillBox (leftv, vert, rightv, vertup, bcolor)
		    else
			dr
		    end if
		    exit when tm + 10000 >= Time.Elapsed
		end loop
		exit when c > 20
	    end loop
	    c := 0
	    if vc = true then
		%record:
		for i : 50 .. 350
		    if whatdotcolor (i, 550) ~= 0 then
			cls
			endgame := true
			exit
		    end if
		end for
		store
		%board ((rightv - 50) div 30) (vert div 30) := 1
		%reset:
		leftv := 200
		rightv := 230
		vert := 540
		centerv := 200
		checker ()
		exit
	    end if
	end loop
	if endgame = true then
	    exit
	end if
    end loop
    if endgame = true then
	exit
    end if
end loop
if endgame = true then
    open : pointout, "Score.txt", put
    cls
    var font4 : int := Font.New ("sans serif:18:bold,Italic")
    Font.Draw ("Game Over. Your score is :", 150, 300, font4, green)
    Font.Draw (intstr (currentscore), 240, 280, font4, green)
    if currentscore > highscore then
	put : pointout, intstr (currentscore)
	Font.Draw ("A new highscore! ", 210, 340, font4, green)
    end if
end if
