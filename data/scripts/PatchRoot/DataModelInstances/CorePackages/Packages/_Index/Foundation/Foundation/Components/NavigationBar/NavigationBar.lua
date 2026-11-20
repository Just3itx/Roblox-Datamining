-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Dash = require(FoundationParent.Dash)
local React = require(FoundationParent.React)

local Breakpoint = require(Foundation.Enums.Breakpoint)
local BreakpointConfig = require(Foundation.Utility.Responsive.BreakpointConfig)
local Divider = require(Foundation.Components.Divider)
local NavigationBarTab = require(script.Parent.NavigationBarTab)
local StateLayerAffordance = require(Foundation.Enums.StateLayerAffordance)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local useAnimatedHighlight = require(Foundation.Utility.useAnimatedHighlight)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local width = BreakpointConfig.widths[Breakpoint.Small]

local tbl1 = { testId = "--foundation-navigation-bar" }

return React.memo(React.forwardRef(function(arg1, ref) -- name: NavigationBar
    local var1 = withDefaults(arg1, tbl1)

    local var2, var3 = React.useState(var1.defaultActiveItemId or Dash.get(var1.items, { 1, "id" }))
    if var1.activeItemId ~= nil then
        var2 = var1.activeItemId
    end
    local onActivated = React.useCallback(function(arg2)
        var3(arg2)
        if var1.onActivated then
            var1.onActivated(arg2)
        end
    end, { var1.onActivated })

    local var5 = useTokens()
    local var6 = React.useRef(nil)
    local var7 = React.useRef({})
    local var8 = React.useMemo(function()
        local current = var7.current
        for _, item in var1.items do
            if not current[item.id] then
                current[item.id] = React.createRef()
            end
        end
        return current
    end, { var1.items })

    local var9 = Dash.some(var1.items, function(arg2): boolean
        return arg2.id == var2
    end)
    local var10 = useAnimatedHighlight(var2, ref or var6, var8, var1.items)

    return React.createElement(
        View,
        withCommonProps(var1, {
            tag = "size-full-0 auto-y",
            backgroundStyle = var5.Color.Common.NavigationBar,
            onActivated = Dash.noop,
            stateLayer = {
                affordance = StateLayerAffordance.None
            },
            selection = { Selectable = false },
            ref = ref or var6
        }),
        {
            ActiveIndicator = React.createElement(View, {
                tag = "radius-circle bg-system-contrast",
                Size = var10.highlightWidth:map(function(xOffset: number): UDim2
                    return UDim2.fromOffset(xOffset, var5.Size.Size_50)
                end),
                Position = var10.highlightPosition:map(function(xOffset: number): UDim2
                    return UDim2.fromOffset(xOffset, 0)
                end),
                Visible = var9,
                ZIndex = 3,
                testId = `{var1.testId}--active-indicator`
            }),
            Divider = React.createElement(Divider, { testId = `{var1.testId}--divider` }),
            Tabs = React.createElement(
                View,
                {
                    tag = "row gap-small size-full-0 auto-y margin-x-small",
                    AnchorPoint = Vector2.new(0.5, 0),
                    Position = UDim2.fromScale(0.5, 0),
                    sizeConstraint = {
                        MaxSize = Vector2.new(width, math.huge)
                    },
                    ZIndex = 2,
                    testId = `{var1.testId}--tabs`
                },
                Dash.map(var1.items, function(arg2, layoutOrder)
                    return React.createElement(NavigationBarTab, {
                        key = tostring(arg2.id),
                        item = arg2,
                        isActive = arg2.id == var2,
                        onActivated = onActivated,
                        LayoutOrder = layoutOrder,
                        ref = var8[arg2.id],
                        testId = `{var1.testId}--item-{arg2.id}`
                    })
                end)
            )
        }
    )
end))
