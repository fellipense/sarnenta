function newAnimator(parent, default)
    local animator = {}

    animator.parent = parent
    animator.animations = {}
    animator.currentAnimation = default
    animator.timer = 0
    animator.step = 1

    animator.addAnimation = function(self, name, path, frames, fps)
        self.animations[name] = {}
        self.animations[name].frames = {}
        self.animations[name].fps = fps

        for i=1,frames do
            table.insert(
                self.animations[name].frames,
                love.graphics.newImage(path .. "Sprite-" .. i .. ".png")
            )
        end
    end

    animator.playAnimation = function(self, name)
        self.currentAnimation = name
        self.timer = 0
        self.step = 1
    end
    
    animator.update = function(self, deltaTime)
        self.timer = self.timer + deltaTime
        local currentAnimation = self.animations[self.currentAnimation]
        local frames = #currentAnimation.frames
        local fps = currentAnimation.fps

        if self.step == 1 then
            self.event = self.currentAnimation.."-start"
        end

        if self.timer >= 1/fps then
            self.step = self.step + 1
            if self.step > frames then
                self.step = 1
                self.event = self.currentAnimation.."-end"
            end
            self.timer = 0
        end

        self.parent.sprite = currentAnimation.frames[self.step]
    end

    return animator
end