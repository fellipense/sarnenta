require("functions")

function checkCol(a, b)
    --print(a.type .. " VS " .. b.type)

    -- Circle to circle collision
    if a.type == "circle" and b.type == "circle" then

        return (a.globalX - b.globalX)^2 + 
            (a.globalY - b.globalY)^2 < 
            (a.radius + b.radius)^2
    end

    -- Circle to rectangle collision
    if a.type == "circle" and b.type == "rectangle" then

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

    -- Rectangle to circle collision
    if a.type == "rectangle" and b.type == "circle" then

        local closerPoint = {} --BETWEEN THE CIRCLE AND RECTANGLE

        closerPoint.x = clamp(
            a.globalX,
            a.globalX + a.width,
            b.globalX
        )

        closerPoint.y = clamp(
            a.globalY,
            a.globalY + a.height,
            b.globalY
        )

        return (b.globalX - closerPoint.x)^2 + 
            (b.globalY - closerPoint.y)^2 < 
            (b.radius)^2
    end


    -- Rectangle to rectangle collision
    if b.type == "rectangle" and a.type == "rectangle" then

        return b.globalY < a.globalY + a.height
            and b.globalX + b.width > a.globalX
            and b.globalY + b.height > a.globalY
            and b.globalX < a.globalX + a.width
    end
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