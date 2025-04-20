function newAnimator(parent, default)
    local animator = {}

    animator.parent = parent
    animator.animations = {}
    animator.currentAnimation = default
    
    -- INITIALIZING COUNTERS
    animator.timer = 0
    animator.step = 1

    animator.addAnimation = function(self, name, path, frames, fps)
        self.animations[name] = {}
        self.animations[name].frames = {}
        self.animations[name].fps = fps

        -- INSERT FRAMES IN THE ANIMATION
        for i=1,frames do
            table.insert(
                self.animations[name].frames,
                love.graphics.newImage(path .. "sprite-" .. i .. ".png")
            )
        end
    end

    animator.playAnimation = function(self, name)
        self.currentAnimation = name
        self.timer = 0
        self.step = 1
    end
    
    animator.update = function(self, deltaTime)

        -- INCREMENTS ANIMATION TIME
        self.timer = self.timer + deltaTime

        -- GETS THE CURRENT ANIMATION
        local currentAnimation = self.animations[self.currentAnimation]
        local frames = #currentAnimation.frames
        local fps = currentAnimation.fps

        -- TRIGGER THE "START" EVENT WHEN THE ANIMATION STARTS
        if self.step == 1 then
            self.event = self.currentAnimation.."-start"
        end

        -- TRIGGER THE "END" EVENT WHEN THE ANIMATION ENDS
        if self.timer >= 1/fps then
            self.step = self.step + 1
            if self.step > frames then
                self.step = 1
                self.event = self.currentAnimation.."-end"
            end
            self.timer = 0
        end

        -- SET THE ANIMATION FRAME TO THE OBJECTS'S SPRITE
        self.parent.sprite = currentAnimation.frames[self.step]
    end

    return animator
end