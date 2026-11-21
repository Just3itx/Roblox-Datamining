-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:50:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function parseProfileFrameAssetId(arg1)
    if typeof(arg1) ~= "table" then
        return nil
    end

    local frameAssetId = arg1.FrameAssetId
    if typeof(frameAssetId) == "number" and frameAssetId ~= 0 then
        return tostring(frameAssetId)
    end

    return nil
end

return parseProfileFrameAssetId
