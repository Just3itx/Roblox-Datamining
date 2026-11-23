-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local Roact = require(scriptParentParent.Roact)

local ColorMode = require(scriptParentParent.Foundation).Enums.ColorMode

local FadeController = require(scriptParent.FadeController)
local AdLabel = require(scriptParent.AdLabel)
local CircularButton = require(scriptParent.CircularButton)
local LivePreviewWatermark = require(scriptParent.LivePreviewWatermark)

local Flags = require(script.Parent.Flags)
local SharedFlags = require(scriptParentParent.SharedFlags)
local UIBlox = require(scriptParentParent.UIBlox)
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local AppStyleProvider = UIBlox.App.Style.AppStyleProvider

local Images = UIBlox.App.ImageSet.Images
local iconsControlsSpeakerMute = Images["icons/controls/speakerMute"]
local iconsControlsSpeaker = Images["icons/controls/speaker"]
local iconsActionsPreviewExpand = Images["icons/actions/previewExpand"]
local iconsActionsPreviewShrink = Images["icons/actions/previewShrink"]
local iconsControlsMediaPlayLarge = Images["icons/controls/media-play-large"]
local iconsControlsMediaPauseLarge = Images["icons/controls/media-pause-large"]
local iconsNavigationClose = Images["icons/navigation/close"]
local component_assetsCircle_42_stroke_3 = Images["component_assets/circle_42_stroke_3"]

local fFlagEnableReportAdDropdown = Flags.GetFFlagEnableReportAdDropdown()
local enableHideReportAdModalDuringScreenshot = Flags.GetEnableHideReportAdModalDuringScreenshot()
local FFlagFixReportAdInfoDuringRotation = Flags.FFlagFixReportAdInfoDuringRotation
local FFlagInExperienceUseAppStyleProvider = SharedFlags.FFlagInExperienceUseAppStyleProvider
local ArgCheck = if FFlagFixReportAdInfoDuringRotation then require(scriptParentParent.ArgCheck) else nil
local ReportAdPopup = if fFlagEnableReportAdDropdown then require(scriptParent.ReportAdPopup) else nil
local AdDropdownMenu = if fFlagEnableReportAdDropdown then require(scriptParent.AdDropdownMenu) else nil
local AdsInteractivityTelemetry = require(scriptParent.AdsInteractivityTelemetry)

local var1 = Roact.PureComponent:extend("AdsInteractivityControls")

local function opacityToTransparency(num1: number): number -- Luacid: Inlined by compiler; 7 call sites recovered
    return 1 - num1
end

local PixelsPerStud = Flags.GetAdGuiInteractivityPixelsPerStud()

local function getAdornee(adGui) -- Luacid: Inlined by compiler; 2 call sites recovered
    if adGui == nil then
        return nil
    end

    if adGui.Adornee == nil then
        if adGui.Parent == nil or not adGui.Parent:IsA("BasePart") then
            return nil
        end

        return adGui.Parent
    end

    return adGui.Adornee
end

function var1.init(arg1)
    if game:GetEngineFeature("DeprecateCpv15") then
        arg1.state = {
            adUIType = Enum.AdUIType.None,
            adGuiRectStuds = Vector2.new(0, 0),
            isViewable = false,
            videoPlaying = false,
            isFullscreen = false,
            eudsaPromptActive = false,
            isDropDownOpen = false,
            isReportAdPopupOpen = false,
            hideLivePreviewWatermark = false
        }
    else
        arg1.state = {
            adUIType = Enum.AdUIType.None,
            adGuiRectStuds = Vector2.new(0, 0),
            isViewable = false,
            videoPlaying = false,
            isFullscreen = false,
            isClickToPlay = false,
            eudsaPromptActive = false,
            isDropDownOpen = false,
            isReportAdPopupOpen = false,
            hideLivePreviewWatermark = false
        }
    end

    local function onAdorneeChanged()
        arg1:setState({ adornee = getAdornee(arg1.props.adGui) })
    end

    arg1.signalConnections = { arg1.props.adGui:GetPropertyChangedSignal("Adornee"):Connect(onAdorneeChanged), arg1.props.adGui:GetPropertyChangedSignal("Parent"):Connect(onAdorneeChanged) }

    arg1.props.adGui.adGuiStateChanged:Connect(function(arg2)
        arg1:setState(arg2)
    end)

    arg1.fadeController = FadeController.new()
    local controlsOpacity, updateControlsOpacity = Roact.createBinding(1)
    arg1.controlsOpacity = controlsOpacity
    arg1.updateControlsOpacity = updateControlsOpacity

    arg1.fadeController:subscribe(function(arg2)
        arg1.updateControlsOpacity(arg2)
    end)

    arg1.props.adGui:forwardStateToLuaUI()
