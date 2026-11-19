-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:51:11Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function isPluginElevated(arg1): boolean
    return (pcall(function()
        return arg1:GetPluginComponent("Panels")
    end))
end
return isPluginElevated
