-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local PerfUtils = require(RobloxGui.Modules.Common.PerfUtils)

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)

local scriptParentParentParent = script.Parent.Parent.Parent

local SetMenuOpen = require(scriptParentParentParent.Actions.SetMenuOpen)
local SetRespawnBehaviour = require(scriptParentParentParent.Actions.SetRespawnBehaviour)

local EventConnection = require(scriptParentParentParent.Parent.Common.EventConnection)

local RobloxGui2 = CoreGui:WaitForChild("RobloxGui")
local isNewInGameMenuEnabled = require(RobloxGui2.Modules.isNewInGameMenuEnabled)

local GetFFlagEnableInGameMenuDurationLogger = require(RobloxGui2.Modules.Common.Flags.GetFFlagEnableInGameMenuDurationLogger)

local FFlagTopBarSignalizeMenuOpen = require(CorePackages.Workspace.Packages.CoreGuiCommon).Flags.FFlagTopBarSignalizeMenuOpen
local FFlagTopBarDeprecateRespawnRodux = require(scriptParentParentParent.Flags.FFlagTopBarDeprecateRespawnRodux)

local var1 = Roact.PureComponent:extend("MenuConnector")

var1.validateProps = t.strictInterface(
    {
        setMenuOpen = if FFlagTopBarSignalizeMenuOpen then nil else t.callback,
        setRespawnBehaviour = t.callback
    }
)
function var1.didMount(arg1)
    if isNewInGameMenuEnabled() then
        local inGameMenuInit = require(RobloxGui2.Modules.InGameMenuInit)
        if not FFlagTopBarSignalizeMenuOpen then
            arg1.props.setMenuOpen(inGameMenuInit.getOpen())
        end

        local var2, var3 = inGameMenuInit.getRespawnBehaviour()
        arg1.props.setRespawnBehaviour(var2, var3)
        return
    end
    local settingsHub = require(RobloxGui2.Modules.Settings.SettingsHub)
    if not FFlagTopBarSignalizeMenuOpen then
        arg1.props.setMenuOpen(settingsHub:GetVisibility())
    end

    local var2, var3 = settingsHub:GetRespawnBehaviour()
    arg1.props.setRespawnBehaviour(var2, var3)
end

function var1.render(arg1)
    if isNewInGameMenuEnabled() then
        local inGameMenuInit = require(RobloxGui2.Modules.InGameMenuInit)
        local openChangedEvent = inGameMenuInit.getOpenChangedEvent()

        local respawnBehaviourChangedEvent = inGameMenuInit.getRespawnBehaviourChangedEvent()

        return Roact.createFragment({
            MenuOpenChangedConnection = if FFlagTopBarSignalizeMenuOpen then nil else Roact.createElement(EventConnection, {
                event = openChangedEvent.Event,
                callback = function(arg2)
                    arg1.props.setMenuOpen(arg2)
                end
            }),
            RespawnBehaviourConnection = Roact.createElement(EventConnection, {
                event = respawnBehaviourChangedEvent.Event,
                callback = function(arg2, arg3)
                    arg1.props.setRespawnBehaviour(arg2, arg3)
                end
            })
        })
    end
    local settingsHub = require(RobloxGui2.Modules.Settings.SettingsHub)
    local settingsShowEvent = settingsHub.SettingsShowEvent

    local respawnBehaviourChangedEvent = settingsHub.RespawnBehaviourChangedEvent

    return Roact.createFragment({
        MenuOpenChangedConnection = if FFlagTopBarSignalizeMenuOpen then nil else Roact.createElement(EventConnection, {
            event = settingsShowEvent.Event,
            callback = function(arg2)
                if GetFFlagEnableInGameMenuDurationLogger() and arg2 then
                    PerfUtils.menuOpenBegin()
                end
                arg1.props.setMenuOpen(arg2)
            end
        }),
        RespawnBehaviourConnection = Roact.createElement(EventConnection, {
            event = respawnBehaviourChangedEvent.Event,
            callback = function(arg2, arg3)
                arg1.props.setRespawnBehaviour(arg2, arg3)
            end
        })
    })
end

return RoactRodux.UNSTABLE_connect2(nil, function(arg1) -- name: mapDispatchToProps
    return {
        setMenuOpen = not FFlagTopBarSignalizeMenuOpen and function(arg2)
            return arg1(SetMenuOpen(arg2))
        end or nil,
        setRespawnBehaviour = not FFlagTopBarDeprecateRespawnRodux and function(arg2, arg3)
            return arg1(SetRespawnBehaviour(arg2, arg3))
        end or nil
    }
end)(var1)
