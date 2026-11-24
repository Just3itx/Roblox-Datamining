-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExperienceLoadingScript = script:FindFirstAncestor("ExperienceLoadingScript")

if require(ExperienceLoadingScript.Flags.FFlagUseSharedLoadingScreenView) then
    return require(ExperienceLoadingScript.LoadingScreenWrapper)
end

local ExperienceLoadingScriptParent = ExperienceLoadingScript.Parent

local ContextActionService = game:GetService("ContextActionService")
local CoreGui = game:GetService("CoreGui")
local ExperienceService = game:GetService("ExperienceService")
local GuiService = game:GetService("GuiService")
local LocalizationService = game:GetService("LocalizationService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local React = require(ExperienceLoadingScriptParent.React)
local Cryo = require(ExperienceLoadingScriptParent.Cryo)
local Roact = require(ExperienceLoadingScriptParent.Roact)
local RoactRodux = require(ExperienceLoadingScriptParent.RoactRodux)
local ExternalEventConnection = require(ExperienceLoadingScriptParent.RoactUtils).ExternalEventConnection
local GetGameProductInfo = require(ExperienceLoadingScript.Thunks.GetGameProductInfo)
local GetIsSubjectToChinaPolicies = require(ExperienceLoadingScript.Thunks.GetIsSubjectToChinaPolicies)
local GetUniverseId = require(ExperienceLoadingScript.Thunks.GetUniverseId)
local ProgressLoading = require(ExperienceLoadingScriptParent.ProgressLoading)
local PlaceLauncherState = ProgressLoading.PlaceLauncherState

local VerifiedBadges = require(ExperienceLoadingScriptParent.VerifiedBadges)
local LoggingProtocol = require(ExperienceLoadingScriptParent.LoggingProtocol)
local UIBlox = require(ExperienceLoadingScriptParent.UIBlox)
local FFlagIncreaseLoadingScreenOrder = require(ExperienceLoadingScriptParent.SharedFlags).FFlagIncreaseLoadingScreenOrder
local FFlagLoadingScreenControlMilestones = require(ExperienceLoadingScriptParent.SharedFlags).FFlagLoadingScreenControlMilestones
local LoadingScreenMilestones = require(ExperienceLoadingScriptParent.ProgressLoading.LoadingScreenMilestones)

local withStyle = UIBlox.Style.withStyle
local Responsive = require(ExperienceLoadingScriptParent.Responsive)

local Foundation = require(ExperienceLoadingScriptParent.Foundation)
local IconSize = Foundation.Enums.IconSize
local Loading = Foundation.Loading

local FoundationProvider = Foundation.FoundationProvider
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local Localization = require(ExperienceLoadingScriptParent.InExperienceLocales).Localization
local LocalizationProvider = require(ExperienceLoadingScriptParent.Localization).LocalizationProvider

local AutoTranslateBadge = ProgressLoading.AutoTranslateBadge
local LoadingScreenTelemetry = require(ExperienceLoadingScriptParent.ProgressLoading.LoadingScreenTelemetry)
local PolicyContainer = ProgressLoading.PolicyContainer
local ServerStatus = ProgressLoading.ServerStatus
local ServerStatusWithCountdown = ProgressLoading.ServerStatusWithCountdown

local localization = Localization.new(LocalizationService.RobloxLocaleId)

local QueueExperimentation = require(ExperienceLoadingScriptParent.SocialExperiments).QueueExperimentation

local GetFFlagReportFirstExperienceCancelled = require(ExperienceLoadingScript.Flags.GetFFlagReportFirstExperienceCancelled)

local createNetworking = ProgressLoading.createNetworking

local DisplayOrder = if FFlagIncreaseLoadingScreenOrder then 8 else 7

local vector2 = Vector2.new(768, 432)

local darkStoneGrey = Color3.fromRGB(101, 102, 104)

local tbl1 = {
    MOBILE_PORTRAIT = { TOP = 44, BOTTOM = 44, LEFT = 24, RIGHT = 24 },
    MOBILE_LANDSCAPE = { TOP = 24, BOTTOM = 24, LEFT = 44, RIGHT = 44 },
    DESKTOP = { TOP = 24, BOTTOM = 24, LEFT = 24, RIGHT = 24 },
    CONSOLE = { TOP = 64, BOTTOM = 64, LEFT = 64, RIGHT = 64 }
}

local showTenFootCancelBtn = require(ExperienceLoadingScriptParent.AppCommonLib).isTenFootInterface()
local platform = UserInputService:GetPlatform()
local bool1 = platform == Enum.Platform.IOS or platform == Enum.Platform.Android

local tbl2 = { 150, 256 }

local var2 = nil
local num2 = 0
local huge = math.huge

local function getPadding(isPortrait) -- Luacid: Inlined by compiler; 1 call site recovered
    if bool1 then
        return isPortrait and tbl1.MOBILE_PORTRAIT or tbl1.MOBILE_LANDSCAPE
    end

    if showTenFootCancelBtn then
        return tbl1.CONSOLE
    end

    return tbl1.DESKTOP
end

local function lerp(arg1, arg2) -- Luacid: Inlined by compiler; 19 call sites recovered
    if type(arg1) ~= "table" or not (#arg1 >= 2) then
        return 0
    end

    local num3 = math.clamp(arg2, 0, 1)
    return arg1[1] * (1 - num3) + arg1[2] * num3
end

local tbl3 = {
    FadeIn = function(arg1, _, arg2, callback)
        local tbl3 = { 1, 1 }
        local tbl4 = { 1, 0 }
        local tbl5 = { 1, 0.2 }
        if arg1 <= 0.6 then
            local var3 = arg1 / 0.6
            arg2.iconTransparency((lerp(tbl4, var3)))
            arg2.iconSize((lerp(tbl3, var3)))
            arg2.infoFrameTransparency((lerp(tbl5, var3)))
            arg2.thumbnailTransparency((lerp(tbl4, var3)))
            arg2.placeTextTransparency((lerp(tbl4, var3)))
            arg2.placeTextSize((lerp(tbl3, var3)))
            arg2.creatorTextTransparency((lerp(tbl4, var3)))
            arg2.creatorTextSize((lerp(tbl3, var3)))
            return
        end

        arg2.iconTransparency(if type(tbl4) ~= "table" then 0 elseif #tbl4 >= 2 then tbl4[1] * 0 + tbl4[2] * 1 else 0)
        arg2.iconSize(if type(tbl3) ~= "table" then 0 elseif #tbl3 >= 2 then tbl3[1] * 0 + tbl3[2] * 1 else 0)
        arg2.infoFrameTransparency(if type(tbl5) ~= "table" then 0 elseif #tbl5 >= 2 then tbl5[1] * 0 + tbl5[2] * 1 else 0)
        arg2.thumbnailTransparency(if type(tbl4) ~= "table" then 0 elseif #tbl4 >= 2 then tbl4[1] * 0 + tbl4[2] * 1 else 0)
        arg2.placeTextTransparency(if type(tbl4) ~= "table" then 0 elseif #tbl4 >= 2 then tbl4[1] * 0 + tbl4[2] * 1 else 0)
        arg2.placeTextSize(if type(tbl3) ~= "table" then 0 elseif #tbl3 >= 2 then tbl3[1] * 0 + tbl3[2] * 1 else 0)
        arg2.creatorTextTransparency(if type(tbl4) ~= "table" then 0 elseif #tbl4 >= 2 then tbl4[1] * 0 + tbl4[2] * 1 else 0)
        arg2.creatorTextSize(if type(tbl3) ~= "table" then 0 elseif #tbl3 >= 2 then tbl3[1] * 0 + tbl3[2] * 1 else 0)
        callback()
    end,
    FadeOut = function(arg1, _, arg2, callback)
        local tbl3 = { 1, 0.6 }
        local tbl4 = { 0, 1 }
        local tbl5 = { 0.2, 1 }

        if arg1 <= 0.6 then
            local var3 = arg1 / 0.6
            arg2.iconTransparency((lerp(tbl4, var3)))
            arg2.iconSize((lerp(tbl3, var3)))
            arg2.infoFrameTransparency((lerp(tbl5, var3)))
            arg2.thumbnailTransparency((lerp(tbl4, var3)))
            arg2.placeTextTransparency((lerp(tbl4, var3)))
            arg2.placeTextSize((lerp(tbl3, var3)))
            arg2.creatorTextTransparency((lerp(tbl4, var3)))
            arg2.creatorTextSize((lerp(tbl3, var3)))
            return
        end
        RunService:SetRobloxGuiFocused(false)
        arg2.iconTransparency(if type(tbl4) ~= "table" then 0 elseif #tbl4 >= 2 then tbl4[1] * 0 + tbl4[2] * 1 else 0)
        arg2.iconSize(if type(tbl3) ~= "table" then 0 elseif #tbl3 >= 2 then tbl3[1] * 0 + tbl3[2] * 1 else 0)
        arg2.infoFrameTransparency(if type(tbl5) ~= "table" then 0 elseif #tbl5 >= 2 then tbl5[1] * 0 + tbl5[2] * 1 else 0)
        arg2.thumbnailTransparency(if type(tbl4) ~= "table" then 0 elseif #tbl4 >= 2 then tbl4[1] * 0 + tbl4[2] * 1 else 0)
        arg2.placeTextTransparency(if type(tbl4) ~= "table" then 0 elseif #tbl4 >= 2 then tbl4[1] * 0 + tbl4[2] * 1 else 0)
        arg2.placeTextSize(if type(tbl3) ~= "table" then 0 elseif #tbl3 >= 2 then tbl3[1] * 0 + tbl3[2] * 1 else 0)
        arg2.creatorTextTransparency(if type(tbl4) ~= "table" then 0 elseif #tbl4 >= 2 then tbl4[1] * 0 + tbl4[2] * 1 else 0)
        arg2.creatorTextSize(if type(tbl3) ~= "table" then 0 elseif #tbl3 >= 2 then tbl3[1] * 0 + tbl3[2] * 1 else 0)
        callback()
    end
}

local function disconnectAndCloseHealthStat() -- Luacid: Inlined by compiler; 1 call site recovered
    if var2 then
        var2:disconnect()
        var2 = nil
        GuiService:CloseStatsBasedOnInputString("ConnectionHealth")
    end
end

local var3 = Roact.Component:extend("LoadingScreen")

function var3.playAnimation(arg1, animationFunction, arg2, callback)
    arg1.animationStartTime = tick()
    arg1.animationFunction = animationFunction

    if arg1.renderSteppedConnection then
        return
    end

    arg1.renderSteppedConnection = RunService.RenderStepped:Connect(function()
        arg1.animationFunction(tick() - arg1.animationStartTime, arg2, arg1.updateBindings, function()
            arg1:stopAnimation()
            if callback then
                callback()
            end
        end)
    end)
end

function var3.stopAnimation(arg1)
    if arg1.renderSteppedConnection then
        arg1.renderSteppedConnection:Disconnect()
        arg1.renderSteppedConnection = nil
    end
end

function var3.renderBackground(arg1, arg2)
    local thumbnailScaledWidth = arg1.state.thumbnailScaledWidth
    local thumbnailScaledHeight = arg1.state.thumbnailScaledHeight
    local thumbnailPositionX = arg1.state.thumbnailPositionX

    local image = if arg1.props.placeId and arg1.props.placeId > 0 then ("rbxthumb://type=GameThumbnail&id=%d&w=768&h=432"):format(arg1.props.placeId) else ""

    local reducedMotion = arg2.Settings.ReducedMotion
    return Roact.createElement(
        "ScreenGui",
        {
            DisplayOrder = DisplayOrder,
            IgnoreGuiInset = true,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        },
        { Roact.createElement("Frame", {
                Name = "BackgroundFrame",
                [Roact.Change.AbsoluteSize] = arg1.onAbsoluteSizeChange,
                BackgroundColor3 = arg2.Theme.BackgroundUIDefault.Color,
                BackgroundTransparency = 0,
                BorderSizePixel = 0,
                Size = UDim2.fromScale(1, 1),
                Position = UDim2.fromScale(0.5, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Active = true
            }, {
                ThumbnailImage = Roact.createElement("ImageLabel", {
                    BackgroundTransparency = 1,
                    Image = image,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(thumbnailPositionX, 0.5),
                    Size = UDim2.fromOffset(thumbnailScaledWidth, thumbnailScaledHeight),
                    ImageTransparency = arg1.bindings.thumbnailTransparency
                }),
                renderStepped = not reducedMotion
                    and Roact.createElement(
                        ExternalEventConnection,
                        {
                            event = RunService.renderStepped,
                            callback = arg1.renderBackgroundSteppedCallback
                        }
                    )
            }) }
    )
end

function var3.showConnnectionHealthDebugMenu(_, _)
    if num2 == 0 then
        num2 = 1
        huge = tick()
        return
    end
    if bool1 and tick() - huge <= 0.5 then
        GuiService:ShowStatsBasedOnInputString("ConnectionHealth")
    end

    num2 = 0
    huge = math.huge
end

function var3.renderPlaceIcon(arg1, arg2)
    local shimPos = arg1.state.shimPos
    local value = arg1.bindings.iconTransparency:getValue()

    local image = if arg1.props.universeId and arg1.props.universeId > 0 then ("rbxthumb://type=GameIcon&id=%d&w=256&h=256"):format(arg1.props.universeId) else ""

    local reducedMotion = arg2.Settings.ReducedMotion
    return Roact.createElement("Frame", {
        Name = "IconFrame",
        BackgroundTransparency = arg1.bindings.iconTransparency,
        BackgroundColor3 = darkStoneGrey,
        BorderSizePixel = 0,
        Size = arg1.bindings.iconSize,
        Position = UDim2.fromScale(0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Active = true
    }, {
        LoadingOverlay = not reducedMotion
            and Roact.createElement("Frame", {
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                Size = UDim2.fromScale(1, 1),
                BackgroundColor3 = Color3.new(1, 1, 1),
                BackgroundTransparency = 0,
                ZIndex = 2
            }, {
                Corner = Roact.createElement("UICorner"),
                Gradient = Roact.createElement("UIGradient", {
                    Rotation = 25,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.5, 0.5, 0.5)), ColorSequenceKeypoint.new(0.5, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(0.5, 0.5, 0.5)) }),
                    Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, (lerp({ 0.7, 1 }, value))), NumberSequenceKeypoint.new(0.5, (lerp({ 0.3, 1 }, value))), NumberSequenceKeypoint.new(1, (lerp({ 0.7, 1 }, value))) }),
                    Offset = Vector2.new(shimPos, 0)
                }),
                renderStepped = Roact.createElement(
                    ExternalEventConnection,
                    {
                        event = RunService.renderStepped,
                        callback = arg1.renderShimmerCallback
                    }
                )
            }),
        GameIconImage = Roact.createElement("ImageLabel", {
            BackgroundTransparency = 1,
            Image = image,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(1, 1),
            ImageTransparency = arg1.bindings.iconTransparency
        }, {
            Corner = Roact.createElement("UICorner")
        }),
        Corner = Roact.createElement("UICorner")
    })
end

function var3.renderInfoFrame(arg1, arg2)
    local productInfo = arg1.props.productInfo
    local productInfoName = productInfo and productInfo.Name or ""
    local creatorName = productInfo and productInfo.Creator.Name or ""

    if productInfo and productInfo.Creator.HasVerifiedBadge then
        creatorName = VerifiedBadges.appendVerifiedBadge(creatorName)
    end

    local num3 = math.clamp(math.max(arg1.state.absoluteSize.X, arg1.state.absoluteSize.Y) / 1024 * tbl2[1], tbl2[1], tbl2[2])
    local createElement = Roact.createElement
    local tbl4 = {
        Name = "InfoFrame",
        BackgroundColor3 = arg2.Theme.BackgroundMuted.Color,
        BackgroundTransparency = arg1.bindings.infoFrameTransparency,
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0.5),
        AutomaticSize = Enum.AutomaticSize.Y,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = arg1.isPortrait and UDim2.fromScale(1, 0) or UDim2.fromScale(0.6, 0),
        Active = true
    }

    tbl4[Roact.Change.AbsoluteSize] = function(arg3)
        arg1.updateBindings.updateInfoFrameAbsoluteSize(arg3.AbsoluteSize)
    end

    return createElement("Frame", tbl4, {
        PlaceIcon = arg1:renderPlaceIcon(arg2),
        TextLayoutFrame = Roact.createElement("Frame", {
            Name = "TextLayout",
            BackgroundColor3 = arg2.Theme.BackgroundMuted.Color,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            AnchorPoint = Vector2.new(0.5, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Position = UDim2.new(0.5, 0, 0, num3 / 2),
            Size = UDim2.fromScale(1, 0),
            Active = true
        }, {
            PlaceLabel = Roact.createElement("TextLabel", {
                Name = "PlaceLabel",
                BackgroundTransparency = 1,
                TextTransparency = arg1.bindings.placeTextTransparency,
                Size = UDim2.fromScale(0.8, 0),
                AnchorPoint = Vector2.new(0.5, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                FontFace = normalizeFontFace(arg2.Tokens.Typography.HeadingLarge.Font),
                TextSize = arg1.bindings.placeTextSize,
                TextScaled = false,
                TextWrapped = true,
                TextColor3 = arg2.Theme.TextEmphasis.Color,
                TextStrokeTransparency = 1,
                Text = productInfoName,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center,
                ZIndex = 2,
                LayoutOrder = 1,
                TextTruncate = Enum.TextTruncate.AtEnd,
                RichText = false
            }),
            CreatorLabel = Roact.createElement("TextLabel", {
                Name = "CreatorLabel",
                BackgroundTransparency = 1,
                TextTransparency = arg1.bindings.creatorTextTransparency,
                Size = UDim2.fromScale(0.6, 0),
                AnchorPoint = Vector2.new(0.5, 1),
                AutomaticSize = Enum.AutomaticSize.Y,
                FontFace = normalizeFontFace(arg2.Tokens.Typography.BodySmall.Font),
                TextSize = arg1.bindings.creatorTextSize,
                TextWrapped = true,
                TextScaled = false,
                TextColor3 = arg2.Theme.TextDefault.Color,
                TextStrokeTransparency = 1,
                Text = creatorName,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center,
                ZIndex = 2,
                LayoutOrder = 2,
                TextTruncate = Enum.TextTruncate.AtEnd,
                RichText = false
            }),
            UIListLayout = Roact.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, if bool1 then 12 else 36)
            }),
            Padding = Roact.createElement(
                "UIPadding",
                {
                    PaddingTop = UDim.new(0, if bool1 then 12 else 36),
                    PaddingBottom = UDim.new(0, if bool1 then 12 else 36)
                }
            )
        }),
        Corner = Roact.createElement("UICorner")
    })
end

function var3.renderMain(arg1, arg2)
    local padding = getPadding(arg1.isPortrait)

    local reducedMotion = arg2.Settings.ReducedMotion
    local createElement = Roact.createElement
    local str1 = "ScreenGui"
    local tbl4 = {
        DisplayOrder = DisplayOrder + 1,
        IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        OnTopOfCoreBlur = true
    }
    local tbl5 = {
        DarkGradient = Roact.createElement("Frame", {
            BackgroundTransparency = 0,
            BorderSizePixel = 0,
            Size = UDim2.fromScale(1, 1),
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5)
        }, {
            Gradient = Roact.createElement("UIGradient", {
                Rotation = 90,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0)) }),
                Transparency = NumberSequence.new(
                    { NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 1), NumberSequenceKeypoint.new(1, 0.5) }
                )
            }),
            Spinner = reducedMotion
                and Roact.createElement(
                    "Frame",
                    {
                        Size = UDim2.fromScale(1, 1),
                        BackgroundColor3 = Color3.new(1, 1, 1),
                        BackgroundTransparency = 1,
                        ZIndex = 20
                    },
                    { Roact.createElement(
                            Loading,
                            {
                                size = IconSize.Medium,
                                Position = UDim2.new(1, 0, 1, 0),
                                AnchorPoint = Vector2.new(1, 1)
                            }
                        ) }
                ),
            infoFrame = arg1:renderInfoFrame(arg2),
            AutoTranslate = arg1:renderAutoTranslate(),
            serverFrame = if arg1.isQueueTreatmentEnabled then nil else arg1:renderServerFrame(arg2),
            policyContainer = if arg1.isQueueTreatmentEnabled then arg1:renderPolicyContainer() else nil,
            serverStatusContainer = if arg1.isQueueTreatmentEnabled then arg1:renderServerStatus() else nil,
            closeBtn = arg1:renderCloseBtn(arg2),
            gamepadCancelBtn = arg1:renderGamepadCancelBtn(arg2),
            Padding = Roact.createElement("UIPadding", {
                PaddingLeft = UDim.new(0, padding.LEFT),
                PaddingRight = UDim.new(0, padding.RIGHT),
                PaddingTop = UDim.new(0, padding.TOP),
                PaddingBottom = UDim.new(0, padding.BOTTOM)
            })
        })
    }
    return createElement(str1, tbl4, tbl5)
end

function var3.renderCloseBtn(arg1, _)
    if arg1.props.preferredInputRef.current ~= Responsive.Input.Directional
        and not arg1.state.showCloseBtn
        and tick() - arg1.startTime > 5
    then
        arg1:setState({ showCloseBtn = true })
    end

    local showCloseBtn = arg1.state.showCloseBtn

    if showCloseBtn then
        local createElement = Roact.createElement
        local str1 = "ImageButton"
        local tbl4 = {
            Name = "CloseButton",
            Image = "rbxasset://textures/loading/cancelButton.png",
            ImageTransparency = 0,
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(0, 0)
        }
        local fromOffset = UDim2.fromOffset
        if arg1.isQueueTreatmentEnabled then
        end

        local num3 = 32

        if arg1.isQueueTreatmentEnabled then
        end

        tbl4.Size = fromOffset(num3, 32)

        tbl4.Active = false
        tbl4.ZIndex = 10
        tbl4[Roact.Event.MouseButton1Click] = function()
            if FFlagLoadingScreenControlMilestones and arg1.props.milestones then
                arg1.props.milestones.abort(LoadingScreenMilestones.AbortReason.Cancelled)
            end
            if GetFFlagReportFirstExperienceCancelled then
                LoggingProtocol.default:logEventOnce("first_experience_cancelled")
            end
            game:Shutdown()
        end

        showCloseBtn = createElement(str1, tbl4)
    end

    return showCloseBtn
end

function var3.renderServerFrame(arg1, arg2)
    local serverStatusText = arg1.state.serverStatusText
    local isSubjectToChinaPolicies = arg1.props.isSubjectToChinaPolicies
    local textSize = if showTenFootCancelBtn then 16 else 12
    local num1 = if showTenFootCancelBtn then 16 else 12

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl4 = {
        Name = "ServerFrame",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.fromScale(0.5, 1),
        Size = UDim2.new(1, -48, 0.2, 0),
        Active = true
    }
    local tbl5 = {
        PolicyLabel = isSubjectToChinaPolicies
            and Roact.createElement("TextLabel", {
                Name = "PolicyLabel",
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 2 * num1),
                Position = UDim2.new(0, 0, 1, -4 * textSize - 2 * num1),
                FontFace = normalizeFontFace(arg2.Tokens.Typography.CaptionSmall.Font),
                TextSize = num1,
                TextWrapped = true,
                TextScaled = false,
                TextColor3 = arg2.Theme.TextDefault.Color,
                TextStrokeTransparency = 1,
                Text = localization:Format("Authentication.Login.WeChat.AntiAddictionText"),
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center,
                ZIndex = 2
            }),
        JoinServerLabel = Roact.createElement("TextLabel", {
            Name = "JoinText",
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 4 * textSize),
            Position = UDim2.new(0, 0, 1, -2 * textSize),
            FontFace = normalizeFontFace(arg2.Tokens.Typography.CaptionSmall.Font),
            TextSize = textSize,
            TextWrapped = true,
            TextScaled = false,
            TextColor3 = arg2.Theme.TextDefault.Color,
            TextStrokeTransparency = 1,
            Text = serverStatusText,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
            ZIndex = 2,
            RootLocalizationTable = CoreGui.CoreScriptLocalization,
            [Roact.Event.InputBegan] = if arg1.props.isSubjectToChinaPolicies then nil else arg1.showConnnectionHealthDebugMenu or nil
        })
    }
    return createElement(str1, tbl4, tbl5)
end

function var3.renderGamepadCancelBtn(arg1, arg2)
    if arg1.props.preferredInputRef.current ~= Responsive.Input.Directional then
        return false
    end

    return not arg1.state.gamepadCancelPressed
        and Roact.createElement("Frame", {
            Name = "GamepadCancelFrame",
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            AnchorPoint = Vector2.new(0, 1),
            Position = UDim2.fromScale(0, 1),
            Size = UDim2.fromOffset(150, 48),
            Active = true
        }, {
            CancelIcon = Roact.createElement("ImageLabel", {
                Name = "GamepadCancel",
                Image = "rbxasset://textures/ui/Controls/DesignSystem/ButtonB@2x.png",
                BackgroundTransparency = 1,
                Size = UDim2.fromOffset(24, 24),
                Active = false,
                ZIndex = 10,
                LayoutOrder = 0
            }),
            CancelLabel = Roact.createElement("TextLabel", {
                Name = "CancelText",
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1),
                FontFace = normalizeFontFace(arg2.Tokens.Typography.TitleLarge.Font),
                TextSize = 24,
                TextWrapped = true,
                TextColor3 = arg2.Theme.TextEmphasis.Color,
                TextStrokeTransparency = 1,
                Text = localization:Format("CoreScripts.TopBar.Back"),
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center,
                ZIndex = 2,
                LayoutOrder = 1
            }),
            UIListLayout = Roact.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                FillDirection = Enum.FillDirection.Horizontal,
                Padding = UDim.new(0, 5)
            })
        })
