-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:11:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getContentFromObject(arg1): Content
    if typeof(arg1) == "Object" then
        return Content.fromObject(arg1)
    end

    return Content.none
end

return getContentFromObject
