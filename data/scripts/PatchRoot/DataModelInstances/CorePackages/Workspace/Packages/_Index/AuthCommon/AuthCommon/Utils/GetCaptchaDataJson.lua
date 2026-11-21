-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:50:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

return function(arg1)
    if arg1 == nil or arg1.errors == nil or not (arg1.errors[1] and arg1.errors[1].fieldData) then
        return "", ""
    end

    local fieldData = arg1.errors[1].fieldData
    local success, result = pcall(function()
        return HttpService:JSONDecode(fieldData)
    end)
    if success then
        return if result.unifiedCaptchaId then result.unifiedCaptchaId else "", if result.dxBlob then result.dxBlob else ""
    end
    return "", fieldData
end
