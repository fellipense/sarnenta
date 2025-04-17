function newEnemy(x, y, z, speed, life)
    local dummy = newGameObject("enemy", x or 100, y or 100, nil, nil, nil)
    dummy.type = "enemy"
    dummy.width = 100
    dummy.height = 100
    dummy.transform.z = z or 0
    dummy.destroyIt = false
    dummy.die = false
    dummy.speed = speed or 50
    dummy.life = life or 3
    dummy.timer = 0
    dummy.sprite = love.graphics.newImage("sprites/vilao/idle/Sprite-1.png")
    dummy.circleCollider = newCircleCollider(
        dummy, 
        dummy.sprite:getWidth()/2, 
        dummy.sprite:getWidth()/2, 
        dummy.sprite:getHeight()/2
    )
    dummy.animator = newAnimator(dummy, "idle")
    dummy.animator:addAnimation("idle", "sprites/vilao/idle/", 2, 3)
    dummy.animator:addAnimation("die", "sprites/vilao/Transform/", 5, 5)

    dummy.draw = function(self)
        love.graphics.draw(self.sprite, self.transform.x, self.transform.y)

        if drawColliders then
            if self.circleCollider ~= nil then
                self.circleCollider:draw()
            end
        end
    end

    dummy.update = function(self, deltaTime)

        if not self.die then
            self.transform.y = self.transform.y + self.speed * deltaTime
        end

        if self.circleCollider ~= nil then

            if checkCircleToBoundaryCollision(self.circleCollider, "bottom") then
                gameOver = true
            end

            for i,o in ipairs(gameObjects) do
                if o.type == "bullet" then
                    if checkCircleToCircleCollision(self.circleCollider, o.circleCollider) then
                        self.life = self.life -1
                        o.destroyIt = true
                    end
                end
            end
        end

        if self.life <= 0 then
            self.die = true
        end

        if self.die then

            self.circleCollider = nil
            if self.animator.currentAnimation ~= "die" then 
                self.animator:playAnimation("die")
            end

            if self.animator.event == "die-end" then
                self.destroyIt = true
                kills = kills + 1
            end
        end
    end

    return dummy
end