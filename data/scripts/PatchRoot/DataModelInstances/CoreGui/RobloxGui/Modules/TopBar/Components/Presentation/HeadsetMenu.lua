-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local _CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local VRService = game:GetService("VRService")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)
local Signals = require(CorePackages.Packages.Signals)
local Display = require(CorePackages.Workspace.Packages.Display)

local scriptParentParentParent = script.Parent.Parent.Parent
local EventConnection = require(scriptParentParentParent.Parent.Common.EventConnection)

local isSubjectToDesktopPolicies = require(CorePackages.Workspace.Packages.SharedFlags).isSubjectToDesktopPolicies
local FFlagTopBarSignalizeScreenSize = require(CorePackages.Workspace.Packages.CoreGuiCommon).Flags.FFlagTopBarSignalizeScreenSize

local DisconnectedDialog = require(script.DisconnectedDialog)

local var1 = Roact.PureComponent:extend("HeadsetMenu")

local strictInterface = t.strictInterface
local tbl1 = {
    screenSize = if FFlagTopBarSignalizeScreenSize then nil else t.Vector2,
    vrService = t.optional(t.union(t.instanceOf("VRService"), t.table)),
    guiService = t.optional(t.union(t.instanceOf("GuiService"), t.table))
}
var1.validateProps = strictInterface(tbl1)

var1.defaultProps = { vrService = VRService, guiService = GuiService }

function var1.init(arg1)
    arg1.state = { vrDeviceAvailable = false, shouldShowDisconnectDialog = false }

    function arg1.restartApp()
        local notificationTypeList = arg1.props.guiService:GetNotificationTypeList()

        if isSubjectToDesktopPolicies() then
            if game:GetEngineFeature("EnableLuaControlsRestartApp") then
                arg1.props.guiService:BroadcastNotification("", notificationTypeList.RESTART_APP)
            else
                arg1.props.guiService:BroadcastNotification("", notificationTypeList.NATIVE_EXIT)
            end
        else
            RunService.Heartbeat:Wait()
            game:Shutdown()
        end

        arg1:setState({ shouldShowDisconnectDialog = false })
    end

    if not FFlagTopBarSignalizeScreenSize then
        return
    end

    local getViewportSize = Display.GetDisplayStore(false).getViewportSize

    arg1.disposeScreenSize = Signals.createEffect(function(arg2)
        arg1:setState({ screenSize = getViewportSize(arg2) })
    end)
end

function var1.render(arg1)
    local createFragment = Roact.createFragment
    local tbl2 = { HeadsetConnection = 0 }
    local createElement = Roact.createElement
    local var2 = EventConnection

    local tbl3 = {
        event = arg1.props.vrService:GetPropertyChangedSignal("VRDeviceAvailable"),
        callback = function()
            arg1:setState({ vrDeviceAvailable = arg1.props.vrService.VRDeviceAvailable })
        end
    }
    local tbl4 = {
        HeadsetDisconnectedDialog = Roact.createElement(DisconnectedDialog, {
            visible = arg1.state.shouldShowDisconnectDialog,
            screenSize = if FFlagTopBarSignalizeScreenSize then arg1.state.screenSize else arg1.props.screenSize,
            onConfirm = arg1.restartApp,
            guiService = arg1.props.guiService
        })
    }
    tbl2.HeadsetConnection = createElement(var2, tbl3, tbl4)
    return createFragment(tbl2)
end

function var1.didMount(arg1)
    arg1:setState({ vrDeviceAvailable = arg1.props.vrService.VRDeviceAvailable })
end

function var1.willUnmount(arg1)
    if FFlagTopBarSignalizeScreenSize then
        arg1.disposeScreenSize()
    end
end

function var1.didUpdate(arg1, _, arg2)
    if arg1.state.vrDeviceAvailable ~= arg2.vrDeviceAvailable and not arg1.state.vrDeviceAvailable then
        arg1:setState({ shouldShowDisconnectDialog = true })
    end
end

if not FFlagTopBarSignalizeScreenSize then
    var1 = RoactRodux.connect(function(arg1)
        return {
            screenSize = arg1.displayOptions.screenSize
        }
    end)(var1)
end

return var1
