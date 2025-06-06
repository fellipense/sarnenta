require("components/GameObject")
require("components/Animator")
require("components/Script")
require("components/Sprite")
require("components/Collider")
require("input")
require("physics")

sarnenta = newGameObject(
    "sarnenta",                      -- NAME
    0,                               -- X 
    love.graphics.getHeight() - 100, -- Y 
    1, 0, 1                          -- Z, R, SIZE
)

local sprite = "sprites/sarnenta/idle/sprite-1.png"

sarnenta.sprite = newSprite(sprite, 1, 0, 0, 0, 0)
sarnenta.sprite.xPivot = sarnenta.sprite.image:getWidth()/2
sarnenta.sprite.yPivot = sarnenta.sprite.image:getHeight()/2

sarnenta.speed = 300
sarnenta.transform.y = sarnenta.transform.y - sarnenta.sprite.image:getHeight()/2
sarnenta.destroyIt = false

-- CREATING COMPONENTS
local animator = newAnimator(sarnenta, "idle")
animator:addAnimation("idle", "sprites/sarnenta/idle/", 11, 10)
animator:addAnimation("walking", "sprites/sarnenta/walking/", 4, 10)

local fullCollider = newCollider(sarnenta, 
    "rectangle", 
    sarnenta.sprite.image:getWidth(),        -- WIDTH
    sarnenta.sprite.image:getHeight(),       -- HEIGHT 
    sarnenta.sprite.image:getWidth()/2 * -1, -- X OFFSET
    sarnenta.sprite.image:getHeight()/2 * -1 -- Y OFFSET   
)

local footCollider = newCollider(sarnenta,
    "rectangle",
    sarnenta.sprite.image:getWidth() -10,       -- WIDTH
    10,                                         -- HEIGHT 
    sarnenta.sprite.image:getWidth()/2 *-1 + 5, -- X OFFSET
    sarnenta.sprite.image:getHeight()/2 - 8     -- Y OFFSET   
)


-- INSERTING COMPONENTS
sarnenta:addComponent(animator)
sarnenta:addComponent(fullCollider)
sarnenta:addComponent(footCollider)

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

table.insert(sarnenta.components,
    newScript(
        function(deltaTime)
            if input.left then
                sarnenta.transform.x = sarnenta.transform.x - sarnenta.speed * deltaTime
            end
            if input.right then
                sarnenta.transform.x = sarnenta.transform.x + sarnenta.speed * deltaTime
            end
        end
    )
)


sarnenta.selfDraw = function(self, mode)
   
    love.graphics.draw(sarnenta.sprite.image,

        sarnenta.transform.x - ternary(sarnenta.sprite.flipX,
            sarnenta.sprite.xPivot *-1,
            sarnenta.sprite.xPivot
        ), 

        sarnenta.transform.y - ternary(sarnenta.sprite.flipY,
            sarnenta.sprite.yPivot *-1,
            sarnenta.sprite.yPivot
        ),

        sarnenta.transform.r + sarnenta.sprite.rOffset,
        ternary(sarnenta.sprite.flipX, -1, 1),
        ternary(sarnenta.sprite.flipY, -1, 1)       
    )

    if drawColliders then
    end
end