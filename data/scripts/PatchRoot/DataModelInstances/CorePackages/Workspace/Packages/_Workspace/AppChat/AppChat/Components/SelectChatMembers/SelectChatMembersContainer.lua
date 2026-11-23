-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:31:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _types = require(AppChat.types)
local Constants = require(AppChat.Constants)
local _ConversationChannels = require(AppChat.Models.ConversationChannels)

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local Signals = require(AppChatParent.Signals)
local View = require(AppChatParent.Foundation).View
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization
local useNavigation = require(AppChatParent.Navigation).useNavigation

local useAppChatIsWideMode = require(AppChat.Hooks.useAppChatIsWideMode)
local useIsInExperience = require(AppChat.Hooks.useIsInExperience)

local isUserInConversation = require(script.Parent.Utils.isUserInConversation)
local searchFilterPredicate = require(script.Parent.Utils.searchFilterPredicate)
local sortComparator = require(script.Parent.Utils.sortComparator)

local useFetchPaginatedFriendIds = require(script.Parent.useFetchPaginatedFriendIds)
local SelectChatMembers = require(script.Parent.SelectChatMembers)

local GetFFlagIsSquadEnabled = require(AppChatParent.SharedFlags).GetFFlagIsSquadEnabled
local FFlagFixPaginatedChatMembersCutoff = require(AppChat.Flags.FFlagFixPaginatedChatMembersCutoff)

local GetSelectedUsersStore = require(AppChat.Stores.GetSelectedUsersStore)

local tbl1 = {
    minSelections = 1,
    maxSelections = Constants.MIN_PARTICIPANT_COUNT,
    maxConversationSize = Constants.MAX_PARTICIPANT_COUNT,
    canOnlyCreateOneToOneChat = false,
    filterPredicate = searchFilterPredicate,
    sortComparator = sortComparator,
    conversation = {
        participants = {}
    },
    navigateToToast = function(_) end,
    selectedUsersChanged = function(_, _) end,
    isDebugEnabled = false
}

function SelectChatMembersContainer(tbl2)
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)
    local selectedUsersStore = GetSelectedUsersStore(false)
    local var2 = if FFlagFixPaginatedChatMembersCutoff then useNavigation().getScreenProps("topBarHeight", 0) else nil

    React.useEffect(function()
        selectedUsersStore.setMaxSize(var1.maxSelections)
        return function()
            selectedUsersStore.clearStore()
        end
    end, { var1.maxSelections })

    React.useEffect(function()
        local effect = Signals.createEffect(function(arg1)
            local var3 = selectedUsersStore.getSelectedUserIdsArray()(arg1)

            local var4 = Cryo.List.map(var3, function(id)
                return { id = id }
            end)

            var1.selectedUsersChanged(var4, var1.minSelections)
        end)
        return function()
            effect()
        end
    end, { var1.minSelections })

    local var3 = useLocalization({
        systemButtonText = var1.systemButtonText,
        pageHeaderText = var1.pageHeaderText,
        searchFriendsText = "Feature.Chat.Label.SearchFriends",
        networkErrorText = "Feature.Chat.Response.NetworkError",
        tooManyFriendsText = {
            if GetFFlagIsSquadEnabled() then "Feature.Chat.Message.AddFriendsPartyLimit" else "Feature.Chat.Message.AddFriendsLimit",
            friendNum = Constants.MAX_PARTICIPANT_COUNT,
            connectionsNum = Constants.MAX_PARTICIPANT_COUNT
        },
        tooManyFriendsTextSingular = if GetFFlagIsSquadEnabled() then "Feature.Chat.Message.AddFriendsPartyLimitSingular" else "Feature.Chat.Message.GroupFriendLimitSingular"
    })

    local var4 = React.useCallback(function()
        local toastTitle = if var1.canOnlyCreateOneToOneChat then var3.tooManyFriendsTextSingular else var3.tooManyFriendsText
        var1.navigateToToast({ toastProps = { toastContent = { toastTitle = toastTitle } } })
    end, { var1.canOnlyCreateOneToOneChat, var1.navigateToToast, var3 })
    React.useEffect(function()
        local var5 = selectedUsersStore.onMaxSizeExceeded(var4)
        return function()
            var5()
        end
    end, { var4 })

    local var5, var6, var7 = useFetchPaginatedFriendIds()

    local friendIds = React.useMemo(function()
        return Cryo.List.filter(var5, function(arg1): boolean
            return not isUserInConversation(arg1, var1.conversation)
        end)
    end, { var5, var1.conversation })

    local fetchMoreFriends = React.useCallback(function()
        if var6 and not var7 then
            var6()
        end
    end, { var6, var7 })

    local shouldShowSelectChatMembersBar = not var1.canOnlyCreateOneToOneChat
    local var10 = useIsInExperience()
    local bool2 = not useAppChatIsWideMode(var10)
    return React.createElement(
        View,
        {
            Size = UDim2.new(1, 0, 1, if bool2 then 0 else -(if FFlagFixPaginatedChatMembersCutoff then var2 else 56))
        },
        {
            SelectMembers = React.createElement(SelectChatMembers, {
                friendIds = friendIds,
                fetchMoreFriends = fetchMoreFriends,
                searchFriendsText = var3.searchFriendsText,
                shouldShowSelectChatMembersBar = shouldShowSelectChatMembersBar,
                conversation = var1.conversation,
                isDebugEnabled = var1.isDebugEnabled
            })
        }
    )
end
return React.memo(SelectChatMembersContainer)
