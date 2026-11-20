-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local module = {}

function module.isEnabled(): boolean
    return GuiService.ReducedMotionEnabled
end

return module
