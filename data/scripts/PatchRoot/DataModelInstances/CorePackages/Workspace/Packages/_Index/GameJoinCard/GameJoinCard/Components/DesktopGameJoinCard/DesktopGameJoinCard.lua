-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCard = script:FindFirstAncestor("GameJoinCard")
local GameJoinCardParent = GameJoinCard.Parent
local React = require(GameJoinCardParent.React)
local useComposedRef = require(GameJoinCardParent.ReactUtils).useComposedRef
local Foundation = require(GameJoinCardParent.Foundation)

local useTokens = Foundation.Hooks.useTokens
local useScaledValue = Foundation.Hooks.useScaledValue
local useLocalization = require(GameJoinCardParent.Localization).Hooks.useLocalization

local View = Foundation.View
local FoundationText = Foundation.Text
local Image = Foundation.Image
local Icon = Foundation.Icon
local Button = Foundation.Button
local Skeleton = Foundation.Skeleton
local ButtonVariant = Foundation.Enums.ButtonVariant
local IconSize = Foundation.Enums.IconSize
local InputSize = Foundation.Enums.InputSize
local Radius = Foundation.Enums.Radius
local getBuilderIconForCurrentPlatform = Foundation.Utility.getBuilderIconForCurrentPlatform
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance
local ControlState = Foundation.Enums.ControlState

local AnalyticsConstants = require(script.Parent.Parent.Parent.Analytics.AnalyticsConstants)
local viewEDPsourceValues = AnalyticsConstants.viewEDPsourceValues
local viewProfileSourceValues = AnalyticsConstants.viewProfileSourceValues

local SharedFlags = require(GameJoinCardParent.SharedFlags)
local FFlagBlockEDPClickthrough = SharedFlags.FFlagBlockEDPClickthrough
local FFlagJoinabilityCTARefactor = SharedFlags.FFlagJoinabilityCTARefactor
local FFlagJoinabilityCTAContextCopy = SharedFlags.FFlagJoinabilityCTAContextCopy
local FFlagDesktopGameJoinCardGamepadSupport = SharedFlags.FFlagDesktopGameJoinCardGamepadSupport
local FFlagConsoleOpenGameJoinCard = SharedFlags.FFlagConsoleOpenGameJoinCard
local FFlagGameJoinCardContent = SharedFlags.FFlagGameJoinCardContent

local useGameJoinCardGamepadNavigation = nil
local assignPrimaryFocusRef = nil
if FFlagDesktopGameJoinCardGamepadSupport or FFlagConsoleOpenGameJoinCard then
    local useGameJoinCardGamepadNavigation2 = require(GameJoinCard.Hooks.useGameJoinCardGamepadNavigation)
    useGameJoinCardGamepadNavigation = useGameJoinCardGamepadNavigation2.useGameJoinCardGamepadNavigation
    assignPrimaryFocusRef = useGameJoinCardGamepadNavigation2.assignPrimaryFocusRef
end

local AgeCheckUpsellCTA = require(script.Parent.Parent.AgeCheckUpsellCTA)
local _Types = require(GameJoinCard.Components.Actions.Types)
local buildJoinCardActionsComponent = require(GameJoinCard.Components.Actions.buildJoinCardActionsComponent)

