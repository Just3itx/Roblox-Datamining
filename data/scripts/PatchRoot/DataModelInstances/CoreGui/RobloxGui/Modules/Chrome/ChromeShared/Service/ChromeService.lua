-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:31:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChromeShared = script:FindFirstAncestor("ChromeShared")

local CorePackages = game:GetService("CorePackages")
local LocalizationService = game:GetService("LocalizationService")
local UserInputService = game:GetService("UserInputService")
local GamepadService = game:GetService("GamepadService")

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)

local AppCommonLib = require(CorePackages.Workspace.Packages.AppCommonLib)
local Localization = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization

local Chrome = require(CorePackages.Workspace.Packages.Chrome)
local SideSheetPlacement = Chrome.Enums.SideSheetPlacement

local Signal = AppCommonLib.Signal
local FocusUtils = Chrome.FocusUtils
local FocusOnChromeSignal = FocusUtils.FocusOnChromeSignal
local FocusOffChromeSignal = FocusUtils.FocusOffChromeSignal
local ChromeUtils = require(ChromeShared.Service.ChromeUtils)
local LocalStore = require(ChromeShared.Service.LocalStore)
local ViewportUtil = require(ChromeShared.Service.ViewportUtil)
local WindowSizeSignal = require(ChromeShared.Service.WindowSizeSignal)
local ObservableValue = ChromeUtils.ObservableValue
local NotifySignal = ChromeUtils.NotifySignal
local AvailabilitySignal = ChromeUtils.AvailabilitySignal
local Constants = require(ChromeShared.Unibar.Constants)
local ShortcutService = require(ChromeShared.Service.ShortcutService)

local FFlagEnableConsoleExpControls = SharedFlags.FFlagEnableConsoleExpControls

local isInExperienceUIVREnabled = require(CorePackages.Workspace.Packages.SharedExperimentDefinition).isInExperienceUIVREnabled
local isPioneerLaunch = require(CorePackages.Workspace.Packages.PioneerUtils).isPioneerLaunch
local FFlagIntegrationsChromeShortcutTelemetry = require(ChromeShared.Parent.Flags.FFlagIntegrationsChromeShortcutTelemetry)
local bool1 = game:DefineFastFlag("ChromeDeprecateMRUs", false)
local isSideSheetEnabled = require(CorePackages.Workspace.Packages.InExperienceSideSheetUtils.isSideSheetEnabled)
local FFlagEnableSideSheetWidgets = SharedFlags.FFlagEnableSideSheetWidgets
local FFlagSideSheetUnifiedMenuOrder = SharedFlags.FFlagSideSheetUnifiedMenuOrder
local FFlagEnableChromeWindowsNotInMenu = require(ChromeShared.Flags).FFlagEnableChromeWindowsNotInMenu
local FFlagChromeNineDotActivityIndicator = require(ChromeShared.Flags).FFlagChromeNineDotActivityIndicator

local InExperienceSideSheet = require(CorePackages.Workspace.Packages.InExperienceSideSheet)
local toggleSideSheet = InExperienceSideSheet.toggleSideSheet
local getSideSheetVisibility = InExperienceSideSheet.getSideSheetVisibility
local registerSideSheetIntegrations = InExperienceSideSheet.registerSideSheetIntegrations

local module = ({})
module.__index = module

module.AvailabilitySignal = ChromeUtils.AvailabilitySignalState
module.IntegrationStatus = { None = 0, Icon = 1, Window = 2 }

function noop() end

local integration = {
    id = "div",
    label = "div",
    initialAvailability = module.AvailabilitySignal.Unavailable,
    availability = AvailabilitySignal.new(module.AvailabilitySignal.Unavailable),
    notification = NotifySignal.new(),
    components = {},
    hideNotificationCountWhileOpen = false,
    sideSheetPlacement = if isSideSheetEnabled then SideSheetPlacement.None else nil
}

function createUnibarLayoutInfo(vector2: Vector2, vector2_2: Vector2)
    return Rect.new(vector2, vector2 + vector2_2)
end

