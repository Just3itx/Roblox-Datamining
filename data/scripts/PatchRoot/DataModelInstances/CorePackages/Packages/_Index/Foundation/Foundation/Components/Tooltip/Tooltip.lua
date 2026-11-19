-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:10:40Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local UserInputService = require(Foundation.Utility.Wrappers).Services.UserInputService

local Flags = require(Foundation.Utility.Flags)

local Constants = require(Foundation.Constants)
local Logger = require(Foundation.Utility.Logger)
local PopoverAlign = require(Foundation.Enums.PopoverAlign)
local PopoverContext = require(Foundation.Components.Popover.PopoverContext)
local PopoverSide = require(Foundation.Enums.PopoverSide)
local Radius = require(Foundation.Enums.Radius)
local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)

local useScaledValue = require(Foundation.Utility.useScaledValue)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local Popover = require(Foundation.Components.Popover)

local tbl1 = {
    align = PopoverAlign.Start,
    side = PopoverSide.Right,
    hasArrow = true,
    testId = "--foundation-tooltip"
}

local function AnchorWrapper(arg1)
    local var1 = React.useContext(PopoverContext)
    local var2 = React.useRef(nil)

    React.useEffect(function()
        if var1.anchor ~= nil then
            if typeof(var1.anchor) ~= "Instance" then
                Logger:warning("MeasurableRef cannot be an anchor for the tooltip")
                return
            end
            var2.current = var1.anchor:GetPropertyChangedSignal("GuiState"):Connect(function()
                arg1.onHover(var1.anchor.GuiState == Enum.GuiState.Hover)
            end)
        end

        return function()
            if var2.current ~= nil then
                var2.current:Disconnect()
            end
        end
    end, { var1.anchor, arg1.onHover })

    return React.createElement(Popover.Anchor, withCommonProps(arg1, {}), arg1.children)
end

return React.memo(function(arg1) -- name: Tooltip
    local var1 = withDefaults(arg1, tbl1)
    local isOpen, onHover = React.useState(false)
    local var4 = useTokens()
    local bool1 = not (var1.text == nil) and var1.text ~= ""
    local x = useScaledValue(Constants.TOOLTIP_MAX_WIDTH)

    local padding = bool1
        and {
            top = UDim.new(0, var4.Size.Size_150),
            bottom = UDim.new(0, var4.Size.Size_200),
            left = UDim.new(0, var4.Size.Size_200),
            right = UDim.new(0, var4.Size.Size_200)
        }
        or {
            top = UDim.new(0, var4.Size.Size_100),
            bottom = UDim.new(0, var4.Size.Size_150),
            left = UDim.new(0, var4.Size.Size_150),
            right = UDim.new(0, var4.Size.Size_150)
        }

    local var5 = React.useMemo(function()
        if var1.shortcut == nil then
            return nil
        end
        local str1 = ""
        for value, value2 in var1.shortcut do
            local stringForKeyCode = UserInputService:GetStringForKeyCode(value2)
            if stringForKeyCode == nil or stringForKeyCode == "" then
                stringForKeyCode = value2.Name
            end

            if value > 1 then
                str1 ..= " + "
            end
            str1 ..= stringForKeyCode
        end
        return str1
    end, { var1.shortcut })

    local createElement = React.createElement
    local root = Popover.Root
    local tbl3 = {
        isOpen = isOpen,
        testId = var1.testId
    }
    local tbl4 = {
        Anchor = React.createElement(AnchorWrapper, withCommonProps(var1, { onHover = onHover }), var1.children),
        Content = 0
    }
    local createElement2 = React.createElement
    local content = Popover.Content
    local tbl5 = {
        hasArrow = var1.hasArrow,
        align = var1.align,
        side = {
            position = var1.side,
            offset = var4.Size.Size_200
        },
        radius = Radius.Small,
        backgroundStyle = var4.Inverse.Surface.Surface_0,
        selectionGroup = false,
        onPressedOutside = Flags.FoundationTooltipPressedOutside and function()
            onHover(false)
        end or nil
    }

    local createElement3 = React.createElement
    local var6 = View
    local tbl6 = {
        tag = { ["col gap-xsmall auto-xy"] = true },
        padding = padding,
        sizeConstraint = {
            MaxSize = Vector2.new(x, math.huge)
        }
    }
    local tbl7 = { Header = 0, Text = 0 }
    local element

    if var1.title == "" and not var1.shortcut then
        element = nil
    else
        element = React.createElement(View, {
            LayoutOrder = 1,
            tag = "row flex-between gap-small size-full-0 auto-y"
        }, {
            Title = if var1.title == "" then nil else React.createElement(Text, {
                LayoutOrder = 1,
                Text = var1.title,
                tag = {
                    ["shrink auto-xy text-truncate-end content-inverse-emphasis"] = true,
                    ["text-caption-medium"] = bool1,
                    ["text-body-small"] = not bool1
                },
                testId = `{var1.testId}--title`
            }),
            Shortcut = if var1.shortcut then React.createElement(Text, {
                LayoutOrder = 2,
                Text = var5,
                tag = "auto-xy text-body-small content-inverse-muted",
                testId = `{var1.testId}--shortcut`
            }) else nil
        })
    end

    tbl7.Header = element

    tbl7.Text = if var1.text and var1.text ~= "" then React.createElement(Text, {
        LayoutOrder = 2,
        Text = var1.text,
        tag = "auto-xy text-body-small text-wrap text-align-x-left content-inverse-default",
        testId = `{var1.testId}--text`
    }) else nil
    tbl4.Content = createElement2(content, tbl5, createElement3(var6, tbl6, tbl7))
    return createElement(root, tbl3, tbl4)
end)
