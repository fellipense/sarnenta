function newTransform(x, y, z, r, size)

    local transform = newComponent("transform")
    
    transform.x = x or 0;
    transform.y = y or 0;
    transform.z = z or 1;
    transform.r = r or 0;
    transform.size = size or 1;
    
    return transform
end