function module.new()
    local robloxLocaleId = LocalizationService.RobloxLocaleId
    local tbl2 = {
        _shortcutService = if FFlagEnableConsoleExpControls then ShortcutService.new() else nil,
        _layout = ChromeUtils.ObservableValue.new(createUnibarLayoutInfo(Vector2.zero, Vector2.zero)),
        _menuAbsolutePosition = Vector2.zero,
        _menuAbsoluteSizeOpen = Vector2.zero,
        _currentSubMenu = ChromeUtils.ObservableValue.new(nil),
        _selectedItem = ChromeUtils.ObservableValue.new(nil),
        _selectedItemIdx = 0,
        _integrations = {},
        _integrationsConnections = {},
        _integrationsStatus = {},
        _menuConfig = {},
        _subMenuConfig = {},
        _subMenuNotifications = {},
        _menuList = ObservableValue.new({}),
        _windowList = ObservableValue.new({}),
        _dragConnection = {},
        _windowPositions = ObservableValue.new({}),
        _totalNotifications = NotifySignal.new(true),
        _mostRecentlyUsedAndPinnedLimit = -1,
        _localization = Localization.new(robloxLocaleId),
        _localizedLabelKeys = {},
        _currentShortcutBar = ObservableValue.new(nil),
        _notificationIndicator = ObservableValue.new(nil),
        _nineDotActivityIndicatorVisible = if FFlagChromeNineDotActivityIndicator then ObservableValue.new(false) else nil,
        _nineDotActivityIndicatorKeys = FFlagChromeNineDotActivityIndicator and {} or nil,
        _orderAlignment = ObservableValue.new(Enum.HorizontalAlignment.Left),
        _onIntegrationRegistered = Signal.new(),
        _onIntegrationActivated = Signal.new(),
        _onIntegrationStatusChanged = Signal.new(),
        _onIntegrationHovered = Signal.new(),
        _triggerMenuIcon = Signal.new(),
        _triggerVRToggleButton = if isInExperienceUIVREnabled then Signal.new() else nil,
        _topBarVisibility = if isInExperienceUIVREnabled then ObservableValue.new(nil) else nil,
        _inFocusNav = ObservableValue.new(false)
    }
    local self = setmetatable(tbl2, module)

    ViewportUtil.viewport:connect(function(arg1)
        if bool1 then
            self:updateWindowSizeSignals()
            return
        end
        self:updateScreenSize(arg1.size, arg1.isMobileDevice, arg1.portraitOrientation, arg1.tinyPortrait)
    end, true)

    if FFlagEnableConsoleExpControls then
        tbl2._shortcutService.onShortcutBarChanged:connect(function(arg1)
            self._currentShortcutBar:set(arg1)
        end)
    end

    if FFlagChromeNineDotActivityIndicator then
        tbl2._currentSubMenu:connect(function()
            self:updateNineDotActivityIndicatorVisible()
        end)
    end

    FocusOnChromeSignal:connect(function(arg1)
        if arg1 and not tbl2._subMenuConfig.nine_dot[arg1] then
            self:setSelected(arg1)
        end
        self:enableFocusNav()
    end)
    FocusOffChromeSignal:connect(function()
        self:disableFocusNav()
        if FFlagEnableConsoleExpControls then
            self:setShortcutBar(nil)
        end
    end)

    return self
end

function module:storeChromeInteracted()
    if LocalStore.isEnabled() then
        LocalStore.storeForLocalPlayer("ChromeInteracted3", true)
    end
end

function module:updateScreenSize(_vector2: Vector2, bool2: boolean, bool3: boolean, bool4: boolean)
    local _mostRecentlyUsedAndPinnedLimit = if bool2 then if bool4 then Constants.MOBILE_TINY_PORTRAIT_SLOTS - Constants.CORE_SLOTS elseif bool3 then Constants.MOBILE_PORTRAIT_SLOTS - Constants.CORE_SLOTS else Constants.MOBILE_LANDSCAPE_SLOTS - Constants.CORE_SLOTS else Constants.NON_MOBILE_SLOTS - Constants.CORE_SLOTS

    if _mostRecentlyUsedAndPinnedLimit ~= self._mostRecentlyUsedAndPinnedLimit then
        self._mostRecentlyUsedAndPinnedLimit = _mostRecentlyUsedAndPinnedLimit

        self:updateMenuList()
        self:updateNotificationTotals()
    end

    self:updateWindowSizeSignals()
