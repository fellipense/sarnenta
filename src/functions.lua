function addGameObject(obj)
    table.insert(gameObjects, obj)
    table.sort(gameObjects, compareByZ)
end

-- ORDER ITENS BASED ON IT'S Z LAYER
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

function ternary(condition, trueValue, falseValue)
    if condition then return trueValue else return falseValue end
end

-- LOGGING (for some reasons it didn't work in an exclusive file. I will se it later)
function log()
    for i,o in ipairs(gameObjects) do

        if o.transform == nil then goto continue end

        -- OBJECT'S NAME
        love.graphics.print(o.name, o.transform.x, o.transform.y -35)

        -- OBJECT'S Z-LAYER
        love.graphics.print(o.transform.z, o.transform.x, o.transform.y -20)

        -- OBJECT'S RECTANGLE COLLIDER
        if o.rectangleCollider ~= nil then 
            love.graphics.print(tostring(o.rectangleCollider.colliding), o.transform.x + 25, o.transform.y)
        end

        -- OBJECT'S SPEED
        if o.speed ~= nil then
            love.graphics.print(tostring(o.speed), o.transform.x, o.transform.y + 80)
        end

        ::continue::
    end
 
    -- SHOW FPS
	love.graphics.print(string.format("FPS: %d", fps), 10, 10)

    -- GAME OBJECTS COUNTER
	love.graphics.print(table.getn(gameObjects), love.graphics.getWidth() - 10)
end