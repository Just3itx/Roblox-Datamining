-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:50:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local scriptParentParentParent = script.Parent.Parent.Parent

local SetPlayerFriendStatus = require(scriptParentParentParent.Actions.SetPlayerFriendStatus)

local EventConnection = require(script.Parent.EventConnection)

local var1 = Roact.PureComponent:extend("SocialConnector")

function var1.didMount(arg1)
    arg1.mounted = true
end

function var1.render(arg1)
    return Roact.createFragment({
        FriendStatusChangedConnection = Roact.createElement(EventConnection, {
            event = Players.LocalPlayer.FriendStatusChanged,
            callback = function(arg2, arg3)
                arg1.props.setPlayerFriendStatus(arg2, arg3)
            end
        })
    })
end

function var1.willUnmount(arg1)
    arg1.mounted = false
end

return RoactRodux.connect(nil, function(arg1) -- name: mapDispatchToProps
    return {
        setPlayerFriendStatus = function(arg2, arg3)
            return arg1(SetPlayerFriendStatus(arg2, arg3))
        end
    }
end)(var1)
