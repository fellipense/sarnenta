require("components/Component")

function newScript(updateScript)

    local script = newComponent("script")

    script.updateScript = updateScript or nil

    script.update = function(self, deltaTime)
        self.updateScript(deltaTime)
    end

    return script
end