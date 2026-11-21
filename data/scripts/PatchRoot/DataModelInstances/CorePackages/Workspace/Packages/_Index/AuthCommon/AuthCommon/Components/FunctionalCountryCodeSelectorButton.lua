-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:11:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local Roact = require(AuthCommonParent.Roact)
local Foundation = require(AuthCommonParent.Foundation)
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local GetTextSize = require(AuthCommonParent.Style).GetTextSize

local Colors = require(AuthCommonParent.Style).Colors
local White = Colors.White
local Gray2 = Colors.Gray2
Roact.PureComponent:extend("CountryCodeSelectorButton")
local GetFFlagCountryCodeBoldPrefixEnabled = require(AuthCommon.Flags.GetFFlagCountryCodeBoldPrefixEnabled)
local useStyle = require(AuthCommonParent.UIBlox).Core.Style.useStyle
local _Types = require(AuthCommon.Common.Types)

local function CountryCodeSelectorButton(tbl1)
    local localizedName = tbl1.CountryCode.localizedName or ""
    local var1 = "+" .. (tbl1.CountryCode.prefix or "")
    local textSize = tbl1.ListButtonProps.TextSize
    local boldPrefixEnabled = GetFFlagCountryCodeBoldPrefixEnabled() and tbl1.BoldPrefixEnabled
    local var2 = Foundation.Hooks.useTokens()

    local textSizeX = GetTextSize(var1, textSize, var2.Typography.BodySmall.Font, Vector2.new(10000, 10000)).X
    local str1 = string.format("%s (%s)", localizedName, var1)
    local size = tbl1.Size
    local layoutOrder = tbl1.LayoutOrder
    local var3 = tbl1.ListButtonProps.SelectionCallback or function(_) end
    local var4 = useStyle()

    local var5 = boldPrefixEnabled
        and {
            FullText = Roact.createElement("TextLabel", {
                Size = UDim2.new(1, 0, 1, 0),
                Text = str1,
                BackgroundTransparency = 1,
                FontFace = normalizeFontFace(var2.Typography.BodySmall.Font),
                TextColor3 = var4.Tokens.Color.Shift.Shift_400.Color3,
                TextSize = textSize,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd
            })
        }
        or {
            CountryName = Roact.createElement("TextLabel", {
                Size = UDim2.new(1, -textSizeX, 1, 0),
                Text = localizedName,
                BackgroundTransparency = 1,
                FontFace = normalizeFontFace(var2.Typography.BodySmall.Font),
                TextColor3 = White,
                TextSize = textSize,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd
            }),
            CountryPrefix = Roact.createElement("TextLabel", {
                Size = UDim2.new(1, 0, 1, 0),
                Text = var1,
                BackgroundTransparency = 1,
                FontFace = normalizeFontFace(var2.Typography.BodySmall.Font),
                TextColor3 = Gray2,
                TextSize = textSize,
                TextXAlignment = Enum.TextXAlignment.Right,
                TextTruncate = Enum.TextTruncate.AtEnd
            })
        }

    local createElement = Roact.createElement
    local tbl2 = { Size = size, BackgroundTransparency = 1, LayoutOrder = layoutOrder, Text = "" }
    tbl2[Roact.Event.Activated] = function()
        var3(tbl1.CountryCode)
    end

    return createElement("TextButton", tbl2, var5)
end

return CountryCodeSelectorButton
