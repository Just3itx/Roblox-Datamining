-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux

local scriptParentParentParent = script.Parent.Parent.Parent

local SetFriendStatus = require(scriptParentParentParent.Actions.SetFriendStatus)
local ExternalEventConnection = require(scriptParentParentParent.Utility.ExternalEventConnection)

local var1 = Roact.PureComponent:extend("FriendStatusConnector")

function var1.init(arg1)
    arg1.state = {
        localPlayer = Players.LocalPlayer
    }
end

function var1.render(arg1)
    local tbl1 = {
        PlayerAdded = Roact.createElement(ExternalEventConnection, {
            event = Players.PlayerAdded,
            callback = function(localPlayer)
                if localPlayer == Players.LocalPlayer then
                    arg1:setState({ localPlayer = localPlayer })
                    return
                end

                arg1.props.setFriendStatus(localPlayer.UserId, Enum.FriendStatus.Unknown)
            end
        }),
        PlayerRemoving = Roact.createElement(ExternalEventConnection, {
            event = Players.PlayerRemoving,
            callback = function(arg2)
                arg1.props.setFriendStatus(arg2.UserId, nil)
            end
        })
    }

    if arg1.state.localPlayer then
        tbl1.FriendStatusChanged = Roact.createElement(ExternalEventConnection, {
            event = Players.LocalPlayer.FriendStatusChanged,
            callback = function(arg2, arg3)
                arg1.props.setFriendStatus(arg2.UserId, arg3)
            end
        })
    end

    return Roact.createFragment(tbl1)
end

return RoactRodux.UNSTABLE_connect2(nil, function(arg1)
    return {
        setFriendStatus = function(arg2, arg3)
            return arg1(SetFriendStatus(arg2, arg3))
        end
    }
end)(var1)
