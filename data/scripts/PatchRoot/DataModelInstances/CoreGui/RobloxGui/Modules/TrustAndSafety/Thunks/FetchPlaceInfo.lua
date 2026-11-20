-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local HttpRbxApiService = game:GetService("HttpRbxApiService")

local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local GetGameNameAndDescription = require(CorePackages.Workspace.Packages.GameDetailRodux).GetGameNameAndDescription

local var1 = require(RobloxGui.Modules.Common.httpRequest)(HttpRbxApiService)

local scriptParentParent = script.Parent.Parent
local SetPlaceInfo = require(scriptParentParent.Actions.SetPlaceInfo)

return function(arg1)
    return function(arg2)
        if arg1 == 0 then
            return
        end
        GetGameNameAndDescription(var1, arg1):andThen(function(arg3)
            arg2:dispatch(SetPlaceInfo(arg3.Name, arg3.Description))
        end):catch(function()
            warn("Unable to fetch place info for TrustAndSafety.")
        end)
    end
end
