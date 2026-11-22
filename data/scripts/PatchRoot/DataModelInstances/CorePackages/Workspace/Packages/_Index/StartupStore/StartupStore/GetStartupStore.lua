-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StartupStoreParent = script:FindFirstAncestor("StartupStore").Parent

local Signals = require(StartupStoreParent.Signals)
local SignalsExperimental = require(StartupStoreParent.SignalsExperimental)

local RetrievalStatus = require(StartupStoreParent.Http).Enum.RetrievalStatus

local function isRetrievalStatus(arg1): boolean -- Luacid: unused: defined but never referenced
    return arg1 == RetrievalStatus.NotStarted
        or arg1 == RetrievalStatus.Fetching
        or arg1 == RetrievalStatus.Failed
        or arg1 == RetrievalStatus.Done
end

local function joinRetrievalStatus(str1: string?, str2: string?)
    if str1 ~= RetrievalStatus.NotStarted
        and str1 ~= RetrievalStatus.Fetching
        and str1 ~= RetrievalStatus.Failed
        and str1 ~= RetrievalStatus.Done
    then
        str1 = nil
    end

    if str2 ~= RetrievalStatus.NotStarted
        and str2 ~= RetrievalStatus.Fetching
        and str2 ~= RetrievalStatus.Failed
        and str2 ~= RetrievalStatus.Done
    then
        str2 = nil
    end

    if str1 == nil then
        return str2
    end

    if str2 == nil then
        return str1
    end

    if str1 == RetrievalStatus.Failed or str2 == RetrievalStatus.Failed then
        return RetrievalStatus.Failed
    end

    if str1 == RetrievalStatus.NotStarted and str2 == RetrievalStatus.NotStarted then
        return RetrievalStatus.NotStarted
    end

    if str1 == RetrievalStatus.Done and str2 == RetrievalStatus.Done then
        return RetrievalStatus.Done
    end

    return RetrievalStatus.Fetching
end

local function defaultGamesPageDataStatus() -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        status = RetrievalStatus.NotStarted,
        isRefreshFetch = false
    }
end

return Signals.createComputed(function()
    local getPreloading, setPreloading = Signals.createSignal(true)

    local getHomePageDataStatus, setHomePageDataStatus = Signals.createSignal(RetrievalStatus.NotStarted)

    local getGamesPageDataStatus, var6 = Signals.createSignal((defaultGamesPageDataStatus()))

    local getFetchHomePageDataStatusAll, setFetchHomePageDataStatusAll = Signals.createSignal(RetrievalStatus.NotStarted)

    return {
        getPreloading = getPreloading,
        getHomePageDataStatus = getHomePageDataStatus,
        getGamesPageDataStatus = getGamesPageDataStatus,
        getFetchHomePageDataStatusAll = getFetchHomePageDataStatusAll,
        getAppLoadingStarted = Signals.createComputed(function(arg1): boolean
            local status = getGamesPageDataStatus(arg1).status
            local var9 = getHomePageDataStatus(arg1)
            local var10 = getFetchHomePageDataStatusAll(arg1)

            return joinRetrievalStatus(joinRetrievalStatus(status, var9), var10) ~= RetrievalStatus.NotStarted
        end),
        setPreloading = setPreloading,
        setHomePageDataStatus = setHomePageDataStatus,
        setGamesPageDataStatus = function(status: string, isRefreshFetch: boolean?)
            var6({ status = status, isRefreshFetch = isRefreshFetch or false })
        end,
        setFetchHomePageDataStatusAll = setFetchHomePageDataStatusAll,
        reset = function()
            SignalsExperimental.batch(function()
                setPreloading(true)
                setHomePageDataStatus(RetrievalStatus.NotStarted)
                var6((defaultGamesPageDataStatus()))
                setFetchHomePageDataStatusAll(RetrievalStatus.NotStarted)
            end)
        end
    }
end)
