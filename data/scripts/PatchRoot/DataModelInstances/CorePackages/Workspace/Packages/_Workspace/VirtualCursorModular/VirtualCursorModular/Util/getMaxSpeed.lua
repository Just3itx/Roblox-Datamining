-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local GuiService = game:GetService("GuiService")
local Properties = require(scriptParentParent.Properties)

local function getMaxSpeed()
    return GuiService:GetScreenResolution().Magnitude * Properties.MaxSpeedRelative
end

return getMaxSpeed
