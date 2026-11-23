-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:41:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local CoreGui = game:GetService("CoreGui")

local Localization = require(scriptParentParentParentParent.Localization)
local React = require(scriptParentParentParentParent.React)
local UIBlox = require(scriptParentParentParentParent.UIBlox)
local normalizeFontFace = require(scriptParentParentParentParent.Foundation).Utility.normalizeFontFace

local useAnalytics = require(scriptParentParentParent.Analytics.useAnalytics)
local useLocalization = Localization.Hooks.useLocalization
local useStyle = UIBlox.Core.Style.useStyle

local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local EventNames = require(scriptParentParentParent.Analytics.EventNames)

return function(tbl1)
    local var1 = useAnalytics()
    local var2 = useStyle()

    local var3 = useLocalization({
        videoCTATitle = "Feature.Captures.Title.VideoCTA",
        videoEducationalText = "Feature.Captures.Label.VideoEducationalText",
        startRecording = "Feature.Captures.Control.StartRecordingVideo",
        stopRecording = "Feature.Captures.Control.StopRecordingVideo"
    })

    local var4, var5 = React.useState(false)

    React.useEffect(function()
        local connection = nil
        local gameOptions = settings():FindFirstChild("Game Options")
        if gameOptions then
            connection = gameOptions.VideoRecordingChangeRequest:connect(function(recording: boolean)
                var5(recording)
            end)
        end

        return function()
            if connection then
                connection:disconnect()
            end
        end
    end, { var1.fireEvent })

    local onActivated = React.useCallback(function()
        if not var4 then
            tbl1.closeSettingsMenu()
            var1.fireEvent(EventNames.CapturesMigratedLegacyVideoRecordActivated)
        else
            var1.fireEvent(EventNames.CapturesMigratedLegacyVideoRecordDeactivated)
        end
        CoreGui:ToggleRecording()
    end, { var1.fireEvent, var4, tbl1.closeSettingsMenu })

    local backgroundDefaultColor = var2.Theme.BackgroundDefault.Color
    local backgroundDefaultTransparency = var2.Theme.BackgroundDefault.Transparency

    local textDefaultColor = var2.Theme.TextDefault.Color
    local textSize = var2.Font.BaseSize * var2.Font.CaptionBody.RelativeSize

    local textEmphasisColor = var2.Theme.TextEmphasis.Color
    local var6 = var2.Font.BaseSize * var2.Font.Header2.RelativeSize

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = backgroundDefaultColor,
        BackgroundTransparency = backgroundDefaultTransparency,
        BorderSizePixel = 0,
        LayoutOrder = 3,
        Size = UDim2.fromScale(1, 0)
    }
    local tbl3 = {
        TextFrame = React.createElement(
            "Frame",
            {
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(0.7, 0)
            },
            {
                Layout = React.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Vertical,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalAlignment = Enum.VerticalAlignment.Top
                }),
                Title = React.createElement("TextLabel", {
                    BackgroundTransparency = 1,
                    FontFace = normalizeFontFace(var2.Tokens.Typography.TitleLarge.Font),
                    LayoutOrder = 1,
                    Size = UDim2.new(1, 0, 0, 30),
                    Text = var3.videoCTATitle,
                    TextColor3 = textEmphasisColor,
                    TextSize = var6,
                    TextXAlignment = Enum.TextXAlignment.Left
                }),
                EducationalLabel = React.createElement("TextLabel", {
                    BackgroundTransparency = 1,
                    FontFace = normalizeFontFace(var2.Tokens.Typography.BodySmall.Font),
                    LayoutOrder = 2,
                    Size = UDim2.new(1, 0, 0, 40),
                    Text = var3.videoEducationalText,
                    TextColor3 = textDefaultColor,
                    TextSize = textSize,
                    TextWrapped = true,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
            }
        ),
        CapturesToggleFrame = 0
    }

    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl4 = {
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(1, 0.5),
        Size = UDim2.fromOffset(224, 44)
    }
    local tbl5 = {
        RecordButton = React.createElement(Button, {
            buttonType = ButtonType.Secondary,
            onActivated = onActivated,
            size = UDim2.fromScale(1, 1),
            text = if var4 then var3.stopRecording else var3.startRecording
        })
    }
    tbl3.CapturesToggleFrame = createElement2(str2, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end
