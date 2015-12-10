io.stdout:setvbuf('no')

local _MapSol = {}

local TILE_WIDTH_HALF = 32
local TILE_HEIGHT_HALF = 16

local camera = {}
camera.x = (love.graphics.getWidth() / 2) - TILE_WIDTH_HALF
camera.y = 0

local _ImgTiles = {}
_ImgTiles["1"] = love.graphics.newImage("img/tile_grass.png")
_ImgTiles["2"] = love.graphics.newImage("img/tile_rock.png")

function playSound(sd)
  love.audio.newSource("snd/"..sd..".wav", "static"):play()
end

-- Thanks to
-- http://stackoverflow.com/questions/5249629/modifying-a-character-in-a-string-in-lua
function replace_char(str, pos, r)
    return str:sub(1, pos-1) .. r .. str:sub(pos+1)
end

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
	x1 = x1 - w1/2
	y1 = y1 - h1/2
	x2 = x2 - w2/2
	y2 = y2 - h2/2
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function Reset(  )
	_MapSol[1]  = "1111111111"
	_MapSol[2]  = "1111111111"
	_MapSol[3]  = "1111111111"
	_MapSol[4]  = "1111111111"
	_MapSol[5]  = "2111111111"
	_MapSol[6]  = "2111111111"
	_MapSol[7]  = "2111111111"
	_MapSol[8]  = "2111111111"
	_MapSol[9]  = "2111111111"
	_MapSol[10] = "2222222221"
end

function love.load()
	print("load...")
	math.randomseed( os.time() )

	love.window.setTitle( "ISOMETRIQUE TEST" )
	love.window.setMode(800, 600, {fullscreen=false, vsync=true, minwidth=800, minheight=600})
	Reset()
end

function love.update(dt)
end

function love.draw()
--  love.graphics.draw(_ImgTiles["1"],0,0)

	local ligne,colonne,char
	for ligne=1,10 do
		for colonne=1,10 do
			char = string.sub(_MapSol[ligne],colonne,colonne)
			if _ImgTiles[char] ~= nil then
        local x = (colonne - ligne) * TILE_WIDTH_HALF;
        local y = (colonne + ligne) * TILE_HEIGHT_HALF;
        love.graphics.draw(_ImgTiles[char], x + camera.x, y + camera.y)
			end
		end
	end

end

function love.keypressed(key)
	print("Key pressed", key)
 	if key == "escape" then
		love.event.quit()
		return
	end
end
