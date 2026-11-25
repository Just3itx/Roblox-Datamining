-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContent = script:FindFirstAncestor("SduiSharedContent")
local SduiSharedContentParent = SduiSharedContent.Parent

local React = require(SduiSharedContentParent.React)
local Foundation = require(SduiSharedContentParent.Foundation)
local View = Foundation.View
local Divider = Foundation.Divider
local EnumsOrientation = Foundation.Enums.Orientation
local _SduiCompat = require(SduiSharedContentParent.SduiCompat)
local _SduiCoreSystem = require(SduiSharedContentParent.SduiCoreSystem)
local useScrollAwayHeaderPosition = require(SduiSharedContentParent.SduiSharedUtilities).useScrollAwayHeaderPosition

local buildSduiFeedChildren = require(SduiSharedContent.Components.buildSduiFeedChildren)

local function buildWrappedItems(tbl1)
    return buildSduiFeedChildren({
        configs = tbl1.stickyItems,
        sduiContext = tbl1.sduiContext,
        debugName = tbl1.debugName or "StickyHeader",
        componentType = "StickyHeader",
        extraLocalProps = tbl1.extraLocalProps,
        impressionsTag = tbl1.impressionsTag,
        negateImpressionIndex = true,
        selectionBehaviorLeft = tbl1.selectionBehaviorLeft,
        selectionBehaviorRight = tbl1.selectionBehaviorRight
    })
end

return React.memo(function(tbl1) -- name: SduiStickyHeader
    local wrappedItems = buildWrappedItems(tbl1)

    local var1, var2 = React.useBinding(UDim2.new(1, 0, 0, 0))
    local scrollAway = tbl1.sduiContext.scrollAway
    local scrollAwayHeight = if scrollAway then scrollAway.scrollAwayHeight else nil
    local var3 = useScrollAwayHeaderPosition({
        enabled = scrollAway ~= nil,
        scrollAwayHeight = scrollAwayHeight,
        headerHeightBinding = if scrollAway then scrollAway.headerHeightBinding else nil
    })
    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var2(UDim2.new(1, 0, 0, arg1.AbsoluteSize.Y))
    end, {})

    local num1 = if scrollAwayHeight then math.max(0, scrollAwayHeight) else 0
    local var5 = React.useMemo(function()
        return var1:map(function(uDim2: UDim2): UDim2
            return UDim2.new(1, 0, 0, uDim2.Y.Offset + num1)
        end)
    end, { var1, num1 })

    if next(wrappedItems) == nil then
        return nil
    end

    local backgroundStyle = tbl1.backgroundStyle
    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = var1,
        LayoutOrder = tbl1.layoutOrder or 1,
        ZIndex = tbl1.zIndex or 1,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = false
    }

    local tbl3 = { Translation = 0 }
    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl4 = {
        Size = var1,
        Position = var3,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = false
    }

    local tbl5 = {
        Background = React.createElement("Frame", {
            AnchorPoint = Vector2.new(0, 1),
            Position = UDim2.new(0, 0, 1, 0),
            Size = var5,
            BackgroundColor3 = if backgroundStyle then backgroundStyle.Color3 else nil,
            BackgroundTransparency = if not backgroundStyle or backgroundStyle.Transparency == nil then 0 else backgroundStyle.Transparency,
            BorderSizePixel = 0,
            ZIndex = 0
        }),
        Content = React.createElement(View, {
            tag = tbl1.contentTag,
            Size = UDim2.fromScale(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            onAbsoluteSizeChanged = onAbsoluteSizeChanged,
            layout = {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        }, {
            TopSpacer = if tbl1.paddingTop and tbl1.paddingTop > 0 then React.createElement(
                "Frame",
                {
                    Size = UDim2.new(1, 0, 0, tbl1.paddingTop),
                    BackgroundTransparency = 1,
                    LayoutOrder = 1
                }
            ) else nil,
            StickyContent = React.createElement(View, {
                tag = "size-full-0 auto-y",
                LayoutOrder = 2,
                layout = {
                    FillDirection = Enum.FillDirection.Vertical,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, tbl1.gapBetweenItems)
                }
            }, wrappedItems),
            BottomSpacer = if tbl1.paddingBottom and tbl1.paddingBottom > 0 then React.createElement(
                "Frame",
                {
                    Size = UDim2.new(1, 0, 0, tbl1.paddingBottom),
                    BackgroundTransparency = 1,
                    LayoutOrder = 3
                }
            ) else nil,
            StickyDivider = React.createElement(Divider, { orientation = EnumsOrientation.Horizontal, LayoutOrder = 4 })
        })
    }
    tbl3.Translation = createElement2(str2, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end)
