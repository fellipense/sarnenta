require("functions")

function newCollider(parent, type, width, height, xOffset, yOffset, z)

    local collider = {}
    collider.name = "component:collider"
    collider.parent = parent
    collider.xOffset = xOffset or 0
    collider.yOffset = yOffset or 0
    collider.z = z or parent.transform.z

    if type == "rectangle" then
        collider.width = width or parent.width or 10
        collider.height = height or parent.height or 10
    end

    if type == "circle" then
        collider.radius = width*2 or parent.radius or 10
    end

    collider.globalX = parent.transform.x + collider.xOffset
    collider.globalY = parent.transform.y + collider.yOffset

    collider.draw = function(self, mode)

        love.graphics.setColor(0, 1, 0)

        if type == "rectangle" then
            love.graphics.rectangle(mode or "line", 
                self.globalX,
                self.globalY, 
                self.width,
                self.height
            )
        end

        if type == "circle" then
            love.graphics.circle(mode or "line", 
                self.globalX,
                self.globalY, 
                self.radius
            )
            
            for i,o in ipairs(gameObjects) do
                for n,c in ipairs(o.components) do
                    if c.name == "component:collider" And c.type == "rectangle" then
                        local closePoint = {} -- BETWEEN THE CIRCLE AND THE RECTANGLE

                        closePoint.x = clamp(
                            c.globalX,
                            c.globalX + c.width,
                            self.globalX
                        )

                        closePoint.y = clamp(
                            c.globalY,
                            c.globalY + c.height,
                            self.globalY
                        )
                        
                        love.graphics.line(
                            self.globalX, self.globalY, 
                            closePoint.x, closePoint.y
                        )
                    end
                end
            end
        end

        love.graphics.setColor(1, 1, 1)
    end

    collider.update = function(self, deltaTime)

        -- DEFINING IT'S POSITION
        self.globalX = parent.transform.x + collider.xOffset
        self.globalY = parent.transform.y + collider.yOffset
    end

    return collider
end

