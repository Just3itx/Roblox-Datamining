-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:50:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getCaptureContent(arg1): Content
    if typeof(arg1) == "table" and arg1.assetId ~= nil then
        return Content.fromUri(`rbxthumb://type=Asset&id={arg1.assetId}&w=420&h=420`)
    end
    return Content.fromObject(arg1)
end

return getCaptureContent
