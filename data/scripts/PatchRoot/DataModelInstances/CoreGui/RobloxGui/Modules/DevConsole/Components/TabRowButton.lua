-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:50:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local Constants = require(script.Parent.Parent.Constants)

local HighlightHeight = Constants.TabRowFormatting.HighlightHeight
local FrameHeight = Constants.TabRowFormatting.FrameHeight

local function TabRowButton(arg1)
    local index = arg1.index
    local name = arg1.name
    local textWidth = arg1.textWidth
    local padding = arg1.padding
    local isSelected = arg1.isSelected
    local layoutOrder = arg1.layoutOrder
    local onTabButtonClicked = arg1.onTabButtonClicked

    local xOffset = textWidth + padding
    local unselectedTextTransparency = Constants.TabRowFormatting.UnselectedTextTransparency
    if isSelected then
        unselectedTextTransparency = Constants.TabRowFormatting.SelectedTextTransparency
    end

    local createElement = Roact.createElement
    local tbl1 = {
        Text = name,
        TextSize = Constants.DefaultFontSize.TabBar,
        Font = Constants.Font.TabBar,
        TextScaled = false,
        TextTransparency = unselectedTextTransparency,
        Size = UDim2.new(0, xOffset, 0, FrameHeight),
        AutoButtonColor = false,
        TextColor3 = Constants.Color.Text,
        BackgroundColor3 = Constants.Color.UnselectedGray,
        BorderSizePixel = 0,
        LayoutOrder = layoutOrder
    }
    tbl1[Roact.Event.Activated] = function(_)
        onTabButtonClicked(index)
    end

    return createElement("TextButton", tbl1, {
        BlueHighlight = isSelected
            and Roact.createElement("Frame", {
                Size = UDim2.new(1, 0, 0, -HighlightHeight),
                Position = UDim2.new(0, 0, 1, 0),
                BorderSizePixel = 0,
                BackgroundColor3 = Constants.Color.HighlightBlue
            })
    })
end

return TabRowButton
