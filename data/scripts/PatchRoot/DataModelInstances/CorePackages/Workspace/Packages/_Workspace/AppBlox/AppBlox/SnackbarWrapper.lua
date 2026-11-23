-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent

local Foundation = require(AppBloxParent.Foundation)
local React = require(AppBloxParent.React)
local RoactUtils = require(AppBloxParent.RoactUtils)
local useDeviceInsets = require(AppBloxParent.Responsive).useDeviceInsets
local shouldUseDeviceSafeInsets = require(AppBloxParent.Display).shouldUseDeviceSafeInsets

local FFlagFixOverlayTopInsetForDeviceSafeInsets = require(AppBloxParent.SharedFlags).FFlagFixOverlayTopInsetForDeviceSafeInsets

local Snackbar = Foundation.Snackbar
local useScaledValue = Foundation.Hooks.useScaledValue
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector

return React.memo(function(tbl1) -- name: SnackbarWrapper
    React.useEffect(function()
        local var1 = if tbl1.autoDismissDelaySeconds then task.delay(tbl1.autoDismissDelaySeconds, tbl1.closeSnackbar) else nil

        return function()
            if var1 then
                task.cancel(var1)
                var1 = nil
            end
        end
    end, { tbl1.closeSnackbar, tbl1.autoDismissDelaySeconds })

    local var1 = React.useCallback(function(_, swipeDirection)
        if swipeDirection == Enum.SwipeDirection.Up then
            tbl1.closeSnackbar()
        end
    end, { tbl1.closeSnackbar })

    local action = tbl1.buttonText and tbl1.onButtonActivated and {
        text = tbl1.buttonText,
        onActivated = tbl1.onButtonActivated
    } or nil

    local var3 = useSelector(function(arg1)
        return arg1.GlobalGuiInset or { left = 0, top = 0, right = 0, bottom = 0 }
    end)

    local var4 = useSelector(function(arg1)
        return arg1.TopBar.statusBarHeight
    end)

    local var5

    if FFlagFixOverlayTopInsetForDeviceSafeInsets then
        local var6 = useDeviceInsets()
        var5 = if shouldUseDeviceSafeInsets then var6.top else 0
    else
        var5 = 0
    end

    local var6 = useScaledValue(20)
    local var7 = tbl1.Position or UDim2.new(0.5, 0, 0, var6 + var3.top + var4 + var5)

    return React.createElement("Frame", {
        AnchorPoint = tbl1.AnchorPoint or Vector2.new(0.5, 0),
        Position = var7,
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1,
        Selectable = false,
        Active = true,
        [React.Event.TouchSwipe] = var1
    }, { React.createElement(Snackbar, {
            title = tbl1.titleText,
            icon = tbl1.icon,
            action = action,
            onClose = if tbl1.hideCloseAffordance then nil else tbl1.closeSnackbar
        }) })
end)
