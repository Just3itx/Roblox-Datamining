-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:41:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent

local Signals = require(AvatarExperienceCommonParent.Signals)
local Promise = require(AvatarExperienceCommonParent.Promise)
local createSignal = Signals.createSignal
local createComputed = Signals.createComputed
local createHttpStore = require(AvatarExperienceCommonParent.InternalHttpStore).createHttpStore

local mutedError = require(AvatarExperienceCommonParent.Loggers).mutedError
local Url = require(AvatarExperienceCommonParent.Http).Url

local getTimeoutEndTime = require(AvatarExperienceCommon.Utils.getTimeoutEndTime)

local FFlagAXTimeoutAcknowledgementGating = require(AvatarExperienceCommonParent.AvatarExperienceFlags).FFlagAXTimeoutAcknowledgementGating

local function isAcknowledged(str1: string?): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not (str1 == nil or str1 == "") and string.sub(str1, 1, 5) ~= "0001-"
end

local function getRequiresAcknowledgement(tbl1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local bool1

    if tbl1 == nil or tbl1.acknowledgeable ~= true then
        bool1 = false
    else
        bool1 = not isAcknowledged(tbl1.acknowledgedTime)
    end

    return bool1
end

local function getEndDateTime(tbl1)
    local timeoutEndTime = getTimeoutEndTime(
        if tbl1.details then tbl1.details.endDate else nil,
        if tbl1.timeoutAction then tbl1.timeoutAction.endTime else nil
    )

    if not timeoutEndTime then
        return nil
    end

    local success, result = pcall(function(): DateTime
        return DateTime.fromIsoDate(timeoutEndTime)
    end)

    return if success then result else nil
end

local function createTimeoutStatusStore()
    local getStatus, var2 = createSignal({ isTimedOut = false, featureName = nil, access = nil, timeoutAction = nil, details = nil, error = nil })

    local bool1 = false
    local bool2 = false
    local httpStore = createHttpStore()
    local effect = nil
    local effect2 = nil

    local tbl1 = {}
    local num1 = 0

    local function extractTimeoutAction(tbl2, featureName: string)
        if not tbl2.features then
            return nil
        end
        for _, value in tbl2.features do
            if value.featureName ~= featureName or not (value.v2Recourses and #value.v2Recourses > 0) then
                continue
            end

            local var3 = value.v2Recourses[1]
            if not (var3 and #var3 > 0) then
                continue
            end

            local var4 = var3[1]
            if var4.timeoutActions and #var4.timeoutActions > 0 then
                return var4.timeoutActions[1]
            end
        end

        return nil
    end

    local var3 = nil
    local var4 = nil

    local effectDispose = Signals.createEffect(function(arg1)
        local var5 = getStatus(arg1)
        local isoDate = if var5.details and var5.details.endDate then var5.details.endDate elseif var5.timeoutAction and var5.timeoutAction.endTime then var5.timeoutAction.endTime else nil

        if not isoDate or isoDate == "" then
            return
        end

        local success, result = pcall(function(): DateTime
            return DateTime.fromIsoDate(isoDate)
        end)

        if not (success and result) then
            return
        end

        local dateTime = DateTime.now()
        local var6 = result.UnixTimestamp - dateTime.UnixTimestamp

        if FFlagAXTimeoutAcknowledgementGating and var5.requiresAcknowledgement then
            local var7 = result.UnixTimestampMillis - dateTime.UnixTimestampMillis
            if not (var7 <= 0) then
                local var8 = task.delay(var7 / 1000 + 1, function()
                    var4(var5.featureName)
                end)

                return function()
                    task.cancel(var8)
                end
            end

            return
        end

        if var6 <= 0 then
            var3()
            return
        end

        local var7 = task.delay(var6, function()
            var3()
        end)

        return function()
            if var7 then
                task.cancel(var7)
            end
        end
    end)

    local function fetchTimeoutDetails(featureVector: string, callback: (...any) -> (...any))
        if bool2 then
            callback()
            return
        end

        bool2 = true

        local url = string.format("%sv1/not-approved?abuseVector=%s", Url.USER_MODERATION_URL, featureVector)

        local var5, _ = httpStore.fetch("TimeoutDetails_" .. featureVector, { Url = url, Method = "GET" })

        if effect2 then
            effect2()
        end

        local function complete() -- Luacid: Inlined by compiler; 3 call sites recovered
            bool2 = false
            callback()
        end

        effect2 = Signals.createEffect(function(arg1)
            local var6 = var5(arg1)
            if var6.status ~= "Success" then
                if var6.status == "Failed" then
                    mutedError("Failed to fetch timeout details")
                    local var7 = getStatus(arg1)
                    var2({
                        isTimedOut = var7.isTimedOut,
                        featureName = var7.featureName,
                        access = var7.access,
                        timeoutAction = var7.timeoutAction,
                        details = nil,
                        error = "Failed to fetch timeout details",
                        requiresAcknowledgement = if FFlagAXTimeoutAcknowledgementGating then var7.requiresAcknowledgement else nil
                    })
                    complete()
                end

                return
            end

            local body = var6.response.Body
            local success, result = pcall(function()
                return HttpService:JSONDecode(body)
            end)

            if success and result then
                local var7 = getStatus(arg1)

                var2({
                    isTimedOut = var7.isTimedOut,
                    featureName = var7.featureName,
                    access = var7.access,
                    timeoutAction = var7.timeoutAction,
                    details = result,
                    error = nil,
                    requiresAcknowledgement = if FFlagAXTimeoutAcknowledgementGating then var7.requiresAcknowledgement else nil
                })
                complete()
                return
            end

            mutedError("Failed to decode timeout details JSON response")
            local var7 = getStatus(arg1)
            var2({
                isTimedOut = var7.isTimedOut,
                featureName = var7.featureName,
                access = var7.access,
                timeoutAction = var7.timeoutAction,
                details = nil,
                error = "Failed to decode timeout details",
                requiresAcknowledgement = if FFlagAXTimeoutAcknowledgementGating then var7.requiresAcknowledgement else nil
            })
            complete()
        end)
    end

    local function resolvePendingFetches()
        local var5 = getStatus(false)
        for _, value in tbl1 do
            value(var5)
        end
        tbl1 = {}
    end

    local function doFetchStatus(str1: string?, nameSpace: string?, bool3: boolean?, callback: ((...any) -> (...any))?)
        if bool1 and not (FFlagAXTimeoutAcknowledgementGating and bool3) then
            return
        end

        bool1 = true

        local featureName = str1 or "AvatarChange"
        local url = string.format(
            "%saccess-management/v1/feature-access?%s",
            Url.APIS_URL,
            Url:makeQueryString({ featureNames = featureName, nameSpace = nameSpace or "avatar_marketplace/AvatarMarketPlace" })
        )
        local str3 = "TimeoutStatus_" .. featureName
        if FFlagAXTimeoutAcknowledgementGating and bool3 then
            num1 += 1
            str3 ..= "_" .. tostring(num1)

            if effect2 then
                effect2()
                effect2 = nil
            end
            bool2 = false
        end

        local var5, _ = httpStore.fetch(str3, { Url = url, Method = "GET" })

        if effect then
            effect()
        end

        local function complete() -- Luacid: Inlined by compiler; 5 call sites recovered
            resolvePendingFetches()
        end

        local function settle(bool4: boolean) -- Luacid: Inlined by compiler; 3 call sites recovered
            if callback then
                callback(bool4)
            end
        end

        local function keepStatusWithError(error: string)
            local var6 = getStatus(false)
            var2({
                isTimedOut = var6.isTimedOut,
                featureName = var6.featureName or featureName,
                access = var6.access,
                timeoutAction = var6.timeoutAction,
                details = var6.details,
                error = error,
                requiresAcknowledgement = var6.requiresAcknowledgement
            })
        end

        effect = Signals.createEffect(function(arg1)
            local var6 = var5(arg1)
            if var6.status ~= "Success" then
                if var6.status == "Failed" then
                    mutedError("Failed to fetch timeout status")
                    if FFlagAXTimeoutAcknowledgementGating then
                        keepStatusWithError("Failed to fetch timeout status")
                        bool1 = false
                        complete()
                        settle(false)
                        return
                    end
                    var2({
                        isTimedOut = false,
                        featureName = featureName,
                        access = nil,
                        timeoutAction = nil,
                        details = nil,
                        error = "Failed to fetch timeout status"
                    })

                    bool1 = false
                    complete()
                    return
                end

                return
            end

            local body = var6.response.Body
            local success, result = pcall(function()
                return HttpService:JSONDecode(body)
            end)

            if not (success and result) then
                mutedError("Failed to decode timeout status JSON response")
                if FFlagAXTimeoutAcknowledgementGating then
                    keepStatusWithError("Failed to decode timeout status")
                    bool1 = false
                    complete()
                    settle(false)
                    return
                end
                var2({
                    isTimedOut = false,
                    featureName = featureName,
                    access = nil,
                    timeoutAction = nil,
                    details = nil,
                    error = "Failed to decode timeout status"
                })

                bool1 = false
                complete()
                return
            end

            local timeoutAction = extractTimeoutAction(result, featureName)
            local isTimedOut = timeoutAction ~= nil

            local access = nil
            if result.features then
                for _, value in result.features do
                    if value.featureName == featureName then
                        access = value.access
                        break
                    end
                end
            end

            var2({
                isTimedOut = isTimedOut,
                featureName = featureName,
                access = access,
                timeoutAction = timeoutAction,
                details = nil,
                error = nil,
                requiresAcknowledgement = if FFlagAXTimeoutAcknowledgementGating then getRequiresAcknowledgement(timeoutAction) else nil
            })

            bool1 = false
            if FFlagAXTimeoutAcknowledgementGating then
                settle(true)
            end

            if isTimedOut and timeoutAction then
                local featureVector = timeoutAction.featureVector or "avatar_change"
                fetchTimeoutDetails(featureVector, complete)
                return
            end

            complete()
        end)
    end

    local function fetchStatusAsync(str1: string?, nameSpace: string?)
        return Promise.new(function(arg1)
            table.insert(tbl1, arg1)
            doFetchStatus(str1, nameSpace)
        end)
    end

    var4 = function(str1: string?, nameSpace: string?)
        local num2 = 3
        local function attempt() -- Luacid: Inlined by compiler; 1 call site recovered
            doFetchStatus(str1, nameSpace, true, function(arg1)
                if not arg1 and num2 > 0 then
                    num2 -= 1

                    task.defer(attempt)
                end
            end)
        end

        attempt()
    end

    local getIsTimedOut = createComputed(function(arg1)
        return getStatus(arg1).isTimedOut
    end)

    local getTimeoutDetails = createComputed(function(arg1)
        return getStatus(arg1).details
    end)

    var3 = function()
        if effect2 then
            effect2()
            effect2 = nil
        end
        if effect then
            effect()
            effect = nil
        end
        bool2 = false
        bool1 = false

        var2({ isTimedOut = false, featureName = nil, access = nil, timeoutAction = nil, details = nil, error = nil })

        resolvePendingFetches()
    end

    return {
        getStatus = getStatus,
        getIsTimedOut = getIsTimedOut,
        getTimeoutDetails = getTimeoutDetails,
        fetchStatus = function(str1: string?, nameSpace: string?)
            doFetchStatus(str1, nameSpace)
        end,
        fetchStatusAsync = fetchStatusAsync,
        refreshStatus = var4,
        setStatus = function(tbl2) -- name: setStatusAction
            var2(tbl2)
        end,
        clearStatus = var3,
        clearStatusIfServed = function(): boolean
            local var5 = getStatus(false)
            local endDateTime = getEndDateTime(var5)

            if not var5.isTimedOut or not endDateTime or endDateTime.UnixTimestampMillis > DateTime.now().UnixTimestampMillis then
                return false
            end

            var3()
            return true
        end,
        effectDispose = effectDispose
    }
end

return createTimeoutStatusStore
