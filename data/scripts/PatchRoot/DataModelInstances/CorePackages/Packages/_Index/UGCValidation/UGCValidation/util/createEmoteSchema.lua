-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    "ThumbnailCharacterRotation",
    "ThumbnailHorizontalOffset",
    "ThumbnailKeyframe",
    "ThumbnailVerticalOffset",
    "ThumbnailZoom",
    "ThumbnailTime",
    "ThumbnailFieldOfView"
}

local function createEmoteSchema()
    local tbl2 = {
        ClassName = "Animation",
        _children = {}
    }

    for _, value in tbl1 do
        table.insert(tbl2._children, { Name = value, ClassName = "NumberValue", _optional = true })
    end

    return tbl2
end

return createEmoteSchema
