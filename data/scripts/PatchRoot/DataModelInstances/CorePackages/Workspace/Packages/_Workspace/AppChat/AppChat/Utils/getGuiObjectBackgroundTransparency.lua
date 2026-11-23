-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getGuiObjectBackgroundTransparency(arg1)
    local success, result = pcall(function()
        return arg1:GetStyled("BackgroundTransparency")
    end)
    return if success and type(result) == "number" then result else arg1.BackgroundTransparency
end

return getGuiObjectBackgroundTransparency
