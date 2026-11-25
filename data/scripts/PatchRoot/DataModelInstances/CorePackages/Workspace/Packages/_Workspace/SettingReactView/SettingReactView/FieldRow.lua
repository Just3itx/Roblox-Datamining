-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local _SettingsService = require(scriptParentParent.SettingsService)
local Foundation = require(scriptParentParent.Foundation)
local React = require(scriptParentParent.React)
local Field = require(scriptParent.Field)
local ReactUtils = require(scriptParentParent.ReactUtils)
local SignalsReact = require(scriptParentParent.SignalsReact)
local View = Foundation.View
local FoundationText = Foundation.Text
local createNextOrder = ReactUtils.createNextOrder
local useTokens = Foundation.Hooks.useTokens
local Enums = Foundation.Enums
local ControlState = Enums.ControlState
local StateLayerAffordance = Enums.StateLayerAffordance

return function(arg1)
    local var1 = useTokens()
    local nextOrder = createNextOrder()

    local uDim2 = UDim2.fromScale(0.5, 1)
    local uDim2_2 = UDim2.fromScale(0.5, 1)
    local tbl1 = {
        Color3 = var1.Color.Extended.Gray.Gray_700.Color3,
        Transparency = 0.9
    }
    local tbl2 = {
        Color3 = tbl1.Color3,
        Transparency = 1
    }
    local backgroundStyle, var3 = React.useBinding(tbl2)
    local onStateChanged = React.useCallback(function(default)
        var3(if default == ControlState.Default then tbl2 else tbl1)
    end, { var3 })

    local var5 = SignalsReact.useSignalBinding(arg1.subscribeVisible)

    local createElement = React.createElement
    local var6 = View
    local tbl3 = {
        tag = "auto-y row size-full-1300 radius-medium",
        backgroundStyle = backgroundStyle,
        onStateChanged = onStateChanged,
        stateLayer = {
            affordance = StateLayerAffordance.None
        },
        Visible = var5,
        LayoutOrder = arg1.layoutOrder
    }
    local tbl4 = {
        LabelContainer = React.createElement(
            View,
            {
                tag = "auto-y gui-object-defaults col padding-left-small padding-y-large",
                Size = uDim2_2,
                LayoutOrder = nextOrder()
            },
            {
                Label = React.createElement(FoundationText, {
                    LayoutOrder = nextOrder(),
                    tag = "auto-y grow size-full-0 text-align-x-left text-wrap text-label-large",
                    textStyle = var1.Color.Extended.White.White_100,
                    Text = arg1.label
                }),
                Padding = if arg1.description then React.createElement(View, { tag = "size-full-200", LayoutOrder = nextOrder() }) else nil,
                Description = if arg1.description then React.createElement(FoundationText, {
                    LayoutOrder = nextOrder(),
                    tag = "auto-y size-full-0 text-align-x-left text-wrap text-label-small",
                    textStyle = var1.Color.Extended.White.White_80,
                    Text = arg1.description
                }) else nil
            }
        ),
        FieldContainer = React.createElement(
            View,
            {
                Size = uDim2,
                tag = "row align-x-right align-y-center",
                LayoutOrder = nextOrder()
            },
            { React.createElement(
                    View,
                    {
                        tag = "row align-x-center align-y-center auto-xy padding-right-small padding-y-medium"
                    },
                    React.createElement(Field, arg1)
                ) }
        )
    }
    return createElement(var6, tbl3, tbl4)
end
