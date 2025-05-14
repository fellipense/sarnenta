require("components/Transform")
require("objects/game")

function newGameObject(name, x, y, z, r, size)
    
    local gameObject = {}

    gameObject.name = (name or "unknown") .. "-" .. #gameObjects
    gameObject.type = "default"
    gameObject.display = true
    gameObject.destroyIt = false
    gameObject.transform = newTransform(x, y, z, r, size)
    gameObject.components = {}
    gameObject.selfDraw = function() return end

    gameObject.addComponent = function(self, component)
        table.insert(self.components, component)
    end

    gameObject.update = function(self, deltaTime)
        for i,c in ipairs(self.components) do
            c:update(deltaTime)
        end
    end

    gameObject.draw = function(self, component)
        
        if self.display then
            self:selfDraw()
        end

        if debug then
            for i,c in ipairs(self.components) do
                c:selfDraw()
            end
        end
    end

    return gameObject
end

