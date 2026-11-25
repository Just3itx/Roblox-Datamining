-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:51:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local Foundation = require(SduiSharedContentParent.Foundation)
local Cryo = require(SduiSharedContentParent.Cryo)
local _SduiCompat = require(SduiSharedContentParent.SduiCompat)

local View = Foundation.View
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local useTokens = Foundation.Hooks.useTokens
local useCursor = Foundation.Hooks.useCursor
local withCommonProps = Foundation.Utility.withCommonProps

local IconSize = Foundation.Enums.IconSize
local StateLayerMode = Foundation.Enums.StateLayerMode
local CursorType = Foundation.Enums.CursorType

return React.memo(function(tbl1) -- name: SduiDualActionChip
    local layoutOrder = tbl1.layoutOrder
    local anchorPoint = tbl1.anchorPoint
    local position = tbl1.position

    local selectionImageObject = useCursor(CursorType.SmallPill)
    local var2 = useTokens()

    if not (tbl1.leadingIconName or tbl1.trailingIconName) then
        return React.createElement(React.Fragment, {}, {})
    end

    local onActivated = tbl1.leadingOnActivated or function() end
    local var1 = tbl1.trailingOnActivated or function() end

    local var5 = withCommonProps(tbl1, {
        selection = { Selectable = true, SelectionImageObject = selectionImageObject },
        stateLayer = {
            mode = StateLayerMode.Inverse
        },
        backgroundStyle = var2.Color.ActionStandard.Background,
        tag = "row size-0-800 auto-x radius-circle align-y-center"
    })

    local createElement = React.createElement
    local var6 = View
    local var7 = Cryo.Dictionary.join(var5, {
        LayoutOrder = layoutOrder,
        AnchorPoint = anchorPoint,
        Position = position,
        [React.Tag] = if tbl1.testId then `data-testid={tbl1.testId}` else nil
    })
    local tbl2 = { LeftActionButton = 0, Divider = 0, RightActionButton = 0 }
    local var8

    if tbl1.leadingIconName then
        local createElement2 = React.createElement
        local var9 = View
        local tbl3 = {
            LayoutOrder = 1,
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.XY,
            onActivated = onActivated
        }
        local tbl4 = {
            UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var2.Radius.Large) }),
            Content = React.createElement(View, {
                tag = "row fill auto-xy size-full-800 align-y-center padding-left-medium padding-right-small gap-small",
                [React.Tag] = if tbl1.testId then `data-testid={tbl1.testId}-leading` else nil
            }, {
                Icon = React.createElement(
                    Icon,
                    {
                        LayoutOrder = 1,
                        name = tbl1.leadingIconName,
                        variant = tbl1.leadingIconVariant,
                        size = IconSize.Small
                    }
                ),
                Text = if tbl1.text and tbl1.text ~= "" then React.createElement(FoundationText, {
                    LayoutOrder = 2,
                    Text = tbl1.text,
                    textStyle = var2.Color.ActionStandard.Foreground,
                    tag = "auto-x size-0-full shrink text-label-medium text-truncate-end"
                }) else nil
            })
        }
        var8 = createElement2(var9, tbl3, tbl4)
    else
        var8 = nil
    end

    tbl2.LeftActionButton = var8

    tbl2.Divider = if tbl1.leadingIconName and tbl1.trailingIconName then React.createElement(View, { LayoutOrder = 2, Size = UDim2.new(0, 1, 0, 16), tag = "bg-shift-200" }) else nil
    local var9

    if tbl1.trailingIconName then
        local createElement2 = React.createElement
        local var10 = View
        local tbl3 = {
            LayoutOrder = 4,
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.XY,
            onActivated = var1
        }
        local tbl4 = {
            UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var2.Radius.Circle) }),
            Content = React.createElement(View, {
                tag = "row fill auto-xy align-y-center align-x-center size-full-800 padding-right-medium padding-left-small",
                [React.Tag] = if tbl1.testId then `data-testid={tbl1.testId}-trailing` else nil
            }, {
                Icon = React.createElement(
                    Icon,
                    {
                        LayoutOrder = 1,
                        name = tbl1.trailingIconName,
                        variant = tbl1.trailingIconVariant,
                        size = IconSize.Small
                    }
                )
            })
        }
        var9 = createElement2(var10, tbl3, tbl4)
    else
        var9 = nil
    end

    tbl2.RightActionButton = var9
    return createElement(var6, var7, tbl2)
end)
