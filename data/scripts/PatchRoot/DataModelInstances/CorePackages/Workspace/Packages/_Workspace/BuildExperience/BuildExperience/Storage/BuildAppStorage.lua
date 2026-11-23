-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:51:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")

local AppStorageService = game:GetService("AppStorageService")
local HttpService = game:GetService("HttpService")

local FFlagBuildAdUpsell = require(BuildExperience.Flags.FFlagBuildAdUpsell)
local FFlagBuildAdUpsellPinned = require(BuildExperience.Flags.FFlagBuildAdUpsellPinned)
local FFlagBuildAgentAdCampaignCard = require(BuildExperience.Flags.FFlagBuildAgentAdCampaignCard)
local createAdCampaignCardStorage = require(script.Parent.createAdCampaignCardStorage)

local function sanitizeCount(arg1): number -- Luacid: Inlined by compiler; 7 call sites recovered
    if type(arg1) == "number" and arg1 >= 0 then
        return math.floor(arg1)
    end

    return 0
end

local function sanitizeDisplayCount(arg1): number -- Luacid: Inlined by compiler; 6 call sites recovered
    return sanitizeCount(arg1)
end

local function getUtcDate(str1: string) -- Luacid: Inlined by compiler; 6 call sites recovered
    return string.match(str1, "^(%d%d%d%d%-%d%d%-%d%d)")
end

local function isSameUtcDate(str1: string?, str2: string): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return not (str1 == nil) and getUtcDate(str1) == getUtcDate(str2)
end

local function makeEmptyAdUpsellScheduler()
    return {
        version = if FFlagBuildAdUpsellPinned then 4 else 3,
        nextOrder = 1,
        universes = {},
        anchors = {},
        pendingMilestones = {},
        recentEventIds = {}
    }
end

local function pruneUniverseCap(tbl1)
    local num1 = 0
    local var1 = nil
    local huge = math.huge
    for value, value2 in tbl1.universes do
        num1 += 1

        if value2.lastTouchedOrder < huge or value2.lastTouchedOrder == huge and (var1 == nil or value < var1) then
            huge = value2.lastTouchedOrder
            var1 = value
        end
    end
    if not (num1 > 50) or var1 == nil then
        return
    end

    tbl1.universes[var1] = nil
    local var2 = tonumber(var1)
    if var2 == nil then
        return
    end

    for i = #tbl1.anchors, 1, -1 do
        if tbl1.anchors[i].universeId == var2 then
            table.remove(tbl1.anchors, i)
        end
    end
    for i = #tbl1.pendingMilestones, 1, -1 do
        if tbl1.pendingMilestones[i].universeId == var2 then
            table.remove(tbl1.pendingMilestones, i)
        end
    end
end

