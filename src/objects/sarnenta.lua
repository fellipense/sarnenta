require("components/GameObject")
require("components/Sprite")
require("input")
require("physics")

playerScreenPadding = 20
sprite = "sprites/sarnenta/idle/sprite-1.png"

sarnenta = newGameObject(
    "sarnenta", -- NAME
    0, -- X 
    love.graphics.getHeight(), --Y 
    1, 0, 1 -- Z R SIZE
)

sarnenta.sprite = newSprite(sarnenta, sprite, 1, 0, 0, 0, 0)
sarnenta.speed = 400
sarnenta.xPivot = sarnenta.sprite.image:getWidth()/2
sarnenta.yPivot = sarnenta.sprite.image:getHeight()/2
sarnenta.sprite.offsetX = sarnenta.xPivot *-1
sarnenta.sprite.offsetY = sarnenta.yPivot *-1
sarnenta.rectangleCollider = newRectangleCollider(sarnenta, 30, 20, -15, -10)
sarnenta.destroyIt = false
sarnenta.animator = newAnimator(sarnenta, "idle")
sarnenta.animator:addAnimation("idle", "sprites/sarnenta/idle/", 11, 10)
sarnenta.animator:addAnimation("walking", "sprites/sarnenta/walking/", 4, 10)

sarnenta.transform.y = sarnenta.transform.y - sarnenta.sprite.image:getHeight()

sarnenta.update = function(self, deltaTime)

    --INPUT SYSTEM
	if input.left or input.right then
		if sarnenta.animator.currentAnimation ~= "walking" then
			sarnenta.animator:playAnimation("walking")
		end
	else
		sarnenta.animator:playAnimation("idle")
	end
	if input.left then
		sarnenta.sprite.flipX = true
	end
	if input.right then
		sarnenta.sprite.flipX = false
	end


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

    sarnenta.sprite:draw()

    if drawColliders then
        sarnenta.rectangleCollider:draw()
    end
end