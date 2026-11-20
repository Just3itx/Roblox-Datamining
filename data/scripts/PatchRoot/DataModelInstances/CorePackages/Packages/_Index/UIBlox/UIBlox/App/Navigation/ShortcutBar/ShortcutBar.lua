-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local scriptParentParent = script.Parent.Parent
local scriptParentParentParentParent = scriptParentParent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local UIBloxConfig = require(scriptParentParentParentParent.UIBloxConfig)

local React = require(scriptParentParentParentParentParent.React)
local ReactOtter = require(scriptParentParentParentParentParent.ReactOtter)
local Foundation = require(scriptParentParentParentParentParent.Foundation)

local ReactUtils = require(scriptParentParentParentParentParent.ReactUtils)
local useDelayedActionHandler = ReactUtils.useDelayedActionHandler
local useEventConnection = ReactUtils.useEventConnection

local Object = require(scriptParentParentParentParentParent.LuauPolyfill).Object
local useStyle = require(scriptParentParentParentParent.Core.Style.useStyle)

local _Types = require(script.Parent.Types)
local Shortcut = require(script.Parent.Shortcut)

local useInputType = require(scriptParentParentParentParent.Utility.useInputType)
local Utilities = require(scriptParentParent.Utilities)
local _InputType = require(scriptParentParentParentParent.Enums.InputType)

local tbl1 = { dampingRatio = 2, frequency = 3 }

local tbl2 = {
    items = {},
    spacingTop = 12,
    spacingTrailing = 30,
    spacingBottom = 12,
    spacingLeading = 18,
    itemsGap = 24,
    itemIconLabelGap = 6,
    actionTextSpacingLeading = 12
}

local function ShortcutBar(tbl3)
    local var1 = Object.assign({}, tbl2, tbl3)
    local var2 = useStyle()

    local var3 = Foundation.Hooks.useTokens()
    local var4, var5, var6, var7, var8, var9, var10

    if UIBloxConfig.useTokenizedShortcutBar then
        var4 = tbl3.spacingTop or var3.Padding.Small
        var5 = tbl3.spacingTrailing or var3.Padding.XLarge
        var6 = tbl3.spacingBottom or var3.Padding.Small
        var7 = tbl3.spacingLeading or var3.Padding.Medium
        var8 = tbl3.itemsGap or var3.Gap.Large
        var9 = tbl3.itemIconLabelGap or var3.Gap.XSmall
        var10 = tbl3.actionTextSpacingLeading or var3.Padding.Small
    else
        var4 = nil
        var5 = nil
        var6 = nil
        var7 = nil
        var8 = nil
        var9 = nil
        var10 = nil
    end

    local tbl4 = {
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0.5, 0) }),
        Padding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, var4 or var1.spacingTop),
            PaddingRight = UDim.new(0, var5 or var1.spacingTrailing),
            PaddingBottom = UDim.new(0, var6 or var1.spacingBottom),
            PaddingLeft = UDim.new(0, var7 or var1.spacingLeading)
        }),
        ListLayout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, var8 or var1.itemsGap)
        })
    }

    local var11 = useInputType()

    local var12, var13 = ReactOtter.useAnimatedBinding(0)

    local var14 = useDelayedActionHandler(if var1.transitionDelaySeconds then var1.transitionDelaySeconds else 0, 0.1, function()
        var13(ReactOtter.spring(0, tbl1))
    end)

    local function onInputChanged()
        if var1.transitionDelaySeconds then
            var13(ReactOtter.spring(1, tbl1))
            var14()
        end
    end

    local var15, var16 = React.useState(Utilities.filterItems(var1.items, var11))

    useEventConnection(UserInputService.InputChanged, onInputChanged)
    React.useEffect(function()
        var16(Utilities.filterItems(var1.items, var11))
    end, { var11, var1.items })

    for index, publicProps in ipairs(var15) do
        local str1 = "Item" .. tostring(index)
        tbl4[str1] = React.createElement(Shortcut, {
            index = index,
            iconLabelGap = var9 or var1.itemIconLabelGap,
            actionTextSpacingLeading = var10 or var1.actionTextSpacingLeading,
            publicProps = publicProps
        })
    end

    if not (#var15 > 0) then
        return nil
    end

    local overMedia0 = var2.Tokens.Color.OverMedia.OverMedia_0
    return React.createElement("CanvasGroup", {
        Position = var1.position,
        AnchorPoint = var1.anchorPoint,
        BackgroundTransparency = 1,
        GroupTransparency = if var1.transitionDelaySeconds then var12 else 0,
        AutomaticSize = Enum.AutomaticSize.XY
    }, {
        ShortcutBarComponent = React.createElement("Frame", {
            Size = UDim2.fromOffset(0, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = overMedia0.Color3,
            BackgroundTransparency = overMedia0.Transparency,
            AutomaticSize = Enum.AutomaticSize.XY
        }, tbl4)
    })
end

return ShortcutBar
