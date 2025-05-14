require("functions")
require("components/Component")

function newSprite(imagePath, s, x, y, r)

    sprite = newComponent("sprite")
    
    sprite.image = love.graphics.newImage(imagePath);

    sprite.xPivot = 0
    sprite.yPivot = 0

    sprite.xOffset = x or 0
    sprite.yOffset = y or 0
    sprite.rOffset = r or 0

    sprite.flipX = false
    sprite.flipY = false
    
    return sprite
end