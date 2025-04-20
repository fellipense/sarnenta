input = {}

input.up = false
input.right = false
input.down = false
input.left = false

input.press = {}

input.press.action = false
input.press.debug = false
input.press.restart = false

input.update = function(deltaTime)

    -- input up
    -- W, UP
    if love.keyboard.isDown("w")
    or love.keyboard.isDown("up") then 
        input.up = true
    else
        input.up = false
    end

    -- input right
    -- D, RIGHT
    if love.keyboard.isDown("d")
    or love.keyboard.isDown("right") then
        input.right = true
    else
        input.right = false
    end

    -- input down
    -- S, DOWN
    if love.keyboard.isDown("s")
    or love.keyboard.isDown("down") then
        input.down = true
    else
        input.down = false
    end

    -- input left
    -- A, LEFT
    if love.keyboard.isDown("a")
    or love.keyboard.isDown("left") then
        input.left = true
    else
        input.left = false
    end
end

function love.keypressed(key)

    -- input action
    -- SPACE, Z
	if key == "space" 
    or key == "z" then 
        input.press.action = true 
    end

    --input debug
	if key == "'" then 
        input.press.debug = true
    end
end
