-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactViewParent = script:FindFirstAncestor("PeopleReactView").Parent

local Foundation = require(PeopleReactViewParent.Foundation)
local React = require(PeopleReactViewParent.React)
local SignalsReact = require(PeopleReactViewParent.SignalsReact)
local Signals = require(PeopleReactViewParent.Signals)

local View = Foundation.View
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local IconSize = Foundation.Enums.IconSize
local useTokens = Foundation.Hooks.useTokens
local useSignalState = SignalsReact.useSignalState

local function CoreButton(tbl1)
    local var1 = useTokens()

    local var2 = useSignalState(tbl1.animatedIcon or Signals.createSignal(""))
    local var3 = useSignalState(tbl1.buttonState or Signals.createSignal(false))

    local var4 = React.useMemo(function()
        if tbl1.icon.off and tbl1.buttonState then
            return var3 and tbl1.icon.off or tbl1.icon.on
        end

        return tbl1.icon.on
    end, { var3, tbl1.icon })

    local name = React.useMemo(function()
        return if tbl1.animatedIcon then var2 else var4
    end, { var2, var4 })

    local createElement = React.createElement
    local var6 = View
    local tbl2 = {
        tag = "size-0-1200 flex-x-fill grow radius-medium padding-x-small align-y-center row gap-xsmall bg-surface-200",
        onActivated = tbl1.onActivated,
        LayoutOrder = tbl1.LayoutOrder,
        ref = tbl1.onMount
    }
    local tbl3 = { IconContainer = 0, Text = 0 }
    local createElement2 = React.createElement
    local var7 = View
    local tbl4 = { tag = "size-1100 align-y-center align-x-center row", LayoutOrder = 1 }

    local tbl5 = {
        Icon = React.createElement(Icon, { name = name, size = if tbl1.isNewIcon then IconSize.Large else IconSize.Medium })
    }
    tbl3.IconContainer = createElement2(var7, tbl4, tbl5)

    tbl3.Text = React.createElement(FoundationText, {
        Text = tbl1.text,
        textStyle = {
            Color3 = var1.Color.Content.Default.Color3
        },
        TextTruncate = Enum.TextTruncate.SplitWord,
        tag = "text-label-medium size-full text-align-x-left",
        LayoutOrder = 2
    })
    return createElement(var6, tbl2, tbl3)
end

return CoreButton