end

function module:updateWindowSizeSignals()
    for _, _integration in self._integrations do
        if _integration.windowSize then
            _integration.windowSize:updateConstraints()
        end
    end
end

function module:notificationIndicator()
    return self._notificationIndicator
end

function module:nineDotActivityIndicatorVisible()
    return self._nineDotActivityIndicatorVisible
end

function module:setNineDotActivityIndicatorVisible(str1: string, bool2: boolean)
    self._nineDotActivityIndicatorKeys[str1] = if bool2 then true else nil
    self:updateNineDotActivityIndicatorVisible()
end

function module:updateNineDotActivityIndicatorVisible()
    local bool2 = next(self._nineDotActivityIndicatorKeys) ~= nil

    if self._currentSubMenu:get() == "nine_dot" then
        bool2 = false
    end

    self._nineDotActivityIndicatorVisible:set(bool2)
end

function module:toggleSubMenu(arg1)
    if isSideSheetEnabled and toggleSideSheet then
        toggleSideSheet(true)
        return
    end

    if not self._subMenuConfig[arg1] then
        warn("Not a valid subMenuId:" .. arg1)
        return
    end

    if self._currentSubMenu:get() == arg1 then
        self._currentSubMenu:set(nil)
    else
        self._currentSubMenu:set(arg1)
    end
end

function module:currentSubMenu()
    return self._currentSubMenu
end

function module:inFocusNav()
    return self._inFocusNav
end

function module:enableFocusNav()
    if GamepadService.GamepadCursorEnabled then
        return
    end
    if not self._inFocusNav:get() then
        self._inFocusNav:set(true)
    end

    if FFlagEnableConsoleExpControls then
        self:setShortcutBar(Constants.UNIBAR_SHORTCUTBAR_ID)
    end
end

function module:disableFocusNav()
    if GamepadService.GamepadCursorEnabled then
        return
    end
    if self._inFocusNav:get() then
        self._inFocusNav:set(false)
        self._selectedItem:set(nil)

        self._currentSubMenu:set(nil)
    end
end

function module:toggleWindow(arg1)
    if self._integrations[arg1].components.Window then
        if not self._integrationsStatus[arg1]
            or self._integrationsStatus[arg1] == module.IntegrationStatus.None
            or self._integrationsStatus[arg1] == module.IntegrationStatus.Icon
        then
            self._integrationsStatus[arg1] = module.IntegrationStatus.Window
        else
            self._integrationsStatus[arg1] = module.IntegrationStatus.Icon
        end
        self._onIntegrationStatusChanged:fire(arg1, self._integrationsStatus[arg1])
    end

    if LocalStore.isEnabled() and self._integrations[arg1] and self._integrations[arg1].persistWindowState then
        local var1 = LocalStore.loadForLocalPlayer("ChromeWindowStatus") or {}
        var1[arg1] = self._integrationsStatus[arg1] == module.IntegrationStatus.Window
        LocalStore.storeForLocalPlayer("ChromeWindowStatus", var1)
    end

    self:updateMenuList()
end

function module:isWindowOpen(arg1)
    return self._integrations[arg1].components.Window and self._integrationsStatus[arg1] == module.IntegrationStatus.Window
end

function module:menuList()
    return self._menuList
end

function module:windowList()
    return self._windowList
end

function module:dragConnection(arg1)
    return if self._integrations[arg1] then self._dragConnection[arg1] else nil
end

function module:updateLocalization(arg1)
    local str1 = ""
    self._localizedLabelKeys[arg1.id] = {}

    self._localizedLabelKeys[arg1.id].label = arg1.label
    local label = arg1.label
    local success, result = pcall(function()
        label = self._localization:Format(label)
    end)
    if not success then
        label = arg1.label
        warn(result)
    end

    arg1.label = label

    if arg1.secondaryAction then
        self._localizedLabelKeys[arg1.id].secondaryActionLabel = arg1.secondaryAction.label
        str1 = arg1.secondaryAction.label
        local success2, result2 = pcall(function()
            str1 = self._localization:Format(str1)
        end)
        if not success2 then
            str1 = arg1.secondaryAction.label
            warn(result2)
        end
        arg1.secondaryAction.label = str1
    end

    return arg1
