function newComponent(name)
    local component = {}

    component.name = "component:" .. name
    component.selfDraw = function() return end

    return component
end