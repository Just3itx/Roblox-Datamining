-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:11:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreScriptsPlayerFeedback = script:FindFirstAncestor("CoreScriptsPlayerFeedback")
local CoreScriptsPlayerFeedbackParent = CoreScriptsPlayerFeedback.Parent

local React = require(CoreScriptsPlayerFeedbackParent.React)

local _CaptureTypes = require(CoreScriptsPlayerFeedback.CaptureTypes)

return (React.memo(function(tbl1)
    return React.createElement(
        "Frame",
        {
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 0)
        },
        {
            Layout = React.createElement(
                "UIListLayout",
                {
                    FillDirection = Enum.FillDirection.Vertical,
                    Padding = UDim.new(0, 8),
                    SortOrder = Enum.SortOrder.LayoutOrder
                }
            ),
            PreviewImage = React.createElement(
                "ImageLabel",
                {
                    BackgroundColor3 = Color3.fromRGB(20, 20, 20),
                    BackgroundTransparency = 0,
                    BorderSizePixel = 0,
                    ImageContent = Content.fromObject(tbl1.capture),
                    LayoutOrder = 1,
                    ScaleType = Enum.ScaleType.Fit,
                    Size = UDim2.new(1, 0, 0, 260)
                },
                {
                    Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 6) })
                }
            )
        }
    )
end))
