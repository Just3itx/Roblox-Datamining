-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:50:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getCaptureVideoContent(arg1)
    if typeof(arg1) == "table" and arg1.assetId ~= nil then
        return Content.fromUri(`rbxassetid://{arg1.assetId}`)
    end
    if typeof(arg1) ~= "table" then
        local success, result = pcall(Content.fromObject, arg1)
        if success then
            return result
        end
    end
    return nil
end

return getCaptureVideoContent
