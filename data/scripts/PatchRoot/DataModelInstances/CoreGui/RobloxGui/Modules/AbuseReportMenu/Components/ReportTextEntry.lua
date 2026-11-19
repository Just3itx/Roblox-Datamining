-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)
local UIBlox = require(CorePackages.Packages.UIBlox)
local normalizeFontFace = require(CorePackages.Packages.Foundation).Utility.normalizeFontFace

local useStyle = UIBlox.Core.Style.useStyle

local function ReportTextEntry(tbl1)
    local var1 = useStyle()
    local fontSize400 = var1.Tokens.FontSize.FontSize_400
    local theme = var1.Theme

    local createElement = React.createElement
    local tbl2 = {
        Size = UDim2.new(1, 0, 0, 40 + var1.Tokens.Size.Size_600 + 20),
        BackgroundTransparency = var1.Theme.BackgroundDefault.Transparency,
        BackgroundColor3 = var1.Theme.BackgroundUIDefault.Color,
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
        AbuseReportsText = 0
    }
    local createElement2 = React.createElement
    local tbl4 = {
        Size = UDim2.new(1, 0, 0, 40 + var1.Tokens.Size.Size_600),
        AutomaticSize = Enum.AutomaticSize.Y,
        Position = UDim2.new(0, 0, 0, 0),
        AnchorPoint = Vector2.new(0, 0),
        BackgroundColor3 = theme.BackgroundUIDefault.Color,
        PlaceholderText = tbl1.placeholderText,
        FontFace = normalizeFontFace(var1.Tokens.Typography.BodyLarge.Font),
        Text = tbl1.text,
        TextSize = fontSize400,
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
        OverlayNativeInput = true
    }

    tbl4[React.Event.FocusLost] = function() end
    tbl4[React.Event.Focused] = function() end
    tbl4[React.Change.AbsoluteSize] = function() end
    tbl4[React.Change.Text] = function(arg1)
        if tbl1.text ~= arg1.Text then
            tbl1.onUpdate(arg1.Text)
        end
    end

    tbl3.AbuseReportsText = createElement2("TextBox", tbl4)
    return createElement("Frame", tbl2, tbl3)
end

return ReportTextEntry
