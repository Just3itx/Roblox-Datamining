-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCard = script:FindFirstAncestor("GameJoinCard")
local GameJoinCardParent = GameJoinCard.Parent

local React = require(GameJoinCardParent.React)
local Foundation = require(GameJoinCardParent.Foundation)
local UserTile = require(GameJoinCardParent.UserTile)
local UserTile2 = UserTile.UserTile
local LayoutMode = UserTile.LayoutMode

local OverlayProvider = Foundation.OverlayProvider
local Sheet = Foundation.Sheet
local View = Foundation.View
local FoundationText = Foundation.Text
local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize

local useLocalization = require(GameJoinCardParent.Localization).Hooks.useLocalization

local Image = Foundation.Image
local Skeleton = Foundation.Skeleton
local useTokens = Foundation.Hooks.useTokens
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance

local GuiService = game:GetService("GuiService")

local AnalyticsConstants = require(script.Parent.Parent.Parent.Analytics.AnalyticsConstants)
local viewEDPsourceValues = AnalyticsConstants.viewEDPsourceValues
local viewProfileSourceValues = AnalyticsConstants.viewProfileSourceValues
local CtaType = AnalyticsConstants.CtaType
local useJoinCardCtaLoadTime = require(script.Parent.Parent.Parent.Analytics.useJoinCardCtaLoadTime)

local _VideoUtils = require(GameJoinCardParent.VideoUtils)

local SharedFlags = require(GameJoinCardParent.SharedFlags)
local FFlagMobileGameJoinCardGamepadSupport = SharedFlags.FFlagMobileGameJoinCardGamepadSupport
local FFlagGameJoinCardOptionalActions = SharedFlags.FFlagGameJoinCardOptionalActions
local FFlagGameJoinCardContent = SharedFlags.FFlagGameJoinCardContent

local useGameJoinCardGamepadNavigation = nil
local assignPrimaryFocusRef = nil
if FFlagMobileGameJoinCardGamepadSupport then
    local useGameJoinCardGamepadNavigation2 = require(GameJoinCard.Hooks.useGameJoinCardGamepadNavigation)
    useGameJoinCardGamepadNavigation = useGameJoinCardGamepadNavigation2.useGameJoinCardGamepadNavigation
    assignPrimaryFocusRef = useGameJoinCardGamepadNavigation2.assignPrimaryFocusRef
end

local AgeCheckUpsellCTA = require(script.Parent.Parent.AgeCheckUpsellCTA)
local JoinCardBannerVideoContainer = require(script.Parent.JoinCardBannerVideo.JoinCardBannerVideoContainer)
local GameJoinCardTTI = require(script.Parent.Parent.Parent.Telemetry.GameJoinCardTTI)
local FFlagMobileGameJoinCardThumbnail = require(script.Parent.Parent.Parent.Flags.FFlagMobileGameJoinCardThumbnail)
local bool1 = game:DefineFastFlag("MobileGameJoinCardHideUserAvatar", false)

local bool2 = game:DefineFastFlag("MobileGameJoinCardShowExperienceNameOnly", false)
local FFlagMobileGameJoinCardEDPFromTitle = require(GameJoinCard.Flags.FFlagMobileGameJoinCardEDPFromTitle)
local FFlagMobileGameJoinCardTrapGamepadFocus = require(GameJoinCard.Flags.FFlagMobileGameJoinCardTrapGamepadFocus)

local selectionGroup = FFlagMobileGameJoinCardTrapGamepadFocus
    and {
        SelectionBehaviorUp = Enum.SelectionBehavior.Stop,
        SelectionBehaviorDown = Enum.SelectionBehavior.Stop,
        SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
        SelectionBehaviorRight = Enum.SelectionBehavior.Stop
    }
    or nil

