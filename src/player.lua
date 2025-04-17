require("classes/GameObject")
require("classes/Projectile")
require("input")
require("physics")

playerScreenPadding = 20
sprite = love.graphics.newImage("sprites/ship.png")

player = newGameObject(
    "player",
    sprite:getWidth()/2 + playerScreenPadding, 
    love.graphics.getHeight() - (sprite:getHeight()/2 + playerScreenPadding), 
    1, 0, 1
)

player.sprite = sprite
player.speed = 400
player.xPivot = player.sprite:getWidth()/2
player.yPivot = player.sprite:getHeight()/2
player.rectangleCollider = newRectangleCollider(player, 30, 20, -15, -10)
player.destroyIt = false

player.update = function(self, deltaTime)

    for i,o in ipairs(gameObjects) do
        if o.type == "enemy" and o.circleCollider ~= nil then
            if checkCircleToRectangleCollision(o.circleCollider, player.rectangleCollider) then
                gameOver = true
            end
        end
    end

    if input.up and not checkRectangleToBoundaryCollision(self.rectangleCollider, "top") then
        player.transform.y = player.transform.y - player.speed * deltaTime
    end

    if input.right and not checkRectangleToBoundaryCollision(self.rectangleCollider, "right") then
        player.transform.x = player.transform.x + player.speed * deltaTime
    end

    if input.down and not checkRectangleToBoundaryCollision(self.rectangleCollider, "bottom") then
        player.transform.y = player.transform.y + player.speed * deltaTime
    end

    if input.left and not checkRectangleToBoundaryCollision(self.rectangleCollider, "left") then
        player.transform.x = player.transform.x - player.speed * deltaTime
    end

    if input.press.action then
        input.press.action = false
        addGameObject(newProjectile(player))
    end
end

player.draw = function(mode)
    
    if not player.display then return nil end

    love.graphics.draw(
        player.sprite, 
        player.transform.x, 
        player.transform.y, 
        player.transform.r,
        player.transform.size, player.transform.size,
        player.xPivot, player.yPivot
    )

    if drawColliders then
        player.rectangleCollider:draw()
    end
end