end

function var3.init(arg1)
    arg1.thumbnailMoveSpd = 0.05
    arg1.fadeinComplete = false
    arg1.isPortrait = false
    arg1.startTime = tick()

    arg1.numberOfTaps = 0
    arg1.lastTapTime = math.huge

    arg1:setState({
        visible = true,
        absoluteSize = Vector2.new(0, 0),
        thumbnailPositionX = 0.5,
        thumbnailScaledWidth = vector2.x,
        thumbnailScaledHeight = vector2.y,
        shimPos = 0,
        serverStatusText = "",
        showCloseBtn = false,
        showTenFootCancelBtn = showTenFootCancelBtn,
        gamepadCancelPressed = false
    })

    arg1.isQueueTreatmentEnabled = (QueueExperimentation.getIsJoinNewServerButtonEnabled() or QueueExperimentation.getIsAutoJoinNewServerEnabled())
        and arg1.props.placeId > 0

    function arg1.onAbsoluteSizeChange(arg2)
        arg1:setState({ absoluteSize = arg2.AbsoluteSize })

        arg1.isPortrait = arg2.AbsoluteSize.X < arg2.AbsoluteSize.Y
        arg1.updateBindings.iconSize(1)
    end

    game.Loaded:Connect(function()
        if showTenFootCancelBtn then
            ContextActionService:UnbindCoreAction("CancelGameLoad")
        end
        while not arg1.fadeinComplete do
            wait()
        end
        arg1:stopAnimation()
        arg1:playAnimation(tbl3.FadeOut, {}, function()
            if FFlagLoadingScreenControlMilestones and arg1.props.milestones then
                arg1.props.milestones.record(LoadingScreenMilestones.Milestone.ScreenHidden)
            end
            arg1:setState({ visible = false })
        end)
    end)

    local thumbnailTransparency, var1 = Roact.createBinding(1)
    local iconTransparency, var4 = Roact.createBinding(1)
    local var8, iconSize = Roact.createBinding(0)
    local placeTextTransparency, var5 = Roact.createBinding(1)
    local var12, placeTextSize = Roact.createBinding(0)
    local creatorTextTransparency, var6 = Roact.createBinding(1)
    local var16, creatorTextSize = Roact.createBinding(0)
    local infoFrameTransparency, var7 = Roact.createBinding(1)
    local infoFrameAbsoluteSize, updateInfoFrameAbsoluteSize = Roact.createBinding(Vector2.new(0, 0))

    arg1.bindings = {
        thumbnailTransparency = thumbnailTransparency,
        iconTransparency = iconTransparency,
        iconSize = var8:map(function(arg2): UDim2
            local num3 = math.clamp(math.max(arg1.state.absoluteSize.X, arg1.state.absoluteSize.Y) / 1024 * tbl2[1], tbl2[1], tbl2[2])
            return UDim2.fromOffset(num3 * arg2, num3 * arg2)
        end),
        placeTextTransparency = placeTextTransparency,
        placeTextSize = var12:map(function(arg2)
            return (if bool1 then 20 else 36) * arg2
        end),
        creatorTextTransparency = creatorTextTransparency,
        creatorTextSize = var16:map(function(arg2)
            return 20 * arg2
        end),
        infoFrameTransparency = infoFrameTransparency,
        infoFrameAbsoluteSize = infoFrameAbsoluteSize
    }

    arg1.updateBindings = {
        thumbnailTransparency = var1,
        iconTransparency = var4,
        iconSize = iconSize,
        placeTextTransparency = var5,
        placeTextSize = placeTextSize,
        creatorTextTransparency = var6,
        creatorTextSize = creatorTextSize,
        infoFrameTransparency = var7,
        updateInfoFrameAbsoluteSize = updateInfoFrameAbsoluteSize
    }

    function arg1.renderBackgroundSteppedCallback(arg2)
        local absoluteSize = arg1.state.absoluteSize
        local var22 = absoluteSize.x * 1.5
        local var23 = var22 / vector2.x * vector2.y

        if var23 < absoluteSize.y then
            var22 = absoluteSize.y / vector2.y * vector2.x
            var23 = absoluteSize.y
        end
        local var24 = var22 / absoluteSize.x / 2

        local num3 = math.max(var24, 1 - var24)

        local num4 = math.min(var24, 1 - var24)
        local var25 = arg1.state.thumbnailPositionX + arg1.thumbnailMoveSpd * arg2
        if num3 <= var25 or var25 <= num4 then
            arg1.thumbnailMoveSpd = -arg1.thumbnailMoveSpd
            var25 = math.clamp(var25, num4, num3)
        end

        arg1:setState({ thumbnailPositionX = var25, thumbnailScaledHeight = var23, thumbnailScaledWidth = var22 })
    end

    function arg1.renderShimmerCallback(arg2)
        local var22 = arg1.state.shimPos + arg2 * 1
        local shimPos = if var22 > 1 then -1 else var22

        arg1:setState({ shimPos = shimPos })
    end

    if GuiService:GetUiMessage() ~= "" then
        arg1:setState({ serverStatusText = GuiService:GetUiMessage() })
    end

    GuiService.UiMessageChanged:Connect(function(msgType: Enum.UiMessageType, newUiMessage: string)
        if msgType == Enum.UiMessageType.UiMessageInfo then
            arg1:setState({ serverStatusText = newUiMessage })
        end
    end)

    local bool2 = false
    ContextActionService:BindCoreAction("CancelGameLoad", function(_, userInputState, _)
        if userInputState == Enum.UserInputState.Begin then
            bool2 = true
            return
        end

        if userInputState ~= Enum.UserInputState.End or not bool2 then
            return
        end

        arg1:setState({ showTenFootCancelBtn = false })

        arg1:setState({ gamepadCancelPressed = true })

        ContextActionService:UnbindCoreAction("CancelGameLoad")

        if game:IsLoaded() then
            return
        end

        if FFlagLoadingScreenControlMilestones and arg1.props.milestones then
            arg1.props.milestones.abort(LoadingScreenMilestones.AbortReason.Cancelled)
        end
        game:Shutdown()
    end, false, Enum.KeyCode.ButtonB)
