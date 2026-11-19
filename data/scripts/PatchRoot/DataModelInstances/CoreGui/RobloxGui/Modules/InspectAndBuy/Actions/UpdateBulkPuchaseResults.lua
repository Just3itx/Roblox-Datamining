-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local makeActionCreator = require(CorePackages.Packages.Rodux).makeActionCreator
local _AvatarExperienceInspectAndBuy = require(CorePackages.Workspace.Packages.AvatarExperienceInspectAndBuy)

return makeActionCreator(script.Name, function(arg1)
    return {
        result = arg1 or {}
    }
end)
