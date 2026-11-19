-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local ScrollingTextBox = require(script.Parent.ScrollingTextBox)

local Constants = require(script.Parent.Parent.Constants)

local var1 = Roact.Component:extend("SearchBar")

function var1.render(arg1)
    local size = arg1.props.size
    local pos = arg1.props.pos
    local frameHeight = arg1.props.frameHeight

    local textSize = arg1.props.textSize
    local font = arg1.props.font
    local searchTerm = arg1.props.searchTerm
    local layoutOrder = arg1.props.layoutOrder

    local visible = arg1.props.visible
    local showClear = arg1.props.showClear

    local var2 = frameHeight * 0.6

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl1 = {
        Size = size,
        Position = pos,
        BackgroundColor3 = Constants.Color.UnselectedGray,
        BorderColor3 = Constants.Color.BorderGray,
        Visible = visible,
        LayoutOrder = layoutOrder
    }
    local tbl2 = {
        SearchImage = Roact.createElement("ImageLabel", {
            Name = "SearchIcon",
            Size = UDim2.new(0, var2, 0, var2),
            Position = UDim2.new(0, 10, 0.5, -var2 / 2),
            BackgroundTransparency = 1,
            Image = Constants.Image.Search
        }),
        ClearButton = 0,
        InputField = 0
    }

    showClear = showClear
        and Roact.createElement("ImageButton", {
            Size = UDim2.new(0, -var2, 0, var2),
            Position = UDim2.new(1, -10, 0.5, -var2 / 2),
            BackgroundTransparency = 1,
            Image = Constants.Image.Clear,
            [Roact.Event.InputEnded] = arg1.props.cancelInput
        })
    tbl2.ClearButton = showClear

    tbl2.InputField = Roact.createElement(ScrollingTextBox, {
        Text = searchTerm and searchTerm or "",
        TextSize = textSize,
        Font = font,
        Size = UDim2.new(1, -(2 * frameHeight), 1, 0),
        Position = UDim2.new(0, 20 + var2, 0, 0),
        ShowNativeInput = true,
        TextColor3 = Constants.Color.Text,
        BackgroundTransparency = 1,
        TextXAlignment = 0,
        ClearTextOnFocus = false,
        PlaceholderText = "Search",
        [Roact.Ref] = arg1.props.refForParent,
        TextBoxFocusLost = arg1.props.focusLost
    })
    return createElement(str1, tbl1, tbl2)
end

return var1
