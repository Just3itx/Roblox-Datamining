-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local Squads = script:FindFirstAncestor("Squads")
local SquadsParent = Squads.Parent

local RoactNavigation = require(SquadsParent.RoactNavigation)
local UIBlox = require(SquadsParent.UIBlox)
local useLocalUserId = require(SquadsParent.RobloxAppHooks).useLocalUserId
local useVoiceStatus = require(SquadsParent.CrossExperienceVoice).Hooks.useVoiceStatus

local Constants = require(Squads.Common.Constants)
local dependencies = require(Squads.dependencies)
local Logger = require(Squads.Logger)
local _ModelTypes = require(Squads.Common.ModelTypes)
local SquadLobbyActionBar = require(script.Parent.SquadLobbyActionBar)
local SquadLobbyUserGrid = require(script.Parent.SquadLobbyUserGrid)
local SquadLobbyRegroupRow = require(script.Parent.SquadLobbyRegroupRow)
local SquadLobbyLuckyRecommendationRow = require(script.Parent.SquadLobbyLuckyRecommendationRow)
local SquadLobbyVoiceChatMenu = require(script.Parent.SquadLobbyVoiceChatMenu)
local SquadLobbyBanners = require(script.Parent.SquadLobbyBanners)
local SquadLobbyUserDropdownMenu = require(script.Parent.SquadLobbyUserDropdownMenu)
local SquadLobbyJoinDialogContainer = require(script.Parent.SquadLobbyJoinDialog.SquadLobbyJoinDialogContainer)
local SquadPartySheetActionEnum = require(Squads.Enums.SquadPartySheetActionEnum)
local SquadUserPartyStatus = require(Squads.Enums.SquadUserPartyStatus)

local Cryo = dependencies.Cryo
local Foundation = dependencies.Foundation
local LuauPolyfill = dependencies.LuauPolyfill
local NetworkingPresence = dependencies.NetworkingPresence
local NetworkingSquads = dependencies.NetworkingSquads
local React = dependencies.React
local Roact = dependencies.Roact
local SharedFlags = dependencies.SharedFlags
local Enums = require(SquadsParent.SquadsCore.Enums)
local EventNames = require(SquadsParent.SquadsCore.EventNames)

local SquadExternalContractContext = require(SquadsParent.SquadsCore.SquadExternalContractProvider).SquadExternalContractContext
local SquadPromptType = Enums.SquadPromptType
local SquadCoplayJoin = Enums.SquadCoplayJoin
local SquadViewFlags = require(SquadsParent.SquadsCore.SquadExternalContractProvider).SquadViewFlags
local SquadLobbySessionProvider = require(SquadsParent.SquadsCore.SquadSessionProvider).SquadLobbySessionProvider
local logInExpCoplayTelemetry = require(SquadsParent.SquadsCore.logInExpCoplayTelemetry)
local createOrJoinSquad = require(SquadsParent.SquadsCore.Thunks).createOrJoinSquad
local UserBlockingNetworking = dependencies.UserBlockingNetworking
local useCurrentSquadSelector = dependencies.Hooks.useCurrentSquadSelector
local useDispatch = dependencies.Hooks.useDispatch
local useEffectOnce = dependencies.Hooks.useEffectOnce
local useNavigation = dependencies.useNavigation
local usePrevious = dependencies.Hooks.usePrevious
local useSelector = dependencies.Hooks.useSelector
local useStore = dependencies.Hooks.useStore
local useSquadState = require(SquadsParent.SquadsCore.Hooks).useSquadState
local PresenceType = dependencies.RoduxPresence.Enums.PresenceType

local FFlagSquadsPresenceStoreMigration = require(SquadsParent.SquadsCore.Flags).FFlagSquadsPresenceStoreMigration
local FFlagSquadsEnableFoundationTestIds = require(Squads.Flags.FFlagSquadsEnableFoundationTestIds)
local DataHydration = require(SquadsParent.DataHydration)
local Signals = require(SquadsParent.Signals)
local useSignalState = require(SquadsParent.SignalsReact).useSignalState
local var1 = if FFlagSquadsPresenceStoreMigration then DataHydration.Presence.PresenceStore.get() else nil
local PresenceType2 = if FFlagSquadsPresenceStoreMigration then DataHydration.Presence.PresenceEnums.PresenceType else nil
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance
local useStyle = UIBlox.Core.Style.useStyle
local useTokens = Foundation.Hooks.useTokens

