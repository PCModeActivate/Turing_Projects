var l : int := 0
var w : int := 0
var m : int := 0
Mouse.ButtonChoose ("multibutton")
var mx, my, b : int

type pair :
    record
	first : int
	second : int
    end record

procedure getvalues
    Draw.Text ("Input size of minefield in order of x, y, and mine number.", 100, 200, defFontID, black)
    get l, w, m
    cls
    if (m >= l * w or m <= 0 or l < 1 or w < 1) then
	Draw.Text ("Invalid input, please input again.", 100, 200, defFontID, black)
    else
	Draw.Text ("Welcome to Minesweeper.", 100, 200, defFontID, black)
	delay (1000)
	cls
    end if
end getvalues

getvalues
var scr : string := "graphics:" + intstr (l * 40 + 20) + ";" + intstr (w * 40 + 20)
setscreen (scr)

var field : array 1 .. l, 1 .. w of int
var playerfield : array 1 .. l, 1 .. w of char
%init
for i : 1 .. l
    for j : 1 .. w
	field (i, j) := 0
    end for
end for
for i : 1 .. l
    for j : 1 .. w
	playerfield (i, j) := 'h'
    end for
end for

function translate (i : int) : char
    if (i = -1) then
	result 'm'
    elsif (i = 0) then
	result 'E'
    else
	result chr (i + 48)
    end if
end translate
procedure drawgrid
    cls
    for i : 1 .. l
	for j : 1 .. w
	    Draw.Box (10 + 40 * (i - 1), 10 + 40 * (j - 1), 10 + i * 40, 10 + j * 40, black)
	    Draw.Text (intstr (field (i, j)), 40 * i - 10, 40 * j - 10, defFontID, black)
	end for
    end for
end drawgrid

procedure drawfield
    cls
    for i : 1 .. l
	for j : 1 .. w
	    Draw.Box (10 + 40 * (i - 1), 10 + 40 * (j - 1), 10 + i * 40, 10 + j * 40, black)
	    %Draw.Text (playerfield(l,w), 40 * i - 10, 40 * j - 10, defFontID, black)
	    if playerfield (i, j) = 'u' then
		Draw.FillBox(11 + 40 * (i - 1), 11 + 40 * (j - 1), 9 + i * 40, 9 + j * 40, grey)
		if (~field(i,j)= 0) then
		    Draw.Text (translate (field (i, j)), 40 * i - 20, 40 * j - 20, defFontID, blue)
		end if
	    elsif playerfield (i, j) = 'M' then
		Draw.Text ("P", 40 * i - 20, 40 * j - 20, defFontID, red)
	    end if
	end for
    end for
end drawfield
% assign mines
for i : 1 .. m
    var rl : int
    randint (rl, 1, l)
    var rw : int
    randint (rw, 1, w)
    loop
	randint (rl, 1, l)
	randint (rw, 1, w)
	exit when field (rl, rw) ~= -1
    end loop
    field (rl, rw) := -1
end for

%assign number
for i : 1 .. l
    for j : 1 .. w
	if (field (i, j) = -1) then
	    if (j > 1) then
		if (field (i, j - 1) ~= -1) then
		    field (i, j - 1) += 1
		end if
	    end if
	    if (j < w) then
		if (field (i, j + 1) ~= -1) then
		    field (i, j + 1) += 1
		end if
	    end if
	    if (i > 1) then
		if (field (i - 1, j) ~= -1) then
		    field (i - 1, j) += 1
		end if
		if (j > 1) then
		    if (field (i - 1, j - 1) ~= -1) then
			field (i - 1, j - 1) += 1
		    end if
		end if
		if (j < w) then
		    if (field (i - 1, j + 1) ~= -1) then
			field (i - 1, j + 1) += 1
		    end if
		end if
	    end if
	    if (i < l) then
		if (field (i + 1, j) ~= -1) then
		    field (i + 1, j) += 1
		end if
		if (j > 1) then
		    if (field (i + 1, j - 1) ~= -1) then
			field (i + 1, j - 1) += 1
		    end if
		end if
		if (j < w) then
		    if (field (i + 1, j + 1) ~= -1) then
			field (i + 1, j + 1) += 1
		    end if
		end if
	    end if
	end if
    end for
