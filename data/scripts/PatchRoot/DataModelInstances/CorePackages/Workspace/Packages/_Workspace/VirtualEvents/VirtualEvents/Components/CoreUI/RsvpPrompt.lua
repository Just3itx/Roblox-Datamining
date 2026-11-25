-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Foundation = require(scriptParentParentParentParent.Foundation)
local Localization = require(scriptParentParentParentParent.Localization)
local React = require(scriptParentParentParentParent.React)
local UIBlox = require(scriptParentParentParentParent.UIBlox)
local useScreenSize = require(scriptParentParentParentParent.CoreScriptsRoactCommon).useScreenSize
local useRoactService = require(scriptParentParentParentParent.RobloxAppHooks).useRoactService
local RoactNetworking = require(scriptParentParentParentParent.RoactServiceTags).RoactNetworking
local NotificationModalsManager = require(scriptParentParentParentParent.NotificationModalsManager)
local GameTile = require(scriptParentParentParentParent.GameTile)
local MouseIconOverrideService = require(scriptParentParentParentParent.CoreScriptsCommon).MouseIconOverrideService

local useDesignTokens = require(scriptParentParentParentParent.Style).useDesignTokens

local constants = require(scriptParentParentParent.constants)
local logger = require(scriptParentParentParent.logger)

local postRsvpStatus = require(scriptParentParentParent.Common.postRsvpStatus)
local formatDateLocalized = require(scriptParentParentParent.Common.formatDateLocalized)

local ServiceOverrideContext = require(scriptParentParentParent.Components.CoreUI.ServiceOverrideContext)

local useContext = React.useContext

local ButtonType = UIBlox.App.Button.Enum.ButtonType
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local LoadableImage = UIBlox.App.Loading.LoadableImage
local useLocalization = Localization.Hooks.useLocalization

local FoundationText = Foundation.Text
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens
local getTextBoundsAsync = Foundation.Utility.getTextBoundsAsync
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local GameTileThumbnailBadges = GameTile.GameTileThumbnailBadges

local ScrollView = Foundation.ScrollView
local ScrollBarVisibility = Foundation.Enums.ScrollBarVisibility

local bool1 = game:DefineFastFlag("LuaAppFixRsvpPromptDescriptionScrolling", false)
local FFlagInGameRsvpPushUpsellEnabled = require(scriptParentParentParentParent.SharedFlags).FFlagInGameRsvpPushUpsellEnabled

