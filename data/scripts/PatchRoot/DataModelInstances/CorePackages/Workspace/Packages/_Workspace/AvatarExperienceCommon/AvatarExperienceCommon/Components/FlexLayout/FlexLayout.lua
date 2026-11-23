-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent
local React = require(AvatarExperienceCommonParent.React)

local Dash = require(AvatarExperienceCommonParent.Dash)
local useDesignTokens = require(AvatarExperienceCommonParent.Style).useDesignTokens

local function FlexLayout(tbl1)
    local var1 = useDesignTokens()

    local offset = if tbl1.flexSlot and tbl1.rigidSlot then tbl1.margin or var1.Size.Size_400 else 0
    local fillDirection = tbl1.flexDirection or Enum.FillDirection.Horizontal
    local reverse = tbl1.reverse or false

    local var3, var4 = React.useBinding(Vector2.new(0, 0))
    local var5 = React.useCallback(function(vector2: Vector2): UDim2
        if fillDirection == Enum.FillDirection.Horizontal then
            return UDim2.new(1, -(vector2.X + offset), 1, 0)
        end
        return UDim2.new(1, 0, 1, -(vector2.Y + offset))
    end, { fillDirection, offset })

    local var6 = table.clone(tbl1)

    var6.flexDirection = nil
    var6.reverse = nil
    var6.rigidSlot = nil
    var6.flexSlot = nil
    var6.margin = nil
    var6.padding = nil

    local createElement = React.createElement
    local str1 = "Frame"
    local var7 = Dash.join({
        Size = if fillDirection == Enum.FillDirection.Horizontal then UDim2.fromScale(1, 0) else UDim2.fromScale(0, 1),
        AutomaticSize = if fillDirection == Enum.FillDirection.Horizontal then Enum.AutomaticSize.Y else Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    }, var6)

    local tbl2 = {
        UILayout = React.createElement(
            "UIListLayout",
            {
                FillDirection = fillDirection,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, offset)
            }
        ),
        Padding = 0,
        Flex = 0,
        Rigid = 0
    }
    local element

    if tbl1.padding then
        element = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, tbl1.padding.top or 0),
            PaddingRight = UDim.new(0, tbl1.padding.right or 0),
            PaddingBottom = UDim.new(0, tbl1.padding.bottom or 0),
            PaddingLeft = UDim.new(0, tbl1.padding.left or 0)
        })
    else
        element = nil
    end

    tbl2.Padding = element

    tbl2.Flex = if tbl1.flexSlot then React.createElement(
        "Frame",
        {
            LayoutOrder = if reverse then 1 else 0,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = var3:map(var5)
        },
        tbl1.flexSlot
    ) else nil
    local var8

    if tbl1.rigidSlot then
        local createElement2 = React.createElement
        local str2 = "Frame"
        local tbl3 = {
            LayoutOrder = if reverse then 0 else 1,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = if fillDirection == Enum.FillDirection.Horizontal then UDim2.new(0, 0, 1, 0) else UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.XY
        }

        tbl3[React.Change.AbsoluteSize] = function(arg1)
            var4(arg1.AbsoluteSize)
        end

        var8 = createElement2(str2, tbl3, tbl1.rigidSlot)
    else
        var8 = nil
    end

    tbl2.Rigid = var8
    return createElement(str1, var7, tbl2)
end

return FlexLayout
