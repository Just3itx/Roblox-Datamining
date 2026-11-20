-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:17:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local HttpRbxApiService = game:GetService("HttpRbxApiService")

local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local Promise = require(CorePackages.Packages.Promise)

local var1 = require(RobloxGui.Modules.Common.httpRequest)(HttpRbxApiService)

local scriptParentParent = script.Parent.Parent
local SetGameName = require(scriptParentParent.Actions.SetGameName)

local GetGameNameAndDescription = require(CorePackages.Workspace.Packages.GameDetailRodux).GetGameNameAndDescription

local scriptParentParent2 = script.Parent.Parent
return if require(scriptParentParent2.Flags.FFlagTopBarDeprecateGameInfoRodux) then nil else function(arg1)
    if game.GameId == 0 then
        return Promise.resolve()
    end

    return GetGameNameAndDescription(var1, game.GameId):andThen(function(arg2)
        arg1:dispatch(SetGameName(arg2.Name))

        return arg2.Name
    end, function()
        warn("Unable to get game name for Gamepad Menu")
        return Promise.reject()
    end)
end