end

function var3.renderAutoTranslate(arg1)
    if arg1.props.universeId <= 0 then
        LoadingScreenTelemetry.countAutoTranslateZeroUniverseId()
        return nil
    end
    return Roact.createElement(AutoTranslateBadge, {
        universeId = arg1.props.universeId,
        positionBinding = arg1.bindings.infoFrameAbsoluteSize,
        transparencyBinding = arg1.bindings.infoFrameTransparency
    })
end

function var3.renderPolicyContainer(arg1)
    if not arg1.props.isSubjectToChinaPolicies then
        return nil
    end
    return React.createElement(PolicyContainer, { position = UDim2.new(0, 0, 0, 32) })
end

function var3.renderServerStatus(arg1)
    if QueueExperimentation.getIsAutoJoinNewServerEnabled() then
        return Roact.createElement(ServerStatusWithCountdown, {
            anchorPoint = Vector2.new(0.5, 1),
            isSubjectToChinaPolicies = arg1.props.isSubjectToChinaPolicies,
            placeId = arg1.props.placeId,
            position = UDim2.fromScale(0.5, 1),
            size = UDim2.fromScale(1, 0.2),
            universeId = arg1.props.universeId
        })
    elseif QueueExperimentation.getIsJoinNewServerButtonEnabled() then
        return Roact.createElement(ServerStatus, {
            anchorPoint = Vector2.new(0.5, 1),
            isSubjectToChinaPolicies = arg1.props.isSubjectToChinaPolicies,
            placeId = arg1.props.placeId,
            position = UDim2.fromScale(0.5, 1),
            size = UDim2.fromScale(1, 0.2),
            universeId = arg1.props.universeId
        })
    end

    return nil
