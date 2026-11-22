-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function assetIdAsContent(arg1): string
    if typeof(arg1) == "string" and arg1:find("^.+://") then
        return arg1
    end

    return `rbxassetid://{arg1}`
end

return assetIdAsContent
