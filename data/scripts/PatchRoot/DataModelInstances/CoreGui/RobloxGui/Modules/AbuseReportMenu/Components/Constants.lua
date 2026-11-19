-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:41:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local _Types = require(AbuseReportMenu.Components.Types)

local tbl1 = {
    LegacyAbuseReportMenuRootName = "LegacyAbuseReportMenuRoot",
    AbuseReportMenuPlaceholderFrame = "AbuseReportMenuPlaceholderFrame",
    ModalBaseSelectorDialogRootName = "ModalBaseSelectorDialog",
    ReportModes = { Classic = "Classic", SelectInScene = "SelectInScene" },
    ReportTypes = { Person = "Person", Experience = "Experience" },
    PlayerAbuseTypes = {
        Swearing = "Swearing",
        Username = "Inappropriate Username",
        Bullying = "Bullying",
        Scamming = "Scamming",
        Dating = "Dating",
        Cheating = "Cheating/Exploiting",
        Personal = "Personal Question",
        Links = "Offsite Links"
    },
    PlayerVoiceAbuseTypes = {
        Swearing = "Swearing",
        Username = "Inappropriate Username",
        Bullying = "Bullying",
        Scamming = "Scamming",
        Dating = "Dating",
        Cheating = "Cheating/Exploiting",
        Personal = "Personal Question"
    },
    InappropriateContentAbuseReason = "Inappropriate Content",
    AbuseMethods = {
        TextChat = "Text Chat",
        VoiceChat = "Voice Chat",
        Other = "Other",
        Avatar = "Avatar"
    }
}

tbl1.AbuseMethodToVectorMapping = {
    [tbl1.AbuseMethods.TextChat] = "chat",
    [tbl1.AbuseMethods.VoiceChat] = "voice",
    [tbl1.AbuseMethods.Other] = "other",
    [tbl1.AbuseMethods.Avatar] = "avatar"
}

tbl1.AnalyticsAbuseMethods = { Chat = "Chat", Voice = "Voice", Other = "Other", Game = "Game" }

tbl1.AbuseMethodToAnalyticsMapping = {
    [tbl1.AbuseMethods.TextChat] = tbl1.AnalyticsAbuseMethods.Chat,
    [tbl1.AbuseMethods.VoiceChat] = tbl1.AnalyticsAbuseMethods.Voice,
    [tbl1.AbuseMethods.Other] = tbl1.AnalyticsAbuseMethods.Other,
    [tbl1.AbuseMethods.Avatar] = tbl1.AnalyticsAbuseMethods.Other
}

tbl1.AbuseMethodSublabel = {
    TextChat = "This person typed a mean word in text chat",
    VoiceChat = "This person was screaming on top of their lungs",
    Other = "This person is following me, wearing a bad shirt, etc.",
    Avatar = "This person's avatar is wearing offensive clothing"
}

tbl1.PlayerMenuActions = {
    UpdateAbuseReason = "UpdateAbuseReason",
    UpdateComment = "UpdateComment",
    UpdateMethodOfAbuse = "UpdateMethodOfAbuse",
    UpdateAbuser = "UpdateAbuser",
    UpdatePlayerNameMap = "UpdatePlayerNameMap",
    SetVoiceEnabled = "SetVoiceEnabled",
    ClearState = "ClearState",
    SetShowModalSelector = "SetShowModalSelector",
    SetMenuOpenTimestamp = "SetMenuOpenTimestamp",
    SetPreselectedPlayer = "SetPreselectedPlayer"
}

tbl1.ReportAnythingActions = {
    ClearAll = "ClearAll",
    ClearAnnotationFlowProperties = "ClearAnnotationFlowProperties",
    SetScreenshotId = "SetScreenshotId",
    SetScreenshotContentId = "SetScreenshotContentId",
    SetAnnotationPoints = "SetAnnotationPoints",
    SetIdentificationResults = "SetIdentificationResults",
    CompleteAttachment = "CompleteAttachment",
    SetAnnotationAreaDimensions = "SetAnnotationAreaDimensions",
    SetAnnotationCircleRadius = "SetAnnotationCircleRadius",
    SetAnnotationOptionSeen = "SetAnnotationOptionSeen"
}