end

function var3.renderMainWithProviders(arg1, arg2)
    return Roact.createElement(
        FoundationProvider,
        {
            colorMode = Foundation.Enums.ColorMode.Dark
        },
        { Roact.createElement(LocalizationProvider, { localization = localization }, arg1:renderMain(arg2)) }
    )
end

function var3.render(arg1)
    return withStyle(function(arg2)
        return arg1.state.visible
            and Roact.createElement(
                "Folder",
                {},
                {
                    BackgroundScreen = arg1:renderBackground(arg2),
                    MainScreen = arg1:renderMainWithProviders(arg2)
                }
            )
    end)
end

function var3.willUpdate(_, _, _) end

function var3.didMount(arg1)
    if FFlagLoadingScreenControlMilestones and arg1.props.milestones then
        arg1.props.milestones.record(LoadingScreenMilestones.Milestone.ScreenVisible)
    end
    RunService:SetRobloxGuiFocused(true)

    arg1.props.fetchUniverseId(arg1.props.placeId)

    arg1.props.fetchGameProductInfo(arg1.props.placeId)

    arg1.props.fetchSubjectToChinaPolicies()

    arg1:playAnimation(tbl3.FadeIn, {}, function()
        arg1.fadeinComplete = true
    end)

    if not QueueExperimentation.isInExperiment()
        or not (ExperienceService:GetFollowUserId() > 0)
        or not (arg1.props.placeId > 0)
    then
        return
    end

    if ExperienceService:GetPlaceJoinState() == PlaceLauncherState.Queued then
        QueueExperimentation.logExposure()
        return
    end
    arg1.placeJoinStateConnection = ExperienceService.PlaceJoinStateChanged:Connect(function(state: string)
        if state == PlaceLauncherState.Queued then
            QueueExperimentation.logExposure()
        end
    end)
