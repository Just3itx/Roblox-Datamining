-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local React = require(ChatUIPrimitivesParent.React)
local createNextOrder = require(ChatUIPrimitivesParent.ReactUtils).createNextOrder

return React.memo(function(tbl1) -- name: ExpressionTabBar
    local var1 = Foundation.Hooks.useTokens()
    local bool1 = #tbl1.tabs > 1
    local tbl2 = ({})
    for layoutOrder, tab in tbl1.tabs do
        local bool2 = tab.id == tbl1.activeTabId
        local bool3 = bool2 or not bool1
        local var2 = "Tab_" .. tab.id
        local createElement = React.createElement
        local view = Foundation.View
        local tbl3 = {
            LayoutOrder = layoutOrder,
            testId = "expressionTab_" .. tab.id,
            tag = "auto-xy padding-x-small",
            stateLayer = {
                affordance = Foundation.Enums.StateLayerAffordance.None
            },
            onActivated = 0,
            selection = 0
        }
        function tbl3.onActivated()
            tbl1.onTabActivated(tab.id)
        end

        tbl3.selection = tbl1.focusNavEnabled and not bool1 and { Selectable = false } or nil
        local tbl4 = {
            Label = React.createElement(Foundation.Text, {
                Text = tab.text,
                tag = {
                    ["auto-xy text-label-medium"] = true,
                    ["content-emphasis"] = bool3,
                    ["content-muted"] = not bool3
                }
            }),
            Indicator = if bool2 and bool1 then React.createElement(Foundation.View, {
                testId = "presetTabIndicator",
                tag = "anchor-bottom-center",
                Position = UDim2.new(0.5, 0, 1, 0),
                Size = UDim2.new(1, 0, 0, 2),
                backgroundStyle = {
                    Color3 = var1.Color.Content.Emphasis.Color3,
                    Transparency = 0
                }
            }) else nil
        }
        tbl2[var2] = createElement(view, tbl3, tbl4)
    end

    local nextOrder = createNextOrder()
    local createElement = React.createElement
    local view = Foundation.View
    local tbl3 = {
        LayoutOrder = tbl1.LayoutOrder,
        tag = "row align-y-center gap-small size-full-0 auto-y padding-small"
    }
    local tbl4 = {
        Tabs = React.createElement(Foundation.View, { LayoutOrder = nextOrder(), tag = "row gap-medium auto-xy" }, tbl2),
        Spacer = React.createElement(Foundation.View, { LayoutOrder = nextOrder(), tag = "grow auto-y" }),
        Keyboard = 0
    }
    local element

    if tbl1.showKeyboardButton == false then
        element = nil
    else
        element = React.createElement(Foundation.IconButton, {
            LayoutOrder = nextOrder(),
            testId = "expressionTrayKeyboardButton",
            icon = { name = "keyboard", variant = "Regular" },
            variant = Foundation.Enums.ButtonVariant.Utility,
            size = Foundation.Enums.InputSize.Small,
            isCircular = true,
            isDisabled = false,
            onActivated = tbl1.onKeyboardActivated
        })
    end

    tbl4.Keyboard = element
    return createElement(view, tbl3, tbl4)
end)