local clearInterval = LuauPolyfill.clearInterval
local setInterval = LuauPolyfill.setInterval

local bool1 = game:DefineFastFlag("EnableSquadLobbyBanners", false)
local FFlagEnableSquadTopBannerWideMode = SharedFlags.FFlagEnableSquadTopBannerWideMode
local FFlagMakeCreateOrJoinSquadAThunks = SharedFlags.FFlagMakeCreateOrJoinSquadAThunks
local num1 = game:DefineFastInt("PartyInviteeNoResponseDurationSeconds", 3)
local num2 = game:DefineFastInt("PartyUserInvitedDurationSeconds", 10)
local SquadQuickStartExperimentation = dependencies.SocialExperiments.SquadQuickStartExperimentation

local SquadCoordinationExperienceJoinExperimentation = dependencies.SocialExperiments.SquadCoordinationExperienceJoinExperimentation
local SquadRegroupExperimentation = dependencies.SocialExperiments.SquadRegroupExperimentation
local LuckyRecommendationExperimentation = dependencies.SocialExperiments.LuckyRecommendationExperimentation
local FFlagEnablePartyQuickStartButton = SharedFlags.FFlagEnablePartyQuickStartButton
local FFlagEnablePartyVoiceChangersInLua = SharedFlags.FFlagEnablePartyVoiceChangersInLua
local FFlagEnableSquadRegroupExperimentation = SharedFlags.FFlagEnableSquadRegroupExperimentation

local FFlagEnableSquadRegroupExperimentationSmallScreenFix = SharedFlags.FFlagEnableSquadRegroupExperimentationSmallScreenFix
local FFlagEnableSquadRegroupServerCapacityCheck = SharedFlags.FFlagEnableSquadRegroupServerCapacityCheck
local FFlagAppChatShowOSAOnPageEntry = SharedFlags.FFlagAppChatShowOSAOnPageEntry
local FFlagSquadMemberJoinDialogAndOverflowMenu = require(Squads.Flags.FFlagSquadMemberJoinDialogAndOverflowMenu)

