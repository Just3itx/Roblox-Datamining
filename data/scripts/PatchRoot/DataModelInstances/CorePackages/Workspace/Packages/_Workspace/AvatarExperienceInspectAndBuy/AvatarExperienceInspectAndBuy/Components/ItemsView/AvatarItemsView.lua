-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local React = require(AvatarExperienceInspectAndBuyParent.React)
local Foundation = require(AvatarExperienceInspectAndBuyParent.Foundation)
local Skeleton = Foundation.Skeleton
local useTokens = Foundation.Hooks.useTokens
local ViewType = require(AvatarExperienceInspectAndBuy.Enums.ViewType)
local _Types = require(AvatarExperienceInspectAndBuy.Types)
local ItemCardRowContainer = require(AvatarExperienceInspectAndBuy.Components.ItemsView.ItemCardRowContainer)

local function func1(view, arg1)
    if view == ViewType.WideLandscape then
        return {
            left = UDim.new(0, arg1.Padding.XLarge),
            right = UDim.new(0, arg1.Padding.XLarge),
            bottom = UDim.new(0, arg1.Padding.Large)
        }
    end

    if view == ViewType.Compact then
        return {
            left = UDim.new(0, arg1.Padding.Large),
            right = UDim.new(0, arg1.Padding.Large),
            bottom = UDim.new(0, arg1.Padding.Large)
        }
    end

    return {
        top = UDim.new(0, arg1.Padding.Medium),
        left = UDim.new(0, arg1.Margin.Large * 2),
        right = UDim.new(0, arg1.Margin.Large * 2),
        bottom = UDim.new(0, arg1.Padding.Large)
    }
end

return (React.forwardRef(function(tbl1, ref)
    local var1 = useTokens()
    local headerHeightOffset = tbl1.headerHeightOffset or 0
    local actionBarHeightOffset = tbl1.actionBarHeightOffset or 0

    local itemCardWidth = React.useMemo(function()
        return if tbl1.view == ViewType.Wide then var1.Size.Size_2500 else var1.Size.Size_2000
    end, { tbl1.view, var1 })

    local var2 = React.useCallback(function()
        local var2 = func1(tbl1.view, var1)

        local tbl2 = {
            UIListLayout = React.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Vertical,
                Padding = UDim.new(0, var1.Padding.Large)
            }),
            UIPadding = React.createElement(
                "UIPadding",
                {
                    PaddingTop = var2.top,
                    PaddingLeft = var2.left,
                    PaddingRight = var2.right,
                    PaddingBottom = var2.bottom
                }
            )
        }
        if tbl1.items and #tbl1.items > 0 then
            for layoutOrder, item in tbl1.items do
                local var3 = "Item" .. layoutOrder
                tbl2[var3] = React.createElement(ItemCardRowContainer, {
                    item = item,
                    view = tbl1.view,
                    LayoutOrder = layoutOrder,
                    onItemCardActivated = tbl1.onItemCardActivated,
                    itemCardWidth = itemCardWidth
                })
            end

            return tbl2
        end

        for layoutOrder = 1, 5 do
            local str1 = "Skeleton" .. layoutOrder
            local createElement = React.createElement
            local tbl3 = {
                Size = UDim2.new(1, 0, 0, itemCardWidth),
                LayoutOrder = layoutOrder,
                BackgroundTransparency = 1
            }
            local tbl4 = {
                Skeleton = React.createElement(Skeleton, { Size = UDim2.new(1, 0, 1, 0) })
            }
            tbl2[str1] = createElement("Frame", tbl3, tbl4)
        end

        return tbl2
    end, {
        tbl1.items,
        tbl1.view,
        actionBarHeightOffset,
        var1
    })

    local var3 = React.useMemo(function(): UDim2
        if tbl1.view == ViewType.Compact then
            return UDim2.new(1, 0, 1, -headerHeightOffset - var1.Padding.Small - actionBarHeightOffset)
        end
        return UDim2.new(1, 0, 1, -headerHeightOffset - var1.Padding.Small)
    end, {
        tbl1.view,
        headerHeightOffset,
        var1,
        actionBarHeightOffset
    })
    return React.createElement("ScrollingFrame", {
        Size = var3,
        Position = UDim2.new(0, 0, 0, headerHeightOffset),
        CanvasSize = UDim2.new(1, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        ScrollBarThickness = 0,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = 2,
        ref = ref
    }, var2())
end))
