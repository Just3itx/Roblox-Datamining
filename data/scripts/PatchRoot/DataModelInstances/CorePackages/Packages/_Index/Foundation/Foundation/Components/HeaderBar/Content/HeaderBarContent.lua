-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:40:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Constants = require(Foundation.Constants)
local Flags = require(Foundation.Utility.Flags)
local HeaderBarContext = require(Foundation.Components.HeaderBar.HeaderBarContext)
local HeaderBarSlot = require(Foundation.Enums.HeaderBarSlot)
local View = require(Foundation.Components.View)
local constants = require(Foundation.Components.HeaderBar.constants)
local useHeaderBarContext = require(Foundation.Components.HeaderBar.useHeaderBarContext)
local useTokens = require(Foundation.Providers.Style.useTokens)

local function HeaderBarContent(tbl1)
    local var1 = useHeaderBarContext()

    if not Flags.FoundationHeaderBarSlotSizing then
        return React.createElement(
            HeaderBarContext.Provider,
            {
                testId = var1.testId,
                slot = HeaderBarSlot.Content
            },
            React.createElement(View, {
                tag = "align-y-center grow size-0-full auto-x",
                LayoutOrder = constants.CONTENT_LAYOUT_ORDER,
                testId = `{var1.testId}--content`
            }, tbl1.children)
        )
    end

    local var2 = useTokens()
    local leadingWidth = var1.leadingWidth or 0
    local trailingWidth = var1.trailingWidth or 0
    local var3 = if leadingWidth > 0 then leadingWidth + var2.Gap.Small else 0
    local var4 = if trailingWidth > 0 then trailingWidth + var2.Gap.Small else 0

    local xSmall = var2.Padding.XSmall

    local var5 = var4 - var3

    local createElement = React.createElement
    local provider = HeaderBarContext.Provider
    local tbl2 = {
        testId = var1.testId,
        slot = HeaderBarSlot.Content,
        leadingWidth = var1.leadingWidth,
        trailingWidth = var1.trailingWidth,
        onSideWidthChanged = var1.onSideWidthChanged
    }
    local createElement2 = React.createElement
    local var6 = View
    local tbl3 = {
        tag = "size-full",
        LayoutOrder = constants.CONTENT_LAYOUT_ORDER,
        ZIndex = 1,
        testId = `{var1.testId}--content`
    }
    local tbl4 = { Content = 0 }
    local createElement3 = React.createElement
    local var7 = View
    local tbl5 = {
        tag = "row align-x-center align-y-center padding-x-xsmall clip",
        Position = UDim2.fromOffset(var3 - xSmall, 0),
        Size = UDim2.new(1, 2 * xSmall - var3 - var4, 1, 0),
        LayoutOrder = 1,
        testId = `{var1.testId}--content--content`
    }
    local tbl6 = {
        CenteringSpacer = React.createElement(View, {
            tag = "shrink",
            Size = UDim2.fromOffset(math.abs(var5), 0),
            LayoutOrder = if var5 > 0 then Constants.MIN_LAYOUT_ORDER else Constants.MAX_LAYOUT_ORDER - 1
        }),
        Children = React.createElement(React.Fragment, nil, tbl1.children)
    }
    tbl4.Content = createElement3(var7, tbl5, tbl6)
    return createElement(provider, tbl2, createElement2(var6, tbl3, tbl4))
end

return HeaderBarContent
