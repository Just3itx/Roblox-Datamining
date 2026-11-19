-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:01:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local scriptParentParent = script.Parent.Parent

local Actions = scriptParentParent.Actions
local HideError = require(Actions.HideError)

local Constants = require(scriptParentParent.Constants)

local var1 = Roact.PureComponent:extend("ErrorMessage")

function var1.render(arg1)
    local layout = Constants.Layouts[arg1.props.layout]

    local createElement = Roact.createElement
    local tbl1 = {
        Size = layout.ErrorFrameSize,
        Position = layout.ErrorFramePosition,
        BackgroundColor3 = Constants.Colors.Black,
        BackgroundTransparency = Constants.ErrorFrameBackgroundTransparency,
        BorderSizePixel = Constants.ErrorFrameBorderSize,
        Selectable = false,
        Visible = arg1.props.displayOptions.errorVisible
    }
    tbl1[Roact.Event.TouchTap] = function()
        arg1.props.close()
    end

    tbl1[Roact.Event.InputBegan] = function(_, arg2)
        if arg2.UserInputType == Enum.UserInputType.MouseButton1 then
            arg1.props.close()
        end
    end

    return createElement("Frame", tbl1, {
        AsspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", { AspectRatio = layout.ErrorFrameAspectRatio }),
        SizeConstraint = Roact.createElement("UISizeConstraint", { MinSize = layout.ErrorFrameMinSize, MaxSize = layout.ErrorFrameMaxSize }),
        ErrorIcon = Roact.createElement(
            "ImageLabel",
            {
                AnchorPoint = Vector2.new(0, 0.5),
                Position = UDim2.new(0, layout.ErrorIconOffset, 0.5, 0),
                Size = UDim2.new(0.2, -layout.ErrorIconOffset * 2, 1, -layout.ErrorIconOffset * 2),
                Image = layout.ErrorIcon,
                BackgroundTransparency = 1
            },
            {
                AsspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", { AspectRatio = 1 })
            }
        ),
        ErrorText = Roact.createElement("TextLabel", {
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0.2, -layout.ErrorIconOffset, 0.5, 0),
            Size = UDim2.new(0.8, 0, 1, 0),
            Text = arg1.props.displayOptions.errorText,
            TextScaled = true,
            TextSize = layout.ErrorTextSize,
            TextColor3 = Constants.Colors.White,
            TextXAlignment = Enum.TextXAlignment.Left,
            Font = layout.ErrorTextFont,
            BackgroundTransparency = 1
        }, {
            SizeConstraint = Roact.createElement(
                "UISizeConstraint",
                {
                    MaxSize = Vector2.new(layout.ErrorFrameMaxSize.X, layout.ErrorTextSize + Constants.TextPadding)
                }
            ),
            TextSizeConstraint = Roact.createElement("UITextSizeConstraint", { MaxTextSize = layout.ErrorTextSize })
        })
    })
end

return RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        displayOptions = arg1.displayOptions,
        layout = arg1.layout
    }
end, function(arg1) -- name: mapDispatchToProps
    return {
        close = function()
            return arg1(HideError())
        end
    }
end)(var1)
