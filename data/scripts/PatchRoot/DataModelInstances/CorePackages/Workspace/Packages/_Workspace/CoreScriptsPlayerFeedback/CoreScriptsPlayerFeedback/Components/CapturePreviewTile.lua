-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreScriptsPlayerFeedback = script:FindFirstAncestor("CoreScriptsPlayerFeedback")
local CoreScriptsPlayerFeedbackParent = CoreScriptsPlayerFeedback.Parent

local React = require(CoreScriptsPlayerFeedbackParent.React)
local Foundation = require(CoreScriptsPlayerFeedbackParent.Foundation)
local Icon = Foundation.Icon
local Loading = Foundation.Loading
local IconSize = Foundation.Enums.IconSize

local BuilderIcons = require(CoreScriptsPlayerFeedbackParent.BuilderIcons)
local IconVariant = BuilderIcons.IconVariant

local _CaptureTypes = require(CoreScriptsPlayerFeedback.CaptureTypes)

return (React.memo(function(tbl1)
    local var1, var2 = React.useState(false)
    local var3, var4 = React.useState(false)
    local bool1 = tbl1.status == "uploading"
    local bool2 = tbl1.status == "failed" and tbl1.failureReason ~= Enum.UploadCaptureResult.CaptureModerated
    local touchEnabled = game:GetService("UserInputService").TouchEnabled

    local createElement = React.createElement
    local str1 = "ImageButton"
    local tbl2 = {
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        ClipsDescendants = false,
        Image = "",
        LayoutOrder = tbl1.layoutOrder,
        Size = UDim2.new(0, 80, 0, 80)
    }

    tbl2[React.Event.MouseEnter] = function()
        var2(true)
    end
    tbl2[React.Event.MouseLeave] = function()
        var2(false)
    end
    tbl2[React.Event.SelectionGained] = function()
        var4(true)
    end
    tbl2[React.Event.SelectionLost] = function()
        var4(false)
    end
    local tbl3 = {
        Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 8) }),
        FailedStroke = if bool2 then React.createElement(
            "UIStroke",
            {
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                Color = Color3.fromRGB(220, 50, 50),
                Thickness = 1
            }
        ) else nil,
        Thumbnail = React.createElement(
            "ImageLabel",
            {
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                ClipsDescendants = true,
                ImageContent = Content.fromObject(tbl1.capture),
                ScaleType = Enum.ScaleType.Crop,
                Size = UDim2.fromScale(1, 1),
                ZIndex = 1
            },
            {
                Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 8) })
            }
        ),
        UploadingOverlay = 0,
        RemoveButton = 0
    }
    local element

    if bool1 then
        element = React.createElement("Frame", {
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundTransparency = 0.45,
            BorderSizePixel = 0,
            ClipsDescendants = true,
            Size = UDim2.fromScale(1, 1),
            ZIndex = 2
        }, {
            Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 8) }),
            Spinner = React.createElement(
                Loading,
                {
                    size = IconSize.Medium,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.5, 0.5),
                    ZIndex = 3
                }
            )
        })
    else
        element = nil
    end

    tbl3.UploadingOverlay = element
    local element2

    if var1 or touchEnabled or var3 then
        element2 = React.createElement("ImageButton", {
            AnchorPoint = Vector2.new(1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.new(1, -2, 0, 2),
            Size = UDim2.new(0, 20, 0, 20),
            ZIndex = 4,
            [React.Event.Activated] = tbl1.onRemove
        }, {
            CircleXIcon = React.createElement(Icon, { name = BuilderIcons.Icon.CircleX, size = IconSize.Medium, variant = IconVariant.Filled })
        })
    else
        element2 = nil
    end

    tbl3.RemoveButton = element2
    return createElement(str1, tbl2, tbl3)
end))
