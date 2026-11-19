-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:01:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local scriptParentParent = script.Parent.Parent

local Constants = require(scriptParentParent.Constants)

local var1 = Roact.PureComponent:extend("SelectionEffect")

function var1.render(arg1)
    local layout = Constants.Layouts[arg1.props.layout]
    local focusedSegmentIndex = arg1.props.emotesWheel.focusedSegmentIndex

    local rotation = 360 / Constants.EmotesPerPage * (focusedSegmentIndex - 1) + Constants.SegmentsStartRotation
    local var3 = Constants.InnerCircleSizeRatio / 2

    local var4 = 360 / Constants.EmotesPerPage
    local yScale = Constants.InnerCircleSizeRatio * math.sin(math.rad(var4 / 2))

    return Roact.createElement("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Rotation = rotation,
        Visible = focusedSegmentIndex ~= 0
    }, {
        SelectedLine = Roact.createElement("ImageLabel", {
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(0.5 + var3, -layout.SelectedLinePadding, 0.5, 0),
            Size = UDim2.new(1, 0, yScale, -layout.SelectedLinePadding),
            BackgroundTransparency = 1,
            Image = layout.SelectedLine,
            ZIndex = 4
        }, {
            AsspectRatioConstraint = Roact.createElement(
                "UIAspectRatioConstraint",
                {
                    AspectRatio = layout.SelectedLineImageSize.X / layout.SelectedLineImageSize.Y
                }
            )
        })
    })
end
return RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        emotesWheel = arg1.emotesWheel,
        layout = arg1.layout
    }
end, nil)(var1)
