-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:00:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local function getDeviceBottomInset(): number
    local success, result = pcall(function(): number
        local rect = GuiService:GetInsetArea(Enum.ScreenInsets.DeviceSafeInsets)
        return GuiService:GetInsetArea(Enum.ScreenInsets.None).Max.Y - rect.Max.Y
    end)
    if success and typeof(result) == "number" then
        return math.max(0, result)
    end
    local success2, _result, result2 = pcall(function(): (Vector2, Vector2)
        return GuiService:GetGuiInset()
    end)
    if not success2 or typeof(result2) ~= "Vector2" then
        return 0
    end

    return math.max(0, result2.Y)
end

return getDeviceBottomInset
