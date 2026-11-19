-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:02:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local UIBlox = require(CorePackages.Packages.UIBlox)

local Colors = UIBlox.App.Style.Colors
local withStyle = UIBlox.Style.withStyle

local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local Constants = require(scriptParentParent.Constants)
local SelectionGradient = require(scriptParent.SelectionGradient)
local SelectionEffect = require(scriptParent.SelectionEffect)
local WheelText = require(scriptParent.WheelText)

local var1 = Roact.PureComponent:extend("WheelBackground")

function var1.renderContent(arg1, arg2)
    local layout = Constants.Layouts[arg1.props.layout]

    local createElement = Roact.createElement
    local str1 = "Folder"
    local tbl1 = {}
    local tbl2 = {
        BackgroundCircleOverlay = 0,
        BackgroundGradient = 0,
        BackgroundImage = 0,
        Selection = 0,
        BackgroundText = 0
    }
    local element

    if arg2 then
        element = Roact.createElement("Frame", {
            Size = UDim2.fromScale(1, 1),
            BackgroundColor3 = Colors.Flint:Lerp(Color3.new(0, 0, 0), arg2),
            BackgroundTransparency = Constants.WheelBackgroundTransparency * arg2
        }, { Roact.createElement("UICorner", { CornerRadius = UDim.new(0.5, 0) }) })
    else
        element = Roact.createElement("ImageLabel", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundTransparency = 1,
            Image = layout.CircleBackground,
            ZIndex = 1
        })
    end

    tbl2.BackgroundCircleOverlay = element

    tbl2.BackgroundGradient = Roact.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            ZIndex = 2
        },
        {
            SelectionGradient = Roact.createElement(SelectionGradient)
        }
    )
    tbl2.BackgroundImage = Roact.createElement("ImageLabel", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundTransparency = 1,
        Image = layout.SegmentedCircle,
        ZIndex = 3
    })

    tbl2.Selection = Roact.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            ZIndex = 4
        },
        {
            SelectionEffect = Roact.createElement(SelectionEffect)
        }
    )
    tbl2.BackgroundText = Roact.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            ZIndex = 5
        },
        {
            MiddleText = Roact.createElement(WheelText)
        }
    )
    return createElement(str1, tbl1, tbl2)
end

function var1.render(arg1)
    return withStyle(function(arg2)
        return arg1:renderContent(arg2.Settings.PreferredTransparency)
    end)
end

return RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        layout = arg1.layout
    }
end, nil)(var1)