end

function var3.willUnmount(arg1)
    if FFlagLoadingScreenControlMilestones and arg1.props.milestones then
        arg1.props.milestones.abort(LoadingScreenMilestones.AbortReason.Unmounted)
    end
    ContextActionService:UnbindCoreAction("CancelGameLoad")
    RunService:SetRobloxGuiFocused(false)

    var2 = var2 or UserInputService.InputBegan:Connect(function()
        disconnectAndCloseHealthStat()
    end)

    if QueueExperimentation.isInExperiment() and arg1.placeJoinStateConnection then
        arg1.placeJoinStateConnection:Disconnect()
        arg1.placeJoinStateConnection = nil
    end
end

local var4 = RoactRodux.connect(function(arg1, arg2)
    return {
        productInfo = arg1.productInfo,
        isSubjectToChinaPolicies = arg1.isSubjectToChinaPolicies,
        placeId = arg1.gameIds and arg1.gameIds.placeId or arg2.placeId,
        universeId = arg1.gameIds and arg1.gameIds.universeId or 0,
        settings = arg1.settings
    }
end, function(callback)
    return {
        fetchGameProductInfo = function(arg1)
            callback(GetGameProductInfo(arg1))
        end,
        fetchSubjectToChinaPolicies = function()
            callback(GetIsSubjectToChinaPolicies())
        end,
        fetchUniverseId = function(arg1)
            callback(GetUniverseId(createNetworking, arg1))
        end
    }
end)(var3)
return function(arg1)
    local preferredInputRef = React.useRef(nil)
    preferredInputRef.current = Responsive.usePreferredInput()

    return React.createElement(var4, Cryo.Dictionary.join(arg1, { preferredInputRef = preferredInputRef }))
end
