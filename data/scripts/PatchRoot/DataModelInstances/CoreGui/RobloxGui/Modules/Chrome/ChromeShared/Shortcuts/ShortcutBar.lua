-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChromeShared = script:FindFirstAncestor("ChromeShared")

local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local GamepadConnector = require(ChromeShared.Parent.Parent.TopBar.Components.GamepadConnector)

local React = require(CorePackages.Packages.React)
local ReactRoblox = require(CorePackages.Packages.ReactRoblox)
local UIBlox = require(CorePackages.Packages.UIBlox)
local Foundation = require(CorePackages.Packages.Foundation)
local ShortcutBar = UIBlox.App.Navigation.ShortcutBar
local _Chrome = require(CorePackages.Workspace.Packages.Chrome)
local Constants = require(ChromeShared.Unibar.Constants)
local ViewportUtil = require(ChromeShared.Service.ViewportUtil)
local useObservableValue = require(ChromeShared.Hooks.useObservableValue)
local useTokens = Foundation.Hooks.useTokens
local useDrawerAnimating = require(CorePackages.Workspace.Packages.Drawer).Hooks.useDrawerAnimating

local Service = require(ChromeShared.Service)

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FFlagEnableConsoleExpControls = SharedFlags.FFlagEnableConsoleExpControls
local isSpatial = require(CorePackages.Workspace.Packages.AppCommonLib).isSpatial
local FFlagGamepadIconSupportCheck = SharedFlags.FFlagGamepadIconSupportCheck
local isSideSheetEnabled = require(CorePackages.Workspace.Packages.InExperienceSideSheetUtils.isSideSheetEnabled)
local FFlagSideSheetFocusNav = SharedFlags.FFlagSideSheetFocusNav
local FFlagEnableDrawerAnimatingHook = SharedFlags.FFlagEnableDrawerAnimatingHook

local getSideSheetVisibility = require(CorePackages.Workspace.Packages.InExperienceSideSheet).getSideSheetVisibility

function ChromeShortcutBar(_)
    local var1, var2 = React.useState({})
    local var3, var4 = React.useState({})
    local var5, var6 = React.useBinding(false)
    local var7 = useTokens()

    local var8 = useObservableValue(ViewportUtil.screenSize)
    local var9 = React.useRef(0)

    local function checkOverflow()
        if not (var9.current > var8.X) then
            return
        end

        local num1 = 1
        for value, value2 in var1 do
            if value2.displayPriority <= var1[num1].displayPriority then
                num1 = value
            end
        end

        local var10 = table.clone(var1)
        table.remove(var10, num1)
        var4(var10)
    end

    React.useEffect(function()
        var4({})
        checkOverflow()
    end, { var8 })

    React.useEffect(function()
        local function updateShortcuts()
            if FFlagGamepadIconSupportCheck and not GamepadConnector:getGamepadActive():get() then
                return
            end
            local currentShortcuts = Service:getCurrentShortcuts()
            var2(currentShortcuts)
            var4({})
        end

        Service:onShortcutBarChanged():connect(updateShortcuts)
        if FFlagGamepadIconSupportCheck then
            UserInputService.LastInputTypeChanged:Connect(updateShortcuts)
        end

        if isSpatial() then
            return
        end

        local showTopBar = GamepadConnector:getShowTopBar()
        local gamepadActive = GamepadConnector:getGamepadActive()

        if FFlagEnableConsoleExpControls then
            local function shouldHideShortcutBar() -- Luacid: Inlined by compiler; 1 call site recovered
                local bool1 = not (showTopBar:get() and gamepadActive:get())
                Service:setHideShortcutBar("TopBar", bool1)
            end

            shouldHideShortcutBar()
            showTopBar:connect(shouldHideShortcutBar)
            gamepadActive:connect(shouldHideShortcutBar)
            return
        end
        local function shouldShowShortcutBar()
            local var10 = showTopBar:get() and gamepadActive:get()
            var6(var10)
        end

        showTopBar:connect(shouldShowShortcutBar)
        gamepadActive:connect(shouldShowShortcutBar)
    end, {})

    if isSideSheetEnabled and FFlagSideSheetFocusNav and FFlagEnableDrawerAnimatingHook then
        local sideSheetVisibility = getSideSheetVisibility(false)

        local var10 = useDrawerAnimating()

        React.useEffect(function()
            Service:setHideShortcutBar("SideSheet", sideSheetVisibility or var10)
        end, { sideSheetVisibility, var10 })
    end

    if not (#var3 > 0) then
        var3 = var1
    end

    local items = {}
    for _, value in var3 do
        if not value.label then
            continue
        end

        local tbl2 = { icon = "", text = "" }
        if value.icon then
            tbl2.icon = value.icon
        end
        tbl2.text = value.label

        table.insert(items, tbl2)
    end

    local createPortal = ReactRoblox.createPortal
    local tbl2 = { Name = 0 }
    local createElement = React.createElement
    local str1 = "ScreenGui"
    local tbl3 = {
        Name = "ShortcutBar",
        DisplayOrder = Constants.SHORTCUTBAR_DISPLAYORDER,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Enabled = 0
    }

    if FFlagEnableConsoleExpControls then
        var5 = nil
    end

    tbl3.Enabled = var5

    local createElement2 = React.createElement
    local tbl4 = {
        Name = "ShortcutBarWrapper",
        AutomaticSize = Enum.AutomaticSize.XY,
        Position = UDim2.new(0.5, 0, 1, if var7 then -var7.Gap.Medium else 0),
        AnchorPoint = Vector2.new(0.5, 1),
        BorderSizePixel = 0,
        BackgroundTransparency = 1
    }

    tbl4[React.Change.AbsoluteSize] = function(arg1)
        var9.current = arg1.AbsoluteSize.X
        checkOverflow()
    end

    tbl2.Name = createElement(str1, tbl3, { createElement2(
            "Frame",
            tbl4,
            {
                Layout = React.createElement("UIListLayout"),
                React.createElement(ShortcutBar, { items = items })
            }
        ) })
    return createPortal(tbl2, CoreGui)
end

return ChromeShortcutBar