tbl1.AnalyticsActions = {
    Reset = "Reset",
    SetMenuOpenedTimestamp = "SetMenuOpenedTimestamp",
    IncrementExperiencePersonChanged = "IncrementExperiencePersonChanged",
    IncrementTypeofabuseChanged = "IncrementTypeofabuseChanged",
    IncrementPersonChanged = "IncrementPersonChanged",
    IncrementReasonChanged = "IncrementReasonChanged",
    IncrementCaptureScene = "IncrementCaptureScene",
    SetMemoryRequirementMet = "SetMemoryRequirementMet",
    SetViewportInformation = "SetViewportInformation",
    SetSubmissionCompleted = "SetSubmissionCompleted",
    SetTypeOfAbuseSelection = "SetTypeOfAbuseSelection",
    SetPreselectedAbuseSelection = "SetPreselectedAbuseSelection",
    SetReasonSelection = "SetReasonSelection",
    SetCommentAdded = "SetCommentAdded",
    SwitchToExperienceInitialSelections = "SwitchToExperienceInitialSelections",
    SwitchToPersonInitialSelections = "SwitchToPersonInitialSelections"
}

tbl1.ReportSuccessToast = {
    ReportAnythingGeneric = "We’ve received your report and will take action soon if needed. Your feedback helps keep our community safe.",
    ChatGeneric = "Thanks for your report! Our moderators will review the chat logs and evaluate what happened.",
    Cheating = "Thanks for your report! We've recorded your report for evaluation.",
    BadUserName = "Thanks for your report! Our moderators will evaluate the username.",
    Place = "Thanks for your report! Our moderators will review the place and make a determination."
}

tbl1.localizationKeys = {
    ReportType = "Feature.ReportAbuse.Label.ReportType",
    Person = "Feature.ReportAbuse.Label.Person",
    Experience = "Feature.ReportAbuse.Label.Experience",
    SelectInScene = "Feature.ReportAbuse.Action.SelectInScene",
    BuildAReport = "Feature.ReportAbuse.Action.BuildAReport",
    [tbl1.AbuseMethods.TextChat] = "Feature.ReportAbuse.Label.TextChat",
    [tbl1.AbuseMethods.VoiceChat] = "Feature.SettingsHub.MethodOfAbuse.VoiceChat.Title",
    [tbl1.AbuseMethods.Other] = "Feature.SettingsHub.MethodOfAbuse.Other.Title",
    [tbl1.AbuseMethods.Avatar] = "Feature.ReportAbuse.Label.Avatar",
    [tbl1.InappropriateContentAbuseReason] = "Feature.ReportAbuse.Label.Content",
    [tbl1.PlayerAbuseTypes.Swearing] = "Feature.ReportAbuse.Problem.Swearing",
    [tbl1.PlayerAbuseTypes.Username] = "Feature.ReportAbuse.ProblemSurface.Username",
    [tbl1.PlayerAbuseTypes.Bullying] = "Feature.ReportAbuse.Problem.Bullying",
    [tbl1.PlayerAbuseTypes.Scamming] = "Feature.ReportAbuse.Problem.Scamming",
    [tbl1.PlayerAbuseTypes.Dating] = "Feature.ReportAbuse.Problem.Dating",
    [tbl1.PlayerAbuseTypes.Cheating] = "Feature.ReportAbuse.Problem.Cheating",
    [tbl1.PlayerAbuseTypes.Personal] = "Feature.ReportAbuse.Problem.Personal",
    [tbl1.PlayerAbuseTypes.Links] = "Feature.ReportAbuse.Problem.Links",
    [tbl1.PlayerVoiceAbuseTypes.Swearing] = "Feature.ReportAbuse.Problem.Swearing",
    [tbl1.PlayerVoiceAbuseTypes.Username] = "Feature.ReportAbuse.ProblemSurface.Username",
    [tbl1.PlayerVoiceAbuseTypes.Bullying] = "Feature.ReportAbuse.Problem.Bullying",
    [tbl1.PlayerVoiceAbuseTypes.Scamming] = "Feature.ReportAbuse.Problem.Scamming",
    [tbl1.PlayerVoiceAbuseTypes.Dating] = "Feature.ReportAbuse.Problem.Dating",
    [tbl1.PlayerVoiceAbuseTypes.Cheating] = "Feature.ReportAbuse.Problem.Cheating",
    [tbl1.PlayerVoiceAbuseTypes.Personal] = "Feature.ReportAbuse.Problem.Personal",
    ReasonForAbuse = "Feature.SettingsHub.Label.ReasonForAbuse",
    AttachScreenshot = "Feature.SettingsHub.Label.AttachScreenshot",
    SceneCaptured = "Feature.SettingsHub.Label.SceneCaptured",
    CaptureScene = "Feature.SettingsHub.Action.CaptureScene",
    MethodOfAbuse = "Feature.SettingsHub.Label.MethodOfAbuse",
    WhichPerson = "Feature.SettingsHub.Label.WhichPlayer",
    ChooseOne = "Feature.SettingsHub.Label.ChooseOne",
    ReportCommentPlaceholder = "Feature.SettingsHub.Label.ReportComment",
    SubmitButton = "Feature.ReportAbuse.Action.Submit",
    FooterInformation1 = "Feature.ReportAbuse.Message.OSACopy1",
    FooterInformation2 = "Feature.ReportAbuse.Message.ReportInformationCopy"
}
tbl1.InitialIdentificationResults = {
    identifiedAvatars = {},
    identifiedAds = {},
    avatarIDStats = { totalPlayers = 0, checkedPlayers = 0, duration = 0 },
    adIDStats = { totalPlayers = 0, checkedPlayers = 0, duration = 0 }
}

