-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:20:49Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local BuilderIcons = require(FoundationParent.BuilderIcons)
local React = require(FoundationParent.React)

local Components = Foundation.Components
local Checkbox = require(Components.Checkbox)
local Divider = require(Components.Divider)
local Flags = require(Foundation.Utility.Flags)
local Icon = require(Components.Icon)
local InputSize = require(Foundation.Enums.InputSize)
local ListItemInputType = require(Foundation.Enums.ListItemInputType)
local RadioGroup = require(Components.RadioGroup)
local Text = require(Components.Text)
local Toggle = require(Components.Toggle)
local _Types = require(Foundation.Components.Types)
local View = require(Components.View)
local devAssert = require(Foundation.Utility.devAssert)
local escapeRichText = require(Foundation.Utility.escapeRichText)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withDefaults = require(Foundation.Utility.withDefaults)

local useListItemVariants = require(script.Parent.useListItemVariants)

local ListAccessory = require(script.Parent.ListAccessory)
local useListAccessoryVariants = require(script.Parent.useListAccessoryVariants)

local useList = require(script.Parent.Parent.useList)

local tbl1 = {
    [InputSize.XSmall] = "gap-xxsmall",
    [InputSize.Small] = "gap-xxsmall",
    [InputSize.Medium] = "gap-xsmall",
    [InputSize.Large] = "gap-xsmall"
}

local tbl2 = {}

