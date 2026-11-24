-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:20:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local React = require(scriptParentParentParentParent.React)
local Foundation = require(scriptParentParentParentParent.Foundation)
local TouchControlIcon = require(script.Parent.TouchControlIcon)
local _TouchControlList = require(script.Parent.TouchControlList)

return React.memo(function(tbl1) -- name: TouchDeviceMock
    local layout = tbl1.layout
    local var1 = Foundation.Hooks.useTokens()

    local var2 = var1.Gap.XXSmall / (if tbl1.scale > 0 then tbl1.scale else 1)
    local tbl2 = {}
    for i, slot in ipairs(tbl1.slots) do
        local var3 = layout.centerButtonPosition + layout.slotOffsets[i]
        local id = slot.id
        tbl2[id] = React.createElement(TouchControlIcon, {
            name = slot.icon,
            assetId = slot.assetId,
            diameter = layout.smallButtonSize,
            disabled = slot.disabled,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromOffset(var3.X, var3.Y),
            testId = "TouchMockIcon-" .. slot.id
        })
    end

    for i = 1, 3 do
        local str1 = "TopAction" .. i
        tbl2[str1] = React.createElement(TouchControlIcon, {
            name = Foundation.Enums.IconName.DiamondSimplified,
            diameter = layout.smallButtonSize,
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(1, -layout.sidePadding - (i - 1) * (layout.smallButtonSize + layout.topGap), 0, layout.topPadding),
            testId = "TouchMockTopAction-" .. i
        })
    end

    tbl2[tbl1.centerControl.id] = React.createElement(TouchControlIcon, {
        name = tbl1.centerControl.icon,
        assetId = tbl1.centerControl.assetId,
        diameter = layout.centerButtonSize,
        disabled = tbl1.centerControl.disabled,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromOffset(layout.centerButtonPosition.X, layout.centerButtonPosition.Y),
        testId = "TouchMock" .. tbl1.centerControl.id
    })
    tbl2.Roblox = React.createElement(TouchControlIcon, {
        name = Foundation.Enums.IconName.Tilt,
        diameter = layout.smallButtonSize,
        inverted = true,
        Position = UDim2.fromOffset(layout.sidePadding, layout.topPadding),
        testId = "TouchMockRoblox"
    })

    tbl2.InnerOutline = React.createElement(Foundation.View, {
        Position = UDim2.fromOffset(var2, var2),
        Size = UDim2.new(1, -2 * var2, 1, -2 * var2),
        cornerRadius = UDim.new(0, math.max(0, layout.cornerRadius - layout.inset + var2)),
        stroke = {
            Color = var1.Color.Extended.White.White_100.Color3,
            Transparency = var1.Color.Extended.White.White_100.Transparency,
            Thickness = 0.33
        },
        testId = "TouchMockInnerOutline"
    })

    local createElement = React.createElement
    local tbl3 = {
        Name = "TouchDeviceMock",
        Size = UDim2.fromOffset(layout.size.X, layout.size.Y),
        BackgroundTransparency = 1,
        GroupTransparency = 0,
        [React.Tag] = "data-testid=TouchDeviceMock"
    }
    local tbl4 = {
        Scale = React.createElement("UIScale", { Scale = tbl1.scale, [React.Tag] = "data-testid=TouchDeviceMockScale" }),
        Phone = React.createElement(Foundation.View, {
            Position = UDim2.fromOffset(layout.inset / 2, layout.inset / 2),
            Size = UDim2.new(1, -layout.inset, 1, -layout.inset),
            cornerRadius = UDim.new(0, layout.cornerRadius),
            stroke = {
                Color = var1.Color.Extended.White.White_100.Color3,
                Transparency = var1.Color.Extended.White.White_100.Transparency,
                Thickness = 0.75
            },
            testId = "TouchMockOuterOutline"
        }, tbl2)
    }
    return createElement("CanvasGroup", tbl3, tbl4)
end)
