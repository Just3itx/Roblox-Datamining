-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:01:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local scriptParentParent = script.Parent.Parent

local Constants = require(scriptParentParent.Constants)

local var1 = Roact.PureComponent:extend("SlotNumbers")

function var1.render(arg1)
    local layout = Constants.Layouts[arg1.props.layout]

    local tbl1 = ({})

    for i = 1, Constants.EmotesPerPage do
        local var2 = 360 / Constants.EmotesPerPage * (i - 1) + Constants.SegmentsStartRotation
        local var3 = Constants.InnerCircleSizeRatio / 2

        local slotNumberSize = Constants.SlotNumberSize
        local var4 = slotNumberSize / 2

        local num1 = math.cos(math.rad(var2))
        local var5 = var3 * num1

        local var6 = var4 * num1
        local xScale = 0.5 + var5 + var6

        local num2 = math.sin(math.rad(var2))
        local var7 = var3 * num2

        local var8 = var4 * num2
        local yScale = 0.5 + var7 + var8

        local createElement = Roact.createElement
        local tbl2 = {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(xScale, 0, yScale, 0),
            Size = UDim2.new(slotNumberSize, 0, slotNumberSize, 0),
            BackgroundTransparency = 1,
            TextScaled = true,
            TextSize = layout.SlotNumberTextSize,
            TextColor3 = Constants.Colors.White,
            Text = i,
            Font = layout.SlotNumberFont,
            ZIndex = 2
        }
        local tbl3 = {
            TextSizeConstraint = Roact.createElement("UITextSizeConstraint", { MaxTextSize = layout.SlotNumberTextSize })
        }
        tbl1[i] = createElement("TextLabel", tbl2, tbl3)
    end

    return Roact.createElement("Frame", { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1 }, tbl1)
end

return RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        layout = arg1.layout
    }
end, nil)(var1)
