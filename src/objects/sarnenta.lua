require("components/GameObject")
require("components/Script")
require("components/Sprite")
require("components/Collider")
require("input")
require("physics")

sarnenta = newGameObject(
    "sarnenta",                -- NAME
    0,                         -- X 
    love.graphics.getHeight(), -- Y 
    1, 0, 1                    -- Z, R, SIZE
)

local sprite = "sprites/sarnenta/idle/sprite-1.png"

sarnenta.sprite = newSprite(sarnenta, sprite, 1, 0, 0, 0, 0)
sarnenta.sprite.offsetX = 0
sarnenta.sprite.offsetY = 0

sarnenta.transform.y = sarnenta.transform.y - sarnenta.sprite.image:getHeight()
sarnenta.destroyIt = false

-- CREATING COMPONENTS
local animator = newAnimator(sarnenta, "idle")
animator:addAnimation("idle", "sprites/sarnenta/idle/", 11, 10)
animator:addAnimation("walking", "sprites/sarnenta/walking/", 4, 10)

local fullCollider = newCollider(sarnenta, 
    "rectangle", 
    sarnenta.sprite.image:getWidth(), 
    sarnenta.sprite.image:getHeight(),   
    sarnenta.sprite.image:getWidth()/2 * -1,
    sarnenta.sprite.image:getHeight()/2 * -1    
)

-- INSERTING COMPONENTS
table.insert(sarnenta.components, animator)
table.insert(sarnenta.components, fullCollider)

-- SCRIPTS
table.insert(sarnenta.components, 
    newScript(
        function(self, deltaTime)
            if input.left or input.right then
                if animator.currentAnimation ~= "walking" then
                    animator:playAnimation("walking")
                end
            else
                if animator.currentAnimation ~= "idle" then
                    animator:playAnimation("idle")
                end
            end
            if input.left then
                sarnenta.sprite.flipX = true
            end
            if input.right then
                sarnenta.sprite.flipX = false
            end
        end
    )
)


sarnenta.draw = function(mode)
    sarnenta.sprite:draw()

    if drawColliders then
    end
end