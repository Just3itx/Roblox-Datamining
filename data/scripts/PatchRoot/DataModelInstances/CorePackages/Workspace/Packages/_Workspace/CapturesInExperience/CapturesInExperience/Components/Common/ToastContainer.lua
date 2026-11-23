-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local Dash = require(scriptParentParentParentParent.Dash)
local Foundation = require(scriptParentParentParentParent.Foundation)
local Localization = require(scriptParentParentParentParent.Localization)
local React = require(scriptParentParentParentParent.React)
local RoactUtils = require(scriptParentParentParentParent.RoactUtils)
local SocialStopwatch = require(scriptParentParentParentParent.SocialStopwatch)
local UIBlox = require(scriptParentParentParentParent.UIBlox)

local IconName = Foundation.Enums.IconName
local Images = UIBlox.App.ImageSet.Images
local Toast = UIBlox.App.Dialog.Toast

local useAnalytics = require(scriptParentParentParent.Analytics.useAnalytics)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useLocalization = Localization.Hooks.useLocalization
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector

local CapturesToastType = require(scriptParentParentParent.Enums.CapturesToastType)
local CaptureType = require(scriptParentParentParent.Enums.CaptureType)
local CarouselOpened = require(scriptParentParentParent.Actions.CarouselOpened)
local Constants = require(scriptParentParentParent.Constants)
local EventNames = require(scriptParentParentParent.Analytics.EventNames)
local ExternalShareSourceType = require(scriptParentParentParent.Enums.ExternalShareSourceType)
local getSaveToStoragePermission = require(scriptParentParentParent.Utils.getSaveToStoragePermission)
local ShareCapture = require(scriptParentParentParent.Thunks.ShareCapture)
local StartMomentsCreationFlow = require(scriptParentParentParent.Thunks.StartMomentsCreationFlow)
local ToastVanished = require(scriptParentParentParent.Actions.ToastVanished)
local _Types = require(scriptParentParentParent.Types)

local ToastController = require(script.Parent.ToastController)

local SharedFlags = require(scriptParentParentParentParent.SharedFlags)
local FFlagBuildExperienceInGameCaptureToChat = SharedFlags.FFlagBuildExperienceInGameCaptureToChat
local FFlagMomentsCreationFeatureGate = SharedFlags.FFlagMomentsCreationFeatureGate
local GetMomentsCapabilities = require(scriptParentParentParentParent.MomentsCommon).Stores.GetMomentsCapabilities
local FFlagCreateMomentsToast = require(scriptParentParentParent.Flags.FFlagCreateMomentsToast)

local FFlagCapturesInExpMomentsToastDownloadButton = require(scriptParentParentParent.Flags.FFlagCapturesInExpMomentsToastDownloadButton)

local FFlagEnableCapturesGalleryRetrievalCoreScript = require(scriptParentParentParent.Flags.FFlagEnableCapturesGalleryRetrievalCoreScript)

local bool1 = UserInputService:GetPlatform() == Enum.Platform.Windows or UserInputService:GetPlatform() == Enum.Platform.OSX