local function DesktopGameJoinCard(tbl1)
    local var1 = useTokens()
    local xOffset = useScaledValue(260)
    local var2 = useLocalization({
        isPlaying = "Feature.Friends.Text.IsPlaying",
        joinButton = "Feature.Profile.Action.JoinGame",
        chat = "Feature.Profile.Action.Chat",
        viewProfile = "Feature.Profile.Action.ViewProfile",
        playTogether = "Feature.GameJoin.Label.PlayTogether",
        playTogetherSoon = "Feature.GameJoin.Label.PlayTogetherSoon",
        differentServer = "Feature.GameJoin.Description.DifferentServer"
    })

    local layoutOrder = tbl1.layoutOrder
    local playerName = tbl1.playerName
    local experienceName = tbl1.experienceName
    local gameIconUrl = tbl1.gameIconUrl
    local isLoading = tbl1.isLoading
    local var3 = if tbl1.isConsole then var1.Size.Size_1500 else var1.Size.Size_1000

    local name = React.useMemo(function()
        return getBuilderIconForCurrentPlatform()
    end, {})

    local var5 = React.useCallback(function()
        tbl1.onViewExperienceDetails(viewEDPsourceValues.Thumbnail)
    end, { tbl1 })

    local var6 = React.useCallback(function()
        tbl1.onViewExperienceDetails(viewEDPsourceValues.Title)
    end, { tbl1 })

    local onActivated = React.useCallback(function()
        if tbl1.onViewProfile then
            tbl1.onViewProfile(viewProfileSourceValues.ViewProfileButton)
        end
    end, { tbl1 })

    local var8, var9 = React.useState(false)
    local onStateChanged = React.useCallback(function(hover)
        var9(hover == ControlState.Hover)
    end, {})

    local var11 = if var8 then `<u>{var2.viewProfile}</u>` else var2.viewProfile
    local isConsole = FFlagConsoleOpenGameJoinCard and tbl1.isConsole
    local var12 = if FFlagDesktopGameJoinCardGamepadSupport or FFlagConsoleOpenGameJoinCard then useGameJoinCardGamepadNavigation(tbl1.onClose, tbl1.isOpen ~= false) else nil
    local primaryButtonFocusRef = if var12 == nil or not FFlagDesktopGameJoinCardGamepadSupport or tbl1.isConsole then nil else var12.primaryButtonFocusRef
    local rootRef = if var12 == nil then nil elseif if tbl1.isConsole then isConsole else FFlagDesktopGameJoinCardGamepadSupport then var12.rootRef else nil
    local var13 = if FFlagDesktopGameJoinCardGamepadSupport or FFlagConsoleOpenGameJoinCard then useComposedRef(rootRef, tbl1.focusRootRef) else nil
    local bool1 = tbl1.ageCheckRequired == true
    local tbl2 = {}
    local var14 = nil
    if FFlagJoinabilityCTARefactor or FFlagGameJoinCardContent and tbl1.content ~= nil then
        if tbl1.areActionsLoading then
            tbl2.ActionsLoading = React.createElement(
                Skeleton,
                {
                    Size = UDim2.new(1, 0, 0, var1.Size.Size_600),
                    radius = Radius.Medium,
                    LayoutOrder = 1
                }
            )
        else
            local var15 = if primaryButtonFocusRef then assignPrimaryFocusRef(tbl1.actions, primaryButtonFocusRef) or tbl1.actions else tbl1.actions

            tbl2, var14 = buildJoinCardActionsComponent(
                var15,
                {
                    playTogether = var2.playTogether,
                    playTogetherSoon = var2.playTogetherSoon,
                    differentServer = var2.differentServer
                },
                tbl1.onClose,
                function(arg1, layoutOrder2)
                    return React.createElement(Button, {
                        ref = arg1.focusRef,
                        text = arg1.text,
                        onActivated = function()
                            arg1.onActivated()
                        end,
                        isLoading = arg1.isLoading,
                        isDisabled = arg1.isDisabled,
                        variant = arg1.variant,
                        size = arg1.inputSize,
                        width = arg1.width,
                        tag = "align-x-center fill size-full-0",
                        LayoutOrder = layoutOrder2
                    })
                end
            )
        end
    end

    local var15 = FFlagJoinabilityCTAContextCopy and not tbl1.isConsole

    local createElement = React.createElement
    local var16 = View
    local tbl3 = {
        Size = UDim2.fromOffset(xOffset, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = layoutOrder,
        backgroundStyle = var1.Color.OverMedia.OverMedia_300,
        tag = "col gap-medium padding-large radius-medium stroke-thin stroke-muted",
        ref = 0,
        selectionGroup = 0
    }
    if rootRef == nil then
        var13 = tbl1.focusRootRef
    end

    tbl3.ref = var13
    tbl3.selectionGroup = isConsole
        and {
            SelectionBehaviorUp = Enum.SelectionBehavior.Stop,
            SelectionBehaviorDown = Enum.SelectionBehavior.Stop,
            SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
            SelectionBehaviorRight = Enum.SelectionBehavior.Stop
        }
        or nil

    local tbl4 = { GameInfoRow = 0, CtaContext = 0, Actions = 0 }
    local createElement2 = React.createElement
    local var17 = View
    local tbl5 = {
        tag = "row gap-small items-center size-full-0 auto-y align-x-left",
        LayoutOrder = 1
    }

    local tbl6 = { GameIcon = 0, TextContainer = 0 }
    local element

    if not isLoading then
        local createElement3 = React.createElement
        local var18 = View
        local tbl7 = {
            Size = UDim2.fromOffset(var3, var3),
            LayoutOrder = 1,
            ClipsDescendants = true
        }

        local tbl8 = {
            Media = if FFlagGameJoinCardContent and tbl1.content then tbl1.content.media else nil,
            Thumbnail = 0
        }
        local createElement4 = React.createElement
        local var19 = Image
        local tbl9 = {
            Image = gameIconUrl,
            Size = UDim2.fromScale(1, 1),
            ScaleType = Enum.ScaleType.Fit,
            tag = "radius-small",
            onActivated = 0,
            stateLayer = 0
        }
        if FFlagBlockEDPClickthrough or FFlagGameJoinCardContent and tbl1.content ~= nil then
            var5 = nil
        end

        tbl9.onActivated = var5

        tbl9.stateLayer = if FFlagBlockEDPClickthrough or FFlagGameJoinCardContent and tbl1.content ~= nil then nil else tbl1.onViewExperienceDetails and {
            affordance = StateLayerAffordance.None
        } or nil
        tbl8.Thumbnail = createElement4(var19, tbl9)
        element = createElement3(var18, tbl7, tbl8)
    else
        element = React.createElement(Skeleton, { LayoutOrder = 1, Size = UDim2.fromOffset(var3, var3), radius = Radius.Small })
    end

    tbl6.GameIcon = element

    local createElement3 = React.createElement
    local var18 = View
    local tbl7 = {
        tag = "col size-full-0 auto-y gap-xxsmall shrink align-x-left items-start",
        LayoutOrder = 2,
        AutomaticSize = Enum.AutomaticSize.Y
    }
    local tbl8 = { GameInfo = 0, PlatformName = 0 }
    local createElement4 = React.createElement
    local var19 = View
    local tbl9 = {
        tag = "col size-full-0 auto-y shrink align-x-left items-start",
        LayoutOrder = 1,
        AutomaticSize = Enum.AutomaticSize.Y
    }
    local tbl10 = { GameTitle = 0, GameName = 0 }
    local element2

    if not isLoading then
        local createElement5 = React.createElement
        local var20 = View
        local tbl11 = {
            tag = "row auto-y gap-xxsmall size-full-0 align-x-left align-y-center text-body-medium content-default text-align-x-left",
            LayoutOrder = 1
        }

        local tbl12 = {
            PlayerName = React.createElement(FoundationText, {
                Text = playerName,
                tag = "shrink auto-xy text-body-medium content-default text-no-wrap text-truncate-end text-align-x-left",
                LayoutOrder = 1
            }),
            IsPlaying = React.createElement(FoundationText, {
                Text = if FFlagGameJoinCardContent and tbl1.content then tbl1.content.activityText else var2.isPlaying,
                tag = "shrink-0 auto-xy text-body-medium content-default text-align-x-left",
                LayoutOrder = 2
            })
        }
        element2 = createElement5(var20, tbl11, tbl12)
    else
        element2 = React.createElement(
            Skeleton,
            {
                Size = UDim2.new(0.7, 0, 0, var1.Typography.BodyMedium.FontSize),
                radius = Radius.Small,
                LayoutOrder = 1
            }
        )
    end

    tbl10.GameTitle = element2
    local element3

    if not isLoading then
        local createElement5 = React.createElement
        local var20 = View
        local tbl11 = {
            tag = "size-full-0 auto-y",
            LayoutOrder = 2,
            onActivated = 0,
            stateLayer = 0
        }

        if FFlagBlockEDPClickthrough or FFlagGameJoinCardContent and tbl1.content ~= nil then
            var6 = nil
        end

        tbl11.onActivated = var6

        tbl11.stateLayer = not FFlagBlockEDPClickthrough
            and (not FFlagGameJoinCardContent or tbl1.content == nil)
            and {
                affordance = StateLayerAffordance.None
            }
            or nil
        element3 = createElement5(var20, tbl11, {
            Label = React.createElement(FoundationText, {
                Text = experienceName,
                tag = "size-full-0 auto-y text-title-medium text-no-wrap text-align-x-left text-truncate-split content-emphasis"
            })
        })
    else
        element3 = React.createElement(
            Skeleton,
            {
                Size = UDim2.new(0.5, 0, 0, var1.Typography.TitleMedium.FontSize),
                radius = Radius.Small,
                LayoutOrder = 2
            }
        )
    end

    tbl10.GameName = element3
    tbl8.GameInfo = createElement4(var19, tbl9, tbl10)
    local element4

    if tbl1.isConsole then
        if not isLoading then
            element4 = React.createElement(View, {
                LayoutOrder = 2,
                tag = "row align-x-left items-center gap-small size-full-0 auto-y",
                onActivated = tbl1.onPlatformProfilePressed,
                selection = tbl1.onPlatformProfilePressed and { Selectable = true } or nil,
                stateLayer = tbl1.onPlatformProfilePressed and {
                    affordance = StateLayerAffordance.Background
                } or nil
            }, {
                PlatformLogo = React.createElement(
                    View,
                    { tag = "auto-xy shrink", LayoutOrder = 1 },
                    {
                        LogoImage = React.createElement(Icon, { name = name, size = IconSize.XSmall })
                    }
                ),
                PlatformNameLabel = React.createElement(FoundationText, {
                    Text = tbl1.consolePlatformLabel,
                    tag = "fill shrink auto-y text-body-small content-default text-no-wrap text-truncate-end text-align-x-left",
                    LayoutOrder = 2
                })
            })
        else
            element4 = React.createElement(
                Skeleton,
                {
                    Size = UDim2.new(0.6, 0, 0, var1.Typography.BodySmall.FontSize),
                    radius = Radius.Small,
                    LayoutOrder = 2
                }
            )
        end
    else
        element4 = nil
    end

    tbl8.PlatformName = element4
    tbl6.TextContainer = createElement3(var18, tbl7, tbl8)
    tbl4.GameInfoRow = createElement2(var17, tbl5, tbl6)
    local element5

    if var15 and var14 ~= nil then
        element5 = React.createElement(
            View,
            { tag = "col align-x-left items-start gap-xxsmall size-full-0 auto-y", LayoutOrder = 2 },
            {
                CtaContextTitle = React.createElement(
                    FoundationText,
                    {
                        Text = var14.title,
                        tag = "auto-xy text-body-medium text-align-x-left content-emphasis",
                        LayoutOrder = 1
                    }
                ),
                CtaContextSubtitle = if var14.subtitle == nil then nil else React.createElement(
                    FoundationText,
                    {
                        Text = var14.subtitle,
                        tag = "auto-xy text-label-small text-align-x-left content-muted",
                        LayoutOrder = 2
                    }
                )
            }
        )
    else
        element5 = nil
    end

    tbl4.CtaContext = element5
    local var20

    if tbl1.isConsole then
        var20 = nil
    else
        local createElement5 = React.createElement
        local var21 = View
        local tbl11 = { tag = "col gap-small size-full-0 auto-y", LayoutOrder = 3 }

        if not FFlagJoinabilityCTARefactor and (not FFlagGameJoinCardContent or tbl1.content == nil) then
            tbl2 = { JoinButton = 0, ChatButton = 0, ViewProfileButton = 0 }
            local element6

            if bool1 then
                element6 = React.createElement(AgeCheckUpsellCTA, {
                    onUnlockPressed = tbl1.onAgeCheckPressed or function() end,
                    LayoutOrder = 1,
                    focusRef = primaryButtonFocusRef
                })
            else
                element6 = React.createElement(Button, {
                    ref = primaryButtonFocusRef,
                    text = var2.joinButton,
                    onActivated = tbl1.onJoin,
                    isLoading = isLoading,
                    variant = ButtonVariant.Emphasis,
                    size = InputSize.Medium,
                    tag = "align-x-center fill size-full-0",
                    width = UDim.new(1, 0),
                    LayoutOrder = 1
                })
            end

            tbl2.JoinButton = element6
            local chatButton = if tbl1.onChat == nil then nil else React.createElement(Button, {
                text = var2.chat,
                onActivated = tbl1.onChat,
                variant = ButtonVariant.Standard,
                size = InputSize.Medium,
                tag = "align-x-center fill size-full-0",
                width = UDim.new(1, 0),
                LayoutOrder = 2
            })
            tbl2.ChatButton = chatButton
            local element8

            if tbl1.onViewProfile == nil then
                element8 = nil
            else
                element8 = React.createElement(View, {
                    Size = UDim2.new(1, 0, 0, var1.Size.Size_600),
                    tag = "row align-x-center align-y-center",
                    onActivated = onActivated,
                    onStateChanged = onStateChanged,
                    stateLayer = {
                        affordance = StateLayerAffordance.None
                    },
                    LayoutOrder = 3
                }, {
                    Label = React.createElement(
                        FoundationText,
                        {
                            Text = var11,
                            RichText = true,
                            tag = "auto-xy text-title-medium text-align-x-center content-emphasis"
                        }
                    )
                })
            end

            tbl2.ViewProfileButton = element8
        end

        var20 = createElement5(var21, tbl11, tbl2)
    end

    tbl4.Actions = var20
    local gameJoinCard = createElement(var16, tbl3, tbl4)

    return React.createElement(Foundation.Popover.Root, {
        isOpen = tbl1.isOpen
    }, {
        Anchor = React.createElement(Foundation.Popover.Anchor, { anchorRef = tbl1.anchorRef }),
        Content = React.createElement(Foundation.Popover.Content, {
            align = Foundation.Enums.PopoverAlign.Center,
            side = tbl1.isConsole and {
                position = Foundation.Enums.PopoverSide.Bottom,
                offset = var1.Padding.Small
            }
                or Foundation.Enums.PopoverSide.Bottom,
            radius = Foundation.Enums.Radius.Medium,
            hasArrow = false,
            backgroundStyle = var1.Color.None,
            onPressedOutside = tbl1.onClose
        }, { GameJoinCard = gameJoinCard })
    })
end

return DesktopGameJoinCard
