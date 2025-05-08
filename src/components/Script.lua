function newScript(updateScript)

    local script = {}
    script.name = "component:script"

    script.updateScript = updateScript or nil

    script.update = function(self, deltaTime)
        updateScript()
    end

    return script
end