-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local _chatTypes = require(BuildExperience.Chat.chatTypes)

local Icon = Foundation.Icon
local IconButton = Foundation.IconButton
local Progress = Foundation.Progress
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local InputSize = Foundation.Enums.InputSize
local ProgressShape = Foundation.Enums.ProgressShape
local ProgressSize = Foundation.Enums.ProgressSize

return React.memo(function(tbl1) -- name: ChatImagePreviewList
    local var1 = Foundation.Hooks.useTokens()
    local tbl2 = ({})
    local testId = tbl1.testId or "ChatImagePreviewList"

    for layoutOrder, value2 in tbl1.images do
        local bool1 = value2.uploadStatus == "uploading"
        local bool2 = value2.uploadStatus == "failed"
        local str1 = `Image-{layoutOrder}`
        local createElement = React.createElement
        local str2 = "ImageLabel"
        local tbl3 = {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ClipsDescendants = true,
            Image = if typeof(value2.capture) == "Object" then "" else value2.uri or "",
            ImageContent = if typeof(value2.capture) == "Object" then Content.fromObject(value2.capture) else nil,
            LayoutOrder = layoutOrder,
            ScaleType = Enum.ScaleType.Crop,
            Size = UDim2.fromOffset(var1.Size.Size_2400, var1.Size.Size_2400),
            [React.Tag] = `data-testid={testId}.Image.{layoutOrder}`
        }
        local tbl4 = {
            Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var1.Size.Size_200) }),
            FailedStroke = if bool2 then React.createElement(
                "UIStroke",
                {
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    Color = var1.Color.System.Alert.Color3,
                    Thickness = var1.Stroke.Thick
                }
            ) else nil,
            Progress = if bool1 then React.createElement(Progress, {
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                shape = ProgressShape.Circle,
                size = ProgressSize.Medium,
                ZIndex = 2,
                testId = `{testId}.Progress.{layoutOrder}`
            }) else nil,
            Error = if bool2 then React.createElement(Icon, {
                AnchorPoint = Vector2.new(0.5, 0.5),
                name = IconName.TriangleExclamation,
                Position = UDim2.fromScale(0.5, 0.5),
                size = IconSize.Medium,
                style = var1.Color.System.Alert,
                tag = "auto-xy",
                ZIndex = 2,
                testId = `{testId}.Error.{layoutOrder}`
            }) else nil,
            Retry = 0,
            Remove = 0
        }
        local var2

        if bool2 and tbl1.onRetry ~= nil then
            local createElement2 = React.createElement
            local var3 = IconButton
            local tbl5 = {
                icon = IconName.ArrowSpinClockwise,
                isCircular = true,
                onActivated = 0,
                Position = 0,
                AnchorPoint = 0,
                size = 0,
                variant = 0,
                ZIndex = 3,
                testId = 0
            }
            function tbl5.onActivated()
                tbl1.onRetry(layoutOrder)
            end
            tbl5.Position = UDim2.new(0, 4, 1, -4)
            tbl5.AnchorPoint = Vector2.new(0, 1)
            tbl5.size = InputSize.Small
            tbl5.variant = ButtonVariant.OverMedia

            tbl5.testId = `{testId}.Retry.{layoutOrder}`
            var2 = createElement2(var3, tbl5)
        else
            var2 = nil
        end

        tbl4.Retry = var2
        local var3

        if tbl1.onRemove == nil then
            var3 = nil
        else
            local createElement2 = React.createElement
            local var4 = IconButton
            local tbl5 = {
                AnchorPoint = Vector2.new(1, 0),
                icon = IconName.X,
                isCircular = true,
                onActivated = 0,
                Position = 0,
                size = 0,
                variant = 0,
                ZIndex = 2,
                testId = 0
            }
            function tbl5.onActivated()
                tbl1.onRemove(layoutOrder)
            end
            tbl5.Position = UDim2.new(1, -4, 0, 4)
            tbl5.size = InputSize.Small
            tbl5.variant = ButtonVariant.OverMedia

            tbl5.testId = `{testId}.Remove.{layoutOrder}`
            var3 = createElement2(var4, tbl5)
        end

        tbl4.Remove = var3
        tbl2[str1] = createElement(str2, tbl3, tbl4)
    end

    return React.createElement(View, {
        LayoutOrder = tbl1.LayoutOrder,
        tag = {
            ["row wrap gap-small size-full-0 auto-y"] = true,
            ["align-x-right"] = tbl1.alignRight == true
        },
        testId = testId
    }, {
        Images = React.createElement(React.Fragment, nil, tbl2)
    })
end)
