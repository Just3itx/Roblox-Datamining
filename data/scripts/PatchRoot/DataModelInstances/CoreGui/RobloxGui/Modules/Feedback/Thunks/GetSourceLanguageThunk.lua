-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local PerformFetch = require(CorePackages.Workspace.Packages.Http).PerformFetch

local scriptParentParent = script.Parent.Parent

local GetExperienceSourceLanguage = require(scriptParentParent.Network.GetExperienceSourceLanguage)

local SetSourceLanguageName = require(scriptParentParent.Actions.SetSourceLanguageName)

return function()
    return PerformFetch.Single("GetExperienceSourceLanguage", function(arg1)
        return GetExperienceSourceLanguage():andThen(function(arg2)
            arg1:dispatch(SetSourceLanguageName(arg2))
        end)
    end)
end
