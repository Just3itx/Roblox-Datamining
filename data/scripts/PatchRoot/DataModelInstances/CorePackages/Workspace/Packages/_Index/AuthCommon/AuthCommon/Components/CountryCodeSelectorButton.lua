-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:11:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local Roact = require(AuthCommonParent.Roact)
local AppFonts = require(AuthCommonParent.Style).AppFonts

local Colors = require(AuthCommonParent.Style).Colors
local White = Colors.White
local Gray2 = Colors.Gray2

local var1 = Roact.PureComponent:extend("CountryCodeSelectorButton")
local AppCommonLibText = require(AuthCommonParent.AppCommonLib).Text

function var1.init(arg1)
    function arg1.selectionCallback()
        if arg1.props.ListButtonProps.SelectionCallback then
            arg1.props.ListButtonProps.SelectionCallback(arg1.props.Data)
        end
    end
end

function var1.render(arg1)
    local localizedName = arg1.props.Data.localizedName or ""
    local var2 = "+" .. (arg1.props.Data.prefix or "")
    local textSize = arg1.props.ListButtonProps.TextSize

    local textWidth = AppCommonLibText.GetTextWidth(var2, AppFonts.default:getDefault(), textSize)

    return Roact.createElement("TextButton", {
        Size = arg1.props.Size,
        BackgroundTransparency = 1,
        LayoutOrder = arg1.props.LayoutOrder,
        Text = "",
        [Roact.Event.Activated] = arg1.selectionCallback
    }, {
        CountryName = Roact.createElement("TextLabel", {
            Size = UDim2.new(1, -textWidth, 1, 0),
            Text = localizedName,
            BackgroundTransparency = 1,
            Font = AppFonts.default:getDefault(),
            TextColor3 = White,
            TextSize = textSize,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd
        }),
        CountryPrefix = Roact.createElement("TextLabel", {
            Size = UDim2.new(1, 0, 1, 0),
            Text = var2,
            BackgroundTransparency = 1,
            Font = AppFonts.default:getDefault(),
            TextColor3 = Gray2,
            TextSize = textSize,
            TextXAlignment = Enum.TextXAlignment.Right
        })
    })
end

return var1
