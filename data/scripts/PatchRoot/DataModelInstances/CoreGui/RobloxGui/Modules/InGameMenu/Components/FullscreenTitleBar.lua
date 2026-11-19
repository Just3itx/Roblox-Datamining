-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local GuiService = game:GetService("GuiService")
local AppStorageService = game:GetService("AppStorageService")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux
local t = InGameMenuDependencies.t
local UIBlox = InGameMenuDependencies.UIBlox
local Promise = InGameMenuDependencies.Promise
local FullscreenTitleBar = UIBlox.App.Bar.FullscreenTitleBar

local scriptParentParent = script.Parent.Parent
local InGameMenuPolicy = require(scriptParentParent.InGameMenuPolicy)

local OpenEducationalPopup = require(scriptParentParent.Thunks.OpenEducationalPopup)
local StartLeavingGame = require(scriptParentParent.Actions.StartLeavingGame)

local ExternalEventConnection = require(scriptParentParent.Utility.ExternalEventConnection)
local UserLocalStore = require(scriptParentParent.Utility.UserLocalStore)

local GetFIntFullscreenTitleBarTriggerDelayMillis = require(scriptParentParent.Flags.GetFIntFullscreenTitleBarTriggerDelayMillis)

local GetFFlagFullscreenTitleBarInjectGameServices = require(scriptParentParent.Flags.GetFFlagFullscreenTitleBarInjectGameServices)
local GetFFlagFixFullscreenTitleBarPromiseCancel = require(scriptParentParent.Flags.GetFFlagFixFullscreenTitleBarPromiseCancel)

local var1 = Roact.PureComponent:extend("FullscreenTitleBar")

var1.validateProps = t.strictInterface({
    titleText = t.optional(t.string),
    displayOrder = t.integer,
    isMenuOpen = t.boolean,
    isEducationalPopupEnabled = t.boolean,
    maxDisplayCount = t.integer,
    openEducationalPopup = t.callback,
    startLeavingGame = t.callback,
    userGameSettings = t.optional(t.union(t.Instance, t.table)),
    guiService = t.optional(t.union(t.Instance, t.table)),
    appStorageService = t.optional(t.union(t.Instance, t.table))
})

var1.defaultProps = {
    titleText = "Roblox",
    userGameSettings = UserGameSettings,
    guiService = GuiService,
    appStorageService = AppStorageService
}

function var1.init(arg1)
    arg1.userGameSettings = GetFFlagFullscreenTitleBarInjectGameServices() and arg1.props.userGameSettings or UserGameSettings
    arg1.guiService = GetFFlagFullscreenTitleBarInjectGameServices() and arg1.props.guiService or GuiService
    arg1.appStorageService = GetFFlagFullscreenTitleBarInjectGameServices() and arg1.props.appStorageService or AppStorageService

    arg1:setState({ isTriggered = false, fullscreenEnabled = arg1.userGameSettings:InFullScreen() })

    function arg1.onFullscreenChanged(fullscreenEnabled)
        arg1:setState({ fullscreenEnabled = fullscreenEnabled, isTriggered = false })
    end

    function arg1.triggerTitleBar()
        local var2 = GetFIntFullscreenTitleBarTriggerDelayMillis() / 1000
        if not (var2 > 0) then
            if not arg1.state.isTriggered then
                arg1:setState({ isTriggered = true })
            end

            return
        end

        arg1.triggerTitleBarPromise = Promise.delay(var2):andThenCall(function()
            arg1.triggerTitleBarPromise = nil
            if not arg1.state.isTriggered then
                arg1:setState({ isTriggered = true })
            end
        end)
    end

    function arg1.cancelTriggerTitleBar()
        if arg1.triggerTitleBarPromise then
            arg1.triggerTitleBarPromise:cancel()
            arg1.triggerTitleBarPromise = nil
        end
    end

    function arg1.hideTitleBar()
        if arg1.state.isTriggered then
            arg1:setState({ isTriggered = false })
        end
    end

    function arg1.exitFullscreen()
        arg1.hideTitleBar()
        arg1.guiService:ToggleFullscreen()
    end

    function arg1.closeRoblox()
        arg1.hideTitleBar()

        if arg1.props.isEducationalPopupEnabled then
            local userLocalStore = UserLocalStore.new()
            arg1.props.openEducationalPopup(arg1.guiService, userLocalStore, arg1.props.maxDisplayCount)
            return
        end
        arg1.props.startLeavingGame()
    end

    function arg1.onDisappear()
        if arg1.hideTitleBarPromise then
            if GetFFlagFixFullscreenTitleBarPromiseCancel() then
                arg1.hideTitleBarPromise:cancel()
            else
                arg1.hideTitleBarPromise.cancel()
            end
            arg1.hideTitleBarPromise = nil
        end

        arg1.hideTitleBarPromise = Promise.delay(0.5):andThenCall(function()
            arg1.hideTitleBarPromise = nil
            arg1.hideTitleBar()
        end)
    end

    function arg1.mouseReenter()
        if arg1.state.isTriggered and arg1.hideTitleBarPromise then
            arg1.hideTitleBarPromise:cancel()
            arg1.hideTitleBarPromise = nil
        end
    end
