-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:17:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local _ContentProvider = game:GetService("ContentProvider")

local UIBlox = require(CorePackages.Packages.UIBlox)
local Images = UIBlox.App.ImageSet.Images
local Toast = UIBlox.App.Dialog.Toast
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local renderWithCoreScriptsStyleProvider = require(RobloxGui.Modules.Common.renderWithCoreScriptsStyleProvider)

local Roact = require(CorePackages.Packages.Roact)
local t = require(CorePackages.Packages.t)

local TrackerPromptType = require(RobloxGui.Modules.Tracker.TrackerPromptType)

local bool1 = game:DefineFastFlag("TrackerPromptNewCopyForCameraPerformanceEnabled", false)

local str1 = game:DefineFastString("CameraUnavailableUrl", "https://help.roblox.com/hc/articles/17877687557396")

local var1 = Roact.PureComponent:extend("TrackerPrompt")

var1.validateProps = t.strictInterface({ promptType = t.optional(t.string) })

local tbl1 = {
    [TrackerPromptType.None] = "",
    [TrackerPromptType.VideoNoPermission] = RobloxTranslator:FormatByKey("Feature.FaceChat.Heading.UnableToAccessCamera"),
    [TrackerPromptType.NotAvailable] = RobloxTranslator:FormatByKey("Feature.FaceChat.Heading.NotAvailable"),
    [TrackerPromptType.FeatureDisabled] = RobloxTranslator:FormatByKey("Feature.FaceChat.Heading.FacialAnimation"),
    [TrackerPromptType.LODCameraRecommendDisable] = if bool1 then RobloxTranslator:FormatByKey("Feature.FaceChat.Heading.LowPerformanceDetected") else RobloxTranslator:FormatByKey("Feature.FaceChat.Heading.VideoPerformancePromptDisable"),
    [TrackerPromptType.NoDynamicHeadEquipped] = RobloxTranslator:FormatByKey("Feature.FaceChat.Heading.PromptNoDynamicHeadEquipped"),
    [TrackerPromptType.VideoUnsupported] = RobloxTranslator:FormatByKey("Feature.FaceChat.Heading.VideoUnsupported"),
    [TrackerPromptType.UnsupportedDevice] = RobloxTranslator:FormatByKey("Feature.FaceChat.Heading.NotAvailable"),
    [TrackerPromptType.CameraUnavailable] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.CameraUnavailable")
}

local tbl2 = {
    [TrackerPromptType.None] = "",
    [TrackerPromptType.VideoNoPermission] = RobloxTranslator:FormatByKey("Feature.FaceChat.Subtitle.UnableToAccessCamera"),
    [TrackerPromptType.NotAvailable] = RobloxTranslator:FormatByKey("Feature.FaceChat.Subtitle.NotAvailable"),
    [TrackerPromptType.FeatureDisabled] = RobloxTranslator:FormatByKey("Feature.FaceChat.Subtitle.FeatureDisabled"),
    [TrackerPromptType.LODCameraRecommendDisable] = RobloxTranslator:FormatByKey("Feature.FaceChat.Subtitle.VideoPerformancePromptDisable"),
    [TrackerPromptType.NoDynamicHeadEquipped] = RobloxTranslator:FormatByKey("Feature.FaceChat.Subtitle.PromptNoDynamicHeadEquipped"),
    [TrackerPromptType.VideoUnsupported] = RobloxTranslator:FormatByKey("Feature.FaceChat.Subtitle.VideoUnsupported"),
    [TrackerPromptType.UnsupportedDevice] = RobloxTranslator:FormatByKey("Feature.FaceChat.Subtitle.UnsupportedDevice"),
    [TrackerPromptType.CameraUnavailable] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Subtitle.CameraUnavailable")
}

local function openWebview(url: string)
    local str2 = HttpService:JSONEncode({
        title = if game:GetEngineFeature("SetWebViewTitle") then RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.CameraUnavailable") else nil,
        presentationStyle = 2,
        visible = true,
        url = url
    })

    GuiService:BroadcastNotification(str2, 20)
end

function var1.init(arg1)
    arg1.promptType = arg1.props.promptType
end

function var1.render(arg1)
    arg1.promptType = arg1.props.promptType
    local trackerPrompt = Roact.createElement("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1)
    }, {
        Toast = not (arg1.promptType == TrackerPromptType.None)
            and Roact.createElement(Toast, {
                duration = 8,
                toastContent = {
                    iconImage = Images["icons/status/alert"],
                    toastTitle = tbl1[arg1.promptType],
                    toastSubtitle = tbl2[arg1.promptType],
                    onDismissed = function() end,
                    onActivated = function()
                        if arg1.promptType == TrackerPromptType.CameraUnavailable then
                            openWebview(str1)
                        end
                    end
                }
            })
    })

    local content = renderWithCoreScriptsStyleProvider({ TrackerPrompt = trackerPrompt })

    return Roact.createElement("ScreenGui", {
        AutoLocalize = false,
        DisplayOrder = 10,
        IgnoreGuiInset = true,
        OnTopOfCoreBlur = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    }, { Content = content })
end

return var1
