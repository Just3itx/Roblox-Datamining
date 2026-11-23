-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization

local Logger = require(BuildExperienceParent.Loggers).Logger

local getPrivatePlaytestersStore = require(BuildExperienceParent.DataHydration.PrivatePlaytesters).getPrivatePlaytestersStore
local FriendsStore = require(BuildExperienceParent.DataHydration.Friends).FriendsStore
local searchFriendsAsync = require(script.Parent.searchFriendsAsync)
local useUserPicker = require(BuildExperience.Components.UserPicker.useUserPicker)
local _UserPickerTypes = require(BuildExperience.Components.UserPicker.UserPickerTypes)
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)
local useBuildPageImpression = require(BuildExperience.Telemetry.useBuildPageImpression)
local FFlagBuildExperiencePageImpressions = require(BuildExperience.Flags.FFlagBuildExperiencePageImpressions)
local _PrivateInvitesPickerView = require(script.Parent.PrivateInvitesPickerView)
local FFlagBuildExperiencePlaytesterAddTelemetry = require(BuildExperience.Flags.FFlagBuildExperiencePlaytesterAddTelemetry)

local tbl1 = {
    [1] = "invalid_universe",
    [2] = "unauthorized",
    [48] = "invalid_request",
    [49] = "limit_exceeded",
    [50] = "update_failed",
    [51] = "safety_check"
}

local function getAddFailureParameters(arg1, num1: number)
    if type(arg1) ~= "table" then
        arg1 = nil
    end

    local var1 = if arg1 == nil then nil else tonumber(arg1.responseCode)
    local response = if arg1 == nil or type(arg1.response) ~= "table" then nil else arg1.response
    local var2 = if response == nil then nil else tonumber(response.statusCode)
    local tbl2 = {
        count = tostring(num1),
        reason = if var1 == nil then "unknown" else tbl1[var1] or "unknown"
    }
    if var1 ~= nil then
        tbl2.errorCode = tostring(var1)
    end
    if var2 ~= nil then
        tbl2.httpStatus = tostring(var2)
    end
    return tbl2
end

