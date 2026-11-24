-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:21:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InGameAssetReportingParent = script:FindFirstAncestor("InGameAssetReporting").Parent

local React = require(InGameAssetReportingParent.React)
local UIBlox = require(InGameAssetReportingParent.UIBlox)
local normalizeFontFace = require(InGameAssetReportingParent.Foundation).Utility.normalizeFontFace

local useStyle = UIBlox.Core.Style.useStyle

local function ReportTextEntry(tbl1)
    local var1 = useStyle()
    local baseSize = var1.Font.BaseSize
    local theme = var1.Theme

    local createElement = React.createElement
    local tbl2 = {
        Size = UDim2.new(1, 0, 0, 60),
        BackgroundTransparency = var1.Theme.BackgroundDefault.Transparency,
        BackgroundColor3 = var1.Theme.BackgroundDefault.Color,
        LayoutOrder = 1
    }
    local tbl3 = {
        UIPadding = React.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, 10),
            PaddingRight = UDim.new(0, 10),
            PaddingTop = UDim.new(0, 10),
            PaddingBottom = UDim.new(0, 10)
        }),
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 8) }),
        ReportCommentTextBox = 0
    }
    local createElement2 = React.createElement
    local tbl4 = {
        Size = UDim2.new(1, 0, 0, 40),
        Position = UDim2.new(0, 0, 0, 0),
        AnchorPoint = Vector2.new(0, 0),
        BackgroundColor3 = theme.BackgroundDefault.Color,
        PlaceholderText = tbl1.placeholderText,
        FontFace = normalizeFontFace(var1.Tokens.Typography.BodyLarge.Font),
        Text = tbl1.text,
        TextSize = baseSize,
        TextColor3 = theme.TextDefault.Color,
        TextTransparency = theme.TextDefault.Transparency,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        BackgroundTransparency = theme.BackgroundDefault.Transparency,
        BorderSizePixel = 0,
        LayoutOrder = 1,
        RichText = false,
        MultiLine = true,
        TextWrapped = true,
        ClearTextOnFocus = false,
        OverlayNativeInput = true,
        ClipsDescendants = true
    }

    tbl4[React.Change.Text] = function(arg1)
        if tbl1.text ~= arg1.Text then
            tbl1.onUpdate(arg1.Text)
        end
    end

    tbl3.ReportCommentTextBox = createElement2("TextBox", tbl4)
    return createElement("Frame", tbl2, tbl3)
end

return ReportTextEntry
