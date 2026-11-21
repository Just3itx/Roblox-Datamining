-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameFiltersParent = script:FindFirstAncestor("GameFilters").Parent
local _DiscoveryTypes = require(GameFiltersParent.DiscoveryTypes)
local Foundation = require(GameFiltersParent.Foundation)
local RadioGroup = Foundation.RadioGroup
local View = Foundation.View
local Badge = Foundation.Badge
local FoundationText = Foundation.Text
local React = require(GameFiltersParent.React)

local FFlagLuaAppChartsFilterOptionTextTag = require(GameFiltersParent.SharedFlags).FFlagLuaAppChartsFilterOptionTextTag

local useTokens = Foundation.Hooks.useTokens

return function(tbl1)
    local var1 = useTokens()

    local xxLarge = var1.Padding.XXLarge

    local tbl2 = {
        Padding = React.createElement(
            "UIPadding",
            {
                PaddingTop = UDim.new(0, var1.Padding.Medium),
                PaddingBottom = UDim.new(0, var1.Padding.Medium)
            }
        ),
        SizeConstraint = if FFlagLuaAppChartsFilterOptionTextTag then nil else React.createElement("UISizeConstraint", {
            MaxSize = tbl1.containerMaxWidthBinding:map(function(num1: number): Vector2
                return Vector2.new(num1 - 3 * xxLarge, math.huge)
            end)
        }),
        Layout = if FFlagLuaAppChartsFilterOptionTextTag then React.createElement(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalFlex = Enum.UIFlexAlignment.Fill
            }
        ) else nil
    }

    for layoutOrder, option in tbl1.options do
        local bool1 = if FFlagLuaAppChartsFilterOptionTextTag then not (option.optionContextTag == nil) and option.optionContextTag ~= "" else nil
        local element

        if FFlagLuaAppChartsFilterOptionTextTag then
            local createElement = React.createElement
            local item = RadioGroup.Item
            local tbl3 = {
                value = option.optionId,
                LayoutOrder = layoutOrder,
                label = 0
            }
            local createElement2 = React.createElement
            local var2 = View
            local tbl4 = { tag = "size-0 auto-xy row gap-medium flex-between align-y-center fill" }

            local tbl5 = { OptionItem = 0, ContextTag = 0 }
            local createElement3 = React.createElement
            local var3 = FoundationText
            local tbl6 = {
                tag = {
                    ["auto-xy content-default gui-object-defaults size-0 text-color-defaults text-defaults text-size-defaults text-title-medium text-truncate-split text-align-x-left text-align-y-center shrink"] = true,
                    ["text-wrap"] = true
                },
                LayoutOrder = 1,
                Text = option.optionDisplayName,
                textStyle = if tbl1.selectedOptionId == option.optionId then var1.Color.Content.Emphasis else var1.Color.Content.Default
            }

            local tbl7 = {
                SizeConstraint = React.createElement("UISizeConstraint", { MaxSize = Vector2.new(var1.Size.Size_3000 * 3, math.huge) })
            }
            tbl5.OptionItem = createElement3(var3, tbl6, tbl7)
            local var4

            if bool1 then
                local createElement4 = React.createElement
                local var5 = View

                local tbl8 = {
                    Badge = React.createElement(Badge, { variant = Foundation.Enums.BadgeVariant.Neutral, text = option.optionContextTag }),
                    SizeConstraint = React.createElement("UISizeConstraint", { MaxSize = Vector2.new(var1.Size.Size_3000, math.huge) })
                }
                var4 = createElement4(var5, { tag = "auto-xy size-0", LayoutOrder = 2 }, tbl8) or nil
            else
                var4 = nil
            end

            tbl5.ContextTag = var4
            tbl3.label = createElement2(var2, tbl4, tbl5)
            element = createElement(item, tbl3)
        else
            element = React.createElement(RadioGroup.Item, { value = option.optionId, label = option.optionDisplayName })
        end

        table.insert(tbl2, element)
    end

    if FFlagLuaAppChartsFilterOptionTextTag then
        local createElement = React.createElement
        local tbl3 = {
            LayoutOrder = tbl1.LayoutOrder,
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.X,
            Size = tbl1.Size
        }
        local tbl4 = {
            Padding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, xxLarge), PaddingRight = UDim.new(0, xxLarge) }),
            ScrollingFrame = React.createElement("ScrollingFrame", {
                AutomaticCanvasSize = Enum.AutomaticSize.XY,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                CanvasSize = UDim2.fromScale(0, 0),
                ClipsDescendants = true,
                ElasticBehavior = Enum.ElasticBehavior.Always,
                ScrollBarThickness = 0,
                ScrollingDirection = Enum.ScrollingDirection.Y,
                Selectable = false,
                AutomaticSize = Enum.AutomaticSize.X,
                Size = UDim2.fromScale(1, 1),
                [React.Change.AbsoluteCanvasSize] = tbl1.onCanvasSizeChanged
            }, {
                RadioGroup = React.createElement(
                    RadioGroup.Root,
                    {
                        value = tbl1.selectedOptionId,
                        onValueChanged = tbl1.onSelectedOptionChanged
                    },
                    tbl2
                ),
                Layout = React.createElement(
                    "UIListLayout",
                    {
                        FillDirection = Enum.FillDirection.Vertical,
                        HorizontalFlex = Enum.UIFlexAlignment.Fill
                    }
                )
            })
        }
        return createElement("Frame", tbl3, tbl4)
    end

    local createElement = React.createElement
    local tbl3 = {
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        CanvasSize = UDim2.fromScale(1, 0),
        ClipsDescendants = true,
        ElasticBehavior = Enum.ElasticBehavior.Always,
        LayoutOrder = tbl1.LayoutOrder,
        ScrollBarThickness = 0,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        Selectable = false,
        Size = tbl1.Size
    }
    local tbl4 = { MenuFrame = 0 }
    local createElement2 = React.createElement
    local tbl5 = {
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.XY
    }

    tbl5[React.Change.AbsoluteSize] = function(arg1)
        tbl1.onCanvasSizeChanged(arg1.AbsoluteSize)
    end

    tbl4.MenuFrame = createElement2("Frame", tbl5, {
        Padding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, xxLarge), PaddingRight = UDim.new(0, xxLarge) }),
        RadioGroup = React.createElement(
            RadioGroup.Root,
            {
                value = tbl1.selectedOptionId,
                onValueChanged = tbl1.onSelectedOptionChanged
            },
            tbl2
        )
    })
    return createElement("ScrollingFrame", tbl3, tbl4)
end
