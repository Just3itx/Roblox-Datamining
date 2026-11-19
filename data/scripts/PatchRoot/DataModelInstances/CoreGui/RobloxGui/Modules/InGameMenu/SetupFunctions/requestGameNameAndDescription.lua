-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local CorePackages = game:GetService("CorePackages")

local scriptParentParent = script.Parent.Parent

local SetGameNameAndDescription = require(scriptParentParent.Actions.SetGameNameAndDescription)

local var1 = require(scriptParentParent.Network.httpRequest)(HttpRbxApiService)

local GetGameNameAndDescription = require(CorePackages.Workspace.Packages.GameDetailRodux).GetGameNameAndDescription

local function requestGameNameAndDescription(arg1)
    if game.GameId == 0 then
        return
    end

    GetGameNameAndDescription(var1, game.GameId):andThen(function(arg2)
        arg1:dispatch(SetGameNameAndDescription(arg2.Name, arg2.Description))
    end):catch(function()
        warn("Unable to retrieve game name for in game menu")
    end)
end

return requestGameNameAndDescription
