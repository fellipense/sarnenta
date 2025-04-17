require("classes/GameObject")
require("classes/Projectile")
require("classes/Animator")
require("classes/Enemy")

require("game")
require("player")
require("functions")
require("physics")
require("input")

audio1 = love.audio.newSource("audio/C418-Aria_Math.mp3", "stream")
function love.load()
	love.audio.play(audio1)
	-- love.window.setTitle("serene")

	addGameObject(player)
end

function love.update(deltaTime)
	math.randomseed(os.time() + elapsedTime)

	if elapsedTime + deltaTime > math.ceil(elapsedTime) then 
		fps = math.floor(1 / deltaTime);
	end

	if input.press.debug then
		input.press.debug = false
		debug = not debug
	end

	elapsedTime = elapsedTime + deltaTime
	input.update(deltaTime)

	if gameOver then goto continue end

	if #gameObjects < 5 then 
		addGameObject(
			newEnemy(
				math.random(0, love.graphics.getWidth() - 100),
				20,
				nil,
				50 + elapsedTime * 0.5
			)
		)
	end

	-- UPDATE ALL OBJECTS
	for i,s in ipairs(gameObjects) do
		s:update(deltaTime)
	end	

	-- CALCULATE ALL PHYSICS
	for i,s in ipairs(gameObjects) do
		
		if s.rectangleCollider ~= nil then
			s.rectangleCollider:update(deltaTime)
		end

		if s.circleCollider ~= nil then
			s.circleCollider:update(deltaTime)
		end
	end

	-- ANIMATE ALL ANIMATORS
	for i,s in ipairs(gameObjects) do
	
		if s.animator ~= nil then
			s.animator:update(deltaTime)
		end
	end

	-- DESTROY ALL DESTROYABLES
	for i,s in ipairs(gameObjects) do
		if s.destroyIt then
			table.remove(gameObjects, i)
		end
	end

	::continue::
end

function love.draw()

	if gameOver then
		survivedTime = elapsedTime
		love.graphics.print("GAME OVER!", love.graphics:getWidth()/2 - 50, love.graphics:getHeight()/2)
		love.graphics.print("Points: " .. kills, love.graphics:getWidth()/2 - 50, love.graphics:getHeight()/2 + 10)
		goto continue
	end


	for i,s in ipairs(gameObjects) do
		s:draw(mode)
	end
	
	if debug then
		drawColliders = true
		log()
	else
		drawColliders = false
	end

	::continue::
end