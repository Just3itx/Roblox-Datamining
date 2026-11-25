-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local Foundation = require(SduiSharedContentParent.Foundation)
local _SduiCompat = require(SduiSharedContentParent.SduiCompat)

local View = Foundation.View
local FoundationText = Foundation.Text
local AvatarGroup = Foundation.AvatarGroup
local Icon = Foundation.Icon
local useTokens = Foundation.Hooks.useTokens

local var1 = React.memo(function(tbl1) -- name: AccessoryComponent
    local layoutOrder = tbl1.LayoutOrder

    if tbl1.accessory.type == "AvatarGroup" then
        local accessory = tbl1.accessory
        return React.createElement(AvatarGroup, {
            LayoutOrder = layoutOrder,
            avatars = accessory.avatars,
            type = accessory.groupType,
            max = accessory.max,
            backplateStyle = tbl1.accessory.backplateStyle,
            size = accessory.size,
            testId = `{tbl1.testIdPrefix}--{tbl1.position}-avatar-group`
        })
    end

    if tbl1.accessory.type ~= "Icon" then
        return nil
    end

    local accessory = tbl1.accessory
    return React.createElement(Icon, {
        LayoutOrder = layoutOrder,
        name = accessory.name,
        variant = accessory.variant,
        size = accessory.size,
        style = accessory.style,
        testId = `{tbl1.testIdPrefix}--{tbl1.position}-icon`
    })
end)

return React.memo(function(tbl1) -- name: SduiTextAccessoryRow
    local layoutOrder = tbl1.layoutOrder
    local anchorPoint = tbl1.anchorPoint
    local size = tbl1.size
    local position = tbl1.position

    local var2 = useTokens()

    local textStyle = tbl1.textStyle or var2.Color.Content.Emphasis
    local var4 = if tbl1.fontStyle then nil else "text-caption-large"

    local num1 = if tbl1.leading then 2 else 1
    local num2 = if tbl1.leading then 3 else 2

    local testId = tbl1.testId or "--sdui-text-accessory-row"

    local tag = React.useMemo(function()
        return {
            ["row align-y-center auto-xy"] = true,
            ["gap-small"] = not tbl1.gap
        }
    end, { tbl1.gap })

    local createElement = React.createElement
    local var6 = View
    local tbl2 = {
        tag = tag,
        LayoutOrder = layoutOrder,
        AnchorPoint = anchorPoint,
        Size = size,
        Position = position,
        onActivated = tbl1.onActivated,
        testId = testId,
        stateLayer = {
            affordance = Foundation.Enums.StateLayerAffordance.None
        }
    }
    local tbl3 = { ListLayout = 0, LeadingAccessory = 0, TextElement = 0, TrailingAccessory = 0 }
    local element

    if tbl1.gap then
        element = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, tbl1.gap)
        })
    else
        element = nil
    end

    tbl3.ListLayout = element

    tbl3.LeadingAccessory = if tbl1.leading then React.createElement(var1, { accessory = tbl1.leading, LayoutOrder = 1, testIdPrefix = testId, position = "leading" }) else nil

    tbl3.TextElement = if tbl1.text then React.createElement(FoundationText, {
        Text = tbl1.text,
        textStyle = textStyle,
        fontStyle = tbl1.fontStyle,
        tag = `auto-xy {var4 or ""}`,
        LayoutOrder = num1,
        testId = `{testId}--text`,
        RichText = true
    }) else nil

    tbl3.TrailingAccessory = if tbl1.trailing then React.createElement(
        var1,
        {
            accessory = tbl1.trailing,
            LayoutOrder = num2,
            testIdPrefix = testId,
            position = "trailing"
        }
    ) else nil
    return createElement(var6, tbl2, tbl3)
end)