end

function var1.render(arg1)
    local createFragment = Roact.createFragment
    local tbl1 = {
        FullscreenChangedEvent = Roact.createElement(
            ExternalEventConnection,
            {
                event = arg1.userGameSettings.FullscreenChanged,
                callback = arg1.onFullscreenChanged
            }
        ),
        FullscreenTitleBar = 0
    }
    local createElement = Roact.createElement
    local portal = Roact.Portal
    local tbl2 = { target = CoreGui }
    local tbl3 = { InGameFullscreenTitleBarScreen = 0 }
    local createElement2 = Roact.createElement
    local tbl4 = {
        Enabled = arg1.state.fullscreenEnabled,
        IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = arg1.props.displayOrder
    }
    local tbl5 = {
        TriggerArea = Roact.createElement("Frame", {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 1),
            [Roact.Event.MouseEnter] = arg1.triggerTitleBar,
            [Roact.Event.MouseLeave] = arg1.cancelTriggerTitleBar
        }),
        Bar = Roact.createElement(FullscreenTitleBar, {
            title = arg1.props.titleText,
            isTriggered = arg1.state.isTriggered,
            onDisappear = arg1.onDisappear,
            onHover = arg1.mouseReenter,
            exitFullscreen = arg1.exitFullscreen,
            closeRoblox = arg1.closeRoblox
        })
    }
    tbl3.InGameFullscreenTitleBarScreen = createElement2("ScreenGui", tbl4, tbl5)
    tbl1.FullscreenTitleBar = createElement(portal, tbl2, tbl3)
    return createFragment(tbl1)
end

function var1.didUpdate(arg1, arg2)
    if not arg2.isMenuOpen and arg1.props.isMenuOpen then
        arg1.hideTitleBar()
    end
end

function var1.willUnmount(arg1)
    if arg1.hideTitleBarPromise then
        arg1.hideTitleBarPromise:cancel()
    end

    if arg1.triggerTitleBarPromise then
        arg1.triggerTitleBarPromise:cancel()
    end
end

local var2 = InGameMenuPolicy.connect(function(arg1, _)
    return {
        isEducationalPopupEnabled = arg1.enableEducationalPopup(),
        maxDisplayCount = arg1.educationalPopupMaxDisplayCount()
    }
end)(var1)

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    return {
        isMenuOpen = arg1.isMenuOpen
    }
end, function(arg1)
    return {
        openEducationalPopup = function(arg2, arg3, arg4)
            return arg1(OpenEducationalPopup(arg2, arg3, arg4))
        end,
        startLeavingGame = function()
            arg1(StartLeavingGame())
        end
    }
end)(var2)
