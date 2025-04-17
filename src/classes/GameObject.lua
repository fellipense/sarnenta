require("classes/Transform")
function newGameObject(name, x, y, z, r, size)
    
    local gameObject = {}

    gameObject.name = (name or "unknown") .. "-" .. #gameObjects
    gameObject.type = "default"
    gameObject.display = true
    gameObject.destroyIt = false
    gameObject.transform = newTransform(x, y, z, r, size)
    gameObject.update = function(deltaTime) 
        return true
    end

    return gameObject
end

