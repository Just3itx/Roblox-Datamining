-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:41:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local React = require(MomentsParent.React)
local SignalsReact = require(MomentsParent.SignalsReact)

local FoundationProvider = Foundation.FoundationProvider
local Snackbar = Foundation.Snackbar
local Toast = Foundation.Toast
local View = Foundation.View

local ColorMode = Foundation.Enums.ColorMode

local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useScreenSize = MomentsCommon.Hooks.useScreenSize
local useTokens = Foundation.Hooks.useTokens

local GetToastStore = require(Moments.Stores.GetToastStore)
local _createToastStore = require(Moments.Stores.GetToastStore.createToastStore)

local Constants = require(Moments.Constants)
local momentLayout = require(Moments.Components.Feed.Items.Moment.momentLayout)
local useScreenBottomInset = require(Moments.Hooks.useScreenBottomInset)
local FFlagMomentsPostFeedback = require(MomentsParent.SharedFlags).FFlagMomentsPostFeedback

local function ToastItem(tbl1)
    local entry = tbl1.entry
    local onDismiss = tbl1.onDismiss

    React.useEffect(function()
        local var1 = task.delay(3, function()
            onDismiss(entry.id)
        end)
        return function()
            task.cancel(var1)
        end
    end, { entry.id, onDismiss })

    if entry.data.variant == "snackbar" then
        return React.createElement(Snackbar, { title = entry.data.title, LayoutOrder = entry.id })
    end

    return React.createElement(Toast, {
        title = entry.data.title,
        text = if entry.data.text == "" then nil else entry.data.text,
        LayoutOrder = entry.id,
        width = tbl1.toastWidth
    })
end

local function BottomToastStack(tbl1)
    local var1 = useDeviceInsets()
    local var2 = useTokens()

    local var3 = useScreenBottomInset()

    local offset = var3 + momentLayout.getInfoBottomGap(var2, var3, var1.bottom) + var2.Padding.Large - var2.Padding.Medium

    return React.createElement(View, {
        tag = "position-bottom-center anchor-bottom-center size-full-0 auto-y",
        ZIndex = Constants.ZIndex.Toasts,
        padding = {
            bottom = UDim.new(0, offset),
            left = UDim.new(0, var1.left + var2.Padding.Large),
            right = UDim.new(0, var1.right + var2.Padding.Large)
        }
    }, {
        DarkScope = React.createElement(
            FoundationProvider,
            {
                colorMode = ColorMode.Dark
            },
            {
                Stack = React.createElement(View, { tag = "col align-x-center gap-small size-full-0 auto-y" }, tbl1.children)
            }
        )
    })
end

local function PlacedToastStacks(tbl1)
    local var1 = useDeviceInsets()
    local var2 = useTokens()

    local tbl2 = {}
    local children = {}
    local bool1 = false
    for _, entry in tbl1.toasts do
        local element = React.createElement(ToastItem, { entry = entry, onDismiss = tbl1.onDismiss, toastWidth = tbl1.toastWidth })

        if entry.data.placement == "bottom" then
            local id = entry.id
            children["Toast_" .. tostring(id)] = element
            bool1 = true
        else
            local id = entry.id
            tbl2["Toast_" .. tostring(id)] = element
        end
    end

    return React.createElement(React.Fragment, nil, {
        Top = React.createElement(View, {
            tag = "col gap-small position-top-center anchor-top-center auto-xy",
            ZIndex = Constants.ZIndex.Toasts,
            padding = {
                top = UDim.new(0, var1.top + var2.Padding.Large),
                left = UDim.new(0, var1.left + var2.Padding.Large),
                right = UDim.new(0, var1.right + var2.Padding.Large)
            }
        }, tbl2),
        Bottom = if bool1 then React.createElement(BottomToastStack, { children = children }) else nil
    })
end

local function ToastOverlay()
    local toastStore = GetToastStore(false)
    local toasts = SignalsReact.useSignalState(toastStore.getToasts)
    local var2 = useDeviceInsets()
    local var3 = useScreenSize()
    local var4 = useTokens()

    local onDismiss = React.useCallback(function(num1: number)
        toastStore.dismissToast(num1)
    end, { toastStore.dismissToast })

    if #toasts == 0 then
        return nil
    end

    local uDim = UDim.new(0, math.min(400, var3.X - 40))

    if FFlagMomentsPostFeedback then
        return React.createElement(PlacedToastStacks, { toasts = toasts, onDismiss = onDismiss, toastWidth = uDim })
    end

    local tbl1 = {}
    for _, entry in toasts do
        local id = entry.id
        tbl1["Toast_" .. tostring(id)] = React.createElement(ToastItem, { entry = entry, onDismiss = onDismiss, toastWidth = uDim })
    end

    return React.createElement(View, {
        tag = "col gap-small position-top-center anchor-top-center auto-xy",
        ZIndex = Constants.ZIndex.Toasts,
        padding = {
            top = UDim.new(0, var2.top + var4.Padding.Large),
            left = UDim.new(0, var2.left + var4.Padding.Large),
            right = UDim.new(0, var2.right + var4.Padding.Large)
        }
    }, tbl1)
end

return ToastOverlay
