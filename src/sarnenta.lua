require("classes/GameObject")
require("classes/Projectile")
require("input")
require("physics")

playerScreenPadding = 20
sprite = love.graphics.newImage("sprites/sarnenta/sprite-1.png")

sarnenta = newGameObject(
    "sarnenta", -- NAME
    sprite:getWidth()/2, -- X 
    love.graphics.getHeight() - (sprite:getHeight()/2), --Y 
    1, 0, 1 -- Z R SIZE
)

sarnenta.sprite = sprite
sarnenta.speed = 400
sarnenta.xPivot = sarnenta.sprite:getWidth()/2
sarnenta.yPivot = sarnenta.sprite:getHeight()/2
sarnenta.rectangleCollider = newRectangleCollider(sarnenta, 30, 20, -15, -10)
sarnenta.destroyIt = false
sarnenta.animator = newAnimator(sarnenta, "idle")
sarnenta.animator:addAnimation("idle", "sprites/sarnenta/", 11, 10)

sarnenta.update = function(self, deltaTime)

    --INPUT SYSTEM

    -- MOVE, BUT NOT AFTER RIGHT
    if input.left and not checkRectangleToBoundaryCollision(self.rectangleCollider, "left") then
        sarnenta.transform.x = sarnenta.transform.x - sarnenta.speed * deltaTime
    end

    -- MOVE, BUT NOT AFTER LEFT
    if input.right and not checkRectangleToBoundaryCollision(self.rectangleCollider, "right") then
        sarnenta.transform.x = sarnenta.transform.x + sarnenta.speed * deltaTime
    end

    -- ACTION
    if input.press.action then
        input.press.action = false
    end
end

sarnenta.draw = function(mode)
    
    if not sarnenta.display then return nil end

    love.graphics.draw(
        sarnenta.sprite, 
        sarnenta.transform.x, 
        sarnenta.transform.y, 
        sarnenta.transform.r,
        sarnenta.transform.size, sarnenta.transform.size,
        sarnenta.xPivot, sarnenta.yPivot
    )

    if drawColliders then
        sarnenta.rectangleCollider:draw()
    end
end