-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function GetEngineFeatureSafe(name: string)
    local success, result = pcall(function(): boolean
        return game:GetEngineFeature(name)
    end)
    return success and result
end

return GetEngineFeatureSafe
