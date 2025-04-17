function newTransform(x, y, z, r, size)

    local transform = {}
    transform.x = x or 0;
    transform.y = y or 0;
    transform.z = z or 1;
    transform.r = w or 0;
    transform.size = size or 1;
    
    return transform
end