local function SquadLobby(tbl1)
    local var2 = useTokens()
    local var3 = useDispatch()
    local num3 = tonumber(useLocalUserId()) or 0
    local var4 = useStyle()
    local squadState = useSquadState()
    local var6 = useNavigation()
    local isWideMode = tbl1.isWideMode
    local var7 = React.useContext(SquadExternalContractContext)
    local yOffset, var8 = React.useState(0)

    local voiceStatus = useVoiceStatus()

    if FFlagEnableSquadTopBannerWideMode then
        local var10 = React.useRef(HttpService:GenerateGUID())
        React.useEffect(function()
            if isWideMode then
                return function() end
            end

            local current = var10.current
            var7.disableSquadTopBanner(current, true)
            local var11 = var6 and var6.addListener(RoactNavigation.Events.WillBlur, function(arg1)
                if arg1.state.routeName ~= "SquadInviteFriends" and arg1.state.routeName ~= "SquadLobby" then
                    var7.disableSquadTopBanner(current, false)
                    return
                end
                var7.disableSquadTopBanner(current, true)
            end)

            return function()
                if var11 then
                    var11.remove()
                    var11 = nil
                end

                var7.disableSquadTopBanner(current, false)
            end
        end, { var7.disableSquadTopBanner, var6, isWideMode })

        React.useEffect(function()
            var7.updateSquadViewFlags(SquadViewFlags.SquadLobby, true)
            return function()
                var7.updateSquadViewFlags(SquadViewFlags.SquadLobby, false)
            end
        end, { var7.updateSquadViewFlags })
    else
        React.useEffect(function()
            var7.updateSquadViewFlags(SquadViewFlags.SquadLobby, true)
            local var10 = var6 and var6.addListener(RoactNavigation.Events.WillBlur, function(arg1)
                if arg1.state.routeName ~= "SquadInviteFriends" and arg1.state.routeName ~= "SquadLobby" then
                    var7.updateSquadViewFlags(SquadViewFlags.SquadLobby, false)
                    return
                end
                var7.updateSquadViewFlags(SquadViewFlags.SquadLobby, true)
            end)

            return function()
                if var10 then
                    var10.remove()
                    var10 = nil
                end
                var7.updateSquadViewFlags(SquadViewFlags.SquadLobby, false)
            end
        end, { var7.updateSquadViewFlags, var6 })
    end

    local var10, var11 = React.useState(false)
    local var12, var13 = React.useState(Vector2.zero)
    local var14 = React.useCallback(function(arg1)
        var13(arg1.AbsoluteSize)
    end, { var13 })

    local var15 = useCurrentSquadSelector()
    local var5 = if var15 then var15.squadId else ""
    local members = var15 and var15.members

    local var17 = React.useCallback(function(arg1)
        if arg1.Squad and arg1.Squad.Squad and arg1.Squad.Squad.currentSquad then
            return arg1.Squad.Squad.currentSquad.parentChannelId or ""
        end

        return ""
    end, {})
    local var18 = useSelector(var17)

    local var19 = useStore()
    local param = var6.getParam("conversationId") or ""
    local var20 = var7.useGetConversationFromId(param)
    local participants = var20 and var20.participants
    local invitees = var15 and var15.invitees

    local squadCreateOrJoinAttemptId = nil

    local param2 = var6.getParam("extraParams") or {}
    local squadId = param2.squadId
    if SquadQuickStartExperimentation.getPartyQuickStartChangesEnabled() and FFlagEnablePartyQuickStartButton then
        squadCreateOrJoinAttemptId = param2.squadCreateOrJoinAttemptId
    end
    local scheduledGroupUpId = param2.scheduledGroupUpId

    local var21 = React.useCallback(function()
        var7.setSquadPrompt(var19, {
            hideCancelButton = true,
            promptType = SquadPromptType.Error,
            onConfirm = function()
                tbl1.navigateAwayFromSquad()
            end
        })
    end, { tbl1.navigateAwayFromSquad, var19, var7.setSquadPrompt })

    local useCallback = React.useCallback

    local function func1(parentChannelId: string)
        if FFlagMakeCreateOrJoinSquadAThunks then
            var3(
                createOrJoinSquad(
                    parentChannelId,
                    var7.setSquadPrompt,
                    var7.fireSquadAnalytics,
                    var7.squadLocation,
                    squadCreateOrJoinAttemptId,
                    tbl1.navigateAwayFromSquad,
                    scheduledGroupUpId
                )
            )
            return
        end

        var3(
            NetworkingSquads.CreateOrJoinSquad.API({
                parentChannelId = parentChannelId,
                leaveExisting = true,
                squadLocation = var7.squadLocation,
                partyAttemptId = squadCreateOrJoinAttemptId
            })
        ):andThen(
            function(arg1)
                local groupUpId = arg1.responseBody.groupUp.groupUpId
                local members2 = arg1.responseBody.groupUp.members

                if groupUpId and members2 then
                    logInExpCoplayTelemetry(groupUpId, members2, var7.squadLocation, SquadCoplayJoin.PartyJoin, var7.fireSquadAnalytics)
                end
            end
        ):catch(
            function(_)
                var21()
            end
        )
    end

    local var22 = if FFlagMakeCreateOrJoinSquadAThunks then createOrJoinSquad else nil
    local navigateAwayFromSquad = if FFlagMakeCreateOrJoinSquadAThunks then tbl1.navigateAwayFromSquad else nil
    local var23 = if FFlagMakeCreateOrJoinSquadAThunks then nil else var21
    local setSquadPrompt = if FFlagMakeCreateOrJoinSquadAThunks then var7.setSquadPrompt else nil
    local var24 = useCallback(func1, {
        var3,
        var22,
        navigateAwayFromSquad,
        var23,
        setSquadPrompt,
        var7.squadLocation,
        var7.fireSquadAnalytics,
        squadCreateOrJoinAttemptId,
        scheduledGroupUpId
    })

    local var25 = squadId and squadId ~= var5

    React.useEffect(function()
        if not var25 then
            return
        end

        var7.setSquadPrompt(var19, {
            promptType = SquadPromptType.JoinAnotherSquad,
            onConfirm = function()
                var24(param)
            end,
            onCancel = function()
                tbl1.navigateAwayFromSquad()
            end
        })

        var6.setParams({ squadId = nil })
    end, {
        squadId,
        var7.setSquadPrompt,
        var24,
        param,
        tbl1.navigateAwayFromSquad,
        var25
    })

    useEffectOnce(function()
        if var25 then
            return
        end

        if FFlagAppChatShowOSAOnPageEntry and var7.shouldShowOSAForConversation and var7.shouldShowOSAForConversation(var20) then
            tbl1.navigateAwayFromSquad()
            return
        end

        if var5 ~= "" then
            return
        end
        if not var20 or var20.source ~= "friends" then
            var24(param)
            return
        end

        Logger:debug("Channel does not exist for: {}. Creating a friend conversation.", param)

        var3(var7.createFriendConversation(param)):andThen(function(arg1)
            if arg1 and arg1.id then
                var24(arg1.id)
            end
        end):catch(function(arg1)
            Logger:debug("Error while trying to create a friend conversation: {}", arg1)
            var21()
        end)
    end, {
        var3,
        var7.createFriendConversation,
        param,
        var20,
        var24,
        var21
    })

    local users, var27 = React.useState({})

    local var28 = React.useMemo(function()
        local result = {}
        if members then
            for _, member in ipairs(members) do
                local userId = member.userId
                result[tostring(userId)] = true
            end
        end

        return result
    end, { members })

    local var29 = React.useCallback(function(arg1, arg2, arg3)
        local tbl2 = {}
        local num4 = 0

        if arg2 and #Cryo.Dictionary.keys(arg2) == 0 then
            table.insert(tbl2, { userId = num3, partyStatus = SquadUserPartyStatus.Connecting })
        elseif arg1 then
            local now = os.time()

            for _, value in ipairs(arg1) do
                local inactive = SquadUserPartyStatus.Inactive
                local tbl3

                if arg2[value] then
                    inactive = SquadUserPartyStatus.Active

                    tbl3 = {
                        userId = tonumber(value),
                        partyStatus = inactive
                    }
                    table.insert(tbl2, tbl3)
                else
                    local where = arg3 and Cryo.List.findWhere(arg3, function(arg4): boolean
                        return value == tostring(arg4.userId)
                    end)

                    if not where then
                        tbl3 = {
                            userId = tonumber(value),
                            partyStatus = inactive
                        }
                        table.insert(tbl2, tbl3)
                    else
                        local num5 = math.floor(arg3[where].invitedAtTimestampMs / 1000) or 0

                        if not (now < num5) then
                            if now - num5 < num2 then
                                inactive = SquadUserPartyStatus.Invited
                                num4 += 1
                            elseif now - num5 < num1 + num2 then
                                inactive = SquadUserPartyStatus.NoResponse
                                num4 += 1
                            end

                            tbl3 = {
                                userId = tonumber(value),
                                partyStatus = inactive
                            }
                            table.insert(tbl2, tbl3)
                        end
                    end
                end
            end
        end
        return { users = tbl2, numberOfUpdatesPending = num4 }
    end, {})

    React.useEffect(function()
        local var30 = var29(participants, var28, invitees)
        var27(var30.users)

        local var31 = nil
        var31 = setInterval(function()
            local var32 = var29(participants, var28, invitees)
            var27(var32.users)

            if var32.numberOfUpdatesPending == 0 then
                clearInterval(var31)
            end
        end, 1000)

        return function()
            clearInterval(var31)
        end
    end, {
        var28,
        invitees,
        participants,
        var29
    })
    local var30 = usePrevious(var5) or ""
    React.useEffect(function()
        if var30 ~= "" and var5 == "" then
            tbl1.navigateAwayFromSquad()
            return
        end
        if var5 == "" or param == "" or var18 == "" or var18 == param then
            return
        end
        local actions = { RoactNavigation.Actions.navigate({ routeName = "ChatConversation", params = { conversationId = var18 } }), RoactNavigation.Actions.navigate({ routeName = "SquadLobby", params = { conversationId = var18 } }) }

        if isWideMode then
            var6.navigate(
                "ChatLanding",
                { conversationId = var18 },
                RoactNavigation.StackActions.reset({ index = 2, actions = actions })
            )
            return
        end

        table.insert(actions, 1, RoactNavigation.Actions.navigate({ routeName = "ChatLanding" }))

        var6.navigate(
            "ChatLandingStack",
            { conversationId = var18 },
            RoactNavigation.StackActions.reset({ index = 3, actions = actions })
        )
    end, {
        var6,
        var18,
        param,
        var5,
        tbl1.navigateAwayFromSquad
    })

    local var31 = usePrevious(members)
    React.useEffect(function()
        local tbl2 = {}
        if members then
            for _, member in pairs(members) do
                local bool2 = false
                if var31 then
                    for _, value in pairs(var31) do
                        if value.userId == member.userId then
                            bool2 = true
                            break
                        end
                    end
                end

                if bool2 then
                    continue
                end

                table.insert(tbl2, member.userId)
                if num3 ~= member.userId then
                    var3(UserBlockingNetworking.IsBlockedById.API({ userId = member.userId, currentUserId = num3 }))
                end
            end
        end

        if not FFlagSquadsPresenceStoreMigration then
            var3(NetworkingPresence.GetPresencesFromUserIds.API(tbl2))
        end
    end, { members, num3, var31 })

    local toggleVoiceChatMenu = React.useCallback(function()
        var11(not var10)
    end, { var10, var11 })

    local var33 = Constants.SQUAD_LOBBY_ACTION_BAR_HEIGHT + 26 + 20

    local yOffset2 = Constants.SQUAD_LOBBY_ACTION_BAR_HEIGHT + 20
    local userId, var35 = React.useState(nil)
    local var36, var37 = React.useState(false)

    local onAbsoluteSizeChanged = React.useCallback(function(vector2: Vector2)
        if vector2.Y > 0 then
            var8(vector2.Y + var2.Gap.Medium)
            return
        end
        var8(0)
    end, { var8, var2 })

    local var39 = React.useCallback(function(arg1)
        local byUserId = arg1.Squad and arg1.Squad.Presence and arg1.Squad.Presence.byUserId or {}
        local result = ({})

        for _, value in ipairs(members or {}) do
            local str1 = tostring(value.userId)
            result[str1] = byUserId[str1]
        end

        return result
    end, { members })

    local var40 = if FFlagSquadsPresenceStoreMigration then React.useMemo(function()
        return Signals.createComputed(function(arg1)
            local result = ({})
            for _, value in ipairs(members or {}) do
                local str1 = tostring(value.userId)
                result[str1] = var1.GetPresenceByUserId(str1).data(arg1)
            end
            return result
        end)
    end, { members }) else nil

    local var41 = if FFlagSquadsPresenceStoreMigration then useSignalState(var40) else useSelector(var39)
    local bool2 = not FFlagEnableSquadRegroupServerCapacityCheck or Players.MaxPlayers > 1

    local var42 = React.useMemo(function()
        if not (SquadRegroupExperimentation.getSquadRegroupEnabled()
            and tbl1.isInExperience
            and bool2
            and var15
            and var15.members
            and #var15.members > 1
            and var15.selfPermissions
            and var15.selfPermissions.canSeeRegroupJoinButton) then
            return false
        end

        local var42 = var41[tostring(num3)]
        if var42 == nil then
            return false
        end

        for k, value in pairs(var41) do
            if value == nil or k == tostring(num3) then
                continue
            end
            local userPresenceType = value.userPresenceType
            local online = if FFlagSquadsPresenceStoreMigration then PresenceType2.Online else PresenceType.Online

            if userPresenceType == online then
                return true
            end

            local userPresenceType2 = value.userPresenceType
            local inGame = if FFlagSquadsPresenceStoreMigration then PresenceType2.InGame else PresenceType.InGame

            if userPresenceType2 == inGame
                and var42.gameId ~= (if FFlagSquadsPresenceStoreMigration then "" else nil)
                and value.gameId ~= (if FFlagSquadsPresenceStoreMigration then "" else nil)
                and var42.gameId ~= value.gameId
            then
                return true
            end
        end

        return false
    end, {
        var41,
        num3,
        tbl1.isInExperience,
        var15,
        bool2
    })

    local bool3 = false
    if LuckyRecommendationExperimentation.getLuckyRecommendationEnabled() then
        local bool4 = not (members == nil) and #members >= 2
        bool3 = not tbl1.isInExperience and bool4
    end

    local yOffset3 = var2.Size.Size_1000 + var2.Padding.Medium * 2
    local var43 = FFlagEnableSquadRegroupExperimentationSmallScreenFix and var42

    local var44 = if (not var42 or var43) and not bool3 then 0 else var2.Gap.XXLarge + yOffset3

    local squadLobbyBanners = React.useMemo(function()
        if bool1 then
            return (React.createElement(SquadLobbyBanners, { onAbsoluteSizeChanged = onAbsoluteSizeChanged }))
        end
        return nil
    end, { onAbsoluteSizeChanged })

    local navigateToSquadInviteFriends = React.useCallback(function()
        tbl1.navigateToSquadInviteFriends(var18)
    end, { var18, tbl1.navigateToSquadInviteFriends })

    local useMemo = React.useMemo

    local function func2()
        local createElement = React.createElement
        local str1 = "ScrollingFrame"
        local tbl2 = {
            Position = UDim2.fromOffset(0, yOffset),
            Size = UDim2.new(1, 0, 1, -(yOffset + var44)),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            CanvasSize = UDim2.new(),
            ScrollingDirection = Enum.ScrollingDirection.Y,
            ScrollBarImageColor3 = var4.Theme.UIEmphasis.Color,
            ScrollBarImageTransparency = var4.Theme.UIEmphasis.Transparency,
            ScrollBarThickness = 4,
            Selectable = false,
            ZIndex = 0,
            [React.Change.AbsoluteSize] = var14
        }
        local tbl3 = { FrameContents = 0, SquadLobbyUserGrid = 0 }
        local element

        if var43 then
            element = React.createElement(
                Foundation.View,
                { tag = "auto-y size-full-0 bg-surface-0 col align-x-center align-y-top" },
                {
                    UserGridContainer = React.createElement(
                        Foundation.View,
                        { tag = "auto-y size-full-0 bg-surface-0", LayoutOrder = 1 },
                        {
                            SquadLobbyUserGrid = React.createElement(SquadLobbyUserGrid, {
                                containerSize = var12 - Vector2.new(0, var33 + var2.Gap.Medium + yOffset3),
                                paddingBottom = UDim.new(0, 0),
                                users = users,
                                isInExperience = tbl1.isInExperience,
                                onUserCardActivated = function(str2: string)
                                    var7.fireSquadAnalytics(
                                        EventNames.PartySheetAction,
                                        {
                                            parentChannelId = var18,
                                            actionType = SquadPartySheetActionEnum.UserCardClicked,
                                            voiceStatus = voiceStatus
                                        }
                                    )
                                    var35(str2)
                                    var37(true)
                                end,
                                navigateToHomePage = tbl1.navigateToHomePage,
                                navigateToSquadInviteFriends = navigateToSquadInviteFriends,
                                openSquadVoiceAbuseReport = tbl1.openSquadVoiceAbuseReport
                            })
                        }
                    ),
                    RegroupRowSpacer = React.createElement(
                        Foundation.View,
                        {
                            tag = "bg-surface-0",
                            Size = UDim2.new(1, 0, 0, var2.Gap.Medium),
                            LayoutOrder = 2
                        }
                    ),
                    SquadLobbyRegroupRow = React.createElement(
                        Foundation.View,
                        {
                            tag = "bg-surface-0",
                            Size = UDim2.new(1, 0, 0, yOffset3),
                            LayoutOrder = 3
                        },
                        {
                            Row = React.createElement(SquadLobbyRegroupRow, { localUserId = num3 })
                        }
                    ),
                    BottomPadding = React.createElement(Foundation.View, { tag = "bg-surface-0", Size = UDim2.new(1, 0, 0, var33), LayoutOrder = 4 })
                }
            )
        else
            element = nil
        end

        tbl3.FrameContents = element

        tbl3.SquadLobbyUserGrid = if var43 then nil else React.createElement(SquadLobbyUserGrid, {
            containerSize = var12 - Vector2.new(0, var33),
            paddingBottom = UDim.new(0, var33),
            users = users,
            isInExperience = tbl1.isInExperience,
            onUserCardActivated = function(str2: string)
                var7.fireSquadAnalytics(
                    EventNames.PartySheetAction,
                    {
                        parentChannelId = var18,
                        actionType = SquadPartySheetActionEnum.UserCardClicked,
                        voiceStatus = voiceStatus
                    }
                )
                var35(str2)
                var37(true)
            end,
            navigateToHomePage = tbl1.navigateToHomePage,
            navigateToSquadInviteFriends = navigateToSquadInviteFriends,
            openSquadVoiceAbuseReport = tbl1.openSquadVoiceAbuseReport
        })

        return createElement(str1, tbl2, tbl3)
    end

    local navigateToHomePage = tbl1.navigateToHomePage
    local var47 = if var42 then var44 elseif bool3 then var44 else nil
    local var48 = if var43 then yOffset3 else nil
    local var49 = if var43 then num3 else nil
    local squadLobbyUsersScrollingFrame = useMemo(func2, {
        var35,
        var37,
        var12,
        members,
        navigateToSquadInviteFriends,
        var14,
        navigateToHomePage,
        var33,
        yOffset,
        var47,
        users,
        var43,
        var48,
        var49,
        voiceStatus,
        tbl1.openSquadVoiceAbuseReport
    })

    local squadLobbyActionBar = React.useMemo(function()
        return React.createElement(SquadLobbyActionBar, {
            squadState = squadState,
            anchorPoint = Vector2.new(0.5, 1),
            hasUnreadMessages = if var20 and var20.hasUnreadMessages then var20.hasUnreadMessages else false,
            navigateAwayFromSquad = tbl1.navigateAwayFromSquad,
            navigateToChat = tbl1.navigateToChat,
            navigateToHomePage = tbl1.navigateToHomePage,
            toggleVoiceChatMenu = toggleVoiceChatMenu,
            position = UDim2.new(0.5, 0, 1, -20),
            squadId = var5,
            isInExperience = tbl1.isInExperience
        })
    end, {
        var5,
        tbl1.isInExperience,
        tbl1.navigateToChat,
        tbl1.navigateToHomePage,
        squadState,
        toggleVoiceChatMenu,
        var20 and var20.hasUnreadMessages
    })

    local squadLobbyRegroupRow = React.useMemo(function()
        if var43 or not var42 then
            return nil
        end

        return React.createElement(
            Foundation.View,
            {
                tag = "anchor-bottom-center auto-none gui-object-defaults",
                Position = UDim2.new(0.5, 0, 1, -(20 + Constants.SQUAD_LOBBY_ACTION_BAR_HEIGHT + var2.Gap.XXLarge)),
                Size = UDim2.new(1, 0, 0, yOffset3)
            },
            {
                Row = React.createElement(SquadLobbyRegroupRow, { localUserId = num3 })
            }
        )
    end, {
        var42,
        num3,
        var2,
        yOffset3
    })
    local squadLobbyLuckyRecommendationRow = React.useMemo(function()
        if not bool3 then
            return nil
        end

        return React.createElement(Foundation.View, {
            tag = "anchor-bottom-center auto-none gui-object-defaults",
            Position = UDim2.new(0.5, 0, 1, -(20 + Constants.SQUAD_LOBBY_ACTION_BAR_HEIGHT + var2.Gap.XXLarge)),
            Size = UDim2.new(1, 0, 0, yOffset3)
        }, {
            Row = React.createElement(SquadLobbyLuckyRecommendationRow)
        })
    end, { bool3, var2, yOffset3 })

    local squadLobbyVoiceChatMenu = React.useMemo(function()
        if not var10 then
            return nil
        end

        local createElement = React.createElement
        local view = Foundation.View

        local tbl2 = {
            Size = UDim2.new(1, 0, 1, 0),
            stateLayer = {
                affordance = StateLayerAffordance.None
            },
            onActivated = function()
                var11(false)
            end,
            testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lobby--voice-chat-menu-backdrop" else nil
        }

        local createElement2 = React.createElement
        local scrollView = Foundation.ScrollView
        local tbl3 = {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0.5, 0, 0, 0),
            AnchorPoint = Vector2.new(0.5, 0),
            sizeConstraint = {
                MaxSize = Vector2.new(350, math.huge)
            },
            scroll = {
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                CanvasSize = UDim2.new(1, 0, 1, 0),
                ScrollingDirection = Enum.ScrollingDirection.Y
            },
            layout = {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        }

        local tbl4 = {
            FlexibleSpace = React.createElement(Foundation.View, {
                Size = UDim2.new(1, 0, 0, yOffset2),
                flexItem = {
                    FlexMode = Enum.UIFlexMode.Fill
                },
                LayoutOrder = 1,
                stateLayer = {
                    affordance = StateLayerAffordance.None
                },
                onActivated = function()
                    var11(false)
                end
            }),
            Menu = 0,
            BottomPadding = 0
        }

        local createElement3 = React.createElement
        local view2 = Foundation.View
        local tbl5 = {
            Size = UDim2.new(1, 0, 1, 0),
            flexItem = {
                ItemLineAlignment = Enum.ItemLineAlignment.Center
            },
            AutomaticSize = Enum.AutomaticSize.Y,
            LayoutOrder = 2,
            padding = Vector2.new(var2.Padding.XLarge, var2.Padding.Medium),
            stateLayer = {
                affordance = StateLayerAffordance.None
            },
            onActivated = function() end,
            ZIndex = 3
        }
        local tbl6 = {
            SquadLobbyVoiceChatMenu = React.createElement(
                SquadLobbyVoiceChatMenu,
                {
                    openSquadVoiceChangers = if FFlagEnablePartyVoiceChangersInLua then tbl1.openSquadVoiceChangers else nil
                }
            )
        }
        tbl4.Menu = createElement3(view2, tbl5, tbl6)

        tbl4.BottomPadding = React.createElement(Foundation.View, {
            Size = UDim2.new(1, 0, 0, yOffset2),
            LayoutOrder = 3,
            stateLayer = {
                affordance = StateLayerAffordance.None
            },
            onActivated = function()
                var11(false)
            end
        })

        return (createElement(view, tbl2, { createElement2(scrollView, tbl3, tbl4) }))
    end, {
        yOffset2,
        var10,
        var11,
        var2
    })
    local userDropdownMenu = React.useMemo(function()
        if FFlagSquadMemberJoinDialogAndOverflowMenu then
            if var36 and userId then
                return (React.createElement(SquadLobbyJoinDialogContainer, {
                    userId = userId,
                    isInExperience = tbl1.isInExperience,
                    onClose = function()
                        var35(nil)
                        var37(false)
                    end,
                    openViewProfile = tbl1.openViewProfile
                }))
            end

            return nil
        elseif var36 and userId then
            return (React.createElement(SquadLobbyUserDropdownMenu, {
                userId = userId,
                isInExperience = tbl1.isInExperience,
                onDismiss = function()
                    var35(nil)
                    var37(false)
                end,
                openViewProfile = function()
                    tbl1.openViewProfile(userId)
                end,
                openSquadVoiceAbuseReport = tbl1.openSquadVoiceAbuseReport,
                parentChannelId = var18
            }))
        else
            return nil
        end
    end, {
        var18,
        tbl1.isInExperience,
        var36,
        var37,
        tbl1.openViewProfile,
        userId,
        var35
    })

    React.useEffect(function()
        SquadCoordinationExperienceJoinExperimentation.logExposure()
        if FFlagEnableSquadRegroupExperimentation then
            SquadRegroupExperimentation.logExposure()
        end
        LuckyRecommendationExperimentation.logExposure()
    end, {})

    local fragment = Roact.createFragment({
        SquadLobbyBanners = squadLobbyBanners,
        SquadLobbyUsersScrollingFrame = squadLobbyUsersScrollingFrame,
        SquadLobbyRegroupRow = squadLobbyRegroupRow,
        SquadLobbyLuckyRecommendationRow = squadLobbyLuckyRecommendationRow,
        SquadLobbyActionBar = squadLobbyActionBar,
        SquadLobbyVoiceChatMenu = squadLobbyVoiceChatMenu,
        UserDropdownMenu = userDropdownMenu
    })

    if SquadCoordinationExperienceJoinExperimentation.getIsSquadLobbySessionEnabled() then
        fragment = React.createElement(SquadLobbySessionProvider.Provider, nil, fragment)
    end

    return fragment
end

return SquadLobby