end for
%end assignnumber
drawfield
loop
    var checkwon : boolean := true
    Mouse.Where (mx, my, b)
    if (b = 1) then
    if (mx>10 and my>10 and mx<10+l*40 and my<10+w*40) then
	if playerfield ((mx - 10) div 40 + 1, (my - 10) div 40 + 1) = 'h' then
	    playerfield ((mx - 10) div 40 + 1, (my - 10) div 40 + 1) := 'u'
	    if field ((mx - 10) div 40 + 1, (my - 10) div 40 + 1) = 0 then
		var open_other_blanks : flexible array 1 .. 1 of pair
		new open_other_blanks, 1
		open_other_blanks (1).first := (mx - 10) div 40 + 1
		open_other_blanks (1).second := (my - 10) div 40 + 1
		loop
		    var tx : int := open_other_blanks (1).first
		    var ty : int := open_other_blanks (1).second
		    if ty > 1 then
			if field (tx, ty - 1) = 0 and playerfield (tx, ty - 1) = 'h' then
			    new open_other_blanks, upper (open_other_blanks) + 1
			    open_other_blanks (upper (open_other_blanks)).first := tx
			    open_other_blanks (upper (open_other_blanks)).second := ty - 1
			end if
			playerfield (tx, ty - 1) := 'u'
		    end if
		    if ty < w and playerfield (tx, ty + 1) = 'h' then
			if field (tx, ty + 1) = 0 then
			    new open_other_blanks, upper (open_other_blanks) + 1
			    open_other_blanks (upper (open_other_blanks)).first := tx
			    open_other_blanks (upper (open_other_blanks)).second := ty + 1
			end if
			playerfield (tx, ty + 1) := 'u'
		    end if
		    if tx > 1 then
			if field (tx - 1, ty) = 0 and playerfield (tx - 1, ty) = 'h' then
			    new open_other_blanks, upper (open_other_blanks) + 1
			    open_other_blanks (upper (open_other_blanks)).first := tx - 1
			    open_other_blanks (upper (open_other_blanks)).second := ty
			end if
			playerfield (tx - 1, ty) := 'u'
			if ty > 1 then
			    if field (tx - 1, ty - 1) = 0 and playerfield (tx - 1, ty - 1) = 'h' then
				new open_other_blanks, upper (open_other_blanks) + 1
				open_other_blanks (upper (open_other_blanks)).first := tx - 1
				open_other_blanks (upper (open_other_blanks)).second := ty - 1
			    end if
			    playerfield (tx - 1, ty - 1) := 'u'
			end if
			if ty < w then
			    if field (tx - 1, ty + 1) = 0 and playerfield (tx - 1, ty + 1) = 'h' then
				new open_other_blanks, upper (open_other_blanks) + 1
				open_other_blanks (upper (open_other_blanks)).first := tx - 1
				open_other_blanks (upper (open_other_blanks)).second := ty + 1
			    end if
			    playerfield (tx - 1, ty + 1) := 'u'
			end if
		    end if
		    if tx < l then
			if field (tx + 1, ty) = 0 and playerfield (tx + 1, ty) = 'h' then
			    new open_other_blanks, upper (open_other_blanks) + 1
			    open_other_blanks (upper (open_other_blanks)).first := tx + 1
			    open_other_blanks (upper (open_other_blanks)).second := ty
			end if
			playerfield (tx + 1, ty) := 'u'
			if ty > 1 then
			    if field (tx + 1, ty - 1) = 0 and playerfield (tx + 1, ty - 1) = 'h' then
				new open_other_blanks, upper (open_other_blanks) + 1
				open_other_blanks (upper (open_other_blanks)).first := tx + 1
				open_other_blanks (upper (open_other_blanks)).second := ty - 1
			    end if
			    playerfield (tx + 1, ty - 1) := 'u'
			end if
			if ty < w then
			    if field (tx + 1, ty + 1) = 0 and playerfield (tx + 1, ty + 1) = 'h' then
				new open_other_blanks, upper (open_other_blanks) + 1
				open_other_blanks (upper (open_other_blanks)).first := tx + 1
				open_other_blanks (upper (open_other_blanks)).second := ty + 1
			    end if
			    playerfield (tx + 1, ty + 1) := 'u'
			end if
		    end if
		    open_other_blanks (1) := open_other_blanks (upper (open_other_blanks))
		    new open_other_blanks, upper (open_other_blanks) - 1
		    exit when upper (open_other_blanks) = 0
		end loop
	    end if
	    drawfield
	    delay(100)
	end if
	if field ((mx - 10) div 40 + 1, (my - 10) div 40 + 1) = -1 and ~playerfield ((mx - 10) div 40 + 1, (my - 10) div 40 + 1) = 'M' then
	    cls
	    Draw.Text ("Game Over", 200, 240, defFontID, black)
	    delay (10000000);
	end if
	%if playerfield ((mx - 10) div 40 + 1, (my - 10) div 40 + 1) = 'u' and ~field ((mx - 10) div 40 + 1, (my - 10) div 40 + 1) = 0 then
	%    if (mx>40)
	%        if (my>40)
	%            if (playerfield ((mx - 10) div 40 + 1, (my - 10) div 40 + 1) = 'h' and ~playerfield ((mx - 10) div 40 + 1, (my - 10) div 40 + 1) = 'M')
	%    end if
	%    if (mx<40*l)
	%    end if
	%end if
     end if
   elsif (b = 100) then
	if playerfield ((mx - 10) div 40 + 1, (my - 10) div 40 + 1) = 'h' then
	    playerfield ((mx - 10) div 40 + 1, (my - 10) div 40 + 1) := 'M'
	elsif playerfield ((mx - 10) div 40 + 1, (my - 10) div 40 + 1) = 'M' then
	    playerfield ((mx - 10) div 40 + 1, (my - 10) div 40 + 1) := 'h'
	end if
	drawfield
	delay(250)
    end if
    for i : 1 .. l
	for j : 1 .. w
	    if playerfield (i, j) = 'h' then
		checkwon := false
	    end if
	end for
    end for
    if checkwon then
	cls
	Draw.Text ("You won!", 200, 240, defFontID, black)
	delay (10000000);
    end if
end loop
