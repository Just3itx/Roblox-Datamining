-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:40:52Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local module = {}

function module.new()
    return {}
end

function module.fromThumbnailData(arg1, size)
    local module2 = module.new()

    module2.universeId = tostring(arg1.targetId)
    module2.state = arg1.state
    module2.url = arg1.imageUrl
    module2.size = size

    return module2
end

function module.isCompleteThumbnailData(arg1): boolean
    return type(arg1) == "table"
        and type(arg1.targetId) == "number"
        and type(arg1.state) == "string"
        and (type(arg1.imageUrl) == "string" or arg1.imageUrl == nil)
end

function module.checkStateIsFinal(arg1): boolean
    return arg1 ~= "Pending"
end

return module
