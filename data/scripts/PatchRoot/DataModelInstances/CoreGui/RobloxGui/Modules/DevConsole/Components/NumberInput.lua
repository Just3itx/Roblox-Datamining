-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:40:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Constants = require(script.Parent.Parent.Constants)
local Roact = require(CorePackages.Packages.Roact)

local var1 = Roact.Component:extend("NumberInput")

function var1.init(arg1)
    arg1.state = {
        Value = arg1.props.DefaultValue
    }
end

function var1.render(arg1)
    local props = arg1.props

    local createElement = Roact.createElement
    local tbl1 = {
        Font = Constants.Font.Log,
        Text = `{arg1.state.Value}`,
        TextColor3 = Constants.Color.Text,
        TextSize = Constants.GeneralFormatting.NumberInputTextSize,
        TextXAlignment = props.TextXAlignment or Enum.TextXAlignment.Center,
        BackgroundColor3 = Constants.Color.TextBoxGray,
        BorderColor3 = Constants.GeneralFormatting.LineColor,
        LayoutOrder = props.LayoutOrder,
        Size = props.Size,
        ClearTextOnFocus = true
    }
    tbl1[Roact.Event.FocusLost] = function(arg2)
        local var2 = tonumber(arg2.Text)

        if var2 == nil or var2 ~= var2 then
            arg2.Text = `{arg1.state.Value}`
            return
        end

        if props.IntegerOnly then
            var2 = math.floor(var2)
        end

        local num1 = math.clamp(var2, props.Range.Min, props.Range.Max)

        arg1:setState({ Value = num1 })

        arg2.Text = `{num1}`

        if props.OnNumberInputChanged then
            props.OnNumberInputChanged(num1)
        end
    end

    return createElement("TextBox", tbl1)
end

return var1
