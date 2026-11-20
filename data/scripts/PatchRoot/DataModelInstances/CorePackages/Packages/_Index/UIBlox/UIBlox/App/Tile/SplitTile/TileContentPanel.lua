-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local Core = scriptParentParentParentParent.Core
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local normalizeFontFace = require(scriptParentParentParentParentParent.Foundation).Utility.normalizeFontFace

local React = require(scriptParentParentParentParentParent.React)
local useStyle = require(Core.Style.useStyle)
local useTextSizeOffset = require(scriptParentParentParentParent.Core.Style.useTextSizeOffset)

local _Fonts = require(scriptParentParentParentParent.App.Style.Fonts)
local _StyleTypes = require(scriptParentParentParentParent.App.Style.StyleTypes)
local setDefault = require(scriptParentParentParentParent.Utility.setDefault)

local function TileContentPanel(tbl1)
    local var1 = useStyle()
    local settings = var1.Settings
    local var2 = useTextSizeOffset()

    local num1 = if settings.ReducedMotion then 6 else 8
    local contentTitle = tbl1.contentTitle
    local contentFooter = tbl1.contentFooter
    local var3 = setDefault(tbl1.textLineCount, 2)
    local var4 = setDefault(tbl1.hasSidePadding, true)
    local offset, offset2, offset3, offset4

    if tbl1.outerPadding == nil or type(tbl1.outerPadding) == "number" then
        offset = setDefault(tbl1.outerPadding, num1)
        offset2 = offset
        offset3 = offset2
        offset4 = offset3
    else
        offset = setDefault(tbl1.outerPadding.Left, num1)
        offset4 = setDefault(tbl1.outerPadding.Right, num1)
        offset3 = setDefault(tbl1.outerPadding.Top, num1)
        offset2 = setDefault(tbl1.outerPadding.Bottom, num1)
    end
    local offset5 = setDefault(tbl1.titlePadding, num1)
    local panelHeight = tbl1.panelHeight
    local footerHeight = tbl1.footerHeight

    local font = var1.Font
    local var5 = setDefault(tbl1.titleFont, font.Header2)
    local theme = var1.Theme

    local y = (font.BaseSize + var2) * var5.RelativeSize * var3

    local textEmphasis = theme.TextEmphasis

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(UDim.new(1, 0), panelHeight),
        BackgroundTransparency = 1
    }
    local tbl3 = {
        UIListLayout = React.createElement(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, offset5)
            }
        ),
        Padding = React.createElement("UIPadding", {
            PaddingLeft = if var4 then UDim.new(0, offset) else nil,
            PaddingRight = if var4 then UDim.new(0, offset4) else nil,
            PaddingTop = UDim.new(0, offset3),
            PaddingBottom = UDim.new(0, offset2)
        }),
        TitleText = 0,
        ContentFooter = 0
    }
    local element

    if var3 > 0 and contentTitle and string.len(contentTitle) > 0 then
        element = React.createElement(
            "TextLabel",
            {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Text = contentTitle,
                FontFace = normalizeFontFace(var5.Font),
                TextSize = font.BaseSize * var5.RelativeSize,
                TextTransparency = textEmphasis.Transparency,
                TextColor3 = textEmphasis.Color,
                TextWrapped = true,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                LayoutOrder = 1
            },
            {
                UISizeConstraint = React.createElement("UISizeConstraint", { MaxSize = Vector2.new(math.huge, y) })
            }
        )
    else
        element = nil
    end

    tbl3.TitleText = element

    tbl3.ContentFooter = if contentFooter then React.createElement(
        "Frame",
        {
            Size = UDim2.new(UDim.new(1, 0), footerHeight),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            LayoutOrder = 2
        },
        { contentFooter }
    ) else nil
    return createElement(str1, tbl2, tbl3)
end

return TileContentPanel