end

function module:register(arg1)
    if self._integrations[arg1.id] then
        warn(string.format(arg1.id .. "already registered", debug.traceback()))
        for _, value in self._integrationsConnections[arg1.id] do
            value:disconnect()
        end
    end

    self._integrationsConnections[arg1.id] = {}
    local _integrationsConnection = self._integrationsConnections[arg1.id]

    if isSideSheetEnabled and arg1.sideSheetPlacement == nil then
        local belowFold = SideSheetPlacement.BelowFold
        arg1.sideSheetPlacement = belowFold
    end

    if arg1.initialAvailability == nil then
        local unavailable = module.AvailabilitySignal.Unavailable
        arg1.initialAvailability = unavailable
    end

    if arg1.availability == nil then
        local availabilitySignal = AvailabilitySignal.new(arg1.initialAvailability or module.AvailabilitySignal.Unavailable)
        arg1.availability = availabilitySignal
    end

    if arg1.notification == nil then
        local notifySignal = NotifySignal.new()
        arg1.notification = notifySignal
    end

    if arg1.components == nil then
        arg1.components = {}
    end

    if arg1.availability then
        _integrationsConnection[#_integrationsConnection + 1] = arg1.availability:connect(function()
            self:availabilityChanged(arg1)
        end)
    end

    if arg1.notification and not arg1.notification:excludeFromTotalCounts() then
        _integrationsConnection[#_integrationsConnection + 1] = arg1.notification:connect(function()
            self:updateNotificationTotals()
        end)
    end

    if arg1.windowSize == nil and arg1.components and arg1.components.Window then
        local windowSizeSignal = WindowSizeSignal.new()
        arg1.windowSize = windowSizeSignal
    end

    if module:getWindowStatusFromStore(arg1.id) and arg1.persistWindowState or arg1.windowDefaultOpen then
        self._integrationsStatus[arg1.id] = module.IntegrationStatus.Window
        self._onIntegrationStatusChanged:fire(arg1.id, self._integrationsStatus[arg1.id])
    end

    local uDim2 = UDim2.fromOffset(Constants.MENU_ICON_SCREEN_SIDE_OFFSET, Constants.WINDOW_DEFAULT_PADDING)
    if arg1.startingWindowPosition then
        if arg1.persistWindowState then
            uDim2 = self:getWindowPositionFromStore(arg1.id) or arg1.startingWindowPosition
        else
            uDim2 = arg1.startingWindowPosition
        end
    end
    self._windowPositions[arg1.id] = uDim2

    arg1 = self:updateLocalization(arg1)

    local var1 = arg1
    self._integrations[arg1.id] = var1

    if FFlagEnableConsoleExpControls and arg1.selected then
        _integrationsConnection[#_integrationsConnection + 1] = self:selectedItem():connect(function(id)
            if var1.id ~= id then
                return
            end

            if GamepadService.GamepadCursorEnabled then
                return
            end
            arg1.selected(var1)
        end)
    end

    return var1
end

function module:createIconProps(id, num1: number?)
    local order = num1 or 0

    if not self._integrations[id] then
        return {
            id = id,
            children = {},
            order = order,
            activated = noop,
            integration = integration
        }
    end

    return {
        id = id,
        children = {},
        order = order,
        component = self._integrations[id].components.Icon,
        integration = self._integrations[id],
        isDivider = false,
        activated = function()
            self:activate(id)
        end
    }
end

function module:createWidgetProps(id, order: number?)
    local _integration = self._integrations[id]

    if not (_integration and _integration.components.Widget) then
        return nil
    end

    return {
        id = id,
        children = {},
        order = order or 0,
        component = _integration.components.Widget,
        integration = _integration,
        activated = noop
    }
end

function module:isIntegrationValid(arg1)
    local _integration = self._integrations[arg1]
    if not _integration then
        return false
    end

    local availability = _integration.availability
    return availability and availability:get() ~= module.AvailabilitySignal.Unavailable
end

