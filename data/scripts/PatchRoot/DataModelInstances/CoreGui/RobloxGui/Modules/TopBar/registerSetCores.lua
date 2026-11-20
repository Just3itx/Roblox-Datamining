-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:11:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StarterGui = game:GetService("StarterGui")

local CorePackages = game:GetService("CorePackages")
local FFlagTopBarSignalizeSetCores = require(CorePackages.Workspace.Packages.InExperienceTopBar).Flags.FFlagTopBarSignalizeSetCores

local scriptParent = script.Parent

local SetTopBarEnabled = require(scriptParent.Actions.SetTopBarEnabled)

return if FFlagTopBarSignalizeSetCores then nil else function(arg1) -- name: registerSetCores
    StarterGui:RegisterSetCore("TopbarEnabled", function(arg2)
        if type(arg2) == "boolean" then
            arg1:dispatch(SetTopBarEnabled(arg2))
            return
        end
        error("SetCore TopbarEnabled argument must be a boolean", 2)
    end)

    StarterGui:RegisterGetCore("TopbarEnabled", function()
        return arg1:getState().displayOptions.topbarEnabled
    end)
end