local function sanitizeAdUpsellScheduler(scheduler)
    if type(scheduler) ~= "table" then
        return (makeEmptyAdUpsellScheduler())
    end

    if scheduler.version ~= 4 and scheduler.version ~= 3 then
        return (makeEmptyAdUpsellScheduler())
    end

    local emptyAdUpsellScheduler = makeEmptyAdUpsellScheduler()
    local num1 = 0
    local num2 = 0
    if type(scheduler.universes) == "table" then
        for value, value2 in scheduler.universes do
            if type(value) ~= "string" or type(value2) ~= "table" then
                continue
            end

            local lastTouchedOrder = sanitizeDisplayCount(value2.lastTouchedOrder)
            num1 = math.max(num1, lastTouchedOrder)
            local universes = emptyAdUpsellScheduler.universes
            local tbl1 = {
                hasShownUpsell = value2.hasShownUpsell == true,
                dismissedPermanently = value2.dismissedPermanently == true,
                lastTouchedOrder = lastTouchedOrder
            }
            universes[value] = tbl1

            num2 += 1
        end
    end

    if type(scheduler.anchors) == "table" then
        for _, anchor in scheduler.anchors do
            if type(anchor) ~= "table"
                or type(anchor.id) ~= "string"
                or type(anchor.universeId) ~= "number"
                or type(anchor.sessionId) ~= "string"
                or type(anchor.order) ~= "number"
            then
                continue
            end
            local order = math.max(1, math.floor(anchor.order))
            num1 = math.max(num1, order)
            table.insert(emptyAdUpsellScheduler.anchors, {
                id = anchor.id,
                universeId = anchor.universeId,
                sessionId = anchor.sessionId,
                afterMessageKey = if type(anchor.afterMessageKey) == "string" then anchor.afterMessageKey else nil,
                order = order,
                impressed = anchor.impressed == true
            })
        end
    end

    if type(scheduler.pendingMilestones) == "table" then
        for _, value in scheduler.pendingMilestones do
            if type(value) ~= "table"
                or type(value.id) ~= "string"
                or type(value.universeId) ~= "number"
                or value.sessionId ~= nil and type(value.sessionId) ~= "string"
                or type(value.order) ~= "number"
            then
                continue
            end
            local order = math.max(1, math.floor(value.order))
            num1 = math.max(num1, order)
            table.insert(
                emptyAdUpsellScheduler.pendingMilestones,
                {
                    id = value.id,
                    universeId = value.universeId,
                    sessionId = value.sessionId,
                    order = order
                }
            )
        end
    end
    if type(scheduler.recentEventIds) == "table" then
        for _, recentEventId in scheduler.recentEventIds do
            if type(recentEventId) == "string" then
                table.insert(emptyAdUpsellScheduler.recentEventIds, recentEventId)
            end
        end
    end
    for _ = 51, num2 do
        pruneUniverseCap(emptyAdUpsellScheduler)
    end

    table.sort(emptyAdUpsellScheduler.anchors, function(arg1, arg2): boolean
        return arg1.order < arg2.order
    end)
    local tbl1 = ({})
    for i = #emptyAdUpsellScheduler.anchors, 1, -1 do
        local anchor = emptyAdUpsellScheduler.anchors[i]
        local str1 = `{anchor.universeId}:{anchor.sessionId}`
        local var1 = tbl1[str1] or 0
        if var1 >= 10 then
            table.remove(emptyAdUpsellScheduler.anchors, i)
        else
            tbl1[str1] = var1 + 1
        end
    end
    table.sort(emptyAdUpsellScheduler.pendingMilestones, function(arg1, arg2): boolean
        return arg1.order < arg2.order
    end)
    while #emptyAdUpsellScheduler.anchors > 50 do
        table.remove(emptyAdUpsellScheduler.anchors, 1)
    end
    while #emptyAdUpsellScheduler.pendingMilestones > 50 do
        table.remove(emptyAdUpsellScheduler.pendingMilestones, 1)
    end
    while #emptyAdUpsellScheduler.recentEventIds > 50 do
        table.remove(emptyAdUpsellScheduler.recentEventIds, 1)
    end
    emptyAdUpsellScheduler.nextOrder = math.max(sanitizeDisplayCount(scheduler.nextOrder), num1 + 1, 1)
    return emptyAdUpsellScheduler
end

