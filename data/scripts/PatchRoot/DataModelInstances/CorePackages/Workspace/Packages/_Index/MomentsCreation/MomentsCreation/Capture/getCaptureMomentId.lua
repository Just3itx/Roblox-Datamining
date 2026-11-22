-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:50:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getCaptureMomentId(arg1)
    if typeof(arg1) ~= "table" then
        return nil
    elseif arg1.assetId ~= nil then
        return `creation:{arg1.assetId}`
    elseif arg1.LocalId ~= nil then
        return `creation:{arg1.LocalId}`
    end
    return nil
end

return getCaptureMomentId
