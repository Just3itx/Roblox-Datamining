-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent

local AppLifecycleObserverService = nil
pcall(function()
    AppLifecycleObserverService = game:GetService("AppLifecycleObserverService")
end)

local React = require(ProfilePlatformParent.React)
local Cryo = require(ProfilePlatformParent.Cryo)
local SignalsReact = require(ProfilePlatformParent.SignalsReact)
local SharedFlags = require(ProfilePlatformParent.SharedFlags)
local useLocalUserId = require(ProfilePlatformParent.RobloxAppHooks).useLocalUserId

local MomentsGetMomentsUserStore = require(ProfilePlatformParent.DataHydration.MomentsGetMomentsUserStore)
local _MomentsStoreTypes = require(ProfilePlatformParent.DataHydration.MomentsStoreTypes)

local GetDeletedMomentsStore = require(ProfilePlatformParent.Moments.GetDeletedMomentsStore)

local FFlagMomentsRemoveDeletedFromProfile = SharedFlags.FFlagMomentsRemoveDeletedFromProfile
local FFlagMomentsRefreshOwnMomentsAfterPublish = SharedFlags.FFlagMomentsRefreshOwnMomentsAfterPublish
local FFlagMomentsOptimisticProfilePending = SharedFlags.FFlagMomentsOptimisticProfilePending
local FFlagMomentsRefreshProfileOnPostStatus = SharedFlags.FFlagMomentsRefreshProfileOnPostStatus

local function useUserMoments(current: string?, tbl1)
    local var1, var2 = React.useState({})
    local var3, var4 = React.useState(nil)
    local hasMore, var6 = React.useState(false)
    local hasFailed, var8 = React.useState(false)
    local isLoadingMore, var10 = React.useState(false)
    local var11 = React.useRef(nil)
    local var12 = if FFlagMomentsRefreshProfileOnPostStatus or FFlagMomentsOptimisticProfilePending then useLocalUserId() else nil
    local bool1 = not (var12 == nil) and tostring(var12) == current
    local var13 = if FFlagMomentsRefreshOwnMomentsAfterPublish
        or FFlagMomentsRefreshProfileOnPostStatus
        or FFlagMomentsOptimisticProfilePending then SignalsReact.useSignalState(MomentsGetMomentsUserStore(false).getUserMomentsVersion) else 0

    local var14 = not FFlagMomentsOptimisticProfilePending and {}
        or SignalsReact.useSignalState(MomentsGetMomentsUserStore(false).getPendingUserMoments)

    React.useEffect(function()
        local var15 = if current == nil then nil else tonumber(current)

        if var15 == nil then
            return
        end

        local var16 = MomentsGetMomentsUserStore(false)

        if (FFlagMomentsRefreshProfileOnPostStatus or FFlagMomentsOptimisticProfilePending) and var11.current ~= current then
            var11.current = current

            if bool1 then
                var16.evictUserMoments(var15)
            end
        end
        local bool2 = false

        var16.getUserMoments(var15):andThen(function(arg1)
            if not bool2 then
                var8(false)
                var2(arg1.moments)
                var4(arg1.nextCursor)
                var6(arg1.nextCursor ~= nil)
            end
        end):catch(function()
            if not bool2 then
                var8(true)
            end
        end)
        return function()
            bool2 = true
        end
    end, { current, var13, bool1 })

    if FFlagMomentsRefreshProfileOnPostStatus or FFlagMomentsOptimisticProfilePending then
        React.useEffect(function()
            if not bool1 then
                return
            end
            local var15 = tbl1 or AppLifecycleObserverService
            if var15 == nil then
                return
            end
            local connection = var15.OnUnhide:Connect(function()
                local var16 = if current == nil then nil else tonumber(current)

                if var16 ~= nil then
                    MomentsGetMomentsUserStore(false).invalidateUser(var16)
                end
            end)
            return function()
                connection:Disconnect()
            end
        end, { current, tbl1, bool1 })
    end

    local loadMore = React.useCallback(function()
        local var15 = if current == nil then nil else tonumber(current)

        if var15 == nil or var3 == nil or not hasMore or isLoadingMore then
            return
        end
        var10(true)
        MomentsGetMomentsUserStore(false).getUserMoments(var15, var3):andThen(function(arg1)
            var2(function(arg2)
                return Cryo.List.join(arg2, arg1.moments)
            end)

            var6(not (arg1.nextCursor == nil) and arg1.nextCursor ~= var3)
            var4(arg1.nextCursor)
        end):catch(function() end):finally(function()
            var10(false)
        end)
    end, {
        current,
        var3,
        hasMore,
        isLoadingMore
    })

    local var16 = nil
    local var17

    if FFlagMomentsRemoveDeletedFromProfile or FFlagMomentsOptimisticProfilePending then
        var16 = SignalsReact.useSignalState(GetDeletedMomentsStore(false).getDeletedIds)
        local var18 = var16
        var17 = React.useMemo(function()
            if #var18 == 0 then
                return var1
            end
            local result = {}
            for _, value in var1 do
                if not table.find(var18, value.momentId) then
                    table.insert(result, value)
                end
            end
            return result
        end, { var1, var18 })
    else
        var17 = var1
    end
    if FFlagMomentsOptimisticProfilePending then
        local var18 = if current == nil then nil else tonumber(current)
        local var19, var20 = React.useState({})
        local var21 = React.useMemo(function()
            local var21 = var18 == nil and {} or var14[var18] or {}

            local result = {}

            local tbl2 = ({})
            for _, value in var1 do
                tbl2[value.momentId] = true
                local feedItemId = value.recommendationMetadata.feedItemId
                if feedItemId ~= nil and feedItemId ~= "" then
                    tbl2[feedItemId] = true
                end
            end
            for _, value in var21 do
                local publishedMoment = value.publishedMoment
                if publishedMoment == nil then
                    continue
                end

                local feedItemId = publishedMoment.recommendationMetadata.feedItemId

                if tbl2[publishedMoment.momentId]
                    or feedItemId ~= nil and tbl2[feedItemId]
                    or var16 ~= nil and table.find(var16, publishedMoment.momentId) ~= nil
                then
                    result[value.moment.momentId] = true
                end
            end

            return result
        end, {
            var18,
            var1,
            var14,
            var16
        })

        React.useEffect(function()
            var20(function(arg1)
                local var22 = table.clone(arg1)
                local bool2 = false
                for value in var21 do
                    if not var22[value] then
                        var22[value] = true
                        bool2 = true
                    end
                end

                return if bool2 then var22 else arg1
            end)
        end, { var21 })

        local var22 = if var18 == nil then nil else var14[var18]

        if var22 ~= nil and #var22 > 0 then
            local tbl2 = {}
            for _, value in var22 do
                local moment = value.moment

                if not (var21[moment.momentId] or var19[moment.momentId]) then
                    table.insert(tbl2, moment)
                end
            end
            if #tbl2 > 0 then
                var17 = Cryo.List.join(tbl2, var17)
            end
        end
    end

    return {
        moments = var17,
        hasMore = hasMore,
        hasFailed = hasFailed,
        isLoadingMore = isLoadingMore,
        loadMore = loadMore
    }
end

return useUserMoments
