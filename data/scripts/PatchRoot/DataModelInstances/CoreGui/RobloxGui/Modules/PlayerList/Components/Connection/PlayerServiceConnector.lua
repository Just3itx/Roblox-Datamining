-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:50:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local scriptParentParentParent = script.Parent.Parent.Parent

local AddPlayer = require(scriptParentParentParent.Actions.AddPlayer)
local RemovePlayer = require(scriptParentParentParent.Actions.RemovePlayer)

local MakePlayerInfoRequests = require(scriptParentParentParent.Thunks.MakePlayerInfoRequests)
local EventConnection = require(script.Parent.EventConnection)
local FFlagBadgeVisibilitySettingEnabled = require(CorePackages.Workspace.Packages.SharedFlags).FFlagBadgeVisibilitySettingEnabled
local FFlagReplacePlayerIconRoduxWithSignal = require(CorePackages.Workspace.Packages.SharedFlags).FFlagReplacePlayerIconRoduxWithSignal
local bool1 = game:DefineFastFlag("DeferPlayerInfoRequests", false)
local PlayerIconInfoStore = require(CorePackages.Workspace.Packages.PlayerIconInfoStore).PlayerIconInfoStore
local var1 = Roact.PureComponent:extend("PlayerServiceConnector")

function var1.didMount(arg1)
    local players = Players:GetPlayers()
    for _, player in ipairs(players) do
        arg1.props.addPlayer(player)
        arg1.props.makePlayerInfoRequests(player)
    end

    if not FFlagBadgeVisibilitySettingEnabled then
        return
    end

    spawn(function()
        local sendPlayerProfileSettings = RobloxReplicatedStorage:WaitForChild("SendPlayerProfileSettings", math.huge)
        arg1.sendPlayerProfileSettingsConnection = sendPlayerProfileSettings.OnClientEvent:Connect(function(str1: string)
            local var2 = tonumber(str1)
            local playerByUserId = Players:GetPlayerByUserId(var2)
            if not playerByUserId then
                return
            end

            if bool1 then
                task.defer(function()
                    arg1.props.makePlayerInfoRequests(playerByUserId)
                end)

                return
            end

            arg1.props.makePlayerInfoRequests(playerByUserId)
        end)
    end)
end

function var1.render(arg1)
    return Roact.createFragment({
        PlayerAddedConnection = Roact.createElement(EventConnection, {
            event = Players.PlayerAdded,
            callback = function(arg2)
                arg1.props.addPlayer(arg2)
                arg1.props.makePlayerInfoRequests(arg2)
            end
        }),
        PlayerRemovingConnection = Roact.createElement(EventConnection, {
            event = Players.PlayerRemoving,
            callback = function(arg2)
                arg1.props.removePlayer(arg2)
            end
        })
    })
end

function var1.willUnmount(arg1)
    local players = Players:GetPlayers()
    for _, player in ipairs(players) do
        arg1.props.removePlayer(player)
    end

    if FFlagBadgeVisibilitySettingEnabled and arg1.sendPlayerProfileSettingsConnection then
        arg1.sendPlayerProfileSettingsConnection:Disconnect()
    end
end

return RoactRodux.connect(nil, function(arg1) -- name: mapDispatchToProps
    return {
        addPlayer = function(arg2)
            return arg1(AddPlayer(arg2))
        end,
        makePlayerInfoRequests = function(arg2)
            return arg1(MakePlayerInfoRequests(arg2))
        end,
        removePlayer = function(arg2)
            if FFlagReplacePlayerIconRoduxWithSignal then
                PlayerIconInfoStore.removePlayer(arg2.UserId)
            end
            return arg1(RemovePlayer(arg2))
        end
    }
end)(var1)
