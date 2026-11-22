-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")

local dependencies = require(Squads.dependencies)

local SquadsParent = Squads.Parent
local CrossExperienceVoice = require(SquadsParent.CrossExperienceVoice)
local UIBlox = require(SquadsParent.UIBlox)
local UserProfiles = require(SquadsParent.UserProfiles)
local getStandardSizeAvatarHeadShotRbxthumb = require(SquadsParent.UserLib).Utils.getStandardSizeAvatarHeadShotRbxthumb
local useLocalUserId = require(SquadsParent.RobloxAppHooks).useLocalUserId
local BuilderIcons = require(SquadsParent.BuilderIcons)
local Hooks = require(SquadsParent.SquadsCore.Hooks)

local PresenceType = dependencies.RoduxPresence.Enums.PresenceType
local Foundation = dependencies.Foundation
local React = dependencies.React
local SharedFlags = dependencies.SharedFlags

local useLocalization = dependencies.Hooks.useLocalization
local useSelector = dependencies.Hooks.useSelector

local FFlagSquadsPresenceStoreMigration = require(SquadsParent.SquadsCore.Flags).FFlagSquadsPresenceStoreMigration
local FFlagSquadsEnableFoundationTestIds = require(Squads.Flags.FFlagSquadsEnableFoundationTestIds)
local useGetPresenceByUserId = if FFlagSquadsPresenceStoreMigration then require(SquadsParent.FriendsCommon).Hooks.useGetPresenceByUserId else nil
local PresenceType2 = if FFlagSquadsPresenceStoreMigration then require(SquadsParent.DataHydration).Presence.PresenceEnums.PresenceType else nil
local useParticipant = CrossExperienceVoice.Hooks.useParticipant
local useIsVoiceConnected = CrossExperienceVoice.Hooks.useIsVoiceConnected
local useIsActiveParticipant = CrossExperienceVoice.Hooks.useIsActiveParticipant
local useAnimatedTransparency = CrossExperienceVoice.Hooks.useAnimatedTransparency
local useIsParticipantMuted = CrossExperienceVoice.Hooks.useIsParticipantMuted
local useIsVoiceConnecting = CrossExperienceVoice.Hooks.useIsVoiceConnecting
local useIsMicPermissionsError = CrossExperienceVoice.Hooks.useIsMicPermissionsError
local useIsParticipantInOtherAudioContext = CrossExperienceVoice.Hooks.useIsParticipantInOtherAudioContext
local useIsParticipantMutedLocally = CrossExperienceVoice.Hooks.useIsParticipantMutedLocally
local useTokens = Foundation.Hooks.useTokens
local useSquadUserDropdownMenuButtons = require(Squads.Hooks.useSquadUserDropdownMenuButtons)

local useIsLocalPlayerPartyVoiceEligible = Hooks.useIsLocalPlayerPartyVoiceEligible
local useIsUserPartyVoiceEligible = Hooks.useIsUserPartyVoiceEligible
local useIsCurrentSquadPartyVoiceEligible = Hooks.useIsCurrentSquadPartyVoiceEligible

local GetFFlagEnableCrossExpVoice = SharedFlags.GetFFlagEnableCrossExpVoice
local IconSize = Foundation.Enums.IconSize
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local _ModelTypes = require(Squads.Common.ModelTypes)
local SquadUserPartyStatus = require(Squads.Enums.SquadUserPartyStatus)

local SquadLobbyUserOverflowMenuContainer = require(Squads.Components.SquadLobby.SquadLobbyUserOverflowMenu.SquadLobbyUserOverflowMenuContainer)

local num1 = game:DefineFastInt("PartyVoiceActivityIndicatorDebounceMs", 100)
local num2 = game:DefineFastInt("PartyVoiceActivityIndicatorAnimationMs", 100)

