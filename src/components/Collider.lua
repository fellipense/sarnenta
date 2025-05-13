require("components/Component")
require("functions")
require("physics")

function newCollider(parent, type, width, height, xOffset, yOffset, z)

    local collider = newComponent("collider")

    collider.parent = parent
    collider.xOffset = xOffset or 0
    collider.yOffset = yOffset or 0
    collider.z = z or parent.transform.z

    collider.collisions = {}

    collider.onColEnter = function(self, target) return end
    collider.onColStay = function(self, target) return end
    collider.onColOut = function(self, target) return end

    if type == "rectangle" then
        collider.width = width or parent.width or 10
        collider.height = height or parent.height or 10
    end

    if type == "circle" then
        collider.radius = width*2 or parent.radius or 10
    end

    collider.globalX = parent.transform.x + collider.xOffset
    collider.globalY = parent.transform.y + collider.yOffset

    collider.selfDraw = function(self, mode)

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
                for j,c in ipairs(o.components) do
                    if c.name == "component:collider" and c.type == "rectangle" then
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

        -- EACH COLLISIONS
        for i,c in ipairs(self.collisions) do
        
        end

        -- EACH GAMEOBJECTS
        for i,o in ipairs(gameObjects) do

            -- EACH COMPONENTS
            for j,c in ipairs(o.components) do

                -- THAT ARE COLLIDERS
                if c.name == "component:collider" then

                    -- RECTANGLE TO RECTANGLE
                    if self.type == "rectangle" 
                    and c.type == "rectangle" 
                    and checkRecToRecCol(self, c) then

                        -- EACH COLLISIONS
                        for k,l in ipairs(self.collisions) do
                            if l.target == c then
                                if l.state == 0 then l.state = 1 end
                                if l.state == 3 then table.remove(self.collisions, k) end
                                goto COLLIDED
                            end
                        end
                        table.insert(newCollision(c, 0))
                        ::COLLIDED::
                    end

                    -- CIRCLE TO RECTANGLE
                    if self.type == "circle" 
                    and c.type == "rectangle" 
                    and checkCircToRecCol(self, c) then

                        -- EACH COLLISIONS
                        for k,l in ipairs(self.collisions) do
                            if l.target == c then
                                if l.state == 0 then l.state = 1 end
                                if l.state == 3 then table.remove(self.collisions, k) end
                                goto COLLIDED
                            end
                        end
                        table.insert(newCollision(c, 0))
                        ::COLLIDED::
                    end

                    -- CIRCLE TO CIRCLE
                    if self.type == "circle" 
                    and c.type == "cirlce" 
                    and checkCircToCircCol(self, c) then

                        -- EACH COLLISIONS
                        for k,l in ipairs(self.collisions) do
                            if l.target == c then
                                if l.state == 0 then l.state = 1 end
                                if l.state == 3 then table.remove(self.collisions, k) end
                                goto COLLIDED
                            end
                        end
                        table.insert(newCollision(c, 0))
                        ::COLLIDED::
                    end
                end
            end
        end

        -- DEFINING IT'S POSITION
        self.globalX = parent.transform.x + collider.xOffset
        self.globalY = parent.transform.y + collider.yOffset
    end
    return collider
end