local function isVideoCapture(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    if not arg1 then
        return false
    end

    local captureInfo = arg1.captureInfo
    return if captureInfo then if FFlagCapturesInExpMomentsToastDownloadButton and typeof(captureInfo) ~= "table" then captureInfo.CaptureType == Enum.CaptureType.Video elseif FFlagEnableCapturesGalleryRetrievalCoreScript then captureInfo.CaptureType == Enum.CaptureType.Video else captureInfo.type == CaptureType.Video else false
end

local tbl1 = {
    [CapturesToastType.CaptureSavedToDevice] = {
        iconImage = Images["icons/status/success"],
        onActivated = bool1 and function(arg1, _, arg2)
            arg1.fireEvent(EventNames.CapturesSavedToDeviceToastOpenButtonActivated)

            if isVideoCapture(arg2) then
                game:OpenVideosFolder()
                return
            end
            game:OpenScreenshotsFolder()
        end or nil,
        toastCTAKey = if bool1 then "openInFiles" else nil,
        toastTitleKey = "captureSavedToDevice"
    },
    [CapturesToastType.CaptureTaken] = {
        iconImage = Images["icons/controls/screenshot"],
        onActivated = function(arg1, callback, arg2)
            arg1.fireEvent(EventNames.CapturesShareToastButtonActivated)

            if isVideoCapture(arg2) then
                arg1.fireEvent(EventNames.CapturesVideoShareToastButtonActivated)
            end

            if not arg2 or not arg2.captureInfo then
                return
            end

            if not SocialStopwatch.Stopwatch.get(SocialStopwatch.Events.CaptureShared) then
                SocialStopwatch.Stopwatch.start(SocialStopwatch.Events.CaptureShared)
            end
            callback(ShareCapture(arg2.captureInfo, ExternalShareSourceType.Toast))
        end,
        toastCTAKey = "shareAction",
        toastSubtitleKey = "shareCaptureDescription",
        toastTitleKey = "captureSaved"
    },
    [CapturesToastType.CaptureTakenWithAction] = {
        iconImage = Images["icons/controls/screenshot"],
        onActivated = function(_, _, arg1)
            if arg1 and arg1.toastAction and arg1.captureInfo then
                arg1.toastAction.onActivated(arg1.captureInfo)
            end
        end,
        toastTitleKey = "captureSaved"
    },
    [CapturesToastType.CapturesActivated] = {
        iconImage = Images["icons/status/success"],
        toastTitleKey = "capturesEnabled"
    },
    [CapturesToastType.CaptureTakenWithMomentsCTA] = {
        duration = if FFlagCreateMomentsToast then 5 else nil
    },
    [CapturesToastType.MomentFailed] = {
        iconImage = Images["icons/status/alert"],
        toastSubtitleKey = "momentFailedDescription",
        toastTitleKey = "momentFailedTitle"
    },
    [CapturesToastType.MomentProcessing] = {},
    [CapturesToastType.VideoCaptureFailed] = {
        iconImage = Images["icons/status/alert"],
        toastTitleKey = "videoCaptureFailed"
    },
    [CapturesToastType.VideoCaptureInitializationCapturingAlreadyError] = {
        iconImage = Images["icons/status/alert"],
        toastTitleKey = "videoCaptureInitializationCapturingAlreadyError"
    },
    [CapturesToastType.VideoCaptureInitializationNoDeviceSupportError] = {
        iconImage = Images["icons/status/alert"],
        toastTitleKey = "videoCaptureInitializationNoDeviceSupportError"
    },
    [CapturesToastType.VideoCaptureInitializationNoSpaceOnDeviceError] = {
        iconImage = Images["icons/status/alert"],
        toastTitleKey = "videoCaptureInitializationNoSpaceOnDeviceError"
    },
    [CapturesToastType.VideoCaptureInitializationOtherError] = {
        iconImage = Images["icons/status/alert"],
        toastTitleKey = "videoCaptureInitializationOtherError"
    },
    [CapturesToastType.VideoCaptureOtherError] = {
        iconImage = Images["icons/status/alert"],
        toastTitleKey = "videoCaptureOtherError"
    },
    [CapturesToastType.ViewCapture] = {
        iconImage = Images["icons/controls/screenshot"],
        onActivated = function(arg1, callback)
            arg1.fireEvent(EventNames.CapturesViewToastButtonActivated)
            callback(CarouselOpened(1))
        end,
        toastCTAKey = "viewAction",
        toastTitleKey = "captureSaved"
    }
}

return function(_)
    local var1 = useAnalytics()
    local var2 = useDispatch()

    local var3 = useLocalization({
        captureSaved = "Feature.Captures.Toast.CaptureSaved",
        captureSavedToDevice = "Feature.Captures.Toast.CaptureSavedToDevice",
        capturesEnabled = "Feature.Captures.Toast.CapturesEnabled",
        createAction = "Feature.Captures.Action.Create",
        discoverPostWatch = "Feature.Captures.Description.DiscoverPostWatch",
        momentFailedDescription = "Feature.Moments.Label.MomentFailedToPostBody",
        momentFailedTitle = "Feature.Moments.Label.MomentFailedToPostTitle",
        momentProcessingDescription = "Feature.Captures.Description.MomentProcessing",
        momentProcessingTitle = "Feature.Captures.Toast.MomentProcessing",
        momentsTitle = "Feature.Captures.Toast.CreateMoment2",
        openInFiles = "Feature.Captures.Action.OpenInFiles",
        shareAction = "Feature.Captures.Action.Share",
        shareCaptureDescription = "Feature.Captures.Description.ShareCTA",
        videoCaptureFailed = "Feature.Captures.Toast.VideoCaptureFailed",
        videoCaptureInitializationCapturingAlreadyError = "Feature.Captures.Toast.VideoCaptureInitializationCapturingAlreadyError",
        videoCaptureInitializationNoDeviceSupportError = "Feature.Captures.Toast.VideoCaptureInitializationNoDeviceSupportError",
        videoCaptureInitializationNoSpaceOnDeviceError = "Feature.Captures.Toast.VideoCaptureInitializationNoSpaceOnDeviceError",
        videoCaptureInitializationOtherError = "Feature.Captures.Toast.VideoCaptureInitializationOtherError",
        videoCaptureOtherError = "Feature.Captures.Toast.VideoCaptureOtherError",
        viewAction = "Feature.Captures.Action.ViewCapture"
    })

    local var4 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].Toast.ToastType
    end)

    local var5 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].Toast.ToastConfig
    end)

    local var6 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].Toast.IsDismissed
    end)

    local var7 = React.useCallback(function(arg1)
        return if arg1 then var3[arg1] else nil
    end)

    local toastContent = React.useMemo(function()
        if var4 == CapturesToastType.None then
            return nil
        end

        local var8 = tbl1[var4]
        local var9 = var4

        local function onDismissed() -- Luacid: Inlined by compiler; 1 call site recovered
            if var9 == var4 then
                var2(ToastVanished())
            end
        end

        local onActivated = var8.onActivated and function()
            var8.onActivated(var1, var2, var5)
            onDismissed()
        end or nil

        local duration = var8.duration or Constants.ToastDuration

        local var12 = var7(var8.toastCTAKey)
        if FFlagBuildExperienceInGameCaptureToChat and var5 and var5.toastAction then
            var12 = var5.toastAction.text
        end

        return Dash.join(var8, {
            buttonText = var12,
            duration = duration,
            onActivated = onActivated,
            onDismissed = onDismissed,
            toastCTAKey = Dash.None,
            toastSubtitle = var7(var8.toastSubtitleKey),
            toastSubtitleKey = Dash.None,
            toastTitle = var7(var8.toastTitleKey),
            toastTitleKey = Dash.None
        })
    end, { var4, var5 })

    if not toastContent
        or FFlagMomentsCreationFeatureGate
            and var4 == CapturesToastType.CaptureTakenWithMomentsCTA
            and not GetMomentsCapabilities(false).getCanCreateMoments(false)
    then
        return nil
    elseif FFlagCreateMomentsToast then
        if var4 == CapturesToastType.CaptureTakenWithMomentsCTA then
            return React.createElement(ToastController, {
                title = var7("momentsTitle"),
                text = var7("discoverPostWatch"),
                icon = "icons/brands/moments_large",
                actionText = var7("createAction"),
                onAction = function()
                    if var5 and var5.captureInfo then
                        local creationSessionId = HttpService:GenerateGUID(false)
                        var2(StartMomentsCreationFlow(var5.captureInfo, creationSessionId))
                        var1.fireEvent(EventNames.XExpMomentCreationStarted, { creationSessionId = creationSessionId })
                    end

                    var1.fireEvent(EventNames.CapturesCreateMomentToastButtonActivated)
                end,
                iconAction = FFlagCapturesInExpMomentsToastDownloadButton and {
                    icon = IconName.ArrowDownToLine,
                    onActivated = function()
                        if var5 and var5.captureInfo then
                            getSaveToStoragePermission({ var5.captureInfo }, nil, var2)
                        end
                        var1.fireEvent(EventNames.CapturesCreateMomentToastDownloadActivated)
                    end
                } or nil,
                onDismissed = function()
                    var2(ToastVanished())
                end,
                duration = toastContent.duration,
                show = not var6
            })
        elseif var4 == CapturesToastType.MomentProcessing then
            return React.createElement(ToastController, {
                title = var7("momentProcessingTitle"),
                text = var7("momentProcessingDescription"),
                icon = "icons/brands/moments_large",
                onDismissed = function()
                    var2(ToastVanished())
                end,
                duration = toastContent.duration,
                show = not var6
            })
        elseif var4 == CapturesToastType.MomentFailed then
            return React.createElement(React.Fragment, {}, {
                [var4] = React.createElement(ToastController, {
                    title = var7("momentFailedTitle"),
                    text = var7("momentFailedDescription"),
                    icon = "icons/brands/moments_large",
                    onDismissed = function()
                        var2(ToastVanished())
                    end,
                    duration = toastContent.duration,
                    show = not var6
                })
            })
        end
        return React.createElement(React.Fragment, {}, {
            [var4] = React.createElement(Toast, { duration = toastContent.duration, show = not var6, toastContent = toastContent })
        })
    else
        return React.createElement(React.Fragment, {}, {
            [var4] = React.createElement(Toast, { duration = toastContent.duration, show = not var6, toastContent = toastContent })
        })
    end
end