function module:updateMenuList()
    local num1 = 0
    local num2 = 0

    local function iconProps(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
        num2 += 1
        return self:createIconProps(arg1, num2)
    end

    local function windowProps(id)
        num2 += 1

        if self._integrations[id] then
            return {
                id = id,
                children = {},
                order = num2,
                component = self._integrations[id].components.Window,
                activated = noop,
                integration = self._integrations[id]
            }
        end

        return {
            id = id,
            children = {},
            order = num2,
            activated = noop,
            integration = integration
        }
    end

    local function divider(_: number)
        num1 += 1
        num2 += 1
        return {
            id = "DIV" .. num1,
            order = num2,
            isDivider = true,
            children = {},
            activated = noop,
            integration = integration
        }
    end

    local function collectMenu(arg1, arg2, tbl2: {any}): number
        local num3 = 0
        for k, value in pairs(arg1) do
            if type(value) == "table" then
                if not #arg2.children then
                    table.insert(arg2.children, (divider(num1)))
                end
                if collectMenu(value, arg2, tbl2) > 0 then
                    table.insert(arg2.children, (divider(num1)))
                end
            else
                if typeof(value) ~= "string" then
                    error(`Only tables or strings should be passed into the items list, received {value} (at key {k})`)
                end

                if not isSideSheetEnabled and self._subMenuConfig[value] then
                    if self:isIntegrationValid(value) then
                        local var1 = iconProps(value)
                        num3 += 1
                        collectMenu(self._subMenuConfig[value], var1, tbl2)
                        if #var1.children > 0 then
                            table.insert(arg2.children, var1)
                        end
                    end
                elseif self:isIntegrationValid(value) then
                    if self:isWindowOpen(value) then
                        table.insert(tbl2, (windowProps(value)))

                        table.insert(arg2.children, iconProps(value))
                        num3 += 1
                    else
                        table.insert(arg2.children, iconProps(value))
                        num3 += 1
                    end
                end
            end
        end

        return num3
    end

    local tbl2 = {
        children = {}
    }
    local tbl3 = {}
    collectMenu(self._menuConfig, tbl2, tbl3)

    if #tbl2.children and tbl2.children[#tbl2.children] and tbl2.children[#tbl2.children].isDivider then
        table.remove(tbl2.children, #tbl2.children)
    end

    if FFlagEnableChromeWindowsNotInMenu then
        local tbl4 = {}
        for _, value in tbl3 do
            tbl4[value.id] = true
        end
        for k, _ in self._integrations do
            if self:isWindowOpen(k) and not tbl4[k] then
                table.insert(tbl3, (windowProps(k)))
            end
        end
    end

    self._menuList:set(tbl2.children)
    self._windowList:set(tbl3)
    self:repairSelected()
end

if isSideSheetEnabled then
    function module:updateSideSheet()
        local num1 = 0
        local aboveFoldIntegrations = {}
        local unibarIntegrations = {}
        local belowFoldIntegrations = {}
        local sessionActionIntegrations = {}
        local scrollableContentTopWidgetIntegrations = {}
        local scrollableContentBottomWidgetIntegrations = {}

        local function addIntegration(arg1)
            local _integration = self._integrations[arg1]

            if not _integration or _integration.sideSheetPlacement == SideSheetPlacement.None or not self:isIntegrationValid(arg1) then
                return
            end

            if _integration.sideSheetPlacement == SideSheetPlacement.Unibar then
                table.insert(unibarIntegrations, self:createIconProps(arg1, num1))
                return
            end
            if _integration.sideSheetPlacement == SideSheetPlacement.BelowFold
                or FFlagSideSheetUnifiedMenuOrder and _integration.sideSheetPlacement == SideSheetPlacement.AboveFold
            then
                table.insert(belowFoldIntegrations, self:createIconProps(arg1, num1))
                return
            end

            if _integration.sideSheetPlacement == SideSheetPlacement.AboveFold then
                table.insert(aboveFoldIntegrations, self:createIconProps(arg1, num1))
                return
            end

            if _integration.sideSheetPlacement == SideSheetPlacement.SessionAction then
                table.insert(sessionActionIntegrations, self:createIconProps(arg1, num1))
                return
            end

            if _integration.sideSheetPlacement == SideSheetPlacement.ScrollableContentTop then
                if FFlagEnableSideSheetWidgets or isPioneerLaunch() then
                    local var1 = self:createWidgetProps(arg1, num1)
                    if var1 then
                        table.insert(scrollableContentTopWidgetIntegrations, var1)
                    end
                end
            elseif _integration.sideSheetPlacement == SideSheetPlacement.ScrollableContentBottom
                and (FFlagEnableSideSheetWidgets or isPioneerLaunch())
            then
                local var1 = self:createWidgetProps(arg1, num1)
                if var1 then
                    table.insert(scrollableContentBottomWidgetIntegrations, var1)
                end
            end
        end

        for _, value in self._menuConfig do
            for _, value2 in value do
                num1 += 1
                addIntegration(value2)
            end
        end

        for _, value in self._subMenuConfig do
            for _, value2 in value do
                num1 += 1
                addIntegration(value2)
            end
        end

        registerSideSheetIntegrations({
            unibarIntegrations = unibarIntegrations,
            aboveFoldIntegrations = aboveFoldIntegrations,
            belowFoldIntegrations = belowFoldIntegrations,
            sessionActionIntegrations = sessionActionIntegrations,
            scrollableContentTopWidgetIntegrations = scrollableContentTopWidgetIntegrations,
            scrollableContentBottomWidgetIntegrations = scrollableContentBottomWidgetIntegrations
        })
    end
end

function module:availabilityChanged(_)
    self:updateNotificationTotals()
    self:updateMenuList()
    if isSideSheetEnabled then
        self:updateSideSheet()
    end
end

function module:subMenuNotifications(arg1)
    if not self._subMenuNotifications[arg1] then
        self._subMenuNotifications[arg1] = NotifySignal.new(true)
    end
    return self._subMenuNotifications[arg1]
end

function module:totalNotifications()
    return self._totalNotifications
end

function module:onIntegrationRegistered()
    return self._onIntegrationRegistered
end

function module:onIntegrationActivated()
    return self._onIntegrationActivated
end

function module:onIntegrationHovered()
    return self._onIntegrationHovered
end

function module:onIntegrationStatusChanged()
    return self._onIntegrationStatusChanged
end

function module:integrations()
    return self._integrations
end

function module:updateNotificationTotals()
    local num1 = 0
    for _, _integration in self._integrations do
        if _integration.availability:get() == module.AvailabilitySignal.Unavailable
            or _integration.availability:get() == module.AvailabilitySignal.Pinned
            or _integration.notification:excludeFromTotalCounts()
        then
            continue
        end
        local var1 = _integration.notification:get()
        if var1 and var1.type == "count" then
            assert(typeof(var1.value) == "number", "Expected count value to be number")
            num1 += var1.value
        end
    end

    self._totalNotifications:fireCount(num1)

    for k, _subMenuNotification in self._subMenuNotifications do
        local var1 = self:withinCurrentTopLevelMenu(k)
        local num2 = 0

        if not var1 then
            continue
        end

        for _, child in var1.children do
            if self:withinCurrentTopLevelMenu(child.id)
                or child.integration.availability:get() == module.AvailabilitySignal.Unavailable
                or child.integration.notification:excludeFromTotalCounts()
            then
                continue
            end
            local var2 = child.integration.notification:get()
            if var2 and var2.type == "count" then
                assert(typeof(var2.value) == "number", "Expected count value to be number")
                num2 += var2.value
            end
        end

        _subMenuNotification:fireCount(num2)
    end
end

function module:configureMenu(_menuConfig)
    self._menuConfig = _menuConfig
    self:updateNotificationTotals()
    self:updateMenuList()
end

function module:configureSubMenu(arg1, arg2)
    self._subMenuConfig[arg1] = arg2
    if not self._subMenuNotifications[arg1] then
        self._subMenuNotifications[arg1] = NotifySignal.new(true)
    end
    self:updateNotificationTotals()
    self:updateMenuList()
    if isSideSheetEnabled then
        self:updateSideSheet()
    end
end

if FFlagEnableConsoleExpControls then
    function module:registerShortcut(arg1)
        self._shortcutService:registerShortcut(arg1)
        local shortcut = self._shortcutService:getShortcut(arg1.id)
        if not shortcut.integration or not self._integrations[shortcut.integration] then
            return
        end

        local _integration = self._integrations[shortcut.integration]
        if _integration.availability:get() == module.AvailabilitySignal.Unavailable then
            shortcut.availability:unavailable()
        end
        _integration.availability:connect(function()
            local var1 = _integration.availability:get()
            if var1 == module.AvailabilitySignal.Unavailable then
                shortcut.availability:unavailable()
            elseif var1 == module.AvailabilitySignal.Available or var1 == module.AvailabilitySignal.Pinned then
                shortcut.availability:available()
            end
        end)
    end

    function module:activateShortcut(arg1)
        local shortcut = self._shortcutService:getShortcut(arg1)
        if not shortcut.integration then
            self._shortcutService:activateShortcut(arg1)
            return
        end

        if not shortcut.activated then
            if FFlagIntegrationsChromeShortcutTelemetry then
                self:activate(shortcut.integration, { fromShortcut = true })
                return
            end
            self:activate(shortcut.integration)
            return
        end

        if FFlagIntegrationsChromeShortcutTelemetry then
            self._shortcutService:activateShortcut(arg1)
            self._onIntegrationActivated:fire(shortcut.integration, { fromShortcut = true })
        end
    end

    function module:configureShortcutBar(arg1, arg2)
        self._shortcutService:configureShortcutBar(arg1, arg2)
    end

    function module:setShortcutBar(arg1)
        self._shortcutService:setShortcutBar(arg1)
    end

    function module:getCurrentShortcutBar()
        return self._currentShortcutBar
    end

    function module:getShortcutsFromBar(arg1)
        return self._shortcutService:getShortcutsFromBar(arg1, self._integrations)
    end

    function module:getCurrentShortcuts()
        return self:getShortcutsFromBar(self._currentShortcutBar:get())
    end

    function module:onShortcutBarChanged()
        return self._shortcutService.onShortcutBarChanged
    end

    function module:selectMenuIcon()
        self._triggerMenuIcon:fire()
    end

    function module:onTriggerMenuIcon()
        return self._triggerMenuIcon
    end

    function module:setHideShortcutBar(arg1, bool2: boolean?)
        self._shortcutService:setHideShortcutBar(arg1, bool2)
    end

    function module:getHideShortcutBar()
        return self._shortcutService:getHideShortcutBar()
    end
end

if isInExperienceUIVREnabled then
    function module:onTriggerVRToggleButton()
        return self._triggerVRToggleButton
    end

    function module:showTopBar()
        return self._topBarVisibility:get()
    end

    function module:getTopBarVisibiity()
        return self._topBarVisibility
    end

    function module:connectTopBarVisibility(_topBarVisibility)
        self._topBarVisibility = _topBarVisibility
    end
end

function module:gesture(arg1, connection, inputObject)
    if self._integrations[arg1] then
        self._dragConnection[arg1] = { connection = connection, inputObject = inputObject }
    end
end

function module:withinCurrentTopLevelMenu(id)
    for value, value2 in (self._menuList:get()) do
        if value2.id == id then
            return value2, value
        end
    end
    return nil, 0
end

function module:withinCurrentSubmenu(id)
    local var1 = self._currentSubMenu:get()
    if not var1 then
        return false
    end

    local children = nil

    for _, value in (self._menuList:get()) do
        if value.id == var1 then
            children = value.children
            break
        end
    end

    if not children then
        return false
    end

    for _, child in children do
        if child.id == id then
            return true
        end
    end

    return false
end

if isSideSheetEnabled then
    function module:withinOpenSideSheet(id)
        if not getSideSheetVisibility() then
            return false
        end

        for _, _integration in self._integrations do
            if _integration.id == id and _integration.sideSheetPlacement ~= SideSheetPlacement.None then
                return true
            end
        end

        return false
    end
end

function module:windowPosition(arg1)
    return self._windowPositions[arg1]
end

function module:updateWindowPosition(arg1, uDim2: UDim2)
    if LocalStore.isEnabled() and self._integrations[arg1] and self._integrations[arg1].persistWindowState then
        local var1 = LocalStore.loadForLocalPlayer("ChromeWindowPosition") or {}

        var1[arg1] = {
            uDim2.X.Scale,
            uDim2.X.Offset,
            uDim2.Y.Scale,
            uDim2.Y.Offset
        }
        LocalStore.storeForLocalPlayer("ChromeWindowPosition", var1)
    end

    self._windowPositions[arg1] = uDim2
end

function module.getWindowStatusFromStore(_, arg1)
    if LocalStore.isEnabled() then
        return (LocalStore.loadForLocalPlayer("ChromeWindowStatus") or {})[arg1] or false
    end

    return nil
end

function module:getWindowPositionFromStore(arg1)
    if not LocalStore.isEnabled() then
        return nil
    end

    local var1 = (LocalStore.loadForLocalPlayer("ChromeWindowPosition") or {})[arg1] or nil
    if var1 then
        return UDim2.new(var1[1], var1[2], var1[3], var1[4])
    end

    return nil
end

function module:activate(arg1, arg2)
    local var1 = nil

    if self._integrations[arg1] then
        local activated = self._integrations[arg1].activated
        if FFlagIntegrationsChromeShortcutTelemetry then
            self._onIntegrationActivated:fire(arg1, arg2)
        else
            self._onIntegrationActivated:fire(arg1)
        end

        self:storeChromeInteracted()

        if activated then
            local success, result = pcall(function()
                activated(self._integrations[arg1])
                if not FFlagEnableConsoleExpControls then
                    self:disableFocusNav()
                end
            end)
            if not success then
                warn("ChromeService: activate error thrown for " .. arg1)
                var1 = result
            end
        else
            if self._subMenuConfig[arg1] then
                self:toggleSubMenu(arg1)
            end
            self:toggleWindow(arg1)
        end

        if self._currentSubMenu:get() ~= arg1 then
            self._currentSubMenu:set(nil)
        end
    end
    if var1 then
        error(var1)
    end
end

function module:selectedItem()
    return self._selectedItem
end

function module:setSelected(arg1)
    local var1, _selectedItemIdx = self:withinCurrentTopLevelMenu(arg1 or "")
    if not var1 then
        return
    end

    local userInputType = UserInputService:GetLastInputType()
    local bool2 = userInputType == Enum.UserInputType.MouseButton1 or userInputType == Enum.UserInputType.Touch

    local var3 = self._currentSubMenu:get()
    if var3 and var3 ~= arg1 and not bool2 then
        self:toggleSubMenu(var3)
    end

    self._selectedItemIdx = _selectedItemIdx
    self._selectedItem:set(arg1)
end

function module:setSelectedByOffset(num1: number)
    local var1 = self._menuList:get()
    local _, var2 = self:withinCurrentTopLevelMenu(self._selectedItem:get() or "")
    if var2 > 0 then
        local var3 = var2 + num1
        local num2 = #var1
        self:setSelected(var1[math.clamp(var3, 1, num2)].id)
    end
end

function module:repairSelected()
    if not self._selectedItem:get() then
        return
    end
    local _, _selectedItemIdx = self:withinCurrentTopLevelMenu(self._selectedItem:get() or "")
    if _selectedItemIdx == 0 then
        _selectedItemIdx = self._selectedItemIdx
    end
    local var1 = self._menuList:get()
    local num1 = #var1
    self:setSelected(var1[math.clamp(_selectedItemIdx, 1, num1)].id)
end

function module:configureOrderAlignment(arg1)
    if self._orderAlignment:get() ~= arg1 then
        self._orderAlignment:set(arg1)
        self:updateMenuList()
    end
end

function module:orderAlignment()
    return self._orderAlignment
end

function module:setMenuAbsolutePosition(vector2: Vector2)
    if vector2 ~= self._menuAbsolutePosition then
        self._menuAbsolutePosition = vector2
        self._layout:set(createUnibarLayoutInfo(vector2, self._menuAbsoluteSizeOpen))
    end
end

function module:setMenuAbsoluteSize(vector2: Vector2)
    if vector2 ~= self._menuAbsoluteSizeOpen then
        self._menuAbsoluteSizeOpen = vector2
        self._layout:set(createUnibarLayoutInfo(self._menuAbsolutePosition, vector2))
    end
end

function module:layout()
    return self._layout
end

return module
