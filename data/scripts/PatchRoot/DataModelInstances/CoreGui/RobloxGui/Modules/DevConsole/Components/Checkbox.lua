-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Constants = require(script.Parent.Parent.Constants)
local Roact = require(CorePackages.Packages.Roact)

local var1 = Roact.Component:extend("Checkbox")

function var1.render(arg1)
    local propsSize = arg1.props.Size
    local var2 = arg1.props.Position or UDim2.new(0, 0, 0, 0)
    local layoutOrder = arg1.props.LayoutOrder or 0

    local propsName = arg1.props.Name

    local var3 = arg1.props.SelectedColor or Constants.Color.SelectedBlue
    local var4 = arg1.props.UnselectedColor or Constants.Color.UnselectedGray
    local onSelectedStateChanged = arg1.props.OnSelectedStateChanged
    local check, num1

    if arg1.props.IsSelected then
        check = Constants.Image.Check
        num1 = 0
    else
        var3 = var4
        check = ""
        num1 = 1
    end

    local createElement = Roact.createElement
    local tbl1 = {
        Size = propsSize,
        Position = var2,
        Image = check,
        BackgroundColor3 = var3,
        BackgroundTransparency = 0,
        BorderColor3 = Constants.Color.Text,
        BorderSizePixel = num1,
        LayoutOrder = layoutOrder
    }
    tbl1[Roact.Event.Activated] = function(_)
        if onSelectedStateChanged then
            onSelectedStateChanged(propsName, not arg1.props.IsSelected)
        end
    end

    return createElement("ImageButton", tbl1)
end

return var1