local function createBuildAppStorage(arg1, arg2)
    local var1 = nil
    local bool1 = false
    local num1 = 0
    local var2 = nil
    local bool2 = false
    local bool3 = false
    local num2 = 0
    local var3 = nil
    local bool4 = false
    local adCampaignCardStorage = nil

    local function tryReadData()
        local success, result = pcall(arg1.GetItem, arg1, "BuildAppStorageKey")
        if not success then
            return false, {}
        elseif type(result) ~= "string" or result == "" then
            return true, {}
        else
            local success2, result2 = pcall(arg2.JSONDecode, arg2, result)
            if not success2 or type(result2) ~= "table" then
                return true, {}
            end

            return true, result2
        end
    end
    local function tryReadDataStrict()
        local success, result = pcall(arg1.GetItem, arg1, "BuildAppStorageKey")
        if not success then
            return false, {}
        elseif type(result) ~= "string" or result == "" then
            return true, {}
        else
            local success2, result2 = pcall(arg2.JSONDecode, arg2, result)
            if not success2 or type(result2) ~= "table" then
                return false, {}
            end
            return true, result2
        end
    end
    local function readData() -- Luacid: Inlined by compiler; 7 call sites recovered
        local _, tbl1 = tryReadData()
        return tbl1
    end

    local function tryReadDataWithRetry(func1: (...any) -> (...any)) -- Luacid: Inlined by compiler; 8 call sites recovered
        local var4, var5 = func1()
        if var4 then
            return true, var5
        end
        return func1()
    end

    local function writeData(tbl1): boolean -- Luacid: Inlined by compiler; 9 call sites recovered
        local success, result = pcall(arg2.JSONEncode, arg2, tbl1)
        if not success or type(result) ~= "string" then
            return false
        end

        return (pcall(function()
            arg1:SetItem("BuildAppStorageKey", result)
            arg1:Flush()
        end))
    end
    local function updateData(callback: (...any) -> (...any)) -- Luacid: Inlined by compiler; 4 call sites recovered
        local var4, var5 = tryReadDataWithRetry(tryReadData)
        if not var4 then
            return false
        end
        callback(var5)
        return writeData(var5)
    end

    local function getAdCampaignCardStorage()
        if adCampaignCardStorage == nil then
            adCampaignCardStorage = createAdCampaignCardStorage({
                readData = function()
                    return tryReadDataWithRetry(tryReadDataStrict)
                end,
                writeData = writeData
            })
        end
        return adCampaignCardStorage
    end
    local function getChatDraft(str1: string)
        local chatDrafts = readData().chatDrafts
        if type(chatDrafts) ~= "table" then
            return nil
        end
        local chatDraft = chatDrafts[str1]
        return if type(chatDraft) == "string" and chatDraft ~= "" then chatDraft else nil
    end

    local function setChatDraft(str1: string, str2: string): boolean
        return updateData(function(arg3)
            local chatDrafts = type(arg3.chatDrafts) ~= "table" and {} or table.clone(arg3.chatDrafts)
            local str3 = str1
            chatDrafts[str3] = if str2 == "" then nil else str2
            arg3.chatDrafts = chatDrafts
        end)
    end

    local function getUnpublishedPlaytestModeTooltipDisplayCount(): number
        return math.max(sanitizeDisplayCount(readData().unpublishedPlaytestModeTooltipDisplayCount), num1)
    end

    local function incrementUnpublishedPlaytestModeTooltipDisplayCount()
        if FFlagBuildAdUpsell then
            local num3 = num1 + 1
            num1 = num3
            return updateData(function(arg3)
                local unpublishedPlaytestModeTooltipDisplayCount = math.max(sanitizeDisplayCount(arg3.unpublishedPlaytestModeTooltipDisplayCount) + 1, num3)
                num1 = unpublishedPlaytestModeTooltipDisplayCount
                arg3.unpublishedPlaytestModeTooltipDisplayCount = unpublishedPlaytestModeTooltipDisplayCount
            end)
        end

        local tbl1 = readData()
        local unpublishedPlaytestModeTooltipDisplayCount = math.max(sanitizeDisplayCount(tbl1.unpublishedPlaytestModeTooltipDisplayCount), num1) + 1
        num1 = unpublishedPlaytestModeTooltipDisplayCount
        tbl1.unpublishedPlaytestModeTooltipDisplayCount = unpublishedPlaytestModeTooltipDisplayCount
        return writeData(tbl1)
    end

    local function wasPushNotificationsUpsellShownToday(arg3): boolean
        local var4 = (arg3 or DateTime.now()):ToIsoDate()

        if isSameUtcDate(var1, var4) then
            return true
        end

        local pushNotificationsUpsell = readData().pushNotificationsUpsell
        return type(pushNotificationsUpsell) == "table" and isSameUtcDate(pushNotificationsUpsell.lastShownAt, var4)
    end

    local function markPushNotificationsUpsellShown(arg3)
        local lastShownAt = (arg3 or DateTime.now()):ToIsoDate()
        var1 = lastShownAt

        if FFlagBuildAdUpsell then
            return updateData(function(arg4)
                local pushNotificationsUpsell = arg4.pushNotificationsUpsell

                local var4 = type(pushNotificationsUpsell) ~= "table" and {} or table.clone(pushNotificationsUpsell)

                var4.lastShownAt = lastShownAt
                arg4.pushNotificationsUpsell = var4
            end)
        end

        local tbl1 = readData()
        local pushNotificationsUpsell = tbl1.pushNotificationsUpsell

        local var4 = type(pushNotificationsUpsell) ~= "table" and {} or table.clone(pushNotificationsUpsell)

        var4.lastShownAt = lastShownAt
        tbl1.pushNotificationsUpsell = var4
        return writeData(tbl1)
    end

    local function loadAdUpsell()
        if var2 ~= nil then
            return true, var2
        end
        if bool2 then
            return false, nil
        end

        local var4, var5 = tryReadDataWithRetry(tryReadDataStrict)
        if not var4 then
            bool2 = true
            return false, nil
        end
        local adUpsell = var5.adUpsell

        local var6 = type(adUpsell) ~= "table" and {} or table.clone(adUpsell)

        var6.dismissedPermanently = var6.dismissedPermanently == true
        var6.scheduler = if var6.dismissedPermanently then makeEmptyAdUpsellScheduler() else sanitizeAdUpsellScheduler(var6.scheduler)

        var2 = var6
        return true, var6
    end

    local function retryAdUpsellRead(): boolean
        bool2 = false
        return (loadAdUpsell())
    end

    local function persistCachedAdUpsell(bool5: boolean?)
        if var2 == nil then
            return false
        end

        local var4, var5 = tryReadDataWithRetry(if bool5 then tryReadData else tryReadDataStrict)

        if not var4 then
            return false
        end
        local adUpsell = var5.adUpsell
        local var6 = type(adUpsell) ~= "table" and {} or table.clone(adUpsell)
        local var7 = var2
        var6.dismissedPermanently = var7.dismissedPermanently
        var6.scheduler = var7.scheduler
        var5.adUpsell = var6
        return writeData(var5)
    end

    local function scheduleAdUpsellWriteRetry(bool5: boolean?)
        if var3 ~= nil or num2 >= 3 then
            return
        end
        local function retryWrite()
            var3 = nil
            if not bool3 or num2 >= 3 then
                return
            end
            num2 += 1
            if persistCachedAdUpsell(bool4) then
                bool3 = false
                num2 = 0
                bool4 = false
                return
            end
            scheduleAdUpsellWriteRetry(true)
        end

        var3 = if bool5 then task.delay(1, retryWrite) else task.defer(retryWrite)
    end

    local function persistAdUpsellMutation(bool5: boolean?, bool6: boolean?)
        num2 = 0
        if bool6 then
            bool3 = true
            bool4 = bool4 or bool5 == true
            scheduleAdUpsellWriteRetry()
            return true
        end

        num2 += 1
        local bool7 = persistCachedAdUpsell(bool5)
        bool3 = not bool7
        if bool3 then
            bool4 = bool4 or bool5 == true
            scheduleAdUpsellWriteRetry()
            return bool7
        end
        num2 = 0
        bool4 = false
        if var3 ~= nil then
            task.cancel(var3)
            var3 = nil
        end

        return bool7
    end

    local function getAdUpsellScheduler() -- Luacid: unused: defined but never referenced
        local bool5, var4 = loadAdUpsell()
        if not bool5 or var4 == nil then
            return false, nil, nil
        end
        return true, var4, var4.scheduler
    end

    local function getOrCreateUniverseState(tbl1, universeId: number) -- Luacid: Inlined by compiler; 2 call sites recovered
        local str1 = tostring(universeId)
        local tbl2 = tbl1.universes[str1]
        if tbl2 == nil then
            tbl2 = { hasShownUpsell = false, dismissedPermanently = false, lastTouchedOrder = 0 }

            tbl1.universes[str1] = tbl2
        end
        return tbl2
    end

    local function hasRecentEvent(tbl1, eventId: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
        return table.find(tbl1.recentEventIds, eventId) ~= nil
    end

    local function rememberEvent(tbl1, eventId: string)
        table.insert(tbl1.recentEventIds, eventId)
        while #tbl1.recentEventIds > 50 do
            table.remove(tbl1.recentEventIds, 1)
        end
    end

    local function pruneAnchorCaps(tbl1, universeId: number, sessionId: string)
        local num3 = 0
        for _, anchor in tbl1.anchors do
            if anchor.universeId == universeId and anchor.sessionId == sessionId then
                num3 += 1
            end
        end
        while num3 > 10 do
            for k, anchor in tbl1.anchors do
                if anchor.universeId == universeId and anchor.sessionId == sessionId then
                    table.remove(tbl1.anchors, k)
                    num3 -= 1
                    break
                end
            end
        end

        while #tbl1.anchors > 50 do
            table.remove(tbl1.anchors, 1)
        end
    end

    local function addMilestone(tbl1, id: string, universeId: number, sessionId: string?, afterMessageKey: string?, order: number)
        if sessionId == nil or not FFlagBuildAdUpsellPinned and afterMessageKey == nil then
            table.insert(tbl1.pendingMilestones, { id = id, universeId = universeId, sessionId = sessionId, order = order })

            while #tbl1.pendingMilestones > 50 do
                table.remove(tbl1.pendingMilestones, 1)
            end

            return
        end

        local anchors = tbl1.anchors
        local tbl2 = {
            id = id,
            universeId = universeId,
            sessionId = sessionId,
            afterMessageKey = 0,
            order = 0,
            impressed = false
        }

        if FFlagBuildAdUpsellPinned then
            afterMessageKey = nil
        end

        tbl2.afterMessageKey = afterMessageKey
        tbl2.order = order
        table.insert(anchors, tbl2)

        pruneAnchorCaps(tbl1, universeId, sessionId)
    end
    local function recordAdUpsellEvent(tbl1)
        local bool5, var4 = loadAdUpsell()
        local scheduler, bool6

        if bool5 and var4 ~= nil then
            scheduler = var4.scheduler
            bool6 = true
        else
            bool6 = false
            var4 = nil
            scheduler = nil
        end

        if not bool6 or var4 == nil or scheduler == nil then
            return false, false
        end
        local var5 = scheduler.universes[tostring(tbl1.universeId)]

        if var4.dismissedPermanently == true or var5 ~= nil and var5.dismissedPermanently then
            return true, false
        end

        if not tbl1.isEligiblePublish then
            return true, false
        end

        if var5 ~= nil and var5.hasShownUpsell or hasRecentEvent(scheduler, tbl1.eventId) then
            return not bool3 or persistAdUpsellMutation(), false
        end

        rememberEvent(scheduler, tbl1.eventId)
        local orCreateUniverseState = getOrCreateUniverseState(scheduler, tbl1.universeId)
        local nextOrder = scheduler.nextOrder
        scheduler.nextOrder += 1
        orCreateUniverseState.lastTouchedOrder = nextOrder
        orCreateUniverseState.hasShownUpsell = true
        pruneUniverseCap(scheduler)
        addMilestone(scheduler, tbl1.eventId, tbl1.universeId, tbl1.sessionId, tbl1.afterMessageKey, nextOrder)
        return persistAdUpsellMutation(), true
    end

    local function recordAdUpsellCompletedTurn(tbl1): (boolean, boolean)
        return recordAdUpsellEvent(tbl1)
    end

    local function recordAdUpsellPublish(tbl1): (boolean, boolean)
        return recordAdUpsellEvent(tbl1)
    end

    local function attachPendingAdUpsellMilestones(universeId: number, sessionId: string, afterMessageKey: string?)
        local bool5, var4 = loadAdUpsell()
        local scheduler, bool6

        if bool5 and var4 ~= nil then
            scheduler = var4.scheduler
            bool6 = true
        else
            bool6 = false
            var4 = nil
            scheduler = nil
        end

        if not bool6 or var4 == nil or scheduler == nil then
            return false
        end
        if var4.dismissedPermanently == true then
            return true
        end

        local pendingMilestones = {}
        local bool7 = false
        for _, value in scheduler.pendingMilestones do
            if value.universeId == universeId
                and (value.sessionId == nil or value.sessionId == sessionId)
                and (FFlagBuildAdUpsellPinned or afterMessageKey ~= nil)
            then
                table.insert(scheduler.anchors, {
                    id = value.id,
                    universeId = universeId,
                    sessionId = sessionId,
                    afterMessageKey = if FFlagBuildAdUpsellPinned then nil else afterMessageKey,
                    order = value.order,
                    impressed = false
                })
                bool7 = true
            else
                table.insert(pendingMilestones, value)
            end
        end
        if not bool7 then
            return true
        end
        scheduler.pendingMilestones = pendingMilestones
        table.sort(scheduler.anchors, function(arg3, arg4): boolean
            return arg3.order < arg4.order
        end)
        pruneAnchorCaps(scheduler, universeId, sessionId)
        return (persistAdUpsellMutation())
    end

    local function pruneAdUpsellAnchors(universeId: number, sessionId: string, tbl1)
        if FFlagBuildAdUpsellPinned then
            return true, false
        end

        local bool5, var4 = loadAdUpsell()
        local scheduler, bool6

        if bool5 and var4 ~= nil then
            scheduler = var4.scheduler
            bool6 = true
        else
            bool6 = false
            scheduler = nil
        end

        if not bool6 or scheduler == nil then
            return false, false
        end
        local anchors = {}
        local bool7 = false
        for _, anchor in scheduler.anchors do
            if anchor.universeId == universeId
                and anchor.sessionId == sessionId
                and (anchor.afterMessageKey == nil or not tbl1[anchor.afterMessageKey])
            then
                bool7 = true
            else
                table.insert(anchors, anchor)
            end
        end
        if not bool7 then
            return true, false
        end
        scheduler.anchors = anchors
        return persistAdUpsellMutation(), true
    end

    local function getAdUpsellState(universeId: number, sessionId: string?)
        local bool5, var4 = loadAdUpsell()
        local scheduler, bool6

        if bool5 and var4 ~= nil then
            scheduler = var4.scheduler
            bool6 = true
        else
            bool6 = false
            var4 = nil
            scheduler = nil
        end

        if not bool6 or var4 == nil or scheduler == nil then
            return {
                isAvailable = false,
                dismissedPermanently = true,
                hasShownUpsell = false,
                anchors = {},
                pendingMilestoneCount = 0
            }
        end

        local var5 = scheduler.universes[tostring(universeId)]
        local anchors = {}
        if sessionId ~= nil then
            for _, anchor in scheduler.anchors do
                if anchor.universeId == universeId and anchor.sessionId == sessionId then
                    table.insert(anchors, table.clone(anchor))
                end
            end
        end
        local num3 = 0
        for _, value in scheduler.pendingMilestones do
            if value.universeId == universeId and (sessionId == nil or value.sessionId == nil or value.sessionId == sessionId) then
                num3 += 1
            end
        end
        return {
            isAvailable = true,
            dismissedPermanently = var4.dismissedPermanently == true or not (var5 == nil) and var5.dismissedPermanently,
            hasShownUpsell = not (var5 == nil) and var5.hasShownUpsell,
            anchors = anchors,
            pendingMilestoneCount = num3
        }
    end

    local function markAdUpsellAnchorImpressed(universeId: number, sessionId: string, id: string)
        local bool5, var4 = loadAdUpsell()
        local scheduler, bool6

        if bool5 and var4 ~= nil then
            scheduler = var4.scheduler
            bool6 = true
        else
            bool6 = false
            var4 = nil
            scheduler = nil
        end

        if not bool6 or var4 == nil or scheduler == nil or var4.dismissedPermanently == true then
            return false
        end
        for _, anchor in scheduler.anchors do
            if anchor.universeId ~= universeId or anchor.sessionId ~= sessionId or anchor.id ~= id then
                continue
            end

            if anchor.impressed then
                return false
            end
            anchor.impressed = true
            num2 = 0

            bool3 = true
            bool4 = bool4 or false
            scheduleAdUpsellWriteRetry()

            return true
        end

        return false
    end

    local function markAdUpsellDismissedPermanently(universeId: number): boolean
        local bool5, var4 = loadAdUpsell()
        if bool5 and var4 ~= nil and var4.dismissedPermanently == true then
            return true
        end

        local bool6

        if bool5 and var4 ~= nil then
            bool6 = false
        else
            local _, var5 = tryReadDataWithRetry(tryReadData)
            local var6 = type(var5.adUpsell) ~= "table" and {} or table.clone(var5.adUpsell)
            var6.dismissedPermanently = var6.dismissedPermanently == true
            var6.scheduler = sanitizeAdUpsellScheduler(var6.scheduler)
            var2 = var6
            bool2 = false
            bool6 = true
        end

        local scheduler = var2.scheduler
        local orCreateUniverseState = getOrCreateUniverseState(scheduler, universeId)
        orCreateUniverseState.hasShownUpsell = false
        orCreateUniverseState.dismissedPermanently = true

        local anchors = {}
        for _, anchor in scheduler.anchors do
            if anchor.universeId ~= universeId then
                table.insert(anchors, anchor)
            end
        end
        scheduler.anchors = anchors
        local pendingMilestones = {}
        for _, value in scheduler.pendingMilestones do
            if value.universeId ~= universeId then
                table.insert(pendingMilestones, value)
            end
        end
        scheduler.pendingMilestones = pendingMilestones
        num2 = 0

        num2 += 1
        bool3 = not persistCachedAdUpsell(bool6)
        if bool3 then
            bool4 = bool4 or bool6 == true
            scheduleAdUpsellWriteRetry()
        else
            num2 = 0
            bool4 = false
            if var3 ~= nil then
                task.cancel(var3)
                var3 = nil
            end
        end

        return not bool3
    end

    local function isPushNotificationsUpsellDismissedPermanently(): boolean
        if bool1 then
            return true
        end

        local pushNotificationsUpsell = readData().pushNotificationsUpsell
        return type(pushNotificationsUpsell) == "table" and pushNotificationsUpsell.dismissedPermanently == true
    end

    local function markPushNotificationsUpsellDismissedPermanently()
        bool1 = true

        if FFlagBuildAdUpsell then
            return updateData(function(arg3)
                local pushNotificationsUpsell = arg3.pushNotificationsUpsell

                local var4 = type(pushNotificationsUpsell) ~= "table" and {} or table.clone(pushNotificationsUpsell)

                var4.dismissedPermanently = true
                arg3.pushNotificationsUpsell = var4
            end)
        end

        local tbl1 = readData()
        local pushNotificationsUpsell = tbl1.pushNotificationsUpsell

        local var4 = type(pushNotificationsUpsell) ~= "table" and {} or table.clone(pushNotificationsUpsell)

        var4.dismissedPermanently = true
        tbl1.pushNotificationsUpsell = var4
        return writeData(tbl1)
    end

    local function clearSessionCacheForTests()
        if FFlagBuildAgentAdCampaignCard and adCampaignCardStorage ~= nil then
            adCampaignCardStorage.reset()
        end

        var1 = nil
        bool1 = false
        num1 = 0
        var2 = nil
        bool2 = false
        bool3 = false
        num2 = 0
        if var3 ~= nil then
            task.cancel(var3)
        end
        var3 = nil
        bool4 = false
    end

    local tbl1 = {
        getAdCampaignCardStorage = 0,
        STORAGE_KEY = "BuildAppStorageKey",
        AD_UPSELL_SCHEDULER_VERSION = 4,
        getChatDraft = 0,
        setChatDraft = 0,
        getUnpublishedPlaytestModeTooltipDisplayCount = 0,
        incrementUnpublishedPlaytestModeTooltipDisplayCount = 0,
        wasPushNotificationsUpsellShownToday = 0,
        markPushNotificationsUpsellShown = 0,
        retryAdUpsellRead = 0,
        getAdUpsellState = 0,
        recordAdUpsellCompletedTurn = 0,
        recordAdUpsellPublish = 0,
        attachPendingAdUpsellMilestones = 0,
        pruneAdUpsellAnchors = 0,
        markAdUpsellAnchorImpressed = 0,
        markAdUpsellDismissedPermanently = 0,
        isPushNotificationsUpsellDismissedPermanently = 0,
        markPushNotificationsUpsellDismissedPermanently = 0,
        clearSessionCacheForTests = 0
    }

    if not FFlagBuildAgentAdCampaignCard then
        getAdCampaignCardStorage = nil
    end

    tbl1.getAdCampaignCardStorage = getAdCampaignCardStorage

    tbl1.getChatDraft = getChatDraft
    tbl1.setChatDraft = setChatDraft
    tbl1.getUnpublishedPlaytestModeTooltipDisplayCount = getUnpublishedPlaytestModeTooltipDisplayCount
    tbl1.incrementUnpublishedPlaytestModeTooltipDisplayCount = incrementUnpublishedPlaytestModeTooltipDisplayCount
    tbl1.wasPushNotificationsUpsellShownToday = wasPushNotificationsUpsellShownToday
    tbl1.markPushNotificationsUpsellShown = markPushNotificationsUpsellShown
    tbl1.retryAdUpsellRead = retryAdUpsellRead
    tbl1.getAdUpsellState = getAdUpsellState
    tbl1.recordAdUpsellCompletedTurn = recordAdUpsellCompletedTurn
    tbl1.recordAdUpsellPublish = recordAdUpsellPublish
    tbl1.attachPendingAdUpsellMilestones = attachPendingAdUpsellMilestones
    tbl1.pruneAdUpsellAnchors = pruneAdUpsellAnchors
    tbl1.markAdUpsellAnchorImpressed = markAdUpsellAnchorImpressed
    tbl1.markAdUpsellDismissedPermanently = markAdUpsellDismissedPermanently
    tbl1.isPushNotificationsUpsellDismissedPermanently = isPushNotificationsUpsellDismissedPermanently
    tbl1.markPushNotificationsUpsellDismissedPermanently = markPushNotificationsUpsellDismissedPermanently
    tbl1.clearSessionCacheForTests = clearSessionCacheForTests
    return tbl1
end

local buildAppStorage = createBuildAppStorage(AppStorageService, HttpService)

return {
    getAdCampaignCardStorage = if FFlagBuildAgentAdCampaignCard then buildAppStorage.getAdCampaignCardStorage else nil,
    STORAGE_KEY = "BuildAppStorageKey",
    AD_UPSELL_SCHEDULER_VERSION = 4,
    getChatDraft = buildAppStorage.getChatDraft,
    setChatDraft = buildAppStorage.setChatDraft,
    getUnpublishedPlaytestModeTooltipDisplayCount = buildAppStorage.getUnpublishedPlaytestModeTooltipDisplayCount,
    incrementUnpublishedPlaytestModeTooltipDisplayCount = buildAppStorage.incrementUnpublishedPlaytestModeTooltipDisplayCount,
    wasPushNotificationsUpsellShownToday = buildAppStorage.wasPushNotificationsUpsellShownToday,
    markPushNotificationsUpsellShown = buildAppStorage.markPushNotificationsUpsellShown,
    retryAdUpsellRead = buildAppStorage.retryAdUpsellRead,
    getAdUpsellState = buildAppStorage.getAdUpsellState,
    recordAdUpsellCompletedTurn = buildAppStorage.recordAdUpsellCompletedTurn,
    recordAdUpsellPublish = buildAppStorage.recordAdUpsellPublish,
    attachPendingAdUpsellMilestones = buildAppStorage.attachPendingAdUpsellMilestones,
    pruneAdUpsellAnchors = buildAppStorage.pruneAdUpsellAnchors,
    markAdUpsellAnchorImpressed = buildAppStorage.markAdUpsellAnchorImpressed,
    markAdUpsellDismissedPermanently = buildAppStorage.markAdUpsellDismissedPermanently,
    isPushNotificationsUpsellDismissedPermanently = buildAppStorage.isPushNotificationsUpsellDismissedPermanently,
    markPushNotificationsUpsellDismissedPermanently = buildAppStorage.markPushNotificationsUpsellDismissedPermanently,
    clearSessionCacheForTests = buildAppStorage.clearSessionCacheForTests,
    createForTests = createBuildAppStorage
}
