-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")
local SquadsParent = Squads.Parent

local FriendsMenu = require(SquadsParent.FriendsMenu)
local NotificationModalsManager = require(SquadsParent.NotificationModalsManager)
local Promise = require(SquadsParent.Promise)
local UIBlox = require(SquadsParent.UIBlox)
local useAppPolicy = require(SquadsParent.UniversalAppPolicy).useAppPolicy
local useLocalUserId = require(SquadsParent.RobloxAppHooks).useLocalUserId
local ReactFocusNavigation = require(SquadsParent.ReactFocusNavigation)
local CoreGui = ReactFocusNavigation.EngineInterface.CoreGui
local FocusNavigationContext = ReactFocusNavigation.FocusNavigationContext
local FocusNavigationService = ReactFocusNavigation.FocusNavigationService
local FocusBehaviors = require(SquadsParent.FocusBehaviors)

local dependencies = require(Squads.dependencies)
local Constants = require(Squads.Common.Constants)
local InviteToParentChannel = require(Squads.Thunks.InviteToParentChannel)
local SquadInviteSourceEnum = require(Squads.Enums.SquadInviteSourceEnum)

local Cryo = dependencies.Cryo
local React = dependencies.React
local SharedFlags = dependencies.SharedFlags
local Constants2 = require(SquadsParent.SquadsCore.Constants)

local SquadExternalContractContext = require(SquadsParent.SquadsCore.SquadExternalContractProvider).SquadExternalContractContext
local EventNames = require(SquadsParent.SquadsCore.EventNames)
local SquadPromptType = require(SquadsParent.SquadsCore.Enums).SquadPromptType
local useDispatch = dependencies.Hooks.useDispatch
local useCurrentSquadSelector = dependencies.Hooks.useCurrentSquadSelector
local useLocalization = dependencies.Hooks.useLocalization
local useStore = dependencies.Hooks.useStore
local useNavigation = dependencies.useNavigation
local useIsInviteButtonDisabled = require(Squads.Hooks.useIsInviteButtonDisabled)

local FriendsMenuFriendsList = FriendsMenu.FriendsMenuFriendsList
local FriendsMenuContextWrapper = FriendsMenu.FriendsMenuContextWrapper
local FriendsMenuSearch = FriendsMenu.FriendsMenuSearch
local FriendMenuType = FriendsMenu.FriendMenuType
local SelectedUsersScroller = FriendsMenu.SelectedUsersScroller
local SelectedUsersContext = FriendsMenu.SelectedUsersContext
local FFlagEnablePartyQuickStartButton = SharedFlags.FFlagEnablePartyQuickStartButton

local Images = UIBlox.App.ImageSet.Images
local useStyle = UIBlox.Core.Style.useStyle

local SquadInviteFriendsButton = require(script.Parent.SquadInviteFriendsButton)

local inviteToSquad = require(Squads.Thunks.inviteToSquad)

local function inviteSingleFriend() end

local tbl1 = {
    buttonText = "Add",
    onMultiInvite = function(_) end,
    participants = {},
    analyticsInfo = {},
    onRemoveCallback = function() end,
    preselectedUsers = nil,
    preselectedUsersUnremovable = false,
    onSelectedFriendsChanged = function() end,
    shouldHideFooterButton = nil
}

local function SelectedFriendsListener(tbl2)
    local var1 = React.useContext(SelectedUsersContext)
    local selectedFriendsSize = var1.selectedFriendsSize
    local selectedFriends = var1.selectedFriends

    local var2 = React.useCallback(function()
        if FFlagEnablePartyQuickStartButton and tbl2.onMultiInvite then
            tbl2.onMultiInvite(selectedFriends)
            return
        end
        tbl2.fallbackOnMultiInvite(selectedFriends)
    end, { tbl2.onMultiInvite, tbl2.fallbackOnMultiInvite, selectedFriends })

    local var3 = useIsInviteButtonDisabled(selectedFriendsSize, var1.selectedFriends or {}, var1.preselectedUsers or {})

    React.useEffect(function()
        tbl2.onSelectedFriendsChanged(not var3, var2)
    end, { var3, var2, tbl2.onSelectedFriendsChanged })

    return nil
end

