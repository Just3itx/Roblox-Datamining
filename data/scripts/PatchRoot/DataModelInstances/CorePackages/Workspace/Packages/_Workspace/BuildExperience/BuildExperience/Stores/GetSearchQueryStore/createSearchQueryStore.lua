-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:01:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local num1 = game:DefineFastInt("MyStatsExperienceSearchDebounceMs", 200)

local function createSearchQueryStore(tbl1)
    local tbl2 = tbl1 or {}
    local var1 = tbl2.debounceMs or num1
    local var2 = tbl2.schedule or task.delay
    local cancel = tbl2.cancel or task.cancel

    local getDraftQuery, var4 = Signals.createSignal("")
    local getDebouncedQuery, var6 = Signals.createSignal("")
    local getIsSearchActive, setIsSearchActive = Signals.createSignal(false)

    local getShowEmptyState = Signals.createComputed(function(arg1)
        return getIsSearchActive(arg1) and getDraftQuery(arg1) == ""
    end)

    local var9 = nil

    local function cancelPending() -- Luacid: Inlined by compiler; 4 call sites recovered
        if var9 ~= nil then
            pcall(cancel, var9)
            var9 = nil
        end
    end

    local function clear() -- Luacid: Inlined by compiler; 1 call site recovered
        cancelPending()
        var4("")
        var6("")
    end

    return {
        getDraftQuery = getDraftQuery,
        useDraftQuery = function()
            return SignalsReact.useSignalState(getDraftQuery)
        end,
        getDebouncedQuery = getDebouncedQuery,
        useDebouncedQuery = function()
            return SignalsReact.useSignalState(getDebouncedQuery)
        end,
        getIsSearchActive = getIsSearchActive,
        useIsSearchActive = function()
            return SignalsReact.useSignalState(getIsSearchActive)
        end,
        getShowEmptyState = getShowEmptyState,
        useShowEmptyState = function()
            return SignalsReact.useSignalState(getShowEmptyState)
        end,
        setQuery = function(str1: string)
            var4(str1)
            cancelPending()

            if str1 == getDebouncedQuery() then
                return
            end
            local var10 = var1 / 1000
            var9 = var2(var10, function()
                var9 = nil
                var6(str1)
            end)
        end,
        setIsSearchActive = setIsSearchActive,
        beginSearch = function()
            setIsSearchActive(true)
        end,
        endSearch = function()
            clear()
            setIsSearchActive(false)
        end,
        endSearchIfEmpty = function()
            if getDraftQuery() == "" then
                setIsSearchActive(false)
            end
        end,
        clear = clear,
        destroy = function()
            cancelPending()
        end
    }
end
return createSearchQueryStore
