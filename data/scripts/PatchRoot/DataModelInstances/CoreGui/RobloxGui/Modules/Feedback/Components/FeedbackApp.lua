-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local UIBlox = require(CorePackages.Packages.UIBlox)
local ColorMode = require(CorePackages.Packages.Foundation).Enums.ColorMode
local t = require(CorePackages.Packages.t)

local scriptParentParent = script.Parent.Parent

local withStyle = UIBlox.Core.Style.withStyle
local AppStyleProvider = UIBlox.App.Style.AppStyleProvider
local Dark = ColorMode.Dark

local SetFeedbackFlowState = require(scriptParentParent.Actions.SetFeedbackFlowState)
local SetScreenSize = require(scriptParentParent.Actions.SetScreenSize)

local withLocalization = require(CorePackages.Workspace.Packages.Localization).withLocalization

local Assets = require(scriptParentParent.Resources.Assets)

local FeedbackReportDialog = require(scriptParentParent.Components.FeedbackReportDialog)
local RefinedFeedbackBar = require(scriptParentParent.Components.RefinedFeedbackBar)
local FeedbackSubmissionToast = require(scriptParentParent.Components.FeedbackSubmissionToast)
local HelpModal = require(scriptParentParent.Components.HelpModal)
local OnboardingModal = require(scriptParentParent.Components.OnboardingModal)

local FFlagInExperienceUseAppStyleProvider = require(CorePackages.Workspace.Packages.SharedFlags).FFlagInExperienceUseAppStyleProvider

local var1 = Roact.PureComponent:extend("FeedbackApp")

var1.validateProps = t.strictInterface({ setScreenGuiSize = t.callback })

function var1.render(arg1)
    local createElement = Roact.createElement
    local var2 = if FFlagInExperienceUseAppStyleProvider then AppStyleProvider else UIBlox.Core.Style.Provider
    local var3 = FFlagInExperienceUseAppStyleProvider and {
        style = { themeName = Dark }
    } or {}

    local tbl1 = { Gui = 0 }
    local createElement2 = Roact.createElement
    local tbl2 = {
        AutoLocalize = false,
        IgnoreGuiInset = true,
        OnTopOfCoreBlur = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        [Roact.Change.AbsoluteSize] = arg1.props.setScreenGuiSize
    }

    tbl1.Gui = createElement2("ScreenGui", tbl2, {
        ScreenFrame = Roact.createElement("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            ZIndex = 10
        }, {
            FeedbackSubmissionToast = Roact.createElement(FeedbackSubmissionToast),
            HelpModal = Roact.createElement(HelpModal),
            OnboardingModal = Roact.createElement(OnboardingModal),
            FeedbackReportDialog = Roact.createElement(FeedbackReportDialog)
        }),
        RefinedFeedbackBar = withLocalization({ feedbackBarText = "CoreScripts.Feedback.FeedbackBar.MainLabel" })(function(arg2)
            return withStyle(function(arg3)
                local font = arg3.Font
                return Roact.createElement(RefinedFeedbackBar, {
                    leftHint = {
                        text = arg2.feedbackBarText,
                        hintTextSize = font.BaseSize * font.Body.RelativeSize,
                        maxWidth = 200,
                        icon = Assets.Images.FeedbackBarHintIcon
                    }
                }, {})
            end)
        end)
    })

    return createElement(var2, var3, tbl1)
end

return RoactRodux.connect(function() end, function(callback)
    return {
        setScreenGuiSize = function(arg1)
            callback(SetScreenSize(arg1.AbsoluteSize))
        end,
        setFeedbackFlowState = function(arg1)
            callback(function(arg2)
                arg2:dispatch(SetFeedbackFlowState(arg1))
            end)
        end
    }
end)(var1)