local testId = if FFlagMobileGameJoinCardTrapGamepadFocus then "mobile-game-join-card-selection" else nil
local FFlagMobileGameJoinCardEDPFromThumbnail = require(GameJoinCard.Flags.FFlagMobileGameJoinCardEDPFromThumbnail)
local FFlagMobileGameJoinCardVideo = require(GameJoinCardParent.SharedFlags).FFlagMobileGameJoinCardVideo
local bool3 = game:DefineFastFlag("MobileGameCardDontShowChatWith", false)
local FFlagJoinabilityCTARefactor = require(GameJoinCardParent.SharedFlags).FFlagJoinabilityCTARefactor
local FFlagJoinabilityCTAContextCopy = require(GameJoinCardParent.SharedFlags).FFlagJoinabilityCTAContextCopy
local _Types = require(GameJoinCard.Components.Actions.Types)
local buildJoinCardActionsComponent = require(GameJoinCard.Components.Actions.buildJoinCardActionsComponent)
local UserCtaAction = require(GameJoinCardParent.UserCtaCommon).Enums.UserCtaAction

local function MobileGameJoinCard(tbl1)
    local var3 = useTokens()
    local var4, var5 = React.useState(false)
    local var6 = nil
    local var7 = nil
    if FFlagMobileGameJoinCardThumbnail then
        local var8
        var6, var8 = React.useState(false)
        var7 = var8
    end
    local var8, ref = React.useState(nil)

    local var10 = Foundation.Hooks.useOverlay()
    local bool4 = not var10 or var10.AbsoluteSize.X > var10.AbsoluteSize.Y
    local bool5 = not (GuiService.ViewportDisplaySize == Enum.DisplaySize.Small and not bool4)
    local thumbnailImageUrl = tbl1.thumbnailImageUrl
    local content = if FFlagGameJoinCardContent then tbl1.content else nil
    local var11 = if FFlagMobileGameJoinCardGamepadSupport then useGameJoinCardGamepadNavigation(tbl1.onClose, tbl1.isNavigationFocused ~= false) else nil
    local rootRef = if var11 then var11.rootRef else nil
    local primaryButtonFocusRef = if var11 then var11.primaryButtonFocusRef else nil

    local onLoaded = React.useCallback(function(assetFetchStatus)
        if assetFetchStatus ~= Enum.AssetFetchStatus.Success then
            return
        end

        var5(true)
        if content ~= nil or FFlagGameJoinCardOptionalActions and tbl1.disableAppTelemetry then
            return
        end
        GameJoinCardTTI.trackBannerLoaded()
    end, { content ~= nil, if FFlagGameJoinCardOptionalActions then tbl1.disableAppTelemetry else nil })

    local var1 = if FFlagMobileGameJoinCardThumbnail then React.useCallback(function(assetFetchStatus)
        if assetFetchStatus == Enum.AssetFetchStatus.Success then
            var7(true)
        end
    end, {}) else nil

    local var14 = FFlagMobileGameJoinCardThumbnail

    if var14 then
        if thumbnailImageUrl == nil then
            var14 = false
        else
            var14 = not var4
        end
    end

    local bool6 = not (content ~= nil) and (if FFlagMobileGameJoinCardThumbnail then not (var4 or var6) else not var4)

    React.useEffect(function()
        if content ~= nil or FFlagGameJoinCardOptionalActions and tbl1.disableAppTelemetry then
            return
        end
        GameJoinCardTTI.trackCardMounted()
    end, { content ~= nil, if FFlagGameJoinCardOptionalActions then tbl1.disableAppTelemetry else nil })

    local var15 = React.useCallback(function()
        if FFlagGameJoinCardOptionalActions and tbl1.onViewProfile == nil then
            return
        end
        tbl1.onViewProfile(viewProfileSourceValues.UserTile)
    end, { tbl1 })

    local onActivated = React.useCallback(function()
        if FFlagGameJoinCardOptionalActions and tbl1.onViewProfile == nil then
            return
        end
        tbl1.onViewProfile(viewProfileSourceValues.ViewProfileButton)
    end, { tbl1 })

    local var17 = if FFlagMobileGameJoinCardEDPFromThumbnail then React.useCallback(function()
        if FFlagGameJoinCardOptionalActions and tbl1.onViewExperienceDetails == nil then
            return
        end
        tbl1.onViewExperienceDetails(viewEDPsourceValues.Thumbnail)
    end, { tbl1.onViewExperienceDetails }) else nil

    local var18 = if FFlagMobileGameJoinCardEDPFromTitle then React.useCallback(function()
        if FFlagGameJoinCardOptionalActions and tbl1.onViewExperienceDetails == nil then
            return
        end
        tbl1.onViewExperienceDetails(viewEDPsourceValues.Title)
    end, { tbl1.onViewExperienceDetails }) else nil

    local var19 = var3.Typography.TitleMedium.FontSize * var3.Typography.TitleMedium.LineHeight

    local yOffset = var19 + var3.Typography.BodyMedium.FontSize * var3.Typography.BodyMedium.LineHeight + var3.Padding.Small
    local yOffset2 = 88 + yOffset

    local bool7 = false
    if FFlagJoinabilityCTARefactor then
        for _, action in tbl1.actions do
            if action.id == UserCtaAction.UnlockExperience then
                bool7 = true
                break
            end
        end
    end

    if not FFlagJoinabilityCTARefactor then
        bool7 = tbl1.ageCheckRequired == true
    end

    useJoinCardCtaLoadTime({
        isLoading = tbl1.isLoading or FFlagJoinabilityCTARefactor and tbl1.areActionsLoading == true,
        ctaType = if bool7 then CtaType.AgeCheckUnlock else CtaType.Join,
        wasCached = tbl1.wasPlayabilityCached,
        isDisabled = content ~= nil or (if FFlagGameJoinCardOptionalActions then tbl1.disableAppTelemetry else nil)
    })

    local var20 = useLocalization({
        playingExperience = {
            "Feature.Profile.Label.PlayingExperience",
            experienceName = tbl1.experienceName
        },
        userIsPlayingExperience = {
            "Feature.Profile.Label.UserIsPlayingExperience",
            userName = tbl1.playerName,
            experienceName = tbl1.experienceName
        },
        join = "Feature.Profile.Action.JoinGame",
        viewProfile = "Feature.Profile.Action.ViewProfile",
        chat = "Feature.Profile.Action.Chat",
        chatWithName = {
            "Feature.Home.PeopleList.ChatWith",
            username = tbl1.playerName
        },
        playTogether = "Feature.GameJoin.Label.PlayTogether",
        playTogetherSoon = "Feature.GameJoin.Label.PlayTogetherSoon",
        differentServer = "Feature.GameJoin.Description.DifferentServer"
    })

    local tbl2 = {}
    local var21 = nil
    if FFlagJoinabilityCTARefactor or content ~= nil then
        if tbl1.areActionsLoading then
            tbl2.ActionsLoading = React.createElement(Skeleton, { Size = UDim2.new(1, 0, 0, var3.Size.Size_600), LayoutOrder = 1 })
        else
            local var22 = if primaryButtonFocusRef then assignPrimaryFocusRef(tbl1.actions, primaryButtonFocusRef) or tbl1.actions else tbl1.actions

            tbl2, var21 = buildJoinCardActionsComponent(var22, {
                playTogether = var20.playTogether,
                playTogetherSoon = var20.playTogetherSoon,
                differentServer = var20.differentServer
            }, tbl1.onClose, function(arg1, layoutOrder)
                return React.createElement(Button, {
                    ref = arg1.focusRef,
                    text = arg1.text,
                    onActivated = function()
                        arg1.onActivated()
                    end,
                    variant = arg1.variant,
                    size = arg1.inputSize,
                    isLoading = arg1.isLoading,
                    isDisabled = arg1.isDisabled,
                    width = arg1.width,
                    LayoutOrder = layoutOrder
                })
            end)
        end
    end

    local var22 = FFlagJoinabilityCTAContextCopy

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        ref = ref
    }
    local tbl4 = { SheetProvider = 0 }
    if var8 then
        local createElement2 = React.createElement
        local var23 = OverlayProvider
        local tbl5 = { gui = var8 }
        local tbl6 = { SheetRoot = 0 }
        local createElement3 = React.createElement
        local root = Sheet.Root
        local tbl7 = {
            preferCenterSheet = true,
            onClose = tbl1.onClose,
            ref = 0
        }

        if not FFlagMobileGameJoinCardGamepadSupport then
            rootRef = nil
        end

        tbl7.ref = rootRef
        local tbl8 = { Content = 0 }
        local createElement4 = React.createElement
        local content2 = Sheet.Content
        local var24 = nil
        local tbl9 = {
            BottomPadding = if bool5 then React.createElement("UIPadding", { PaddingBottom = UDim.new(0, var3.Padding.Medium) }) else nil,
            Layout = 0
        }

        local createElement5 = React.createElement
        local var25 = View
        local tbl10 = {
            tag = "col gap-medium size-full-0 auto-y",
            testId = testId,
            selectionGroup = selectionGroup
        }
        local tbl11 = { BannerImageContainer = 0, UserTileWrapper = 0, CtaContext = 0, Buttons = 0 }
        local createElement6 = React.createElement
        local var26 = View
        local tbl12 = {
            tag = "size-full-0",
            Size = if bool1 then UDim2.new(1, 0, 0, 187 - var3.Padding.XLarge) else UDim2.new(1, 0, 0, 111),
            LayoutOrder = 1
        }

        local tbl13 = { BannerImageClipper = 0 }
        local createElement7 = React.createElement
        local var27 = View
        local tbl14 = {
            tag = "clip",
            Position = UDim2.new(0, -var3.Padding.XLarge, 0, -var3.Padding.XLarge),
            Size = UDim2.new(1, 40, 0, 187)
        }
        local tbl15 = { BannerImageCanvas = 0, BannerVideo = 0 }
        local createElement8 = React.createElement
        local str2 = "CanvasGroup"
        local tbl16 = {
            Size = UDim2.new(1, 0, 0, 202),
            BackgroundTransparency = 1,
            GroupTransparency = 0
        }

        local tbl17 = {
            Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 15) }),
            BannerImage = React.createElement(Image, {
                BackgroundTransparency = 1,
                Image = tbl1.bannerImageUrl,
                Size = UDim2.fromScale(1, 1),
                ScaleType = Enum.ScaleType.Crop,
                ZIndex = if FFlagMobileGameJoinCardThumbnail then 3 else 2,
                onLoaded = onLoaded,
                onActivated = if content ~= nil
                    or FFlagGameJoinCardOptionalActions and tbl1.onViewExperienceDetails == nil
                    or not FFlagMobileGameJoinCardEDPFromThumbnail then nil elseif var4 then var17 else nil,
                stateLayer = if content == nil
                    and (not FFlagGameJoinCardOptionalActions or tbl1.onViewExperienceDetails ~= nil)
                    and FFlagMobileGameJoinCardEDPFromThumbnail then var4 and {
                    affordance = StateLayerAffordance.None
                } or nil else nil
            }),
            BannerThumbnail = if var14 then React.createElement(Image, {
                BackgroundTransparency = 1,
                Image = thumbnailImageUrl,
                Size = UDim2.fromScale(1, 1),
                ScaleType = Enum.ScaleType.Crop,
                ZIndex = 2,
                onLoaded = var1
            }) else nil,
            Media = if content then React.createElement(View, { tag = "size-full", ZIndex = 4 }, { Content = content.media }) else nil,
            BannerSkeleton = if bool6 then React.createElement(Skeleton, { Size = UDim2.fromScale(1, 1), ZIndex = 1 }) else nil
        }
        tbl15.BannerImageCanvas = createElement8(str2, tbl16, tbl17)
        local var28

        if FFlagMobileGameJoinCardVideo and tbl1.bannerVideoId then
            local createElement9 = React.createElement
            local var29 = JoinCardBannerVideoContainer
            local tbl18 = {
                videoId = tbl1.bannerVideoId,
                videoPlaybackContext = tbl1.bannerVideoPlaybackContext,
                universeId = tbl1.universeId,
                Size = UDim2.new(1, 0, 0, 202),
                cornerRadius = 15,
                ZIndex = 2,
                onActivated = 0
            }

            if not FFlagMobileGameJoinCardEDPFromThumbnail then
                var17 = nil
            end

            tbl18.onActivated = var17
            var28 = createElement9(var29, tbl18)
        else
            var28 = nil
        end

        tbl15.BannerVideo = var28
        tbl13.BannerImageClipper = createElement7(var27, tbl14, tbl15)
        tbl11.BannerImageContainer = createElement6(var26, tbl12, tbl13)
        local var29

        if tbl1.userId then
            local createElement9 = React.createElement
            local var30 = View
            local tbl18 = { Size = 0, ZIndex = 2, LayoutOrder = 2 }
            local var31

            if bool2 or content ~= nil then
                local new = UDim2.new
                local num1 = 1
                local num2 = 0
                local num3 = 0
                if content ~= nil then
                    var19 = yOffset
                end

                var31 = new(num1, num2, num3, var19)
            elseif bool1 then
                var31 = UDim2.new(1, 0, 0, yOffset)
            else
                var31 = UDim2.new(1, 0, 0, yOffset2)
            end

            tbl18.Size = var31

            local tbl19 = { Tile = 0 }
            local element

            if bool2 or content ~= nil then
                local createElement10 = React.createElement
                local var32 = View
                local tbl20 = {
                    tag = if content == nil then "row align-x-center align-y-center size-full" else "col align-x-center align-y-center gap-small size-full",
                    onActivated = 0,
                    stateLayer = 0
                }

                if content ~= nil
                    or FFlagGameJoinCardOptionalActions and tbl1.onViewExperienceDetails == nil
                    or not FFlagMobileGameJoinCardEDPFromTitle
                then
                    var18 = nil
                end

                tbl20.onActivated = var18

                tbl20.stateLayer = if content == nil and (not FFlagGameJoinCardOptionalActions or tbl1.onViewExperienceDetails ~= nil) then FFlagMobileGameJoinCardEDPFromTitle and {
                    affordance = StateLayerAffordance.None
                } or nil else nil

                local tbl21 = {
                    ExperienceText = React.createElement(FoundationText, {
                        tag = "shrink auto-xy text-align-x-center content-emphasis",
                        fontStyle = var3.Typography.TitleMedium,
                        Text = if content then content.title else tbl1.experienceName,
                        LayoutOrder = 1,
                        RichText = true,
                        TextTruncate = Enum.TextTruncate.AtEnd
                    }),
                    Subtitle = if content then React.createElement(FoundationText, {
                        tag = "shrink auto-xy text-align-x-center content-default",
                        fontStyle = var3.Typography.BodyMedium,
                        Text = content.subtitle,
                        LayoutOrder = 2,
                        TextTruncate = Enum.TextTruncate.AtEnd
                    }) else nil
                }
                element = createElement10(var32, tbl20, tbl21)
            elseif bool1 then
                element = React.createElement(View, {
                    tag = "col align-x-center align-y-center size-full"
                }, {
                    CombinedText = React.createElement(FoundationText, {
                        tag = "shrink auto-xy text-wrap text-align-x-center content-default",
                        fontStyle = var3.Typography.BodyMedium,
                        Text = var20.userIsPlayingExperience,
                        LayoutOrder = 1,
                        RichText = true
                    })
                })
            else
                local createElement10 = React.createElement
                local var32 = UserTile2
                local tbl20 = {
                    userId = tbl1.userId,
                    title = tbl1.playerName,
                    subtitle = var20.playingExperience,
                    layoutMode = LayoutMode.compact,
                    avatarSize = UDim2.fromOffset(88, 88),
                    backplateStyle = var3.Color.Surface.Surface_100,
                    onActivated = 0,
                    selectable = 0
                }

                if FFlagGameJoinCardOptionalActions and tbl1.onViewProfile == nil then
                    var15 = nil
                end

                tbl20.onActivated = var15

                tbl20.selectable = if FFlagGameJoinCardOptionalActions then not (tbl1.onViewProfile == nil) and nil else nil
                element = createElement10(var32, tbl20)
            end

            tbl19.Tile = element
            var29 = createElement9(var30, tbl18, tbl19)
        else
            var29 = nil
        end

        tbl11.UserTileWrapper = var29
        local element

        if var22 and var21 ~= nil then
            element = React.createElement(
                View,
                {
                    tag = "col align-x-center items-center gap-xxsmall size-full-0 auto-y",
                    LayoutOrder = 3
                },
                {
                    CtaContextTitle = React.createElement(
                        FoundationText,
                        {
                            Text = var21.title,
                            tag = "auto-xy text-body-medium text-align-x-center content-emphasis",
                            LayoutOrder = 1
                        }
                    ),
                    CtaContextSubtitle = if var21.subtitle == nil then nil else React.createElement(
                        FoundationText,
                        {
                            Text = var21.subtitle,
                            tag = "auto-xy text-label-small text-align-x-center content-muted",
                            LayoutOrder = 2
                        }
                    )
                }
            )
        else
            element = nil
        end

        tbl11.CtaContext = element

        local createElement9 = React.createElement
        local var30 = View
        local tbl18 = {
            tag = "col gap-small size-full-0 auto-y",
            LayoutOrder = var22 and (if var21 == nil then 3 else 4) or 3
        }
        if not FFlagJoinabilityCTARefactor and content == nil then
            tbl2 = { PrimaryButton = 0, ChatButton = 0, SecondaryButton = 0 }
            local var31

            if bool7 then
                local createElement10 = React.createElement
                local var32 = AgeCheckUpsellCTA
                local tbl19 = {
                    onUnlockPressed = tbl1.onAgeCheckPressed or function() end,
                    LayoutOrder = 1,
                    focusRef = 0
                }
                if not FFlagMobileGameJoinCardGamepadSupport then
                    primaryButtonFocusRef = nil
                end

                tbl19.focusRef = primaryButtonFocusRef
                var31 = createElement10(var32, tbl19)
            else
                local createElement10 = React.createElement
                local var32 = Button
                local tbl19 = {
                    ref = 0,
                    text = 0,
                    onActivated = 0,
                    variant = 0,
                    inputSize = 0,
                    isLoading = 0,
                    isDisabled = 0,
                    width = 0,
                    LayoutOrder = 1
                }

                if not FFlagMobileGameJoinCardGamepadSupport then
                    primaryButtonFocusRef = nil
                end

                tbl19.ref = primaryButtonFocusRef

                tbl19.text = var20.join
                tbl19.onActivated = tbl1.onJoin
                tbl19.variant = ButtonVariant.Emphasis
                tbl19.inputSize = InputSize.Medium
                tbl19.isLoading = tbl1.isLoading
                tbl19.isDisabled = not tbl1.isInExperience
                tbl19.width = UDim.new(1, 0)
                var31 = createElement10(var32, tbl19)
            end

            tbl2.PrimaryButton = var31
            local element2 = if tbl1.canUsePlatformChat then React.createElement(Button, {
                text = if bool2 and not bool3 then var20.chatWithName else var20.chat,
                onActivated = tbl1.onChat,
                variant = ButtonVariant.Standard,
                inputSize = InputSize.Medium,
                width = UDim.new(1, 0),
                LayoutOrder = 2
            }) else nil
            tbl2.ChatButton = element2
            local secondaryButton = if FFlagGameJoinCardOptionalActions and tbl1.onViewProfile == nil then nil else React.createElement(
                Button,
                {
                    text = var20.viewProfile,
                    onActivated = onActivated,
                    variant = ButtonVariant.Utility,
                    inputSize = InputSize.Medium,
                    width = UDim.new(1, 0),
                    LayoutOrder = 3
                }
            )
            tbl2.SecondaryButton = secondaryButton
        end

        tbl11.Buttons = createElement9(var30, tbl18, tbl2)
        tbl9.Layout = createElement5(var25, tbl10, tbl11)
        tbl8.Content = createElement4(content2, var24, tbl9)
        tbl6.SheetRoot = createElement3(root, tbl7, tbl8)
        var8 = createElement2(var23, tbl5, tbl6)
    end

    tbl4.SheetProvider = var8
    return createElement(str1, tbl3, tbl4)
end

return MobileGameJoinCard
