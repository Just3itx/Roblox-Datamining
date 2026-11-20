-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local Object = require(scriptParentParentParentParentParent.LuauPolyfill).Object

local useStyle = require(scriptParentParentParentParent.Core.Style.useStyle)

local Constants = require(script.Parent.Constants)

local _Types = require(script.Parent.Types)

return function(arg1, tbl1)
    local var1 = useStyle()
    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = if arg1.size then arg1.size else UDim2.new(1, 0, 1, 0),
        AutomaticSize = arg1.automaticSize,
        BackgroundTransparency = 1,
        LayoutOrder = 1
    }

    local tbl3 = { RoundedBackgroundWithTopAlignedToContent = 0, Overlay = 0, Content = 0 }
    local element

    if arg1.showRoundedBackground then
        element = Roact.createElement(
            "Frame",
            {
                Size = arg1.roundedBackgroundSize or UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = arg1.roundedBackgroundTransparency or 1,
                BackgroundColor3 = arg1.roundedBackgroundColor or var1.Theme.BackgroundUIDefault.Color,
                Position = arg1.roundedBackgroundPosition or UDim2.fromOffset(0, 0),
                ZIndex = 1
            },
            {
                Corner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0.5, 0) })
            }
        )
    else
        element = nil
    end

    tbl3.RoundedBackgroundWithTopAlignedToContent = element
    local element2

    if arg1.showOverlay then
        element2 = Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundColor3 = var1.Theme.BackgroundUIDefault.Color,
                BackgroundTransparency = Constants.ICON_TAB_PRESSED_TRANSPARENCY,
                ZIndex = 3
            },
            {
                Corner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0.5, 0) })
            }
        )
    else
        element2 = nil
    end

    tbl3.Overlay = element2

    local createElement2 = Roact.createElement
    local str2 = "Frame"
    local tbl4 = {
        Size = if arg1.size then arg1.size else UDim2.new(1, 0, 1, 0),
        AutomaticSize = arg1.automaticSize,
        BackgroundTransparency = 1,
        LayoutOrder = 2,
        ZIndex = 2
    }

    local assign = Object.assign
    local tbl5 = {}
    local tbl6 = {
        Layout = Roact.createElement(
            "UIListLayout",
            Object.assign({}, {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, arg1.spacing or 0)
            })
        ),
        Padding = 0
    }
    local element3

    if arg1.padding then
        element3 = Roact.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, arg1.padding.left or 0),
            PaddingRight = UDim.new(0, arg1.padding.right or 0),
            PaddingTop = UDim.new(0, arg1.padding.top or 0),
            PaddingBottom = UDim.new(0, arg1.padding.bottom or 0)
        })
    else
        element3 = nil
    end

    tbl6.Padding = element3
    tbl3.Content = createElement2(str2, tbl4, assign(tbl5, tbl6, tbl1))
    return createElement(str1, tbl2, tbl3)
end
