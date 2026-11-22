-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:31:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NotificationsOrchestrator = script:FindFirstAncestor("NotificationsOrchestrator")
local NotificationsOrchestratorParent = NotificationsOrchestrator.Parent

local _Signals = require(NotificationsOrchestratorParent.Signals)
local createSessionScopedSignal = require(NotificationsOrchestratorParent.SignalsUtils).createSessionScopedSignal
local LocalUserIdStore = require(NotificationsOrchestratorParent.LocalUserIdStore).LocalUserIdStore

local OrchestratorDebugLogger = require(NotificationsOrchestrator.Internal.OrchestratorDebugLogger)
local ExposureTracker = require(NotificationsOrchestrator.Internal.ExposureTracker)

local FFlagEnableNotificationsOrchestratorUnifiedLogging = require(NotificationsOrchestrator.Flags.FFlagEnableNotificationsOrchestratorUnifiedLogging)
local evaluate = require(NotificationsOrchestrator.Internal.evaluate)
local SlotGroupBySlotId = require(NotificationsOrchestrator.Config.SlotGroupBySlotId)
local SlotConfigBySlotId = require(NotificationsOrchestrator.Config.SlotConfigBySlotId)
local getSlotConfig = SlotConfigBySlotId.getSlotConfig
local SlotConfigBySlotId2 = SlotConfigBySlotId.SlotConfigBySlotId
local getSlotGroupConfig = require(NotificationsOrchestrator.Config.SlotGroupConfigByGroupId).getSlotGroupConfig
local _Types = require(NotificationsOrchestrator.Types)

local RunService = game:GetService("RunService")

local function sendReportLog(tbl1) -- Luacid: Inlined by compiler; 10 call sites recovered
    pcall(function()
        require(NotificationsOrchestrator.Analytics.sendNotificationReportUnifiedEvent).send(tbl1)
    end)
end

local function reportLogFromEntry(active, eventType: string, reason: string?, actionId: string?) -- Luacid: Inlined by compiler; 7 call sites recovered
    return {
        slot = active.slotId,
        eventType = eventType,
        reason = reason,
        actionId = actionId,
        handle = active.handle,
        lifecycleKey = active.lifecycleKey,
        source = active.source,
        itemId = active.itemId,
        itemType = active.itemType
    }
end

