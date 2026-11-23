-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local function getAndroidBackSignal(): RBXScriptSignal
    return GuiService.ShowLeaveConfirmation
end

return getAndroidBackSignal
