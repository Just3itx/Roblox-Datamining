-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:11:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local React = require(AuthCommonParent.React)
local UIBlox = require(AuthCommonParent.UIBlox)

local useDesignTokens = require(AuthCommonParent.Style).useDesignTokens

local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local useStyle = UIBlox.Core.Style.useStyle
local useSelectionCursor = UIBlox.App.SelectionImage.useSelectionCursor
local CursorKind = UIBlox.App.SelectionImage.CursorKind

local Images = UIBlox.App.ImageSet.Images

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local function func1(fillDirection, yOffset: number?, size300)
    if fillDirection == Enum.FillDirection.Horizontal then
        return {
            CellSize = UDim2.new(0.5, -size300, 0, yOffset)
        }
    end

    return {
        CellSize = UDim2.new(1, 0, 0, yOffset)
    }
end

local function func2(tbl1)
    local var1 = useStyle()
    local var2 = useDesignTokens()
    local selectionImageObject = useSelectionCursor(CursorKind.RoundedRect)

    local size1400 = var2.Size.Size_1400 or 80
    local size700 = var2.Size.Size_700 or 42

    return React.createElement("ImageButton", {
        AutoButtonColor = false,
        Size = UDim2.new(1, 0, 0, size1400),
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.layoutOrder,
        [React.Event.Activated] = tbl1.activated,
        SelectionImageObject = selectionImageObject
    }, {
        padding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, 36), PaddingRight = UDim.new(0, 36) }),
        ButtonText = React.createElement(StyledTextLabel, {
            text = tbl1.text,
            automaticSize = Enum.AutomaticSize.X,
            size = UDim2.new(1, 0, 0, size1400),
            textXAlignment = Enum.TextXAlignment.Left,
            fontStyle = var1.Font.Header1,
            colorStyle = var1.Theme.TextDefault,
            layoutOrder = 1
        }),
        LinkIconImage = React.createElement(ImageSetLabel, {
            Size = UDim2.new(0, size700, 0, size700),
            Position = UDim2.new(1, 0, 0.5, 0),
            AnchorPoint = Vector2.new(1, 0.5),
            BackgroundTransparency = 1,
            LayoutOrder = 2,
            ScaleType = Enum.ScaleType.Fit,
            Image = Images["icons/navigation/externallink_medium"],
            ImageColor3 = var1.Theme.UIEmphasis.Color,
            ImageTransparency = 0
        })
    })
end

return function(tbl1)
    local var1 = useDesignTokens()
    local size1400 = var1.Size.Size_1400 or 80
    local size300 = var1.Size.Size_300 or 18
    local fillDirection = tbl1.fillDirection or Enum.FillDirection.Vertical
    local tbl2 = func1(fillDirection, size1400, size300)
    return React.createElement("Frame", {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 0),
        Selectable = false,
        LayoutOrder = tbl1.layoutOrder
    }, {
        gridlayout = React.createElement("UIGridLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = fillDirection,
            CellPadding = UDim2.new(0, size300, 0, size300),
            CellSize = tbl2.CellSize
        }),
        ButtonTos = React.createElement(func2, { text = tbl1.textTos, activated = tbl1.activatedTos, layoutOrder = 1 }),
        ButtonPrivacy = React.createElement(func2, { text = tbl1.textPrivacy, activated = tbl1.activatedPrivacy, layoutOrder = 2 })
    })
end
