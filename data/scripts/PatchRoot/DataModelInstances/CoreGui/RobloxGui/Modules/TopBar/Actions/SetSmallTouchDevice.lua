-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:51:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local scriptParentParent = script.Parent.Parent
local FFlagTopBarDeprecateDisplayOptionsRodux = require(scriptParentParent.Flags.FFlagTopBarDeprecateDisplayOptionsRodux)

local makeActionCreator = require(CorePackages.Packages.Rodux).makeActionCreator

if FFlagTopBarDeprecateDisplayOptionsRodux then
    return nil
end

return (makeActionCreator(script.Name, function(isSmallTouchDevice)
    return { isSmallTouchDevice = isSmallTouchDevice }
end))
