-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Foundation = require(scriptParentParentParent.Foundation)
local React = require(scriptParentParentParent.React)

local Icon = Foundation.Icon
local View = Foundation.View

local useCallback = React.useCallback
local useScreenSize = require(scriptParentParent.Hooks.useScreenSize)
local useState = React.useState
local useTokens = Foundation.Hooks.useTokens

local CaptureItem = require(scriptParentParent.Components.CaptureItem)
local _Types = require(scriptParentParent.Types)

local vector2 = Vector2.new(700, 500)

return function(tbl1)
    local var1 = useTokens()

    local var2 = useScreenSize()
    local var3, var4 = useState(var2)

    local onAbsoluteSizeChanged = useCallback(function(arg1)
        var4(arg1.AbsoluteSize)
        tbl1.onAbsoluteSizeChangedCallback(arg1)
    end, { tbl1.onAbsoluteSizeChangedCallback })

    local y = var2.Y
    local x = var2.X
    local enableLargeScreenMode = tbl1.enableLargeScreenMode

    if enableLargeScreenMode then
        if var3.X > vector2.X then
            enableLargeScreenMode = var3.Y > vector2.Y
        else
            enableLargeScreenMode = false
        end
    end

    local bool1 = y < x
    local num1 = if tbl1.children == nil then 1 else 0.6

    local createElement = React.createElement
    local var6 = View
    local tbl2 = {
        onAbsoluteSizeChanged = onAbsoluteSizeChanged,
        stateLayer = {
            affordance = Foundation.Enums.StateLayerAffordance.None
        },
        tag = "size-full-full bg-over-media-0"
    }
    local tbl3 = { ComposerScreenContainer = 0 }
    local createElement2 = React.createElement
    local var7 = View
    local tbl4 = {
        Size = if enableLargeScreenMode then UDim2.fromOffset(math.min(var3.X, vector2.X), math.min(var3.Y, vector2.Y)) else UDim2.fromScale(1, 1),
        stateLayer = {
            affordance = Foundation.Enums.StateLayerAffordance.None
        },
        tag = {
            ["anchor-center-center bg-surface-200 position-center-center"] = true,
            ["radius-large"] = enableLargeScreenMode
        }
    }
    local tbl5 = { ComposerContainer = 0 }
    local createElement3 = React.createElement
    local var9 = View
    local tbl6 = {
        tag = {
            ["anchor-center-center bg-action-subtle position-center-center size-full-full"] = true,
            ["padding-right-large"] = enableLargeScreenMode
        }
    }
    local tbl7 = {
        BackButtonContainer = React.createElement(View, {
            tag = "auto-xy bg-action-subtle",
            ZIndex = 2
        }, {
            Padding = React.createElement("UIPadding", {
                PaddingBottom = UDim.new(0, var1.Padding.Large),
                PaddingLeft = UDim.new(0, var1.Padding.XXLarge),
                PaddingRight = UDim.new(0, var1.Padding.Large),
                PaddingTop = UDim.new(0, var1.Padding.XXLarge)
            }),
            BackButton = React.createElement(
                View,
                {
                    onActivated = tbl1.onCloseCallback,
                    tag = { ["auto-xy bg-over-media-300 padding-medium radius-circle"] = true }
                },
                {
                    BackIcon = React.createElement(Icon, {
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        IconSize = Foundation.Enums.IconSize.Small,
                        name = if enableLargeScreenMode then "icons/navigation/close" else "icons/actions/cycleLeft",
                        Position = UDim2.fromScale(0.5, 0.5),
                        style = var1.Color.ActionEmphasis.Foreground,
                        ZIndex = 2
                    })
                }
            )
        }),
        CaptureContainer = 0,
        ComposerBody = 0
    }

    local createElement4 = React.createElement
    local var10 = View
    local tbl8 = {
        Size = if bool1 then UDim2.new(num1, if enableLargeScreenMode then var1.Padding.Large else 0, 1, 0) else UDim2.fromScale(1, num1),
        tag = {
            ["bg-surface-100 clip"] = true,
            ["padding-right-large"] = enableLargeScreenMode and tbl1.children ~= nil,
            ["radius-large"] = enableLargeScreenMode
        },
        ZIndex = 1
    }
    tbl7.CaptureContainer = createElement4(var10, tbl8, {
        CapturePreviewFrame = React.createElement(
            View,
            {
                LayoutOrder = 2,
                tag = "anchor-center-center bg-action-subtle position-center-center size-full-full"
            },
            {
                CapturePreview = React.createElement(CaptureItem, {
                    capture = tbl1.capture,
                    isVideoPlaying = true,
                    onActivated = function() end,
                    scaleType = Enum.ScaleType.Fit
                })
            }
        )
    })
    tbl7.ComposerBody = tbl1.children
    tbl5.ComposerContainer = createElement3(var9, tbl6, tbl7)
    tbl3.ComposerScreenContainer = createElement2(var7, tbl4, tbl5)
    return createElement(var6, tbl2, tbl3)
end
