-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isValidFocusTarget(arg1)
    if not arg1 then
        return false, "`nil` value provided to isValidFocusTarget"
    elseif not arg1:IsA("GuiBase2d") then
        return false, string.format("provided Instance is of class %s, which is not a GuiBase2d", arg1.ClassName)
    elseif not arg1:FindFirstAncestorWhichIsA("LayerCollector") then
        return false, "provided Instance is not a descendant of a LayerCollector like a ScreenGui or SurfaceGui"
    elseif not arg1:FindFirstAncestorWhichIsA("BasePlayerGui") then
        return false, "provided Instance is not a descendant of a BasePlayerGui like PlayerGui or CoreGui"
    end

    return true
end

return isValidFocusTarget