local function SquadInviteFriends(arg1)
    local var1 = Cryo.Dictionary.join(tbl1, arg1)

    local var2 = React.useContext(FocusNavigationContext)
    local squadExternalContext = React.useContext(SquadExternalContractContext)

    local dispatch = useDispatch()
    local var5 = useNavigation()
    local var6 = useStore()

    local theme = useStyle().Theme
    local var7, var8 = React.useState(0)
    local var9 = React.useCallback(function(arg2)
        return arg2.getCanUsePlatformChat()
    end, {})
    local var10 = useAppPolicy(var9)

    local ref = React.useRef(nil)
    local var3 = React.useRef(nil)

    local var13 = useLocalUserId()

    local var14 = React.useCallback(function(arg2)
        var8(arg2.AbsoluteSize.Y)
    end, { var8 })

    local var15 = useCurrentSquadSelector()
    local parentChannelId = if var15 then if var15.parentChannelId then var15.parentChannelId else "" else ""

    local parentChannel = squadExternalContext.useGetConversationFromId(parentChannelId)

    local var18 = useLocalization({
        user = "Feature.Squads.Description.User",
        youAddedMoreThanTwoToChat = "Feature.Squads.Description.YouAddedMoreThanTwoToChat",
        youAddedToChat = "Feature.Squads.Description.YouAddedToChat",
        youAddedTwoToChat = "Feature.Squads.Description.YouAddedTwoToChat"
    })

    local var19 = React.useCallback(function(arg2)
        local var19 = Cryo.Dictionary.union({ parentChannelId = parentChannelId, source = SquadInviteSourceEnum.SourceSquadInvitePage }, arg2)

        squadExternalContext.fireSquadAnalytics(EventNames.SquadInvite, var19)
    end, { parentChannelId, squadExternalContext.fireSquadAnalytics })

    local var20 = React.useCallback(function(arg2)
        local var20 = Cryo.Dictionary.keys(arg2)

        local displayName = arg2[var20[1]].displayName
        local var21

        if #var20 > 2 then
            var21 = var18.youAddedMoreThanTwoToChat:gsub("{(.-)}", { username = displayName, userCountMinusOne = tostring(#var20 - 1) })
        elseif #var20 == 2 then
            local displayName2 = arg2[var20[2]].displayName
            var21 = var18.youAddedTwoToChat:gsub("{(.-)}", { username1 = displayName, username2 = displayName2 })
        else
            var21 = var18.youAddedToChat:gsub("{(.-)}", { username = displayName })
        end

        NotificationModalsManager.SetUIBloxToast({ iconImage = Images["icons/actions/friends/friendAdd"], toastTitle = var21 })
    end, { var18.youAddedMoreThanTwoToChat, var18.youAddedToChat, var18.youAddedTwoToChat })

    local fallbackOnMultiInvite = React.useCallback(function(arg2)
        if not (var15 and parentChannel) then
            return
        end

        local var21 = Cryo.Dictionary.keys(arg2)

        local var22 = Cryo.List.toSet(parentChannel.participants)

        local userIds = Cryo.List.filter(var21, function(arg3): boolean
            return var22[arg3] == nil
        end)

        local function onConfirm()
            local var24 = Cryo.List.filter(parentChannel.participants, function(arg3): boolean
                return Cryo.List.find(var21, tostring(arg3)) == nil and arg3 ~= var13
            end)

            local tbl2 = {}
            for _, value in ipairs(var24) do
                table.insert(tbl2, squadExternalContext.removeUserFromParentChannel(dispatch, parentChannel.id, value))
            end

            Promise.all(tbl2):andThen(function()
                if not (#userIds > 0) then
                    var5.pop()

                    return
                end

                dispatch(
                    InviteToParentChannel({
                        dispatch = dispatch,
                        onErrorCallback = function()
                            if #var24 > 0 then
                                var5.pop()
                            end
                        end,
                        onSuccessCallback = function(id: string)
                            local bool1 = id ~= parentChannel.id
                            dispatch(inviteToSquad(var15.squadId, id, var13, userIds, var19, bool1))

                            var20(arg2)
                            var5.pop()
                        end,
                        parentChannel = parentChannel,
                        squadExternalContext = squadExternalContext,
                        userIds = userIds
                    })
                )
            end)
        end

        if parentChannel.type ~= Constants2.CONVERSATION_CHANNEL_GROUP_TYPE or not (var10 and #userIds > 0) then
            onConfirm()

            return
        end

        squadExternalContext.setSquadPrompt(var6, {
            hideCancelButton = false,
            promptType = SquadPromptType.ConfirmInviteToSquad,
            onConfirm = function()
                onConfirm()
            end
        })
    end, {
        var15,
        dispatch,
        var5,
        parentChannel,
        var19,
        var20,
        squadExternalContext.setSquadPrompt,
        squadExternalContext.inviteToParentChannel,
        squadExternalContext.removeUserFromParentChannel,
        var6,
        var13
    })

    React.useEffect(function()
        if var2 and ref.current ~= nil and var3.current ~= nil then
            if var2 then
                local var22 = FocusBehaviors.default(var3.current)
                local current = ref.current
                var2:registerFocusBehavior(current, var22)
                return function()
                    var2:deregisterFocusBehavior(current, var22)
                end
            end
        elseif ref.current ~= nil and var3.current ~= nil then
            FocusNavigationService.new(CoreGui):registerFocusBehavior(ref.current, FocusBehaviors.default(var3.current))
        end

        return function() end
    end, { var2 })

    local createElement = React.createElement
    local var22 = FriendsMenuContextWrapper

    local tbl2 = {
        inviteSingleFriend = inviteSingleFriend,
        inviteMultiFriends = if FFlagEnablePartyQuickStartButton then var1.onMultiInvite else fallbackOnMultiInvite,
        isLoadingCustomParams = false,
        selectionLimit = Constants.SQUAD_PARTICIPANT_LIMIT - 1,
        preselectedUsers = if FFlagEnablePartyQuickStartButton then var1.preselectedUsers else parentChannel and parentChannel.participants and Cryo.List.filter(parentChannel.participants, function(arg2): boolean
            return arg2 ~= var13
        end),
        preselectedUsersUnremovable = if FFlagEnablePartyQuickStartButton then var1.preselectedUsersUnremovable elseif parentChannel then parentChannel.type == Constants2.CONVERSATION_CHANNEL_ONE_TO_ONE_TYPE or parentChannel.initiator ~= tostring(var13) else nil,
        onRemoveCallback = if FFlagEnablePartyQuickStartButton then var1.onRemoveCallback else parentChannel and function(arg2, displayName)
            if not Cryo.List.find(parentChannel.participants, arg2) then
                return
            end

            squadExternalContext.setSquadPrompt(var6, {
                bodyTextLocalizationProps = {
                    displayName = displayName or var18.user
                },
                hideCancelButton = true,
                promptType = SquadPromptType.RemoveFromParty
            })
        end or nil
    }

    local tbl3 = {
        SelectedFriendsListener = React.createElement(SelectedFriendsListener, {
            onMultiInvite = var1.onMultiInvite,
            fallbackOnMultiInvite = fallbackOnMultiInvite,
            onSelectedFriendsChanged = var1.onSelectedFriendsChanged
        }),
        ContainerFrame = 0,
        FriendsListButtonFrame = 0
    }
    local createElement2 = React.createElement
    local str1 = "Frame"
    local tbl4 = {
        Size = if var1.shouldHideFooterButton then UDim2.fromScale(1, 1) else UDim2.new(1, 0, 1, -52),
        BackgroundTransparency = 1,
        BackgroundColor3 = theme.BackgroundDefault.Color,
        BorderSizePixel = 0,
        ref = ref
    }
    local tbl5 = {
        VerticalLayout = React.createElement(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Vertical,
                Padding = UDim.new(0, 16),
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        ),
        SearchSelectFrame = React.createElement("Frame", {
            Size = UDim2.fromScale(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            LayoutOrder = 0,
            [React.Change.AbsoluteSize] = var14
        }, {
            Padding = React.createElement(
                "UIPadding",
                {
                    PaddingLeft = UDim.new(0, 24),
                    PaddingRight = UDim.new(0, 24),
                    PaddingTop = UDim.new(0, 12)
                }
            ),
            VerticalLayout = React.createElement(
                "UIListLayout",
                {
                    FillDirection = Enum.FillDirection.Vertical,
                    Padding = UDim.new(0, 16),
                    SortOrder = Enum.SortOrder.LayoutOrder
                }
            ),
            FriendsMenuSearch = React.createElement(
                FriendsMenuSearch,
                {
                    layoutOrder = 0,
                    size = UDim2.new(1, 0, 0, 36),
                    focusElement = false,
                    ref = var3
                }
            ),
            SelectedUsersScroller = React.createElement(SelectedUsersScroller, { layoutOrder = 1, selectionLimit = Constants.SQUAD_PARTICIPANT_LIMIT - 1 })
        }),
        FriendsList = React.createElement(FriendsMenuFriendsList, {
            size = UDim2.new(1, 0, 1, -var7 - 16),
            layoutOrder = 1,
            parentComponentName = Constants.SQUAD_INVITE_PARENT_COMPONENT,
            menuType = FriendMenuType.MultiSelect,
            isFullRowActivatable = true,
            backgroundTransparency = 1,
            disableSelectionParentManagement = true,
            disableListFocus = true
        })
    }
    tbl3.ContainerFrame = createElement2(str1, tbl4, tbl5)
    local element

    if var1.shouldHideFooterButton then
        element = nil
    else
        element = React.createElement("Frame", {
            AnchorPoint = Vector2.new(0, 1),
            Position = UDim2.fromScale(0, 1),
            Size = UDim2.new(1, 0, 0, 52),
            BackgroundTransparency = 1,
            BackgroundColor3 = theme.BackgroundContrast.Color,
            BorderSizePixel = 0
        }, {
            Padding = React.createElement("UIPadding", {
                PaddingRight = UDim.new(0, 12),
                PaddingLeft = UDim.new(0, 12),
                PaddingBottom = UDim.new(0, 8),
                PaddingTop = UDim.new(0, 8)
            }),
            Button = React.createElement(
                SquadInviteFriendsButton,
                {
                    buttonText = var1.buttonText,
                    analyticsInfo = var1.analyticsInfo,
                    partyStartedRef = var1.partyStartedRef
                }
            )
        })
    end

    tbl3.FriendsListButtonFrame = element
    return createElement(var22, tbl2, tbl3)
end

return SquadInviteFriends
