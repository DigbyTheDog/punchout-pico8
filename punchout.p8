pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

crowd_goes_wild=false
audience_members={}

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
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