return React.memo(React.forwardRef(function(arg1, ref) -- name: ListItem
    local var1 = withDefaults(arg1, tbl2)

    if Flags.FoundationListItemDecoupledInput then
        local bool1 = var1.onActivated ~= nil
        local bool2 = typeof(var1.input) == "table" and var1.input.onActivated ~= nil
        devAssert(not (bool1 and bool2), "ListItem: set `onActivated` on the item or on `input`, not both.")
    end

    local var2 = useList()
    local size = var2.size or InputSize.Medium

    local var4 = useTokens()

    local var5 = useListItemVariants(var4, size)
    local var6 = useListAccessoryVariants(var4, size, "Icon")

    local var7 = tbl1[size]
    local bool1 = typeof(var1.onActivated) == "table" and var1.onActivated.onActivated ~= nil

    local onActivated = React.useMemo(function()
        if bool1 then
            return var1.onActivated.onActivated
        end

        if var1.onActivated == nil then
            return nil
        end

        return var1.onActivated
    end, { var1.onActivated, bool1 })

    local var9 = React.useMemo(function()
        if not Flags.FoundationListItemDecoupledInput then
            return nil
        end
        if var1.input == nil then
            if not bool1 then
                return if var1.onActivated == nil then nil else {
                    type = ListItemInputType.Chevron
                }
            end

            local onActivated = var1.onActivated
            return {
                type = onActivated.inputType or ListItemInputType.Chevron,
                isChecked = onActivated.isChecked
            }
        end

        if typeof(var1.input) ~= "table" then
            return {
                type = var1.input
            }
        end

        local input = var1.input
        return {
            type = input.type,
            isChecked = input.isChecked,
            onActivated = input.onActivated
        }
    end, { var1.onActivated, var1.input, bool1 })

    local var10 = React.useMemo(function()
        return if bool1 then var1.onActivated.inputType else nil
    end, { var1.onActivated, bool1 })

    local var11 = React.useMemo(function()
        return if bool1 then var1.onActivated.isChecked else nil
    end, { var1.onActivated, bool1 })

    local var12 = React.useMemo(function()
        if typeof(var1.title) == "string" then
            return var1.title
        end

        return if typeof(var1.title) == "table" then var1.title.title else nil
    end, { var1.title })

    local var13 = React.useMemo(function()
        if typeof(var1.title) == "table" then
            if var1.title.title == nil then
                return nil
            end

            return var1.title.metadata
        end

        return nil
    end, { var1.title })

    local var14 = React.useMemo(function()
        return var12 and string.gsub(var12, "%s+", "-") or ""
    end, { var12 })
    var1.testId = if var1.testId then var1.testId else `{var2.testId}--item-{var14}`
    local bool2 = if Flags.FoundationListItemDecoupledInput then not (var9 == nil) and var9.type ~= ListItemInputType.None else var1.onActivated ~= nil

    if Flags.FoundationListItemDecoupledInput then
        if var9 then
            var10 = var9.type
        else
            var10 = nil
        end
    end

    if Flags.FoundationListItemDecoupledInput then
        if var9 then
            var11 = var9.isChecked
        else
            var11 = nil
        end
    end

    local var3 = React.useCallback(function(bool3: boolean)
        if Flags.FoundationListItemDecoupledInput and var9 and var9.onActivated then
            var9.onActivated(bool3)
        elseif onActivated then
            onActivated()
        end
    end, { var9, onActivated })

    local onValueChanged = React.useCallback(function(str1: string)
        var3(str1 == "radio")
    end, { var3 })

    local createElement = React.createElement
    local var17 = View
    local tbl3 = {
        tag = "col size-full-0 auto-y",
        LayoutOrder = var1.LayoutOrder,
        ref = ref
    }
    local tbl4 = { HoverWrapper = 0, Divider = 0 }
    local createElement2 = React.createElement
    local var18 = View
    local tbl5 = { padding = 0, tag = "size-full-0 auto-y padding-y-xsmall", LayoutOrder = 1 }
    local small

    if var2.isContained then
        small = var4.Padding.Small
    else
        small = { left = 0, right = 0 }
        local new = UDim.new
        local num1 = 0
        local var19 = if var2.hasMargin then var4.Padding.Small else -var4.Padding.Small
        small.left = new(num1, var19)
        local new2 = UDim.new
        local num2 = 0
        local var20 = if var2.hasMargin then var4.Padding.Small else -var4.Padding.Small
        small.right = new2(num2, var20)
    end

    tbl5.padding = small

    local tbl6 = { ListItemContainer = 0 }
    local createElement3 = React.createElement
    local var19 = View
    local tbl7 = {
        onActivated = onActivated,
        onSecondaryActivated = var1.onSecondaryActivated,
        tag = {
            ["size-full-0 auto-y radius-medium"] = true,
            ["margin-x-small"] = var2.hasMargin,
            ["padding-x-small"] = not var2.hasMargin
        }
    }
    local tbl8 = { ListItem = 0 }
    local createElement4 = React.createElement
    local var20 = View
    local tbl9 = {
        testId = var1.testId,
        tag = "row align-y-center gap-medium size-full-0 auto-y padding-y-small radius-medium"
    }
    local tbl10 = {
        LeadingContainer = if var1.leading then React.createElement(
            ListAccessory,
            {
                config = var1.leading,
                size = size,
                testId = `{var1.testId}--leading-accessory`,
                LayoutOrder = 0
            }
        ) else nil,
        Content = 0
    }

    local createElement5 = React.createElement
    local var21 = View
    local tbl11 = {
        tag = "row flex-between align-x-center align-y-center fill gap-medium auto-y",
        LayoutOrder = 1
    }

    local tbl12 = { TextContainer = 0, TrailingContainer = 0, ActivatedIconContainer = 0 }
    local createElement6 = React.createElement
    local var22 = View
    local tbl13 = {
        tag = {
            ["col fill auto-y padding-y-xsmall"] = true,
            [var7] = true
        },
        LayoutOrder = 1
    }

    local tbl14 = { TitleContainer = 0, Description = 0 }
    local element

    if var12 then
        element = React.createElement(View, {
            tag = { ["col auto-xy"] = true, ["gap-xsmall"] = false },
            LayoutOrder = 0
        }, {
            Title = if var12 then React.createElement(Text, { Text = escapeRichText(var12), RichText = true, tag = var5.title.tag, LayoutOrder = 0 }) else nil,
            Metadata = if var13 then React.createElement(Text, { Text = var13, RichText = true, tag = var5.metadata.tag, LayoutOrder = 1 }) else nil
        })
    else
        element = nil
    end

    tbl14.TitleContainer = element

    tbl14.Description = var1.description
        and React.createElement(Text, { Text = var1.description, RichText = true, tag = var5.description.tag, LayoutOrder = 1 })
    tbl12.TextContainer = createElement6(var22, tbl13, tbl14)

    tbl12.TrailingContainer = if var1.trailing then React.createElement(View, { tag = "align-x-center align-y-center auto-xy", LayoutOrder = 2 }, var1.trailing) else nil
    local var23

    if bool2 then
        local createElement7 = React.createElement
        local var24 = View
        local tbl15 = { tag = "align-x-center align-y-center auto-xy", LayoutOrder = 3 }

        local tbl16 = { ActivatedIcon = 0 }
        local element2

        if var10 == nil or Flags.FoundationListItemDecoupledInput and var10 == ListItemInputType.Chevron then
            element2 = React.createElement(Icon, {
                name = BuilderIcons.Icon.ChevronLargeRight,
                size = var5.icon.size,
                testId = `{var1.testId}--activated-icon`
            })
        elseif var10 == ListItemInputType.Radio then
            element2 = React.createElement(
                RadioGroup.Root,
                {
                    value = if var11 then "radio" else "",
                    onValueChanged = onValueChanged,
                    Selectable = false
                },
                React.createElement(RadioGroup.Item, { value = "radio", label = "", size = size })
            )
        else
            element2 = React.createElement(
                if var10 == ListItemInputType.Checkbox then Checkbox else Toggle,
                {
                    label = "",
                    onActivated = var3,
                    isChecked = var11,
                    size = size,
                    Selectable = false
                }
            )
        end

        tbl16.ActivatedIcon = element2
        var23 = createElement7(var24, tbl15, tbl16)
    else
        var23 = nil
    end

    tbl12.ActivatedIconContainer = var23
    tbl10.Content = createElement5(var21, tbl11, tbl12)
    tbl8.ListItem = createElement4(var20, tbl9, tbl10)
    tbl6.ListItemContainer = createElement3(var19, tbl7, tbl8)
    tbl4.HoverWrapper = createElement2(var18, tbl5, tbl6)
    local element2

    if var2.hasDivider and var1.LayoutOrder ~= var2.lastLayoutOrder then
        if var2.isInset then
            element2 = React.createElement(View, { tag = "row size-full-0 auto-y", LayoutOrder = 2 }, {
                LeadingSpacer = React.createElement(View, {
                    Size = UDim2.fromOffset(
                        (if var2.hasMargin then var4.Padding.Small + var4.Margin.Small else 0) + (if var1.leading then var6.container.Size.X.Offset + var4.Gap.Medium else 0),
                        0
                    ),
                    LayoutOrder = 0
                }),
                DividerLine = React.createElement(View, { tag = "fill auto-y", LayoutOrder = 1 }, React.createElement(Divider))
            })
        else
            element2 = React.createElement(Divider, { LayoutOrder = 2 })
        end
    else
        element2 = nil
    end

    tbl4.Divider = element2
    return createElement(var17, tbl3, tbl4)
end))