local function createNotificationsStore()
    local tbl1 = ({})
    local tbl2 = ({})
    local tbl3 = ({})
    local num1 = 0
    local num2 = 0
    local currentUserId = LocalUserIdStore.getCurrentUserId(false)

    local bool1 = false

    local function resetQueuesIfSessionChanged() -- Luacid: Inlined by compiler; 4 call sites recovered
        local currentUserId2 = LocalUserIdStore.getCurrentUserId(false)
        if currentUserId2 == currentUserId then
            return
        end
        currentUserId = currentUserId2
        table.clear(tbl2)
        table.clear(tbl3)
    end

    local function slotSignals(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
        local var1 = tbl1[arg1]
        if var1 ~= nil then
            return var1
        end
        local getActive, setActive = createSessionScopedSignal(nil)
        local tbl4 = { getActive = getActive, setActive = setActive }

        tbl1[arg1] = tbl4
        return tbl4
    end

    local function slotGroup(slotId) -- Luacid: Inlined by compiler; 3 call sites recovered
        return SlotGroupBySlotId[slotId]
    end

    local function queueKeyForSlot(slotId): string -- Luacid: Inlined by compiler; 1 call site recovered
        local var1 = slotGroup(slotId)

        if var1 ~= nil then
            return `group:{var1}`
        end
        return `slot:{slotId}`
    end

    local function getQueue(queueKey: string) -- Luacid: Inlined by compiler; 1 call site recovered
        local var1 = tbl3[queueKey]
        if var1 ~= nil then
            return var1
        end
        local tbl4 = {
            active = nil,
            waiting = {}
        }
        tbl3[queueKey] = tbl4
        return tbl4
    end

    local function publish(active)
        local payload = active.payload
        if payload == nil then
            slotSignals(active.slotId).setActive(nil)
            return
        end
        slotSignals(active.slotId).setActive({ handle = active.handle, payload = payload })
    end

    local function removeFromWaiting(waiting, tbl4)
        for value, value2 in waiting do
            if value2 == tbl4 then
                table.remove(waiting, value)
                return
            end
        end
    end

    local function requestFrequency(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
        local lifecyclePolicy = arg1.lifecyclePolicy
        return if lifecyclePolicy == nil then nil else lifecyclePolicy.frequency
    end

    local function resolveFrequency(arg1)
        local var1 = requestFrequency(arg1)

        if var1 ~= nil then
            return var1
        end

        local var2 = SlotConfigBySlotId2[arg1.slotId]
        if var2 ~= nil then
            local lifecycle = var2.lifecycle
            local frequency = if lifecycle == nil then nil else lifecycle.frequency

            if frequency ~= nil then
                return frequency
            end
        end

        local var3 = slotGroup(arg1.slotId)
        if var3 ~= nil then
            return getSlotGroupConfig(var3).frequency
        end

        if var2 ~= nil then
            return nil
        end

        local lifecycle = getSlotConfig(arg1.slotId).lifecycle
        return if lifecycle == nil then nil else lifecycle.frequency
    end

    local function resolveWindow(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
        local window = if arg1 == nil then nil else arg1.window
        return if window == nil then "forever" else window
    end

    local function isEligible(lifecycleKey, arg1, arg2) -- Luacid: Inlined by compiler; 3 call sites recovered
        return evaluate(arg1, arg2, function()
            return ExposureTracker.getExposure(lifecycleKey, arg2)
        end, ExposureTracker.now())
    end

    local function describeWindow(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
        if typeof(arg1) == "table" then
            return `rolling:{arg1.seconds}s`
        end
        return arg1
    end

    local function takeHighestPriority(waiting)
        local var1 = nil
        for i = #waiting, 1, -1 do
            local var2 = waiting[i]
            if bool1 and var2.suppressWhileInExperienceShopOpen then
                tbl2[var2.handle] = nil
                table.remove(waiting, i)
                if FFlagEnableNotificationsOrchestratorUnifiedLogging then
                    local tbl4 = reportLogFromEntry(var2, "suppressed", nil, nil)
                    sendReportLog(tbl4)
                end
            elseif not isEligible(var2.lifecycleKey, var2.frequency, var2.window) then
                OrchestratorDebugLogger.logLazy(function(): string
                    local frequency = var2.frequency
                    local maxImpressions = if frequency == nil then nil else frequency.maxImpressions
                    local cooldownSeconds = if frequency == nil then nil else frequency.cooldownSeconds
                    local count = ExposureTracker.getCount(var2.lifecycleKey, var2.window)
                    return `drop ineligible: handle={var2.handle} slotId={var2.slotId} lifecycleKey={var2.lifecycleKey} count={count} maxImpressions={maxImpressions} cooldownSeconds={cooldownSeconds} window={describeWindow(var2.window)}`
                end)

                tbl2[var2.handle] = nil
                table.remove(waiting, i)
                if FFlagEnableNotificationsOrchestratorUnifiedLogging then
                    local tbl4 = reportLogFromEntry(var2, "promoteDropped", "frequency", nil)
                    sendReportLog(tbl4)
                end
            elseif var1 == nil
                or var2.priority > var1.priority
                or var2.priority == var1.priority and var2.submissionOrder < var1.submissionOrder
            then
                var1 = var2
            end
        end

        if var1 == nil then
            return nil
        end
        removeFromWaiting(waiting, var1)
        return var1
    end

    local function removeEntry(active)
        tbl2[active.handle] = nil
        local var1 = tbl3[active.queueKey]
        if var1 == nil then
            OrchestratorDebugLogger.logLazy(function(): string
                return `remove: handle={active.handle} slotId={active.slotId} lifecycleKey={active.lifecycleKey} queue=missing`
            end)

            return
        end

        if var1.active ~= active then
            removeFromWaiting(var1.waiting, active)
            OrchestratorDebugLogger.logLazy(function(): string
                return `remove waiting: handle={active.handle} slotId={active.slotId} lifecycleKey={active.lifecycleKey}`
            end)

            return
        end

        var1.active = nil
        slotSignals(active.slotId).setActive(nil)
        local var2 = takeHighestPriority(var1.waiting)
        if var2 == nil then
            OrchestratorDebugLogger.logLazy(function(): string
                return `remove active: handle={active.handle} slotId={active.slotId} lifecycleKey={active.lifecycleKey} slot=empty`
            end)

            return
        end

        OrchestratorDebugLogger.logLazy(function(): string
            return `remove active: handle={active.handle} slotId={active.slotId} lifecycleKey={active.lifecycleKey} promote={var2.handle}`
        end)
        var1.active = var2
        publish(var2)
    end

    return {
        submit = function(arg1)
            resetQueuesIfSessionChanged()
            local enableOnStudio = not (arg1.enableOnStudio == nil) and arg1.enableOnStudio

            if not enableOnStudio and RunService:IsStudio() then
                OrchestratorDebugLogger.logLazy(function(): string
                    return `submit discarded: slotId={arg1.slotId} lifecycleKey={arg1.lifecycleKey} reason=studio`
                end)
                return nil
            end

            if bool1 and arg1.suppressWhileInExperienceShopOpen then
                OrchestratorDebugLogger.logLazy(function(): string
                    return `submit discarded: slotId={arg1.slotId} lifecycleKey={arg1.lifecycleKey} reason=shopOpen`
                end)
                if not FFlagEnableNotificationsOrchestratorUnifiedLogging then
                    return nil
                end

                sendReportLog({
                    slot = arg1.slotId,
                    eventType = "suppressed",
                    lifecycleKey = arg1.lifecycleKey,
                    source = arg1.source,
                    itemId = arg1.itemId,
                    itemType = arg1.itemType
                })

                return nil
            end

            OrchestratorDebugLogger.logLazy(function(): string
                return `submit: slotId={arg1.slotId} lifecycleKey={arg1.lifecycleKey}`
            end)

            local frequency = resolveFrequency(arg1)
            local window = resolveWindow(frequency)

            if not isEligible(arg1.lifecycleKey, frequency, window) then
                OrchestratorDebugLogger.logLazy(function(): string
                    local maxImpressions = if frequency == nil then nil else frequency.maxImpressions
                    local cooldownSeconds = if frequency == nil then nil else frequency.cooldownSeconds
                    local count = ExposureTracker.getCount(arg1.lifecycleKey, window)
                    return `submit discarded: slotId={arg1.slotId} lifecycleKey={arg1.lifecycleKey} count={count} maxImpressions={maxImpressions} cooldownSeconds={cooldownSeconds} window={describeWindow(window)}`
                end)

                if not FFlagEnableNotificationsOrchestratorUnifiedLogging then
                    return nil
                end

                sendReportLog({
                    slot = arg1.slotId,
                    eventType = "submitDropped",
                    reason = "frequency",
                    lifecycleKey = arg1.lifecycleKey,
                    source = arg1.source,
                    itemId = arg1.itemId,
                    itemType = arg1.itemType
                })

                return nil
            end

            num1 += 1
            num2 += 1
            local str1 = tostring(num1)
            local active = {
                handle = str1,
                slotId = arg1.slotId,
                lifecycleKey = arg1.lifecycleKey,
                window = window,
                frequency = frequency,
                priority = if arg1.priority == nil then 0 else arg1.priority,
                payload = arg1.slotDisplayPayload,
                source = if FFlagEnableNotificationsOrchestratorUnifiedLogging then arg1.source else nil,
                itemId = if FFlagEnableNotificationsOrchestratorUnifiedLogging then arg1.itemId else nil,
                itemType = if FFlagEnableNotificationsOrchestratorUnifiedLogging then arg1.itemType else nil,
                submissionOrder = num2,
                queueKey = queueKeyForSlot(arg1.slotId),
                suppressWhileInExperienceShopOpen = arg1.suppressWhileInExperienceShopOpen
            }
            tbl2[str1] = active

            local queue = getQueue(active.queueKey)
            if queue.active == nil then
                OrchestratorDebugLogger.logLazy(function(): string
                    return `submit shown: handle={str1} slotId={active.slotId} lifecycleKey={active.lifecycleKey}`
                end)
                queue.active = active
                publish(active)
                return str1
            end

            local handle = queue.active.handle
            OrchestratorDebugLogger.logLazy(function(): string
                return `submit queued: handle={str1} slotId={active.slotId} lifecycleKey={active.lifecycleKey} behind={handle}`
            end)
            table.insert(queue.waiting, active)
            if FFlagEnableNotificationsOrchestratorUnifiedLogging then
                sendReportLog((reportLogFromEntry(active, "queued", nil, nil)))
            end

            return str1
        end,
        revoke = function(arg1)
            resetQueuesIfSessionChanged()

            OrchestratorDebugLogger.logLazy(function(): string
                return `revoke: handle={arg1}`
            end)
            local var1 = tbl2[arg1]
            if var1 == nil then
                OrchestratorDebugLogger.logLazy(function(): string
                    return `revoke ignored: handle={arg1}`
                end)
                return
            end
            removeEntry(var1)
            if FFlagEnableNotificationsOrchestratorUnifiedLogging then
                sendReportLog((reportLogFromEntry(var1, "revoked", nil, nil)))
            end
        end,
        report = function(slot, lifecycleKey, arg1)
            resetQueuesIfSessionChanged()

            OrchestratorDebugLogger.logLazy(function(): string
                return `report: slot={slot} key={lifecycleKey} event={arg1.type}`
            end)

            if arg1.type == "suppressed" then
                if FFlagEnableNotificationsOrchestratorUnifiedLogging then
                    sendReportLog({ slot = slot, eventType = "suppressed", lifecycleKey = lifecycleKey })

                    return
                end

                return
            end
            local var1 = tbl2[lifecycleKey]
            if var1 == nil or var1.slotId ~= slot then
                OrchestratorDebugLogger.logLazy(function(): string
                    return `report ignored: slot={slot} key={lifecycleKey} event={arg1.type}`
                end)
                return
            end

            local bool2 = false
            if arg1.type == "viewed" then
                ExposureTracker.record(var1.lifecycleKey, var1.window)

                local frequency = var1.frequency
                local maxImpressions = if frequency == nil then nil else frequency.maxImpressions
                local var2 = if maxImpressions == nil then nil else maxImpressions + 1

                if var2 ~= nil and not isEligible(var1.lifecycleKey, { maxImpressions = var2 }, var1.window) then
                    OrchestratorDebugLogger.logLazy(function(): string
                        local count = ExposureTracker.getCount(var1.lifecycleKey, var1.window)
                        return `maxImpressions reached: handle={var1.handle} slotId={var1.slotId} lifecycleKey={var1.lifecycleKey} count={count} maxImpressions={maxImpressions} window={describeWindow(var1.window)}`
                    end)

                    removeEntry(var1)
                    bool2 = true
                end
            elseif arg1.type == "dismissed" then
                removeEntry(var1)
            end

            if not FFlagEnableNotificationsOrchestratorUnifiedLogging then
                return
            end

            local reason = nil
            local actionId = nil
            if arg1.type == "dismissed" then
                reason = arg1.reason
            elseif arg1.type == "activated" then
                actionId = arg1.actionId
            end
            sendReportLog((reportLogFromEntry(var1, arg1.type, reason, actionId)))
            if bool2 then
                sendReportLog((reportLogFromEntry(var1, "capReached", nil, nil)))
            end
        end,
        getActiveForSlot = function(arg1)
            return slotSignals(arg1).getActive
        end,
        setInExperienceShopOpen = function(bool2: boolean)
            resetQueuesIfSessionChanged()

            if bool1 == bool2 then
                return
            end
            bool1 = bool2
            if not bool2 then
                return
            end

            local tbl4 = {}
            for _, value in tbl2 do
                if value.suppressWhileInExperienceShopOpen then
                    table.insert(tbl4, value)
                end
            end
            for _, value in tbl4 do
                if tbl2[value.handle] == nil then
                    continue
                end

                removeEntry(value)
                if FFlagEnableNotificationsOrchestratorUnifiedLogging then
                    local tbl5 = reportLogFromEntry(value, "suppressed", nil, nil)
                    sendReportLog(tbl5)
                end
            end
        end
    }
end

return createNotificationsStore