end

function var1.willUnmount(arg1)
    for _, signalConnection in ipairs(arg1.signalConnections) do
        signalConnection:Disconnect()
    end
end

function var1.render(arg1)
    if not arg1.props.adGui then
        return nil
    end

    local bool1 = arg1.state.adUIType == Enum.AdUIType.Video
    local bool2 = arg1.state.adUIType == Enum.AdUIType.None

    local var2 = nil
    if game:GetEngineFeature("DeprecateCpv15") then
        if bool1 and arg1.state.isFullscreen then
            if arg1.state.videoPlaying then
                var2 = iconsControlsMediaPauseLarge
            else
                var2 = iconsControlsMediaPlayLarge
            end
        end
    elseif bool1 then
        if arg1.state.isFullscreen and not arg1.state.videoPlaying or arg1.state.isClickToPlay and not arg1.state.isFullscreen then
            var2 = iconsControlsMediaPlayLarge
        elseif arg1.state.isFullscreen and arg1.state.videoPlaying then
            var2 = iconsControlsMediaPauseLarge
        end
    end

    local isFullscreen = bool1 and arg1.state.isFullscreen
    local videoPlaying = if game:GetEngineFeature("DeprecateCpv15") then bool1 and not arg1.state.isFullscreen and arg1.state.videoPlaying else bool1 and not arg1.state.isFullscreen and not arg1.state.isClickToPlay and arg1.state.videoPlaying
    local image = arg1.state.volumeEnabled and iconsControlsSpeaker or iconsControlsSpeakerMute
    local var3 = arg1.state.isFullscreen and iconsActionsPreviewShrink or iconsActionsPreviewExpand
    local vector2 = Vector2.new(0.10038949275, 0.17847020934)
    if not arg1.state.isFullscreen then
        vector2 *= 1.5
    end
    local var5 = arg1.controlsOpacity:map(function(num1: number): boolean
        if var2 == iconsControlsMediaPlayLarge then
            return true
        end
        return not (var2 == nil) and num1 and num1 > 0
    end)

    if not arg1.state.isViewable then
        var5 = false
    end

    local imageTransparency = arg1.controlsOpacity:map(function(num1: number)
        if var2 == iconsControlsMediaPlayLarge then
            return (opacityToTransparency(0.8))
        end

        return opacityToTransparency(num1 * 0.8)
    end)

    local createElement = Roact.createElement
    local str1 = "SurfaceGui"
    local tbl1 = {
        ZOffset = 1,
        ZIndexBehavior = if fFlagEnableReportAdDropdown then Enum.ZIndexBehavior.Sibling else Enum.ZIndexBehavior.Global,
        LightInfluence = 0,
        SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud,
        PixelsPerStud = PixelsPerStud,
        Adornee = getAdornee(arg1.props.adGui),
        Face = arg1.props.adGui.Face,
        AlwaysOnTop = arg1.state.isFullscreen,
        Brightness = 2
    }
    local tbl2 = { InteractiveArea = 0 }
    local createElement2 = Roact.createElement
    local str2 = "TextButton"

    local tbl3 = {
        Size = UDim2.fromOffset(arg1.state.adGuiRectStuds.X * PixelsPerStud, arg1.state.adGuiRectStuds.Y * PixelsPerStud),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.new(0, 0, 0),
        BackgroundTransparency = arg1.controlsOpacity:map(function(num1: number)
            if var2 == iconsControlsMediaPlayLarge then
                return (opacityToTransparency(0.30000000000000004))
            end

            return opacityToTransparency(num1 * 0.3)
        end),
        Text = ""
    }

    tbl3[Roact.Event.MouseMoved] = function(_, _)
        if bool1 and arg1.state.isFullscreen then
            arg1.fadeController:updateLastInputTime()
        end
    end
    tbl3[Roact.Event.Activated] = function(_, arg2)
        if fFlagEnableReportAdDropdown and arg1.state.isDropDownOpen then
            arg1:setState({ isDropDownOpen = false })

            arg1.props.adGui:HandleLuaUIEvent(Enum.AdUIEventType.PlayEventTriggered)

            arg1.props.adGui:HandleLuaUIEvent(Enum.AdUIEventType.PlayButtonClicked)
            AdsInteractivityTelemetry.logAdMenuEvent("close")
            return
        end
        if not bool1 then
            return
        end

        if not arg1.state.isFullscreen then
            if arg1.state.isViewable then
                arg1.props.adGui:HandleLuaUIEvent(Enum.AdUIEventType.FullscreenButtonClicked)
            end

            return
        end
        if not arg1.state.videoPlaying then
            arg1.props.adGui:HandleLuaUIEvent(Enum.AdUIEventType.PlayButtonClicked)
            return
        end

        if arg2.UserInputType ~= Enum.UserInputType.Touch then
            arg1.props.adGui:HandleLuaUIEvent(Enum.AdUIEventType.PauseButtonClicked)
            return
        end

        if arg1.fadeController:inProgress() and not arg1.fadeController:isFading() then
            arg1.fadeController:skipToFade()
            return
        end
        arg1.fadeController:updateLastInputTime()
    end

    local tbl4 = {
        AbuseReportingModal = 0,
        AdDropdownMenu = 0,
        AdLabel = 0,
        CloseButton = 0,
        PlayPauseButton = 0,
        VolumeButton = 0,
        FullscreenButton = 0,
        LivePreviewWatermark = 0
    }
    local var7

    if fFlagEnableReportAdDropdown and ReportAdPopup and arg1.state.isReportAdPopupOpen then
        local createElement3 = Roact.createElement
        local var8 = ReportAdPopup

        local tbl5 = {
            showReportAdPopup = arg1.state.isReportAdPopupOpen,
            onClose = function()
                arg1:setState({ isReportAdPopupOpen = false })
            end,
            onOpen = enableHideReportAdModalDuringScreenshot and function()
                arg1:setState({ isReportAdPopupOpen = true })

                AdsInteractivityTelemetry.logReportAdEvent("open")
            end or nil,
            adInfo = if FFlagFixReportAdInfoDuringRotation then ArgCheck.isNotNil(arg1.state.reportAdInfo, "reportAdInfo") or arg1.props.adGui:GetSingleReportAdInfo() else arg1.props.adGui:GetSingleReportAdInfo()
        }

        var7 = createElement3(var8, tbl5) or nil
    else
        var7 = nil
    end

    tbl4.AbuseReportingModal = var7

    tbl4.AdDropdownMenu = if fFlagEnableReportAdDropdown and AdDropdownMenu then Roact.createElement(AdDropdownMenu, {
        showDropDownMenu = arg1.state.isDropDownOpen,
        onWhyThisAdActivated = function()
            arg1.props.adGui:HandleLuaUIEvent(Enum.AdUIEventType.WhyThisAdClicked)
            AdsInteractivityTelemetry.logWhyThisAdEvent()
        end,
        onReportAdActivated = function()
            arg1:setState({ isReportAdPopupOpen = true })
        end,
        transparency = opacityToTransparency(0.8)
    }) else nil

    tbl4.AdLabel = Roact.createElement(AdLabel, {
        onActivated = fFlagEnableReportAdDropdown and function()
            if FFlagFixReportAdInfoDuringRotation then
                local tbl5 = {
                    isDropDownOpen = not arg1.state.isDropDownOpen
                }
                if not arg1.state.isDropDownOpen then
                    tbl5.reportAdInfo = arg1.props.adGui:GetSingleReportAdInfo()
                end
                arg1:setState(tbl5)
            else
                arg1:setState({ isDropDownOpen = not arg1.state.isDropDownOpen })
            end

            if arg1.state.isDropDownOpen then
                arg1.props.adGui:HandleLuaUIEvent(Enum.AdUIEventType.PlayEventTriggered)
                arg1.props.adGui:HandleLuaUIEvent(Enum.AdUIEventType.PlayButtonClicked)
            else
                arg1.props.adGui:HandleLuaUIEvent(Enum.AdUIEventType.PauseEventTriggered)
                arg1.props.adGui:HandleLuaUIEvent(Enum.AdUIEventType.PauseButtonClicked)
            end
            AdsInteractivityTelemetry.logAdMenuEvent(if arg1.state.isDropDownOpen then "open" else "close")
        end or function()
            arg1.props.adGui:HandleLuaUIEvent(Enum.AdUIEventType.AdLabelClicked)
        end,
        isMenuOpen = arg1.state.isDropDownOpen,
        Visible = not bool2
    })
    tbl4.CloseButton = Roact.createElement(CircularButton, {
        HorizontalScale = 0.06884057971,
        Position = UDim2.fromScale(0.995, 0.005),
        AnchorPoint = Vector2.new(1, 0),
        ImageSize = UDim2.fromScale(0.8, 0.8),
        Image = iconsNavigationClose,
        Visible = isFullscreen,
        Transparency = imageTransparency,
        AutoButtonColor = not (fFlagEnableReportAdDropdown and arg1.state.isDropDownOpen),
        onActivated = function()
            if not (fFlagEnableReportAdDropdown and arg1.state.isDropDownOpen) then
                arg1.props.adGui:HandleLuaUIEvent(Enum.AdUIEventType.CloseButtonClicked)
                return
            end

            arg1:setState({ isDropDownOpen = false })

            arg1.props.adGui:HandleLuaUIEvent(Enum.AdUIEventType.PlayEventTriggered)
            arg1.props.adGui:HandleLuaUIEvent(Enum.AdUIEventType.PlayButtonClicked)
            AdsInteractivityTelemetry.logAdMenuEvent("close")
        end
    })

    local createElement3 = Roact.createElement
    local tbl5 = {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(vector2.X, vector2.Y),
        Visible = var5,
        AutoButtonColor = not (fFlagEnableReportAdDropdown and arg1.state.isDropDownOpen)
    }

    tbl5[Roact.Event.Activated] = function()
        if fFlagEnableReportAdDropdown and arg1.state.isDropDownOpen then
            arg1:setState({ isDropDownOpen = false })

            arg1.props.adGui:HandleLuaUIEvent(Enum.AdUIEventType.PlayEventTriggered)
            arg1.props.adGui:HandleLuaUIEvent(Enum.AdUIEventType.PlayButtonClicked)
            AdsInteractivityTelemetry.logAdMenuEvent("close")
        elseif var2 == iconsControlsMediaPlayLarge then
            arg1.props.adGui:HandleLuaUIEvent(Enum.AdUIEventType.PlayButtonClicked)
        elseif var2 == iconsControlsMediaPauseLarge then
            arg1.props.adGui:HandleLuaUIEvent(Enum.AdUIEventType.PauseButtonClicked)
        end
    end

    tbl4.PlayPauseButton = createElement3("ImageButton", tbl5, {
        circle = Roact.createElement(ImageSetLabel, {
            Image = component_assetsCircle_42_stroke_3,
            Size = UDim2.fromScale(1, 1),
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            ImageTransparency = imageTransparency
        }),
        icon = Roact.createElement(ImageSetLabel, {
            Image = var2,
            Size = UDim2.fromScale(0.6, 0.6),
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            ImageTransparency = imageTransparency
        })
    })

    tbl4.VolumeButton = Roact.createElement(CircularButton, {
        Visible = videoPlaying,
        Position = UDim2.fromScale(0.075, 0.75),
        HorizontalScale = 0.12,
        Image = image,
        ImageSize = UDim2.fromScale(0.8, 0.8),
        AutoButtonColor = not (fFlagEnableReportAdDropdown and arg1.state.isDropDownOpen),
        onActivated = function()
            if not (fFlagEnableReportAdDropdown and arg1.state.isDropDownOpen) then
                arg1.props.adGui:HandleLuaUIEvent(Enum.AdUIEventType.VolumeButtonClicked)
                return
            end

            arg1:setState({ isDropDownOpen = false })

            arg1.props.adGui:HandleLuaUIEvent(Enum.AdUIEventType.PlayEventTriggered)
            AdsInteractivityTelemetry.logAdMenuEvent("close")
        end,
        Transparency = opacityToTransparency(0.8)
    })

    tbl4.FullscreenButton = Roact.createElement(CircularButton, {
        Visible = videoPlaying,
        Position = UDim2.fromScale(0.87625, 0.75),
        AnchorPoint = Vector2.new(1, 0),
        HorizontalScale = 0.12,
        Image = var3,
        ImageSize = UDim2.fromScale(0.7, 0.7),
        AutoButtonColor = not (fFlagEnableReportAdDropdown and arg1.state.isDropDownOpen),
        onActivated = function()
            if not (fFlagEnableReportAdDropdown and arg1.state.isDropDownOpen) then
                arg1.props.adGui:HandleLuaUIEvent(Enum.AdUIEventType.FullscreenButtonClicked)
                return
            end

            arg1:setState({ isDropDownOpen = false })

            arg1.props.adGui:HandleLuaUIEvent(Enum.AdUIEventType.PlayEventTriggered)
            AdsInteractivityTelemetry.logAdMenuEvent("close")
        end,
        Transparency = opacityToTransparency(0.8)
    })
    tbl4.LivePreviewWatermark = Roact.createElement(LivePreviewWatermark, { IsVisible = not arg1.state.hideLivePreviewWatermark } or nil) or nil
    tbl2.InteractiveArea = createElement2(str2, tbl3, tbl4)
    return createElement(str1, tbl1, tbl2)
end

return if FFlagInExperienceUseAppStyleProvider then function(arg1) -- name: AdsInteractivityFunctionalWrapper
    return Roact.createElement(
        AppStyleProvider,
        {
            style = {
                themeName = ColorMode.Dark
            }
        },
        {
            AdsInteractivityControls = Roact.createElement(var1, arg1)
        }
    )
end else var1
