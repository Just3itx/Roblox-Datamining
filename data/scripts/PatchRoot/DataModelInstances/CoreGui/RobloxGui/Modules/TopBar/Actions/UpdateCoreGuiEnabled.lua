-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:51:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local scriptParentParent = script.Parent.Parent
local FFlagTopBarDeprecateCoreGuiRodux = require(scriptParentParent.Flags.FFlagTopBarDeprecateCoreGuiRodux)

local makeActionCreator = require(CorePackages.Packages.Rodux).makeActionCreator

if FFlagTopBarDeprecateCoreGuiRodux then
    return nil
end

return (makeActionCreator(script.Name, function(coreGuiType, enabled)
    return { coreGuiType = coreGuiType, enabled = enabled }
end))
