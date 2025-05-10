function newScript(updateScript)

    local script = {}
    script.name = "component:script"

    script.updateScript = updateScript or nil

    script.update = function(self, deltaTime)
        self.updateScript(deltaTime)
    end

    return script
end