local FFlagEnablePartyVoiceChangersInLua = SharedFlags.FFlagEnablePartyVoiceChangersInLua
local FFlagEnableBlackbirdCheck = SharedFlags.FFlagEnableBlackbirdCheck
local FFlagSquadMemberJoinDialogAndOverflowMenu = require(Squads.Flags.FFlagSquadMemberJoinDialogAndOverflowMenu)
local useIsRobloxSubscriber = UserProfiles.Hooks.useIsRobloxSubscriber

return function(tbl1)
    local var1 = useLocalization({
        connectingText = "Feature.Squads.Label.Connecting",
        inExperiencePresenceText = "Common.Presence.Label.InExperience",
        invitedText = "Feature.Squads.Description.Invited",
        noResponseText = "Feature.Squads.Description.NoResponse",
        onlinePresenceText = "Common.Presence.Label.Online"
    })

    local var2 = useTokens()

    local var3, var4 = useAnimatedTransparency(1, num2, Enum.EasingStyle.Cubic)

    local var5 = useIsRobloxSubscriber
    local var6 = if FFlagEnableBlackbirdCheck then tostring(tbl1.user.userId) else nil
    local var7 = var5(var6)

    local useUserProfilesFetch = UserProfiles.Hooks.useUserProfilesFetch
    local tbl2 = {
        userIds = { tostring(tbl1.user.userId) },
        query = UserProfiles.Queries.userProfilesCombinedNameByUserIds
    }
    local var8 = useUserProfilesFetch(tbl2)

    local combinedNameFromId = if var8.data then UserProfiles.Selectors.getCombinedNameFromId(var8.data, tbl1.user.userId) else ""

    local image = getStandardSizeAvatarHeadShotRbxthumb(tostring(tbl1.user.userId))
    local str1 = `--social-squad-lobby-user-card-{tbl1.user.userId}`

    local var9 = React.useCallback(function(arg1)
        return arg1.Squad.Presence.byUserId[tostring(tbl1.user.userId)]
    end, { tbl1.user.userId })

    local var10 = if FFlagSquadsPresenceStoreMigration then useGetPresenceByUserId(tostring(tbl1.user.userId)) else useSelector(var9)
    local bool1 = var10
        and var10.userPresenceType == (if FFlagSquadsPresenceStoreMigration then PresenceType2.InGame else PresenceType.InGame)
    local var11

    if bool1 then
        local lastLocation = if FFlagSquadsPresenceStoreMigration then var10 and var10.lastLocation else var10.lastLocation
        var11 = lastLocation and lastLocation ~= "" and lastLocation or var1.inExperiencePresenceText
    else
        var11 = var1.onlinePresenceText
    end
    local isConnecting = tbl1.isConnecting
    local num3 = tonumber(useLocalUserId()) or 0
    local bool2 = num3 == tbl1.user.userId

    local bool3 = false

    local bool4 = false
    local bool5 = false

    local bool6 = false
    local bool7 = false
    local bool8 = false

    local isVoiceChangerActive = false

    if GetFFlagEnableCrossExpVoice() then
        local var12 = useIsVoiceConnected()
        local var13 = useIsMicPermissionsError()
        local var14 = useParticipant(tbl1.user.userId)
        bool7 = useIsVoiceConnecting() and bool2
        bool3 = useIsActiveParticipant(tbl1.user.userId)
        local var15 = useIsLocalPlayerPartyVoiceEligible()
        local var16 = useIsUserPartyVoiceEligible(tbl1.user.userId)
        local bool9 = useIsCurrentSquadPartyVoiceEligible() == true
        local bool10 = useIsParticipantMutedLocally(tbl1.user.userId) == true
        bool8 = var16 and bool9 and not bool2 and bool10
        bool6 = useIsParticipantMuted(tbl1.user.userId) and not bool8
        local bool11 = useIsParticipantInOtherAudioContext(num3, tbl1.user.userId) == true
        bool4 = bool9 and var15 and var16 and (not var12 or not var14 or bool11 or var13)

        bool5 = bool9 and var15 and not var16
        if FFlagEnablePartyVoiceChangersInLua and var14 then
            isVoiceChangerActive = var14.isVoiceChangerActive
        else
            isVoiceChangerActive = false
        end
    end
    local var12 = React.useMemo(function()
        return CrossExperienceVoice.Utils.debounce(function(num4: number)
            var4(num4)
        end, num1)
    end, {})

    React.useEffect(function()
        if not GetFFlagEnableCrossExpVoice() then
            return
        end

        if bool3 then
            var12.cancel()
            var4(0)
            return
        end
        var12.call(1)
    end, { bool3 })

    local var13 = React.useMemo(function()
        if tbl1.user.partyStatus == SquadUserPartyStatus.NoResponse then
            return var1.noResponseText
        end

        if tbl1.user.partyStatus == SquadUserPartyStatus.Invited then
            return var1.invitedText
        end

        if isConnecting or bool7 then
            return var1.connectingText
        end

        return var11
    end, {
        tbl1.user and tbl1.user.partyStatus,
        var11,
        isConnecting,
        bool7,
        var1.noResponse,
        var1.invitedText,
        var1.connectingText
    })

    local presenceIcon = React.useMemo(function()
        if tbl1.user.partyStatus == SquadUserPartyStatus.Invited then
            local createElement = React.createElement
            local view = Foundation.View
            local tbl3 = { tag = "auto-xy" }
            local tbl4 = {
                LoadingIcon = React.createElement(Foundation.Loading, {
                    LayoutOrder = 1,
                    size = IconSize.Small,
                    Padding = var2.Padding.XSmall,
                    testId = if FFlagSquadsEnableFoundationTestIds then `{str1}--loading` else nil
                })
            }
            return createElement(view, tbl3, tbl4)
        end

        if tbl1.user.partyStatus == SquadUserPartyStatus.NoResponse then
            return nil
        end

        if not (isConnecting or bool7) then
            if not bool1 then
                return nil
            end

            return React.createElement(Foundation.Icon, {
                LayoutOrder = 1,
                name = "icons/common/play",
                size = IconSize.Small,
                style = var2.Color.Content.Emphasis,
                testId = if FFlagSquadsEnableFoundationTestIds then `{str1}--in-game-icon` else nil
            })
        end

        local createElement = React.createElement
        local view = Foundation.View
        local tbl3 = { tag = "auto-xy" }
        local tbl4 = {
            LoadingIcon = React.createElement(Foundation.Loading, {
                LayoutOrder = 1,
                size = IconSize.Small,
                Padding = var2.Padding.XSmall,
                testId = if FFlagSquadsEnableFoundationTestIds then `{str1}--loading` else nil
            })
        }
        return createElement(view, tbl3, tbl4)
    end, {
        tbl1.user and tbl1.user.partyStatus,
        isConnecting,
        bool7,
        bool1,
        str1
    })
    local useMemo = React.useMemo

    local function func1()
        if combinedNameFromId == "" then
            return nil
        end

        local createElement = React.createElement
        local str2 = "Frame"
        local tbl3 = {
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = UDim2.fromScale(1, 0),
            BackgroundTransparency = 1,
            LayoutOrder = 1
        }

        local tbl4 = {
            UIListLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                Padding = UDim.new(0, var2.Gap.XSmall + 2),
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center
            }),
            BlockedIcon = if tbl1.isBlocked then React.createElement(Foundation.Icon, {
                LayoutOrder = 1,
                name = "icons/status/unavailable_small",
                size = IconSize.Small,
                style = var2.Color.Extended.Red.Red_800,
                testId = if FFlagSquadsEnableFoundationTestIds then `{str1}--blocked-icon` else nil
            }) else nil,
            MutedLocallyIcon = if bool8 then React.createElement(Foundation.Icon, {
                LayoutOrder = 2,
                name = "icons/controls/voice/microphone_off_small_dark",
                size = IconSize.Small,
                style = var2.Color.Extended.Red.Red_800,
                testId = if FFlagSquadsEnableFoundationTestIds then `{str1}--muted-locally-icon` else nil
            }) else nil,
            MutedIcon = if bool6 then React.createElement(Foundation.Icon, {
                LayoutOrder = 3,
                name = "icons/controls/microphoneMute_small",
                size = IconSize.Small,
                style = var2.Color.Content.Emphasis,
                testId = if FFlagSquadsEnableFoundationTestIds then `{str1}--muted-icon` else nil
            }) else nil,
            NotVoiceParticipantIcon = if bool4 then React.createElement(Foundation.Icon, {
                LayoutOrder = 4,
                name = "icons/controls/headphoneDeafen_small",
                size = IconSize.Small,
                style = var2.Color.Content.Emphasis,
                testId = if FFlagSquadsEnableFoundationTestIds then `{str1}--not-voice-participant-icon` else nil
            }) else nil,
            NotEligibleVoiceParticipant = if bool5 then React.createElement(Foundation.Icon, {
                LayoutOrder = 5,
                name = "icons/controls/headphoneDeafen_small",
                size = IconSize.Small,
                style = var2.Color.System.Warning,
                testId = if FFlagSquadsEnableFoundationTestIds then `{str1}--not-eligible-voice-participant-icon` else nil
            }) else nil,
            VoiceChangerActiveIcon = if FFlagEnablePartyVoiceChangersInLua and isVoiceChangerActive then React.createElement(
                Foundation.Icon,
                {
                    LayoutOrder = 6,
                    size = IconSize.Small,
                    name = BuilderIcons.Icon.DiamondSimplified,
                    style = var2.Color.Content.Emphasis,
                    testId = if FFlagSquadsEnableFoundationTestIds then `{str1}--voice-changer-icon` else nil
                }
            ) else nil,
            NameTextLabel = 0,
            NameAndBadge = 0
        }
        local element7

        if FFlagEnableBlackbirdCheck then
            element7 = nil
        else
            element7 = React.createElement(
                Foundation.Text,
                {
                    AutomaticSize = Enum.AutomaticSize.Y,
                    backgroundStyle = var2.Color.None,
                    colorstyle = var2.Color.Content.Emphasis,
                    fontStyle = var2.Typography.TitleMedium,
                    LayoutOrder = if FFlagEnablePartyVoiceChangersInLua then 7 else 6,
                    Text = combinedNameFromId,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Center,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    TextWrapped = false,
                    testId = if FFlagSquadsEnableFoundationTestIds then `{str1}--name` else nil
                },
                {
                    UIFlexItem = React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill })
                }
            )
        end

        tbl4.NameTextLabel = element7
        local var15

        if FFlagEnableBlackbirdCheck then
            local createElement2 = React.createElement
            local str3 = "Frame"
            local tbl5 = {
                AutomaticSize = Enum.AutomaticSize.Y,
                Size = UDim2.fromScale(0, 0),
                BackgroundTransparency = 1,
                LayoutOrder = if FFlagEnablePartyVoiceChangersInLua then 7 else 6
            }
            local tbl6 = {
                Layout = React.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal,
                    Padding = UDim.new(0, var2.Gap.XSmall),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalAlignment = Enum.VerticalAlignment.Center
                }),
                FlexFill = React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill }),
                NameText = React.createElement(
                    Foundation.Text,
                    {
                        AutomaticSize = Enum.AutomaticSize.XY,
                        backgroundStyle = var2.Color.None,
                        colorstyle = var2.Color.Content.Emphasis,
                        fontStyle = var2.Typography.TitleMedium,
                        LayoutOrder = 1,
                        Text = combinedNameFromId,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextYAlignment = Enum.TextYAlignment.Center,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        TextWrapped = false,
                        testId = if FFlagSquadsEnableFoundationTestIds then `{str1}--name` else nil
                    },
                    {
                        UIFlexItem = React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Shrink })
                    }
                ),
                SubscriptionBadge = if var7 then React.createElement(Foundation.Icon, {
                    LayoutOrder = 2,
                    size = IconSize.Small,
                    name = Foundation.Enums.IconName.RobloxPlus,
                    style = var2.Color.Content.Emphasis,
                    testId = if FFlagSquadsEnableFoundationTestIds then `{str1}--subscription-badge` else nil
                }) else nil
            }
            var15 = createElement2(str3, tbl5, tbl6)
        else
            var15 = nil
        end

        tbl4.NameAndBadge = var15
        return (createElement(str2, tbl3, tbl4))
    end
    local str2 = combinedNameFromId
    local var15 = bool6
    local var16 = bool8
    local isBlocked = tbl1.isBlocked

    local var17 = bool4
    local var18 = bool5
    local var19 = if FFlagEnablePartyVoiceChangersInLua then isVoiceChangerActive else nil
    local var20 = if FFlagEnableBlackbirdCheck then var7 else nil
    local var21 = useMemo(func1, { str2, var15, var16, isBlocked, var2, var17, var18, var19, var20, str1 })

    local var22 = React.useMemo(function()
        local createElement = React.createElement
        local str3 = "Frame"
        local tbl3 = {
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = UDim2.fromScale(1, 0),
            BackgroundTransparency = 1,
            LayoutOrder = 2
        }

        local tbl4 = {
            UIListLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                Padding = UDim.new(0, var2.Gap.XSmall),
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center
            }),
            PresenceIcon = presenceIcon,
            PresenceTextLabel = React.createElement(
                Foundation.Text,
                {
                    AutomaticSize = Enum.AutomaticSize.Y,
                    backgroundStyle = var2.Color.None,
                    colorstyle = var2.Color.Content.Default,
                    fontStyle = var2.Typography.BodyMedium,
                    LayoutOrder = 2,
                    Text = var13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Center,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    TextWrapped = false,
                    testId = if FFlagSquadsEnableFoundationTestIds then `{str1}--presence` else nil
                },
                {
                    UIFlexItem = React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill })
                }
            )
        }
        return createElement(str3, tbl3, tbl4)
    end, {
        isConnecting,
        bool7,
        bool1,
        var1.connectingText,
        var11,
        var2,
        presenceIcon,
        var13,
        str1
    })

    local var23 = useSquadUserDropdownMenuButtons(tbl1.user.userId, tbl1.isInExperience)
    local bool9 = #var23 < 1
    local bool10 = not (bool2 or bool9)
    local bool11 = false
    if FFlagSquadMemberJoinDialogAndOverflowMenu then
        bool10 = not bool2
        if table.find(var23, "JoinButton") == nil then
            bool11 = false
        else
            bool11 = true
        end
    end

    local openSquadVoiceAbuseReport = tbl1.openSquadVoiceAbuseReport
    local isDisabled = isConnecting
        or bool7
        or tbl1.user.partyStatus == SquadUserPartyStatus.Invited
        or tbl1.user.partyStatus == SquadUserPartyStatus.NoResponse

    local var25 = React.useCallback(function()
        if FFlagSquadMemberJoinDialogAndOverflowMenu and not bool11 then
            return
        end
        if tbl1.onActivated then
            tbl1.onActivated(tostring(tbl1.user.userId))
        end
    end, { tbl1.onActivated, tbl1.user.userId, bool11 })

    local createElement = React.createElement
    local view = Foundation.View
    local tbl3 = {
        LayoutOrder = tbl1.layoutOrder,
        Size = tbl1.size,
        backgroundStyle = var2.Color.Surface.Surface_200,
        cornerRadius = UDim.new(0, var2.Radius.Medium),
        isDisabled = isDisabled,
        onActivated = 0,
        stateLayer = 0,
        testId = 0
    }

    if not (tbl1.onActivated and bool10) then
        var25 = nil
    end

    tbl3.onActivated = var25
    tbl3.stateLayer = if FFlagSquadMemberJoinDialogAndOverflowMenu then not bool11 and {
        affordance = StateLayerAffordance.None
    } or nil else nil

    tbl3.testId = if FFlagSquadsEnableFoundationTestIds then str1 else nil
    local tbl4 = {
        AvatarImage = React.createElement(
            ImageSetLabel,
            {
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                Size = UDim2.fromOffset(96, 96),
                BackgroundColor3 = var2.Color.Shift.Shift_300.Color3,
                BackgroundTransparency = var2.Color.Shift.Shift_300.Transparency,
                Image = image,
                ZIndex = 0
            },
            {
                UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) })
            }
        ),
        GradientFrame = React.createElement("Frame", {
            Size = UDim2.fromScale(1, 0.5),
            Position = UDim2.fromScale(0, 1),
            AnchorPoint = Vector2.new(0, 1),
            BackgroundColor3 = var2.Color.Surface.Surface_100.Color3,
            BackgroundTransparency = var2.Color.Surface.Surface_100.Transparency,
            ZIndex = 1
        }, {
            UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var2.Radius.Medium) }),
            UIGradient = React.createElement("UIGradient", {
                Rotation = 90,
                Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) })
            }, {})
        }),
        InactiveOverlay = 0,
        TextContainer = 0,
        OverflowMenu = 0,
        ActiveBorder = 0,
        DefaultBorder = 0
    }
    local element

    if isConnecting
        or bool4
        or bool7
        or tbl1.user.partyStatus == SquadUserPartyStatus.Invited
        or tbl1.user.partyStatus == SquadUserPartyStatus.NoResponse
    then
        element = React.createElement(Foundation.View, {
            tag = "size-full radius-medium",
            backgroundStyle = {
                Color3 = var2.Color.Surface.Surface_100.Color3,
                Transparency = 0.25
            }
        }, {})
    else
        element = nil
    end

    tbl4.InactiveOverlay = element

    local createElement2 = React.createElement
    local str3 = "Frame"
    local tbl5 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.fromScale(0, 1),
        Size = UDim2.fromScale(1, 0),
        BackgroundTransparency = 1,
        ZIndex = 2
    }

    local tbl6 = {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Bottom
        }),
        UIPadding = React.createElement("UIPadding", {
            PaddingBottom = UDim.new(0, var2.Padding.Medium),
            PaddingLeft = UDim.new(0, var2.Padding.Medium),
            PaddingRight = UDim.new(0, var2.Padding.Medium),
            PaddingTop = UDim.new(0, var2.Padding.Medium)
        }),
        Name = var21,
        Presence = 0
    }

    if tbl1.isBlocked then
        var22 = nil
    end

    tbl6.Presence = var22
    tbl4.TextContainer = createElement2(str3, tbl5, tbl6)
    local element2 = if FFlagSquadMemberJoinDialogAndOverflowMenu and not bool2 and not isDisabled and openSquadVoiceAbuseReport then React.createElement(
        SquadLobbyUserOverflowMenuContainer,
        {
            userId = tostring(tbl1.user.userId),
            isInExperience = tbl1.isInExperience,
            openSquadVoiceAbuseReport = openSquadVoiceAbuseReport
        }
    ) else nil
    tbl4.OverflowMenu = element2

    tbl4.ActiveBorder = React.createElement("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, -8, 1, -8),
        BackgroundTransparency = 1,
        ZIndex = 4
    }, {
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var2.Radius.Medium - 4) }),
        UIStroke = React.createElement(
            "UIStroke",
            {
                Thickness = 4,
                Color = var2.Color.Extended.Green.Green_800.Color3,
                Transparency = var3
            }
        )
    })
    tbl4.DefaultBorder = React.createElement("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, -2, 1, -2),
        BackgroundTransparency = 1,
        ZIndex = 3
    }, {
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var2.Radius.Medium - 1) }),
        UIStroke = React.createElement("UIStroke", {
            Thickness = 1,
            Color = var2.Color.Stroke.Default.Color3,
            Transparency = var3:map(function(arg1)
                if arg1 < 0.9 then
                    return 1
                end

                return var2.Color.Stroke.Default.Transparency
            end)
        })
    })

    return createElement(view, tbl3, tbl4)
end
