require("../functions")

function newSprite(parent, imagePath, s, x, y, r)

    sprite = {}

    sprite.parent = parent
    sprite.image = love.graphics.newImage(imagePath);

    sprite.offsetX = x or 0
    sprite.offsetY = y or 0
    sprite.offsetR = r or 0

    sprite.flipX = false
    sprite.flipY = false

    sprite.draw = function(self)
        love.graphics.draw(
            self.image,
            self.parent.transform.x + ternary(self.flipX, self.offsetX *-1, self.offsetX), 
            self.parent.transform.y + ternary(self.flipY, self.offsetY *-1, self.offsetY), 
            self.parent.transform.r + self.offsetR,
            ternary(self.flipX, -1, 1),
            ternary(self.flipY, -1, 1)       
        )
    end

    return sprite
end