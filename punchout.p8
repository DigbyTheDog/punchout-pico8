pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

crowd_goes_wild=false
audience_members={}
protag=nil

function _init()

	for i=20,105,9 do
		make_audience_member(i,0)
	end
	for i=20,110,12 do
		make_audience_member(i,1)
	end
	for i=20,110,15 do
		make_audience_member(i,2)
	end

	protag=make_protag()

end

function _update()

	if btnp(4) then
		crowd_goes_wild=true
	end

	if btnp(5) then
		crowd_goes_wild=false
	end

	local mem
	for mem in all(audience_members) do
		mem:update()
	end

end

function _draw()

	cls(1)

	local mem
	for mem in all(audience_members) do
		mem:draw()
	end

	draw_boxing_ring(10,43,12,2,7)

	protag:draw()

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

function make_protag()

	local p = {
		draw=function(self)
			spr(1,60,90)
			spr(16,52,98)
			spr(17,60,98)
			spr(18,68,98)
			spr(32,52,106)
			spr(33,60,106)
			spr(34,68,106)
			spr(49,60,114)
			spr(50,68,114)
		end
	}

	protag=p
	return p

end

-- layer: 0 is far back, 1 is middle row, 2 is front row
function make_audience_member(x,layer)

	local dark_skin=false
	local color
	local y
	local body_radius
	local head_radius
	local starts_cheering_on_frame=flr(rnd(10))
	if flr(rnd(5))==0 then
		dark_skin=true
	end
	if layer==0 then
		y=18
		head_radius=2
		body_radius=4
		color=5
	elseif layer==1 then 
		y=25
		head_radius=3
		body_radius=5
		if dark_skin==true then
			color=2
		else
			color=9
		end
	elseif layer==2 then
		y=35
		head_radius=4
		body_radius=6
		if dark_skin==true then
			color=4
		else
			color=15
		end
	end
	local audience_member= {
		orig_y=y,
		x=x,
		y=y,
		head_radius=head_radius,
		body_radius=body_radius,
		color=color,
		layer=layer,
		mouth_open=false,
		thrilled=false,
		rising=true,
		starts_cheering_on_frame=starts_cheering_on_frame,
		cheer_frame_counter=0,
		update=function(self)

			if crowd_goes_wild==true then
				if self.cheer_frame_counter==self.starts_cheering_on_frame then
					self.thrilled=true
				else
					self.cheer_frame_counter+=1
				end
			else
				self.thrilled=false
				self.cheer_frame_counter=0
			end

			if self.thrilled==true then
				self.mouth_open=true
			else 
				self.mouth_open=false
			end

		end,
		draw=function(self)

			if self.thrilled==true or self.y~=self.orig_y then -- rising body
				if self.rising==true then
					self.y-=1
					if self.y==self.orig_y-5 then
						self.rising=false
					end
				end
				if self.rising==false then
					self.y+=1
					if self.y==self.orig_y then
						self.rising=true
					end
				end
			end
			circfill(self.x,self.y+5,self.body_radius,self.color) -- body
			circfill(self.x,self.y,self.head_radius,self.color) -- head
			pset(self.x-2,self.y,0) -- eyes
			pset(self.x+2,self.y,0)

			line(self.x-1,self.y+2,self.x+1,self.y+2,0) -- mouth
			if self.mouth_open==true then 
				line(self.x-1,self.y+1,self.x+1,self.y+1,0)
			end
		end
	}
	add(audience_members,audience_member)

end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000999900000000000000000000033bbb0000000000000000000000000000000000000000000000000099990000999900009999000000000000000000
007007000999999000000000000000000003bbbbb000000000000000000000000000000000000000000000000999999009999990099999900000000000000000
00077000f499999f000000000000000000333b9999000000000000000000000000000000000bbb0000000000f97ff79ff97fff9ff97f889f0000000000000000
00077000f499999f0000000000000000003334999990000000000000000000000000000000bbbbb000000000ff0ff0ffff0fddffff0fddff0000000000000000
00700700ff4444ff000000000000000000fff499999000000000000000000000000000000bbbbbbb00000000fffffffffffffffffffff8ff0000000000000000
000000000ffffff000000000000000000fff49999ff00000000000000000000000000000bbb333bb000000000f7777f00f7707f00f0700800000000000000000
0000000000ffff000000000000000000ffff4444fff0000000000000000000000000000bbb3333bb0000000000ffff0000ffff0000fff8000000000000000000
00000000000ff0000000000000000000f5550ffffff0000000000000000000000000000ff333b33b000000000000000000000000000000000000000000000000
000000bb00ffff000bb0000000000000555550ffff0330000000000000000000000000ffff300000000000000000000000000000000000000000000000000000
00000bbbffffffffbbbb000000000000555ffff000333300000000000000000000000ffff0000000000000000000000000000000000000000000000000000000
00003bffffffffffff3bb00000000000555ffffff00f333000000000000000000000ff9999000000000000000000000000000000000000000000000000000000
00003b5ffff5fffff533b0000000000005fff5fffffff3300000000000000000000ff49999900000000000000000000000000000000000000000000000000000
0000355fffff5ffff55530000000000005ffff5fffffff300000000000000000000ff49999900000000000000000000000000000000000000000000000000000
00000555ff5ff5ff555500000000000000ff5ff5ff55ff00000000000000000000ff49999ff00000000000000000000000000000000000000000000000000000
000005555fffffff0555000000000000000fffffff055f00000000000000000000ff4444fff00000000000000000000000000000000000000000000000000000
000005555fffffff0055000000000000000fffffff00550000000000000000000fff0ffffff00000000000000000000000000000000000000000000000000000
000005550fffffff0000000000000000000fffffff00000000000000000000000ffff0ffff033000000000000000000000000000000000000000000000000000
00000000bffffffb000000000000000000bffffffb00000000000000000000000ffffff000333300000000000000000000000000000000000000000000000000
00000003bbbbbbbb000000000000000003bbbbbbbb00000000000000000000000f5ffffff00f3330000000000000000000000000000000000000000000000000
00000003bbbbbbbbb00000000000000003bbbbbbbbb00000000000000000000005fff5fffffff330000000000000000000000000000000000000000000000000
00000003bbb3bbbbb00000000000000003bbb3bbbbb0000000ff000ff000000005ffff5fffffff30000000000000000000000000000000000000000000000000
0000000333333bbbb0000000000000000333333bbbb0000000ff000ff000000000ff5ff5ff55ff0000000000ff000ff000000000000000000000000000000000
00000000055500555000000000000000000555005550000000ff000ff0000000000fffffff055f0000000000ff000ff000000000000000000000000000000000
0000000000fff00fff000000000000000000fff00fff000000ff000ff00000000000000000000000000000000ff000ff00000000000000000000000000000000
0000000000fff00fff000000000000000000fff00fff000000ff000ff00000000000000000000000000000000ff000ff00000000000000000000000000000000
000000000fff00fff000000000000000000fff00fff0000000ff000ff000000000000000000000000000000000ff000ff0000000000000000000000000000000
00000000fff00fff000000000000000000fff00fff00000000ff000ff000000000000000000000000000000000ff000ff0000000000000000000000000000000
00000000111101111100000000000000001111011111000000111101111100000000000000000000000000000011110111110000000000000000000000000000
00000000111011111100000000000000001110111111000000111011111100000000000000000000000000000011101111110000000000000000000000000000
00000000111011111000000000000000001110111110000000111011111000000000000000000000000000000011101111100000000000000000000000000000