tbl1.ReportAnythingInitialState = {
    identificationResults = tbl1.InitialIdentificationResults,
    screenshotId = "",
    screenshotContentId = "",
    attachCompleted = false,
    annotationPoints = {}
}

tbl1.AnalyticsInitialState = {
    menuEverShown = false,
    menuOpenedUnixTimestampMilliseconds = 0,
    experiencePersonChangeCount = 0,
    typeofabuseChangeCount = 0,
    personChangeCount = 0,
    reasonChangeCount = 0,
    captureSceneCount = 0,
    viewportSizeX = -1,
    viewportSizeY = -1,
    isPortraitMode = false,
    isSubmissionCompleted = false,
    typeofabuseSelection = nil,
    reasonSelection = nil,
    commentAdded = false,
    experiencePersonSelection = nil,
    memoryRequirementMet = -1
}

tbl1.AnalyticsPersonInitialSelections = {
    typeofabuseSelection = nil,
    reasonSelection = nil,
    commentAdded = false,
    experiencePersonSelection = string.lower(tbl1.ReportTypes.Person)
}

tbl1.AnalyticsExpeirenceInitialSelections = {
    typeofabuseSelection = tbl1.AnalyticsAbuseMethods.Game,
    reasonSelection = tbl1.InappropriateContentAbuseReason,
    commentAdded = false,
    experiencePersonSelection = string.lower(tbl1.ReportTypes.Experience)
}

tbl1.AbuseVector = { Voice = "voice" }

tbl1.MenuItemHeight = 42
tbl1.MenuItemHeightTight = 36
tbl1.FreeCommentsMenuItemHeight = 60
tbl1.FieldLabelSize = 18
tbl1.LeftContainerWidth = 240
tbl1.RightContainerWidth = 300
tbl1.MenuItemDynamicWidthOffset = 100

tbl1.FieldLabelSizeSmall = 16
tbl1.LeftContainerWidthSmall = 100
tbl1.RightContainerWidthSmall = 180

tbl1.SmallLayoutThreshold = 540

tbl1.ReportMenuFontStyle = "Header1"
tbl1.ReportMenuButtonSize = 36

tbl1.ReportMenuButtonSizeConsole = 48

tbl1.InitPersonUIState = {
    reportType = tbl1.ReportTypes.Person,
    comment = "",
    playerObjects = {},
    menuContainerWidth = 0,
    allegedAbuserId = nil,
    allegedAbuser = nil,
    abuseReason = nil,
    methodOfAbuse = nil,
    isVoiceEnabled = nil,
    menuOpenedUnixTimestampMilliseconds = nil,
    modalSelectorCellData = nil,
    isModalSelectorShown = nil,
    preselectedPlayer = nil
}

tbl1.InitExperienceUIState = {
    reportType = tbl1.ReportTypes.Experience,
    comment = "",
    abuseReason = tbl1.InappropriateContentAbuseReason,
    menuContainerWidth = 0
}

return tbl1
