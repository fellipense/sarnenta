require("components/Component")
require("functions")
require("physics")

function newCollider(parent, type, width, height, xOffset, yOffset, z)

    local collider = newComponent("collider")

    collider.parent = parent
    collider.type = type
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

        if self.type == "rectangle" then
            love.graphics.rectangle(mode or "line", 
                self.globalX,
                self.globalY, 
                self.width,
                self.height
            )
        end

        if self.type == "circle" then
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

        -- EACH GAMEOBJECTS
        for i,o in ipairs(gameObjects) do

            -- EACH COMPONENTS
            for j,c in ipairs(o.components) do

                -- THIS IS NOT A COLLIDER
                if c.name ~= "component:collider" then goto NOTCOLLISOR end

                -- EACH COLLISION
                for k,l in ipairs(self.collisions) do

                    -- Only colliders there are in some collision with me
                    if l.target ~= c then goto NOTTARGET end

                    -- They entered collision
                    if l.state == 0 then 
                        if checkCol(self, c) then l.state = 1
                        else l.state = 2 end                        

                    -- They are in the collision 
                    elseif l.state == 1 then
                        if checkCol(self, c) then l.state = 1
                        else l.state = 2 end                        

                    -- They left collision 
                    elseif l.state == 2 then
                        if checkCol(self, c) then l.state = 0
                        else table.remove(self.collisions, k) end

                    end

                    goto FOUND

                    ::NOTTARGET::
                end

                -- Never collided before? So create a new collision
                if checkCol(self, c) then
                    self:addCol(newCollision(c, 0))
                end

                ::FOUND::
                ::NOTCOLLISOR::
            end
        end

        for i,c in ipairs(self.collisions) do

            if c.state == 0 then addPhysicEvent(self.onColEnter) end
            if c.state == 1 then addPhysicEvent(self.onColStay) end
            if c.state == 2 then addPhysicEvent(self.onColOut) end
        end

        -- DEFINING IT'S POSITION
        self.globalX = parent.transform.x + collider.xOffset
        self.globalY = parent.transform.y + collider.yOffset
    end

    collider.addCol = function(self, collision) table.insert(self.collisions, collision) end

    return collider
end