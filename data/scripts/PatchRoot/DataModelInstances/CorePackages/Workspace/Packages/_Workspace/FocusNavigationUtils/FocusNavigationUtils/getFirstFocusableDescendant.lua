-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getFirstFocusableDescendant(arg1)
    for _, descendant in arg1:GetDescendants() do
        if descendant:IsA("GuiObject") and descendant.Selectable and descendant.Visible then
            return descendant
        end
    end
    return nil
end

return getFirstFocusableDescendant
