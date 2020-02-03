pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

function _init()

end

function _update()

end

function _draw()

	cls(1)
	draw_boxing_ring(10,43,12,2,7)

end

function draw_boxing_ring(margin,y_start,floor_col,pole_col,rope_col)

	draw_floor(margin,y_start,floor_col)
	draw_poles(margin,y_start,pole_col)
	draw_ropes_horiz(margin,y_start,rope_col)
	draw_ropes_verti(margin,y_start,rope_col)

end

function draw_floor(margin,y_start,col)

	local y_coordinate=y_start
	local x_left=margin-1
	local x_right=128-margin
	for i=0,margin-1,1 do
		for j=x_left,x_right,1 do
			pset(j,y_coordinate,col)
		end
		x_left-=1
		x_right+=1
		y_coordinate+=1
	end

	rectfill(0,y_coordinate,128,128,col)

end

function draw_poles(margin,y_coordinate,col)

	rectfill(margin+1,y_coordinate-25,margin+5,y_coordinate+1,col)
	rectfill(128-(margin+2),y_coordinate-25,128-(margin+6),y_coordinate+1,col)
	circfill(128-(margin+2)-2,y_coordinate-25,2.5,col)
	circfill(margin+1+2,y_coordinate-25,2.5,col)

end

function draw_ropes_horiz(margin,y_coordinate,col)

	line(margin+6,y_coordinate-7,128-margin-7,y_coordinate-7,col)
	line(margin+6,y_coordinate-14,128-margin-7,y_coordinate-14,col)
	line(margin+6,y_coordinate-21,128-margin-7,y_coordinate-21,col)

end

function draw_ropes_verti(margin,y_coordinate,col)

	line(margin,y_coordinate-7,0,y_coordinate+3,col)
	line(margin,y_coordinate-14,0,y_coordinate-4,col)
	line(margin,y_coordinate-21,0,y_coordinate-11,col)

	line(128-margin-1,y_coordinate-7,127,y_coordinate+3,col)
	line(128-margin-1,y_coordinate-14,127,y_coordinate-4,col)
	line(128-margin-1,y_coordinate-21,127,y_coordinate-11,col)

end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
