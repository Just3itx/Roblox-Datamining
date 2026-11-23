-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:04:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

local function releaseAnyFocus()
    local textBox = UserInputService:GetFocusedTextBox()
    if textBox then
        textBox:ReleaseFocus()
    end
    if GuiService.SelectedObject ~= nil then
        GuiService.SelectedObject = nil
    end
end

return releaseAnyFocus
