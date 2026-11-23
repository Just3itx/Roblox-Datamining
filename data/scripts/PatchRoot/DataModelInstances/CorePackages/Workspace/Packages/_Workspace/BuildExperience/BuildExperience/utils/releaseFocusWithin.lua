-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:20:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local function releaseFocusWithin(arg1, tbl1): boolean
    local focusedTextBox = (tbl1 or UserInputService):GetFocusedTextBox()
    if arg1 == nil or focusedTextBox == nil or not focusedTextBox:IsDescendantOf(arg1) then
        return false
    end
    focusedTextBox:ReleaseFocus()
    return true
end

return releaseFocusWithin
