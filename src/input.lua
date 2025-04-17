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

    if love.keyboard.isDown("w")
    or love.keyboard.isDown("up") then 
        input.up = true
    else
        input.up = false
    end

    if love.keyboard.isDown("d")
    or love.keyboard.isDown("right") then
        input.right = true
    else
        input.right = false
    end

    if love.keyboard.isDown("s")
    or love.keyboard.isDown("down") then
        input.down = true
    else
        input.down = false
    end

    if love.keyboard.isDown("a")
    or love.keyboard.isDown("left") then
        input.left = true
    else
        input.left = false
    end
end

function love.keypressed(key)

	if key == "space" 
    or key == "z" then 
        input.press.action = true 
    end

	if key == "'" then 
        input.press.debug = true
    end
end
