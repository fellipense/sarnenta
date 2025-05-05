require("functions")

-- Circle to circle collision
function checkCircToCircCol(a, b)

    return (a.globalX - b.globalX)^2 + 
        (a.globalY - b.globalY)^2 < 
        (a.radius + b.radius)^2
end

-- Circle to rectangle collision
function checkCircToRecCol(a, b)

    local closerPoint = {} --BETWEEN THE CIRCLE AND RECTANGLE

    closerPoint.x = clamp(
        b.globalX,
        b.globalX + b.width,
        a.globalX
    )

    closerPoint.y = clamp(
        b.globalY,
        b.globalY + b.height,
        a.globalY
    )

    return (a.globalX - closerPoint.x)^2 + 
        (a.globalY - closerPoint.y)^2 < 
        (a.radius)^2
end

-- Rectangle to rectangle collision
function checkRecToRecCol(a, b)

    return a.globalY < b.globalY + b.height
        and a.globalX + a.width > b.globalX
        and a.globalY + a.height > b.globalY
        and a.globalX < b.globalX + b.width
end

-- Circle to boundary collision
function checkCircToBoundCol(a, b)

    if b == "top" and a.globalY < a.radius then
        return true
    end

    if b == "right" and a.globalX + a.radius > love.graphics.getWidth() then
        return true
    end

    if b == "bottom" and a.globalY + a.radius > love.graphics.getHeight() then
        return true
    end

    if b == "left" and a.globalX < a.radius then
        return true
    end
end

-- Rectangle to boundary collision
function checkRecToBoundCol(a, b)

    if b == "top" and a.globalY < 0 then
        return true
    end

    if b == "right" and a.globalX + a.width > love.graphics.getWidth() then
        return true
    end

    if b == "bottom" and a.globalY + a.height > love.graphics.getHeight() then
        return true
    end

    if b == "left" and a.globalX < 0 then
        return true
    end
end

function newCollision(target, state)

    local collision = {}

    collision.target = target or nil
    collision.state = state or nil
    -- STATES:
        -- 0: Collision enter
        -- 1: Ongoing Collision
        -- 2: Collision Exit

    return collision
end