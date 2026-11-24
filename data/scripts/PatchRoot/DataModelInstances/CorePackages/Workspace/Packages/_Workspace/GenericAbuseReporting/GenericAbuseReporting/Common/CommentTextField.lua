-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local React = require(GenericAbuseReportingParent.React)
local UIBlox = require(GenericAbuseReportingParent.UIBlox)
local normalizeFontFace = require(GenericAbuseReportingParent.Foundation).Utility.normalizeFontFace
local useCursor = UIBlox.App.SelectionCursor.useCursor
local useStyle = UIBlox.Core.Style.useStyle

local function CommentTextField(tbl1)
    local var1, var2 = React.useState("")
    local selectionImageObject = useCursor()
    local var4 = useStyle()
    local baseSize = var4.Font.BaseSize
    local theme = var4.Theme

    local var5 = React.useCallback(function(arg1)
        local text = arg1.Text
        if arg1.TextFits then
            var2(text)
            tbl1.onUpdate(text)
            return
        end
        arg1.Text = var1
    end)

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(1, 0, 0, 60),
        BackgroundTransparency = if tbl1.backgroundTransparency ~= nil then tbl1.backgroundTransparency else var4.Theme.BackgroundDefault.Transparency,
        BackgroundColor3 = tbl1.backgroundColor3 or var4.Theme.BackgroundDefault.Color,
        LayoutOrder = tbl1.layoutOrder,
        AutomaticSize = Enum.AutomaticSize.Y
    }
    local tbl3 = {
        UIPadding = React.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, 10),
            PaddingRight = UDim.new(0, 10),
            PaddingTop = UDim.new(0, 10),
            PaddingBottom = UDim.new(0, 10)
        }),
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 8) }),
        CommentField = React.createElement("TextBox", {
            Size = UDim2.new(1, 0, 0, 40),
            AutomaticSize = Enum.AutomaticSize.Y,
            Position = UDim2.new(0, 0, 0, 0),
            AnchorPoint = Vector2.new(0, 0),
            BackgroundColor3 = tbl1.backgroundColor3 or theme.BackgroundDefault.Color,
            PlaceholderText = tbl1.placeholderText,
            FontFace = normalizeFontFace(var4.Tokens.Typography.BodyLarge.Font),
            SelectionImageObject = selectionImageObject,
            Text = tbl1.text,
            TextSize = baseSize,
            TextColor3 = theme.TextDefault.Color,
            TextTransparency = theme.TextDefault.Transparency,
            TextXAlignment = tbl1.textXAlignment or Enum.TextXAlignment.Left,
            TextYAlignment = tbl1.textYAlignment or Enum.TextYAlignment.Top,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            LayoutOrder = 1,
            RichText = false,
            MultiLine = true,
            TextWrapped = true,
            TextTruncate = Enum.TextTruncate.SplitWord,
            ClearTextOnFocus = false,
            OverlayNativeInput = true,
            ClipsDescendants = true,
            Interactable = tbl1.interactable,
            [React.Change.Text] = var5
        })
    }
    return createElement(str1, tbl2, tbl3)
end

return CommentTextField
