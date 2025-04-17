require("functions")

function newCircleCollider(parent, radius, xOffset, yOffset, z)
    local circleCollider = {}
    circleCollider.parent = parent
    circleCollider.xOffset = xOffset or 0
    circleCollider.yOffset = yOffset or 0
    circleCollider.z = z or parent.transform.z
    circleCollider.radius = radius or parent.radius or 10

    circleCollider.globalX = parent.transform.x + circleCollider.xOffset
    circleCollider.globalY = parent.transform.y + circleCollider.yOffset

    circleCollider.draw = function(self, mode)
        love.graphics.setColor(0, 1, 0)
        love.graphics.circle(mode or "line", 
            self.globalX,
            self.globalY, 
            self.radius
        )
        love.graphics.setColor(1, 1, 1)

        for i,o in ipairs(gameObjects) do

            if o.rectangleCollider ~= nil then
                local closePoint = {}
                closePoint.x = clamp(
                    o.rectangleCollider.globalX,
                    o.rectangleCollider.globalX + o.rectangleCollider.width,
                    self.globalX
                )
                closePoint.y = clamp(
                    o.rectangleCollider.globalY,
                    o.rectangleCollider.globalY + o.rectangleCollider.height,
                    self.globalY
                )
                love.graphics.line(
                    self.globalX, self.globalY, 
                    closePoint.x, closePoint.y
                )
            end
        end
    end

    circleCollider.update = function(self, deltaTime)
        self.globalX = parent.transform.x + circleCollider.xOffset
        self.globalY = parent.transform.y + circleCollider.yOffset
    end

    return circleCollider
end

function newRectangleCollider(parent, width, height, xOffset, yOffset, z)
    local rectangleCollider = {}
    rectangleCollider.parent = parent
    rectangleCollider.xOffset = xOffset or 0
    rectangleCollider.yOffset = yOffset or 0
    rectangleCollider.z = z or parent.transform.z
    rectangleCollider.width = width or parent.width or 10
    rectangleCollider.height = height or parent.height or 10

    rectangleCollider.globalX = parent.transform.x + rectangleCollider.xOffset
    rectangleCollider.globalY = parent.transform.y + rectangleCollider.yOffset

    rectangleCollider.draw = function(self, mode)
        love.graphics.setColor(0, 1, 0)
        love.graphics.rectangle(mode or "line", 
            self.globalX,
            self.globalY, 
            self.width,
            self.height
        )
        love.graphics.setColor(1, 1, 1)
    end

    rectangleCollider.update = function(self, deltaTime)
        self.globalX = parent.transform.x + rectangleCollider.xOffset
        self.globalY = parent.transform.y + rectangleCollider.yOffset
    end

    return rectangleCollider
end

function checkCircleToCircleCollision(a, b)

    return (a.globalX - b.globalX)^2 + 
        (a.globalY - b.globalY)^2 < 
        (a.radius + b.radius)^2
end

function checkCircleToRectangleCollision(a, b)
    local closerPoint = {}

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

function checkRectangleToRectangleCollision(a, b)

    return a.globalY < b.globalY + b.height
        and a.globalX + a.width > b.globalX
        and a.globalY + a.height > b.globalY
        and a.globalX < b.globalX + b.width
end

function checkCircleToBoundaryCollision(a, b)

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

function checkRectangleToBoundaryCollision(a, b)

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