-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local UserGameSettings = UserSettings():GetService("UserGameSettings")

local event = require(CorePackages.Workspace.Packages.BlockingUtility):GetBlockedStatusChangedEvent()

local scriptParentParentParent = script.Parent.Parent.Parent

local SetPerformanceStatsVisible = require(scriptParentParentParent.Actions.SetPerformanceStatsVisible)
local SetPlayerIsBlocked = require(scriptParentParentParent.Actions.SetPlayerIsBlocked)

local EventConnection = require(script.Parent.EventConnection)

local var1 = Roact.PureComponent:extend("CoreGuiConnector")

function var1.didMount(arg1)
    arg1.props.setPerformanceStatsVisible(UserGameSettings.PerformanceStatsVisible)
end

function var1.render(arg1)
    return Roact.createFragment({
        PerformanceStatsChangedConnection = Roact.createElement(EventConnection, {
            event = UserGameSettings.PerformanceStatsVisibleChanged,
            callback = function(arg2)
                arg1.props.setPerformanceStatsVisible(arg2)
            end
        }),
        BlockedStatusChangedConnection = Roact.createElement(EventConnection, {
            event = event,
            callback = function(userId: number | User, arg2)
                local player = Players:GetPlayerByUserId(userId)
                if player then
                    arg1.props.setPlayerIsBlocked(player, arg2)
                end
            end
        })
    })
end

return RoactRodux.connect(nil, function(arg1) -- name: mapDispatchToProps
    return {
        setPerformanceStatsVisible = function(arg2)
            return arg1(SetPerformanceStatsVisible(arg2))
        end,
        setPlayerIsBlocked = function(arg2, arg3)
            return arg1(SetPlayerIsBlocked(arg2, arg3))
        end
    }
end)(var1)
