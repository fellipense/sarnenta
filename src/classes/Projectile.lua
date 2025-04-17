require("classes/GameObject")
require("physics")

function newProjectile(author, x, y, z, radius, speed, direction)
    projectile = newGameObject(
        "bullet",
        author.transform.x, 
        author.transform.y, 
        author.transform.z -1, 
        0, 
        1
    );

    projectile.type = "bullet"
    projectile.direction = direction or "up"
    projectile.speed = speed or 1000
    projectile.destroyIt = false
    projectile.radius = radius or 5

    projectile.circleCollider = newCircleCollider(projectile);

    projectile.draw = function(self, mode)
        love.graphics.circle("fill", 
            self.transform.x, 
            self.transform.y, 
            self.transform.size * self.radius
        )

        if drawColliders then
            self.circleCollider:draw()
        end
    end
     
    projectile.update = function(self, deltaTime) 
        self.circleCollider:update(deltaTime)

        self.transform.y = self.transform.y - self.speed * deltaTime
    
        if checkCircleToBoundaryCollision(self.circleCollider, "top") then
            self.destroyIt = true
        end
    end

    return projectile
end