-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local React = require(CorePackages.Packages.React)
local Roact = require(CorePackages.Packages.Roact)

local Constants = require(script.Parent.Parent.Constants)
local MainWindowHeader = Constants.Font.MainWindowHeader
local MainWindowHeader2 = Constants.DefaultFontSize.MainWindowHeader
local ConstantsColorText = Constants.Color.Text
local UnselectedGray = Constants.Color.UnselectedGray
local Padding = Constants.Tooltip.Padding
local Offset = Constants.Tooltip.Offset
local MaxWidth = Constants.Tooltip.MaxWidth
local Delay = Constants.Tooltip.Delay

local function Tooltip(tbl1)
    local var1, var2 = React.useState(false)
    local text = tbl1.text
    local pos = tbl1.pos

    React.useEffect(function()
        var2(false)
        local bool1 = false
        task.delay(Delay, function()
            if bool1 then
                return
            end
            var2(true)
        end)
        return function()
            bool1 = true
        end
    end, { text, pos })

    return Roact.createElement(Roact.Portal, { target = CoreGui }, {
        TooltipContainer = Roact.createElement(
            "ScreenGui",
            { DisplayOrder = 20, IgnoreGuiInset = true, OnTopOfCoreBlur = true, Enabled = var1 },
            {
                Tooltip = Roact.createElement("TextLabel", {
                    Text = text,
                    TextSize = MainWindowHeader2,
                    TextColor3 = ConstantsColorText,
                    TextWrapped = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = MainWindowHeader,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    Position = pos + Offset,
                    BackgroundColor3 = UnselectedGray,
                    BackgroundTransparency = 0,
                    BorderSizePixel = 0
                }, {
                    Padding = Roact.createElement(
                        "UIPadding",
                        {
                            PaddingTop = Padding,
                            PaddingBottom = Padding,
                            PaddingLeft = Padding,
                            PaddingRight = Padding
                        }
                    ),
                    SizeConstraint = Roact.createElement("UISizeConstraint", { MaxSize = Vector2.new(MaxWidth, math.huge) })
                })
            }
        )
    })
end

return Tooltip