local function usePrivateInvitesPickerViewModel(tbl2)
    local universeId = tbl2.universeId

    local var1 = useLocalization({
        addPlaytester = LocalizationStrings.PRIVATE_INVITES_ADD_PLAYTESTER,
        addPlaytesters = LocalizationStrings.PRIVATE_INVITES_ADD_PLAYTESTERS,
        allFriendsAdded = LocalizationStrings.PRIVATE_INVITES_ALL_FRIENDS_ADDED,
        friendsLoadError = LocalizationStrings.PRIVATE_INVITES_FRIENDS_LOAD_ERROR,
        noFriends = LocalizationStrings.PRIVATE_INVITES_NO_FRIENDS,
        searchPlaceholder = LocalizationStrings.PRIVATE_INVITES_SEARCH_PLACEHOLDER
    })
    local addPlaytester = var1.addPlaytester
    local addPlaytesters = var1.addPlaytesters
    local allFriendsAdded = var1.allFriendsAdded
    local friendsLoadError = var1.friendsLoadError
    local noFriends = var1.noFriends
    local searchPlaceholder = var1.searchPlaceholder
    local onInvitesSent = tbl2.onInvitesSent

    local hasAddError, var3 = React.useState(false)

    local var4, var5 = React.useState({ userIds = {}, navigateOnDismiss = false })

    local var6 = React.useRef(false)
    React.useEffect(function()
        if var6.current then
            return
        end
        var6.current = true
        sendBuildExperienceEvent("PLAYTEST_PICKER_IMPRESSION", { universeId = universeId })
    end, { universeId })
    if FFlagBuildExperiencePageImpressions then
        useBuildPageImpression("invite-picker", { universeId = universeId })
    end

    local privatePlaytestersStore = getPrivatePlaytestersStore(false)
    local var7 = React.useMemo(function()
        return privatePlaytestersStore.getAndFetchInvitedPlayers(universeId)
    end, { privatePlaytestersStore, universeId })
    local var8 = SignalsReact.useSignalState(var7.players)
    local var9 = SignalsReact.useSignalState(var7.status)
    local var10 = if var9 == "Ready" then math.max(0, privatePlaytestersStore.MAX_INVITES - #var8) else 0

    local excludeUserIds = React.useMemo(function()
        local result = ({})
        for _, value in var8 do
            result[value] = true
        end
        return result
    end, { var8 })

    local var12 = React.useMemo(function()
        return FriendsStore.get()
    end, {})
    local var13 = React.useMemo(function()
        return var12.GetAllFriends()
    end, { var12 })
    local var14 = React.useMemo(function()
        return var12.GetAllFriendsStatus()
    end, { var12 })
    local var15 = SignalsReact.useSignalState(var13)
    local var16 = SignalsReact.useSignalState(var14)

    local browseIds = React.useMemo(function()
        local result = {}
        if var15 ~= nil then
            for _, friend in var15.friends do
                local var17 = tonumber(friend.id)
                if var17 ~= nil then
                    table.insert(result, var17)
                end
            end
        end
        return result
    end, { var15 })
    local browseIsLoading = var16 == "NotReady"

    local loadMoreBrowse = React.useCallback(function()
        var12.FetchMoreFriends()
    end, { var12 })

    local onSearch = React.useCallback(function(str1: string, str2: string?)
        return searchFriendsAsync(str1, str2, 20)
    end, {})

    local var20 = if FFlagBuildExperiencePlaytesterAddTelemetry then React.useRef({ searched = false, addAttempts = 0, addFailures = 0, addedCount = 0, dismissReported = false }) else nil

    local onSubmit = React.useCallback(function(tbl3, str1: string?)
        if FFlagBuildExperiencePlaytesterAddTelemetry and var20 ~= nil then
            local current = var20.current
            current.addAttempts += 1
        end
        return privatePlaytestersStore.sendInvites(universeId, tbl3, str1):andThen(function(tbl4)
            local added = tbl4.added
            if FFlagBuildExperiencePlaytesterAddTelemetry and var20 ~= nil then
                local current = var20.current
                current.addedCount += #added
            end

            local rejected = tbl4.rejected
            local var21 = sendBuildExperienceEvent
            local str2 = "PLAYTESTERS_ADDED"
            local tbl5 = { universeId = universeId }
            local tbl6 = {
                count = tostring(#added),
                rejectedCount = if FFlagBuildExperiencePlaytesterAddTelemetry then tostring(#rejected) else nil,
                requestedCount = if FFlagBuildExperiencePlaytesterAddTelemetry then tostring(#tbl3) else nil
            }
            var21(str2, tbl5, tbl6)

            if #added == 0 then
                if #rejected > 0 then
                    var5({ userIds = rejected, navigateOnDismiss = false })
                    return
                end
                onInvitesSent()
            elseif #rejected > 0 then
                var5({ userIds = rejected, navigateOnDismiss = true })
            else
                onInvitesSent()
            end
        end):catch(function(arg1)
            if FFlagBuildExperiencePlaytesterAddTelemetry and var20 ~= nil then
                local current = var20.current
                current.addFailures += 1
            end
            local var21 = sendBuildExperienceEvent
            local str2 = "PLAYTESTERS_ADD_FAILED"
            local tbl4 = { universeId = universeId }
            local addFailureParameters

            if FFlagBuildExperiencePlaytesterAddTelemetry then
                addFailureParameters = getAddFailureParameters(arg1, #tbl3)
            else
                addFailureParameters = { count = 0 }
                local num1 = #tbl3
                addFailureParameters.count = tostring(num1)
            end

            var21(str2, tbl4, addFailureParameters)

            Logger:warning("PrivateInvitesPicker: add playtesters failed for universe {}: {}", universeId, arg1)
            var3(true)
        end)
    end, { privatePlaytestersStore, universeId, onInvitesSent })

    local onDismissAddError = React.useCallback(function()
        var3(false)
    end, {})

    local onDismissRejectedInvite = React.useCallback(function()
        local navigateOnDismiss = var4.navigateOnDismiss
        var5({ userIds = {}, navigateOnDismiss = false })
        if navigateOnDismiss then
            onInvitesSent()
        end
    end, { var4, onInvitesSent })

    local var24 = React.useMemo(function()
        return {
            browseIds = browseIds,
            browseIsLoading = browseIsLoading,
            loadMoreBrowse = loadMoreBrowse,
            onSearch = onSearch,
            onSubmit = onSubmit,
            selectionLimit = var10,
            excludeUserIds = excludeUserIds
        }
    end, {
        browseIds,
        browseIsLoading,
        loadMoreBrowse,
        onSearch,
        onSubmit,
        var10,
        excludeUserIds
    })

    local var25 = useUserPicker(var24)
    local bool2 = if FFlagBuildExperiencePlaytesterAddTelemetry then string.find(var25.searchText, "%S") ~= nil else nil

    if FFlagBuildExperiencePlaytesterAddTelemetry then
        React.useEffect(function()
            if var20 ~= nil and bool2 then
                var20.current.searched = true
            end
        end, { bool2 })
    end

    local onClose = tbl2.onClose
    local selectedCount = var25.selectedCount
    local userIdsLen = FFlagBuildExperiencePlaytesterAddTelemetry and #var25.userIds or nil

    local var26 = if FFlagBuildExperiencePlaytesterAddTelemetry then React.useCallback(function()
        local current = if var20 == nil then nil else var20.current

        if current ~= nil and not current.dismissReported then
            current.dismissReported = true
            local num1 = 0
            for _, value in browseIds do
                if not excludeUserIds[value] then
                    num1 += 1
                end
            end

            local emptyState = var16 == "Failed" and "load_error"
                or browseIsLoading and "loading"
                or (if var9 == "Failed" then "invited_load_error" elseif var9 ~= "Ready" then "invited_loading" elseif #browseIds == 0 then "no_friends" elseif num1 == 0 then "all_added" else "none")

            sendBuildExperienceEvent("PLAYTEST_PICKER_DISMISSED", { universeId = universeId }, {
                friendsLoaded = tostring(#browseIds),
                availableCount = tostring(num1),
                invitedCount = tostring(#var8),
                selectedCount = tostring(selectedCount),
                emptyState = emptyState,
                searched = if current.searched then "true" else "false",
                searchActive = if bool2 then "true" else "false",
                visibleCount = tostring(userIdsLen),
                addAttempts = tostring(current.addAttempts),
                addFailures = tostring(current.addFailures),
                addedCount = tostring(current.addedCount)
            })
        end
        onClose()
    end, {
        browseIds,
        excludeUserIds,
        var16,
        browseIsLoading,
        var9,
        var8,
        selectedCount,
        bool2,
        userIdsLen,
        universeId,
        onClose
    }) else nil

    local isOpen, var28 = React.useState(true)
    local onRequestClose = React.useCallback(function()
        var28(false)
    end, {})

    local var30, var31 = React.useState(nil)

    local scrollingFrameRef = React.useCallback(function(arg1)
        var31(arg1)
    end, {})
    local loadMore = var25.loadMore
    React.useEffect(function()
        if var30 == nil then
            return
        end

        local var33 = var30
        local function maybeLoadMore() -- Luacid: Inlined by compiler; 1 call site recovered
            local var34 = var33.AbsoluteCanvasSize.Y - (var33.CanvasPosition.Y + var33.AbsoluteWindowSize.Y)
            if var33.AbsoluteCanvasSize.Y > 0 and var34 <= 240 then
                loadMore()
            end
        end
        local connection = var33:GetPropertyChangedSignal("CanvasPosition"):Connect(maybeLoadMore)
        local connection2 = var33:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(maybeLoadMore)
        local connection3 = var33:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(maybeLoadMore)
        maybeLoadMore()

        return function()
            connection:Disconnect()
            connection2:Disconnect()
            connection3:Disconnect()
        end
    end, { var30, loadMore })

    local tbl3 = {
        isOpen = isOpen,
        onClose = 0,
        onRequestClose = 0,
        scrollingFrameRef = 0,
        searchText = 0,
        setSearchText = 0,
        searchPlaceholder = 0,
        userIds = 0,
        isLoading = 0,
        emptyText = 0,
        isSelected = 0,
        canSelect = 0,
        toggleSelected = 0,
        hasSelection = 0,
        submit = 0,
        isSubmitting = 0,
        sendButtonText = 0,
        hasAddError = 0,
        onDismissAddError = 0,
        rejectedInviteUserIds = 0,
        onDismissRejectedInvite = 0,
        testId = 0
    }

    if not FFlagBuildExperiencePlaytesterAddTelemetry or var26 == nil then
        var26 = tbl2.onClose
    end

    tbl3.onClose = var26
    tbl3.onRequestClose = onRequestClose
    tbl3.scrollingFrameRef = scrollingFrameRef
    tbl3.searchText = var25.searchText
    tbl3.setSearchText = var25.setSearchText
    tbl3.searchPlaceholder = searchPlaceholder
    tbl3.userIds = var25.userIds
    tbl3.isLoading = var25.isLoading

    if var16 == "Failed" then
        noFriends = friendsLoadError
    elseif #browseIds > 0 then
        noFriends = allFriendsAdded
    end

    tbl3.emptyText = noFriends

    tbl3.isSelected = var25.isSelected
    tbl3.canSelect = var25.canSelect
    tbl3.toggleSelected = var25.toggleSelected
    tbl3.hasSelection = var25.hasSelection
    tbl3.submit = var25.submit
    tbl3.isSubmitting = var25.isSubmitting

    if var25.selectedCount > 1 then
        addPlaytester = addPlaytesters
    end

    tbl3.sendButtonText = addPlaytester

    tbl3.hasAddError = hasAddError
    tbl3.onDismissAddError = onDismissAddError

    tbl3.rejectedInviteUserIds = var4.userIds
    tbl3.onDismissRejectedInvite = onDismissRejectedInvite
    tbl3.testId = tbl2.testId
    return tbl3
end

return usePrivateInvitesPickerViewModel
