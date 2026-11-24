-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isSelectionWithinVisible(arg1, arg2)
    if arg1 == nil or arg2 == nil then
        return false
    end
    if arg1 ~= arg2 and not arg1:IsDescendantOf(arg2) then
        return false
    end

    while arg1 ~= nil do
        if arg1:IsA("GuiObject") and not arg1.Visible then
            return false
        end
        if arg1 == arg2 then
            break
        end

        arg1 = arg1.Parent
    end
    return true
end

return isSelectionWithinVisible
