function addGameObject(obj)
    table.insert(gameObjects, obj)
    table.sort(gameObjects, compareByZ)
end

function compareByZ(a, b)
    return a.transform.z < b.transform.z
end

function clamp(min, max, value)
    if value > max 
        then return max
    elseif value < min 
        then return min
    else 
        return value 
    end
end

function log()
    for i,o in ipairs(gameObjects) do
        if o.transform == nil then goto continue end
        love.graphics.print(o.transform.z, o.transform.x, o.transform.y -20)
        love.graphics.print(o.name, o.transform.x, o.transform.y -35)

        if o.rectangleCollider ~= nil then 
            love.graphics.print(tostring(o.rectangleCollider.colliding), o.transform.x + 25, o.transform.y)
        end

        if o.life ~= nil then
            love.graphics.print(tostring(o.life), o.transform.x + 75, o.transform.y)
        end

        if o.speed ~= nil then
            love.graphics.print(tostring(o.speed), o.transform.x, o.transform.y + 80)
        end

        ::continue::
    end
 
	love.graphics.print(string.format("FPS: %d", fps), 10, 10)
	love.graphics.print(table.getn(gameObjects), love.graphics.getWidth() - 10)
end