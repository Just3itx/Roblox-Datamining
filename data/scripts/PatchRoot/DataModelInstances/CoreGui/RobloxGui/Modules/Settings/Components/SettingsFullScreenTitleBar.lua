-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local UIBlox = InGameMenuDependencies.UIBlox
local Promise = InGameMenuDependencies.Promise
local _Dash = require(CorePackages.Packages.Dash)
local t = InGameMenuDependencies.t

local InGameMenu = RobloxGui.Modules.InGameMenu
local Constants = require(InGameMenu.Resources.Constants)

local FullscreenTitleBar = UIBlox.App.Bar.FullscreenTitleBar
local ExternalEventConnection = require(InGameMenu.Utility.ExternalEventConnection)

local GetDefaultQualityLevel = require(CorePackages.Workspace.Packages.AppCommonLib).GetDefaultQualityLevel

local renderWithCoreScriptsStyleProvider = require(RobloxGui.Modules.Common.renderWithCoreScriptsStyleProvider)

local GetFIntFullscreenTitleBarTriggerDelayMillis = require(InGameMenu.Flags.GetFIntFullscreenTitleBarTriggerDelayMillis)

local var1 = Roact.PureComponent:extend("SettingsFullScreenTitleBar")

var1.validateProps = t.strictInterface(
    {
        titleText = t.optional(t.string),
        onClose = t.optional(t.callback),
        _mockFullScreen = t.optional(t.boolean)
    }
)
var1.defaultProps = { titleText = "Roblox" }

function var1.init(arg1)
    arg1:setState({ isTriggered = false })

    function arg1.show()
        arg1:setTriggered(true)
    end
    function arg1.hide()
        arg1:setTriggered(false)
    end
    function arg1.cancel()
        arg1:unsetTriggered()
    end
    function arg1.onFullscreenChanged()
        arg1:unsetTriggered()
        arg1:setState({ isTriggered = false })
    end
end

function var1.setTriggered(arg1, isTriggered)
    arg1:unsetTriggered()
    if not UserGameSettings:InFullScreen() and not arg1.props._mockFullScreen then
        return
    end

    arg1.triggerPromise = Promise.delay(GetFIntFullscreenTitleBarTriggerDelayMillis() / 1000):andThenCall(function()
        arg1.triggerPromise = nil
        arg1:setState({ isTriggered = isTriggered })
    end)
end

function var1.unsetTriggered(arg1)
    if arg1.triggerPromise then
        arg1.triggerPromise:cancel()
        arg1.triggerPromise = nil
    end
end

function var1.toggleFullscreen(_)
    GuiService:ToggleFullscreen()
end

function var1.leaveGame(_)
    GuiService.SelectedCoreObject = nil

    RunService.RenderStepped:Wait()
    RunService.RenderStepped:Wait()

    game:Shutdown()

    settings().Rendering.QualityLevel = GetDefaultQualityLevel()
end

function var1.render(arg1)
    local createElement = Roact.createElement
    local portal = Roact.Portal
    local tbl1 = { target = CoreGui }
    local tbl2 = { InGameFullscreenTitleBarScreen = 0 }
    local createElement2 = Roact.createElement
    local tbl3 = {
        Enabled = true,
        IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = Constants.DisplayOrder.FullscreenTitleBar
    }
    local tbl4 = {
        FullscreenChangedEvent = Roact.createElement(
            ExternalEventConnection,
            {
                event = UserGameSettings.FullscreenChanged,
                callback = arg1.onFullscreenChanged
            }
        ),
        TriggerArea = Roact.createElement("Frame", {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 1),
            [Roact.Event.MouseEnter] = arg1.show,
            [Roact.Event.MouseLeave] = arg1.cancel
        }),
        Bar = Roact.createElement(FullscreenTitleBar, {
            title = arg1.props.titleText,
            isTriggered = arg1.state.isTriggered,
            onDisappear = arg1.hide,
            onHover = arg1.cancel,
            exitFullscreen = arg1.toggleFullscreen,
            closeRoblox = arg1.props.onClose or arg1.leaveGame
        })
    }
    tbl2.InGameFullscreenTitleBarScreen = createElement2("ScreenGui", tbl3, tbl4)
    local fullscreenTitleBar = createElement(portal, tbl1, tbl2)

    return renderWithCoreScriptsStyleProvider({ FullscreenTitleBar = fullscreenTitleBar })
end

function var1.willUnmount(arg1)
    arg1:unsetTriggered()
end

return {
    mount = function(arg1, arg2, str1: string?)
        return Roact.mount(Roact.createElement(var1, arg1 or {}), arg2, str1)
    end,
    update = function(arg1, arg2)
        return Roact.update(arg1, Roact.createElement(var1, arg2))
    end,
    unmount = function(arg1)
        return Roact.unmount(arg1)
    end
}
