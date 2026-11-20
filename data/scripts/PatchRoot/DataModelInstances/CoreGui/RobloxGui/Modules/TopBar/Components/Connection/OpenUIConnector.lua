-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)

local scriptParentParentParent = script.Parent.Parent.Parent

if require(scriptParentParentParent.Flags.FFlagTopBarDeprecateMoreMenuRodux) then
    return nil
end

local SetBackpackOpen = require(scriptParentParentParent.Actions.SetBackpackOpen)
local SetEmotesOpen = require(scriptParentParentParent.Actions.SetEmotesOpen)
local SetLeaderboardOpen = require(scriptParentParentParent.Actions.SetLeaderboardOpen)
local SetEmotesEnabled = require(scriptParentParentParent.Actions.SetEmotesEnabled)

local EventConnection = require(scriptParentParentParent.Parent.Common.EventConnection)

local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local FFlagEnableNewBackpack = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableNewBackpack
local BackpackScript = if FFlagEnableNewBackpack then nil else require(RobloxGui.Modules.BackpackScript)
local Features = if FFlagEnableNewBackpack then require(CorePackages.Workspace.Packages.System).Features else nil
local EmotesMenuMaster = require(RobloxGui.Modules.EmotesMenu.EmotesMenuMaster)
local PlayerListManager = require(RobloxGui.Modules.PlayerList.PlayerListManager)

local var1 = Roact.PureComponent:extend("OpenUIConnector")

var1.validateProps = t.strictInterface({
    setBackpackOpen = t.callback,
    setEmotesOpen = t.callback,
    setLeaderboardOpen = t.callback,
    setEmotesEnabled = t.callback
})

function var1.didMount(arg1)
    arg1.props.setLeaderboardOpen(PlayerListManager:GetSetVisible())

    if FFlagEnableNewBackpack then
        arg1.props.setBackpackOpen(Features.getVisibility(Features.FeatureName.Backpack))
        arg1.disposeBackpackListener = Features.onVisibilityChanged(Features.FeatureName.Backpack, function(arg2)
            arg1.props.setBackpackOpen(arg2)
        end)
    else
        arg1.props.setBackpackOpen(BackpackScript.IsOpen)
    end
    arg1.props.setEmotesOpen(EmotesMenuMaster:isOpen())
    arg1.props.setEmotesEnabled(EmotesMenuMaster.MenuIsVisible)
end

function var1.willUnmount(arg1)
    if arg1.disposeBackpackListener then
        arg1.disposeBackpackListener()
        arg1.disposeBackpackListener = nil
    end
end

function var1.render(arg1)
    local setVisibleChangedEvent = PlayerListManager:GetSetVisibleChangedEvent()

    return Roact.createFragment({
        LeaderboardOpenChangedConnection = Roact.createElement(EventConnection, {
            event = setVisibleChangedEvent.Event,
            callback = function(arg2)
                arg1.props.setLeaderboardOpen(arg2)
            end
        }),
        BackpackOpenChangedConnection = if FFlagEnableNewBackpack then nil else Roact.createElement(EventConnection, {
            event = BackpackScript.StateChanged.Event,
            callback = function(arg2)
                arg1.props.setBackpackOpen(arg2)
            end
        }),
        EmotesOpenChangedConnection = Roact.createElement(EventConnection, {
            event = EmotesMenuMaster.EmotesMenuToggled.Event,
            callback = function(arg2)
                arg1.props.setEmotesOpen(arg2)
            end
        }),
        EmotesEnabledChangedConnection = Roact.createElement(EventConnection, {
            event = EmotesMenuMaster.MenuVisibilityChanged.Event,
            callback = function(arg2)
                arg1.props.setEmotesEnabled(arg2)
            end
        })
    })
end

return RoactRodux.UNSTABLE_connect2(nil, function(arg1) -- name: mapDispatchToProps
    return {
        setBackpackOpen = function(arg2)
            return arg1(SetBackpackOpen(arg2))
        end,
        setEmotesOpen = function(arg2)
            return arg1(SetEmotesOpen(arg2))
        end,
        setLeaderboardOpen = function(arg2)
            return arg1(SetLeaderboardOpen(arg2))
        end,
        setEmotesEnabled = function(arg2)
            return arg1(SetEmotesEnabled(arg2))
        end
    }
end)(var1)
