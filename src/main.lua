require("classes/GameObject")
require("classes/Animator")

require("game")
require("sarnenta")
require("functions")
require("physics")
require("input")

audio1 = love.audio.newSource("audio/C418-Aria_Math.mp3", "stream")
background = love.graphics.newImage("sprites/background/sky1.png")

function love.load()
	love.audio.play(audio1)
	addGameObject(sarnenta)
end

function love.update(deltaTime)
	
	elapsedTime = elapsedTime + deltaTime

	-- RANDOMIZING SEED
	math.randomseed(os.time() + elapsedTime)

	-- CALCULATIONG FPS
	if elapsedTime + deltaTime > math.ceil(elapsedTime) then 
		fps = math.floor(1 / deltaTime);
	end

	-- DEBUG TOGGLER
	if input.press.debug then
		input.press.debug = false
		debug = not debug
	end

	-- TRACKING INPUTS
	input.update(deltaTime)

	-- UPDATING ALL OBJECTS
	for i,s in ipairs(gameObjects) do
		s:update(deltaTime)
	end	

	-- CALCULATING ALL PHYSICS
	for i,s in ipairs(gameObjects) do
		
		if s.rectangleCollider ~= nil then
			s.rectangleCollider:update(deltaTime)
		end

		if s.circleCollider ~= nil then
			s.circleCollider:update(deltaTime)
		end
	end

	-- ANIMATING ALL ANIMATORS
	for i,s in ipairs(gameObjects) do
	
		if s.animator ~= nil then
			s.animator:update(deltaTime)
		end
	end

	-- DESTROING ALL DESTROYABLES
	for i,s in ipairs(gameObjects) do
		if s.destroyIt then
			table.remove(gameObjects, i)
		end
	end

end

function love.draw()

	-- GETTING SCREEN DIMENSIONS
	width = love.graphics.getWidth()
	height = love.graphics.getHeight()


	-- DRAWING BACKGROUND
	love.graphics.draw(background, 0, 0, 0,
		width / background:getWidth(),
		height / background:getHeight()
	)

	-- DRAWING EVERY OBJECTS
	for i,s in ipairs(gameObjects) do
		s:draw()
	end
	
	--DEBUG MODE
	if debug then
		drawColliders = true
		log()
	else
		drawColliders = false
	end
end