return function(tbl1)
    local screenSize = useScreenSize()

    local var2 = tbl1.enableInputDelayed == nil or tbl1.enableInputDelayed

    local var3 = useLocalization({
        joinEvent = "Feature.VirtualEvents.JoinEvent",
        notifyMe = "Feature.VirtualEvents.NotifyMe",
        unfollowEvent = "Feature.VirtualEvents.UnfollowEvent",
        notNowButton = "Feature.VirtualEvents.NotNowButton",
        dateAtTime = "Feature.VirtualEvents.Label.DateAtTime",
        toastText = "Feature.VirtualEvents.Label.ReminderSetForEventTime"
    })

    React.useEffect(function()
        MouseIconOverrideService.push("RSVPPromptOverride", Enum.OverrideMouseIconBehavior.ForceShow)

        return function()
            MouseIconOverrideService.pop("RSVPPromptOverride")
        end
    end, {})

    local eventDetails = tbl1.promptData.eventDetails

    local displayTitle = eventDetails.displayTitle
    local displayDescription = eventDetails.displayDescription

    local thumbnails = eventDetails.thumbnails

    local defaultEventMediaId = constants.DEFAULT_EVENT_MEDIA_ID

    if thumbnails and thumbnails[1] and thumbnails[1].mediaId then
        defaultEventMediaId = thumbnails[1].mediaId
    end

    local var4 = useRoactService(RoactNetworking)

    local bool2 = eventDetails.userRsvpStatus == "going"

    local none = Enum.RsvpStatus.None
    if eventDetails.userRsvpStatus == "going" then
        none = Enum.RsvpStatus.Going
    elseif eventDetails.userRsvpStatus == "notGoing" then
        none = Enum.RsvpStatus.NotGoing
    end

    local notifyMe = var3.notifyMe
    if bool2 then
        notifyMe = var3.unfollowEvent
    end

    local isoDate = nil
    local var5 = nil
    if eventDetails.eventTime and eventDetails.eventTime.startUtc then
        isoDate = DateTime.fromIsoDate(eventDetails.eventTime.startUtc)
        if isoDate then
            var5 = formatDateLocalized(var3.dateAtTime, isoDate)
        end
    end

    local joinEvent = var3.joinEvent
    if bool2 then
        joinEvent = var3.unfollowEvent
    end

    local socialService = useContext(ServiceOverrideContext).socialService

    local onActivated = React.useCallback(function()
        if bool2 then
            postRsvpStatus(var4, tbl1.promptData.eventId, "notGoing"):andThen(function()
                socialService:PromptRsvpToEventCompleted(tbl1.promptData.eventId, true, Enum.RsvpStatus.NotGoing, none)
            end, function(arg1)
                socialService:PromptRsvpToEventCompleted(tbl1.promptData.eventId, false, Enum.RsvpStatus.None, none)

                warn("Error updating rsvp status: ", arg1)
            end)
        else
            postRsvpStatus(var4, tbl1.promptData.eventId, "going"):andThen(function()
                socialService:PromptRsvpToEventCompleted(tbl1.promptData.eventId, true, Enum.RsvpStatus.Going, none)

                local toastTitle = var3.toastText:gsub("{(.-)}", { eventName = displayTitle, eventTime = var5 })

                NotificationModalsManager.SetUIBloxToast({ toastTitle = toastTitle, sequenceNumber = DateTime.now().UnixTimestamp })

                if FFlagInGameRsvpPushUpsellEnabled and tbl1.onRsvpGoingSucceeded then
                    xpcall(tbl1.onRsvpGoingSucceeded, function(arg1)
                        logger:warning("Error starting the push upsell: {}", tostring(arg1))
                    end, tbl1.promptData.eventId)
                end
            end, function(arg1)
                socialService:PromptRsvpToEventCompleted(tbl1.promptData.eventId, false, Enum.RsvpStatus.None, none)

                warn("Error updating rsvp status: ", arg1)
            end)
        end
        tbl1.closePrompt()
    end, {
        socialService,
        tbl1.closePrompt,
        bool2,
        tbl1.onRsvpGoingSucceeded
    })
    local onCloseClicked = React.useCallback(function()
        local none2 = Enum.RsvpStatus.None
        if eventDetails.userRsvpStatus == "notGoing" then
            none2 = Enum.RsvpStatus.NotGoing
        elseif eventDetails.userRsvpStatus == "going" then
            none2 = Enum.RsvpStatus.Going
        end
        socialService:PromptRsvpToEventCompleted(tbl1.promptData.eventId, true, none2, none)
        tbl1.closePrompt()
    end, { socialService, tbl1.closePrompt, eventDetails.userRsvpStatus })

    local buttonStackInfo = React.useMemo(function()
        return {
            buttons = {{
                buttonType = ButtonType.PrimaryContextual,
                props = {
                    delayInputSeconds = 2,
                    enableInputDelayed = var2,
                    isDelayedInput = var2,
                    onActivated = onActivated,
                    text = notifyMe
                }
            }}
        }
    end, {
        var3,
        onActivated,
        var2,
        notifyMe
    })
    local var9, var10 = React.useState(Vector2.new(0, 0))

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var10(arg1.AbsoluteSize)
    end, { var10 })

    local yOffset, var12 = React.useState(0)
    local var13, var14 = React.useState(0)

    local ref = React.useRef(nil)
    local var1 = React.useRef(nil)

    local var17 = React.useCallback(function(arg1)
        local num1 = math.ceil(arg1.TextBounds.Y)
        if num1 > 0 then
            var12(function(arg2)
                return if num1 == arg2 then arg2 else num1
            end)
        end
    end, { var12 })

    local size300 = useDesignTokens().Size.Size_300

    local var18 = useTokens()
    local bodyLarge = var18.Typography.BodyLarge

    local overrideUseWideMode = tbl1.overrideUseWideMode

    if not overrideUseWideMode then
        if screenSize.Y < 600 then
            overrideUseWideMode = screenSize.X > screenSize.Y
        else
            overrideUseWideMode = false
        end
    end

    React.useEffect(function()
        if bool1 then
            var12(0)
        end
    end, { overrideUseWideMode, displayDescription })

    React.useEffect(function()
        if bool1 then
            if var1.current then
                var14(var1.current.AbsoluteSize.Y)
            end
            return
        end
        local current = ref.current
        if not current then
            return
        end

        local bool3 = false
        task.spawn(function()
            local textBoundsAsync = getTextBoundsAsync(displayDescription, current.FontFace, current.TextSize, current.AbsoluteSize.X)

            if bool3 or not textBoundsAsync then
                return
            end

            var12(textBoundsAsync.Y * current.LineHeight)

            if var1.current then
                var14(var1.current.AbsoluteSize.Y)
            end
        end)

        return function()
            bool3 = true
        end
    end, {
        ref,
        var9.X,
        displayDescription,
        overrideUseWideMode
    })
    local middleContent = React.useCallback(function()
        local var19 = screenSize.Y - 80 - 200
        local yOffset2 = if var19 < 80 then 80 else var19

        if overrideUseWideMode then
            local var20 = var9.X * 0.6
            if var20 * 1 / constants.THUMBNAIL_ASPECT_RATIO < yOffset2 then
                yOffset2 = var20 * 1 / constants.THUMBNAIL_ASPECT_RATIO
            end
            if bool1 then
                yOffset2 = math.max(yOffset2 - var13 - size300, 80)
            end
        end

        local var20 = if bool1 and yOffset == 0 then 80 else yOffset
        local yOffset3 = math.min(var20, yOffset2)

        if not overrideUseWideMode then
            if bool1 then
                yOffset2 = math.max(yOffset2 - var13 - size300 * 2, 80)
            end
            if bool1 then
                yOffset3 = math.min(var20, yOffset2 * 0.4)
            else
                yOffset3 = math.min(yOffset, yOffset2 * 0.4)
            end

            yOffset2 -= yOffset3
        end

        local uDim2 = UDim2.new(1, 0, 0, yOffset2)
        if overrideUseWideMode then
            uDim2 = UDim2.new(0.6, 0, 0, yOffset2)
        end

        local thumbnailFrame = React.createElement("Frame", {
            AutomaticSize = if overrideUseWideMode then Enum.AutomaticSize.X else Enum.AutomaticSize.Y,
            Size = uDim2,
            BackgroundTransparency = 1,
            LayoutOrder = 1
        }, {
            Thumbnail = React.createElement(LoadableImage, {
                Position = UDim2.fromScale(0.5, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Size = UDim2.fromScale(1, 1),
                BackgroundTransparency = 1,
                Image = "rbxassetid://" .. defaultEventMediaId,
                useShimmerAnimationWhileLoading = true,
                showFailedStateWhenLoadingFailed = true,
                cornerRadius = UDim.new(0, 8)
            }),
            AspectRatioConstraint = React.createElement("UIAspectRatioConstraint", {
                AspectRatio = constants.THUMBNAIL_ASPECT_RATIO,
                DominantAxis = Enum.DominantAxis.Width,
                AspectType = Enum.AspectType.FitWithinMaxSize
            }),
            Overlay = if isoDate then React.createElement(
                "Frame",
                {
                    ZIndex = 2,
                    BackgroundTransparency = 1,
                    Size = UDim2.fromScale(1, 1)
                },
                {
                    Badge = React.createElement(
                        GameTileThumbnailBadges,
                        {
                            tileBadgesByPosition = {
                                ImageTopLeft = {{ tileBadgeType = "Text", text = var5 }}
                            }
                        }
                    )
                }
            ) else nil
        })

        local uDim2_2 = UDim2.new(1, 0, 0, yOffset3)
        if overrideUseWideMode then
            if bool1 then
                uDim2_2 = UDim2.new(0.4, -size300, 0, yOffset3)
            else
                uDim2_2 = UDim2.new(0.4, 0, 0, yOffset3)
            end
        end

        local element2

        if bool1 then
            local yOffset4 = if yOffset > 0 then yOffset else 10000
            local createElement = React.createElement
            local tbl2 = {
                LayoutOrder = 3,
                Size = uDim2_2,
                CanvasSize = UDim2.new(0, 0, 0, yOffset4 + 2),
                ScrollingDirection = Enum.ScrollingDirection.Y,
                ScrollBarThickness = 0,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                ClipsDescendants = true
            }

            local tbl3 = {
                Body = React.createElement("TextLabel", {
                    Size = UDim2.new(1, 0, 0, yOffset4),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Text = displayDescription,
                    TextTruncate = Enum.TextTruncate.None,
                    TextWrapped = true,
                    FontFace = normalizeFontFace(bodyLarge.Font),
                    TextSize = bodyLarge.FontSize,
                    LineHeight = bodyLarge.LineHeight,
                    TextColor3 = var18.Color.Content.Emphasis.Color3,
                    TextTransparency = var18.Color.Content.Emphasis.Transparency,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    [React.Change.TextBounds] = var17,
                    ref = ref
                })
            }
            element2 = createElement("ScrollingFrame", tbl2, tbl3)
        else
            element2 = React.createElement(ScrollView, {
                scroll = {
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    CanvasSize = UDim2.fromScale(1, 0),
                    scrollBarVisibility = ScrollBarVisibility.Auto,
                    ScrollingDirection = Enum.ScrollingDirection.Y,
                    VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
                },
                tag = "col align-y-top",
                LayoutOrder = 3,
                Size = uDim2_2
            }, {
                Body = React.createElement(FoundationText, {
                    tag = "size-full-0 text-body-large text-align-y-top text-align-x-left",
                    Text = displayDescription,
                    TextWrapped = true,
                    Size = UDim2.new(1, 0, 0, yOffset),
                    padding = Vector2.new(0, 0),
                    ref = ref
                })
            })
        end

        if not overrideUseWideMode then
            return React.createElement(View, {
                Size = UDim2.new(1, 0, 0, 0),
                tag = "col align-x-center size-full-0 auto-y gap-medium",
                onAbsoluteSizeChanged = onAbsoluteSizeChanged
            }, {
                ThumbnailFrame = thumbnailFrame,
                Title = React.createElement(
                    FoundationText,
                    {
                        tag = "size-full-0 auto-y text-title-large text-align-x-left",
                        Text = displayTitle,
                        LayoutOrder = 2,
                        ref = var1
                    }
                ),
                BodyScrollView = element2
            })
        end

        return React.createElement(View, {
            Size = UDim2.new(1, 0, 0, 0),
            tag = "col align-x-center size-full-0 auto-y gap-medium",
            onAbsoluteSizeChanged = onAbsoluteSizeChanged
        }, {
            Title = React.createElement(
                FoundationText,
                {
                    tag = "size-full-0 auto-y text-title-large text-align-x-left",
                    Text = displayTitle,
                    LayoutOrder = 1,
                    ref = var1
                }
            ),
            Contents = React.createElement(View, {
                LayoutOrder = 2,
                tag = {
                    ["row align-y-top gap-medium size-full-0"] = bool1,
                    ["row align-y-center gap-medium size-full-0"] = not bool1
                },
                Size = UDim2.new(1, 0, 0, yOffset2)
            }, { ThumbnailFrame = thumbnailFrame, BodyScrollView = element2 })
        })
    end, {
        defaultEventMediaId,
        displayTitle,
        displayDescription,
        isoDate,
        var5,
        var9,
        yOffset,
        onAbsoluteSizeChanged,
        screenSize,
        size300,
        var13,
        var18,
        bodyLarge,
        var17,
        overrideUseWideMode,
        tbl1.overrideUseWideMode
    })

    return React.createElement(InteractiveAlert, {
        onCloseClicked = onCloseClicked,
        buttonStackInfo = buttonStackInfo,
        isMiddleContentFocusable = false,
        middleContent = middleContent,
        position = UDim2.fromScale(0.5, 0.5),
        screenSize = screenSize,
        title = joinEvent
    })
end
