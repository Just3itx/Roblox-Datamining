-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:20:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local AppFonts = require(AuthCommonParent.Style).AppFonts

local Roact = require(AuthCommonParent.Roact)
local ImageSetLabel = require(AuthCommonParent.UIBlox).Core.ImageSet.ImageSetLabel
local GetImageData = require(AuthCommonParent.RobloxAppAssets).GetImageData

local var1 = Roact.PureComponent:extend("LoginSearchBar")

function var1.init(arg1)
    arg1.state = { longText = false }

    arg1.lastInput = 0
    function arg1.searchTextChanged(arg2)
        local longText = arg2.TextBounds.X > arg2.AbsoluteSize.X
        if longText ~= arg1.state.longText then
            arg2.TextXAlignment = longText and Enum.TextXAlignment.Right or Enum.TextXAlignment.Left
            spawn(function()
                arg1:setState({ longText = longText })
            end)
        end

        if not arg1.props.TextChanged then
            return
        end

        arg1.lastInput += 1
        local lastInput = arg1.lastInput
        wait(0.3)
        if lastInput == arg1.lastInput then
            arg1.props.TextChanged(arg2)
        end
    end
end

function var1.render(arg1)
    local offset = arg1.props.Size.Y.Offset
    local iconSize = arg1.props.IconSize
    local textSize = arg1.props.TextSize
    local placeholderText = arg1.props.PlaceholderText
    local placeholderColor3 = arg1.props.PlaceholderColor3
    local propsText = arg1.props.Text
    local textColor3 = arg1.props.TextColor3

    local createElement = Roact.createElement
    local var2 = ImageSetLabel
    local tbl1 = {
        Size = arg1.props.Size,
        Position = arg1.props.Position,
        BackgroundTransparency = 1,
        Image = GetImageData("LuaApp/buttons/buttonFill") or "LuaApp/buttons/buttonFill",
        ImageColor3 = arg1.props.ImageColor3,
        BorderSizePixel = 0,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(8, 8, 9, 9)
    }
    local tbl2 = {
        SearchIcon = Roact.createElement(ImageSetLabel, {
            Size = UDim2.new(0, iconSize, 0, iconSize),
            Position = UDim2.new(0, offset * 0.5, 0, offset * 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Image = GetImageData("LuaApp/icons/ic-search-new") or "LuaApp/icons/ic-search-new",
            BackgroundTransparency = 1,
            ImageColor3 = textColor3
        }),
        SearchInput = Roact.createElement("TextBox", {
            Size = UDim2.new(1, -offset - 10, 1, 0),
            Position = UDim2.new(0, offset, 0, 0),
            TextSize = textSize,
            TextColor3 = textColor3,
            PlaceholderText = placeholderText,
            PlaceholderColor3 = placeholderColor3,
            Font = AppFonts.default:getDefault(),
            TextXAlignment = arg1.state.longText and Enum.TextXAlignment.Right or Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            Text = propsText,
            ClearTextOnFocus = false,
            ClipsDescendants = true,
            [Roact.Change.Text] = arg1.searchTextChanged
        })
    }
    return createElement(var2, tbl1, tbl2)
end

return var1
