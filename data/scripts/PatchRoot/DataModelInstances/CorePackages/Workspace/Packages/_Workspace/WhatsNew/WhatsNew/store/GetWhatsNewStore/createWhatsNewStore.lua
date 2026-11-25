-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T23:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DateTime = DateTime

local WhatsNew = script:FindFirstAncestor("WhatsNew")
local WhatsNewParent = WhatsNew.Parent

local Enums = require(WhatsNew.Enums)
local EntryStorage = require(WhatsNew.storage.EntryStorage)
local Signals = require(WhatsNewParent.Signals)
local _Types = require(WhatsNew.Types)
local WhatsNewTelemetry = require(WhatsNew.telemetry.WhatsNewTelemetry)
local LoadWhatsNewRegistry = require(WhatsNew.registry.LoadWhatsNewRegistry)
local _ScopeActions = require(WhatsNew.registry.ScopeActions)

local function createIdleState(screenScopeId: string)
    return {
        screenScopeId = screenScopeId,
        activeTourType = nil,
        globalTotalSteps = 0,
        globalStepIndex = nil,
        currentScopeTour = nil,
        currentEntry = nil,
        currentTipIndex = 0,
        scopeStack = {},
        surface = Enums.WhatsNewSurface.Idle
    }
end

local function hasBeenSeen(id: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = EntryStorage.getEntries()[id]
    return not (var1 == nil) and var1.seen ~= nil
end

local function isEligibleForNewSession(arg1) -- Luacid: Inlined by compiler; 12 call sites recovered
    return arg1.toShow and not hasBeenSeen(arg1.id)
end

local function countEligibleTips(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    local num1 = 0
    for _, tourTip in arg1.tourTips do
        if isEligibleForNewSession(tourTip) then
            num1 += tourTip.stepCount
        end
    end
    return num1
end

local function tourHasEligibleRootTips(scopeTree) -- Luacid: Inlined by compiler; 2 call sites recovered
    for _, tourTip in scopeTree.tourTips do
        if isEligibleForNewSession(tourTip) then
            return true
        end
    end
    return false
end

local function findFirstEligibleTipIndex(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
    for k, tourTip in arg1.tourTips do
        if isEligibleForNewSession(tourTip) then
            return k
        end
    end
    return nil
end

local function findNextVisibleTipIndexFrom(arg1, num1: number) -- Luacid: Inlined by compiler; 2 call sites recovered
    for i = num1, #arg1.tourTips do
        if arg1.tourTips[i].toShow then
            return i
        end
    end
    return nil
end

local function findPreviousVisibleTipIndexFrom(currentScopeTour, num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
    for i = num1, 1, -1 do
        if currentScopeTour.tourTips[i].toShow then
            return i
        end
    end
    return nil
end

local function findGatewayTipByOpenActionKey(arg1, openActionKey: string)
    for _, tourTip in arg1.tourTips do
        local gateway = tourTip.gateway
        if gateway ~= nil and gateway.openActionKey == openActionKey then
            return tourTip
        end
        if gateway == nil then
            continue
        end

        local gatewayTipByOpenActionKey = findGatewayTipByOpenActionKey(gateway.scope, openActionKey)
        if gatewayTipByOpenActionKey ~= nil then
            return gatewayTipByOpenActionKey
        end
    end

    return nil
end

local function findCloseActionKeyForScope(arg1, id: string)
    for _, tourTip in arg1.tourTips do
        local gateway = tourTip.gateway
        if gateway == nil then
            continue
        end

        if gateway.scope.id == id then
            return gateway.closeActionKey
        end
        local closeActionKeyForScope = findCloseActionKeyForScope(gateway.scope, id)
        if closeActionKeyForScope ~= nil then
            return closeActionKeyForScope
        end
    end

    return nil
end

local function getCloseActionKeyForFrame(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local tourTip = arg1.parentScopeTour.tourTips[arg1.parentTipIndex]
    local gateway = tourTip.gateway
    assert(gateway ~= nil, `parent tip '{tourTip.id}' is missing gateway for scope stack frame`)
    return gateway.closeActionKey
end

local function popScopeStack<T>(tbl1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = tbl1[#tbl1]
    local var2 = table.clone(tbl1)
    table.remove(var2)
    return var1, var2
end

local function markEntrySeen(id: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    EntryStorage.markSeen(id, DateTime.now():ToIsoDate())
end

local function markTipsSeenFromCurrent(currentScopeTour, id: string, arg1)
    local bool1 = false

    local function runtimeStateForTip(currentEntry) -- Luacid: Inlined by compiler; 1 call site recovered
        local var1 = table.clone(arg1)
        var1.currentEntry = currentEntry
        return var1
    end

    for _, tourTip in currentScopeTour.tourTips do
        local bool2 = tourTip.id == id
        if bool2 then
            bool1 = true
        end

        if not bool1 then
            continue
        end

        markEntrySeen(tourTip.id)
        if not bool2 then
            WhatsNewTelemetry.logTourtipInteraction(
                WhatsNewTelemetry.InteractionType.SKIP,
                tourTip.id,
                nil,
                runtimeStateForTip(tourTip),
                WhatsNewTelemetry.SkipReason.TOUR_ENDED_EARLY
            )
        end
    end
end

local function createWhatsNewStore()
    local rootTourMap = nil
    local scopeActions = nil
    local bool1 = false

    local function assertInitialized() -- Luacid: Inlined by compiler; 9 call sites recovered
        local bool2 = bool1

        if bool2 then
            if rootTourMap == nil then
                bool2 = false
            else
                bool2 = scopeActions ~= nil
            end
        end

        assert(bool2, "WhatsNew store not initialized. Call initialize first.")
    end

    local function getRootTourAndScopeActions() -- Luacid: unused: defined but never referenced
        assertInitialized()
        return rootTourMap, scopeActions
    end

    local tbl1 = ({})
    local getRuntimeStateSignal, var2 = Signals.createSignal((createIdleState("")))

    local function resolveSurfaceForAnchor(anchorId: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        local var3 = tbl1[anchorId]
        return if var3 == nil or not var3.isReady then Enums.WhatsNewSurface.WaitingForAnchor else Enums.WhatsNewSurface.TourTip
    end

    local function refreshSurfaceForCurrentEntry()
        local var3 = getRuntimeStateSignal(false)
        local currentEntry = var3.currentEntry
        if currentEntry == nil then
            return
        end
        var2({
            scopeStack = var3.scopeStack,
            screenScopeId = var3.screenScopeId,
            activeTourType = var3.activeTourType,
            globalTotalSteps = var3.globalTotalSteps,
            globalStepIndex = var3.globalStepIndex,
            currentScopeTour = var3.currentScopeTour,
            currentEntry = currentEntry,
            currentTipIndex = var3.currentTipIndex,
            surface = resolveSurfaceForAnchor(currentEntry.anchorId)
        })
    end

    local function showTipAt(currentScopeTour, currentTipIndex: number, currentEntry, tbl2)
        local var3 = getRuntimeStateSignal(false)
        var2({
            screenScopeId = tbl2.screenScopeId or var3.screenScopeId,
            activeTourType = if tbl2.activeTourType ~= nil then tbl2.activeTourType else var3.activeTourType,
            globalTotalSteps = tbl2.globalTotalSteps or var3.globalTotalSteps,
            globalStepIndex = if tbl2.globalStepIndex ~= nil then tbl2.globalStepIndex else var3.globalStepIndex,
            currentScopeTour = currentScopeTour,
            currentEntry = currentEntry,
            currentTipIndex = currentTipIndex,
            scopeStack = tbl2.scopeStack or var3.scopeStack,
            surface = resolveSurfaceForAnchor(currentEntry.anchorId)
        })
    end

    local function resetToIdle() -- Luacid: Inlined by compiler; 3 call sites recovered
        var2((createIdleState(getRuntimeStateSignal(false).screenScopeId)))
    end

    local function stopTour()
        local var3 = getRuntimeStateSignal(false)
        if var3.surface ~= Enums.WhatsNewSurface.Idle then
            WhatsNewTelemetry.logTourLifecycle(
                WhatsNewTelemetry.LifecycleType.TOUR_STOPPED,
                var3,
                WhatsNewTelemetry.StopReason.ABORT
            )
        end

        resetToIdle()
    end

    local bool2 = false

    local function invokeCloseAction(arg1, str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
        bool2 = true
        local success, result = pcall(function()
            arg1:invoke(str1)
        end)
        bool2 = false
        if not success then
            error(result)
        end
    end

    local function exitNestedScope(arg1, tbl2) -- Luacid: Inlined by compiler; 1 call site recovered
        local var3, var4 = popScopeStack(tbl2)
        invokeCloseAction(arg1, (getCloseActionKeyForFrame(var3)))
        return var3, var4
    end

    local function markActiveScopeEndedEarly(arg1)
        if arg1.currentEntry ~= nil then
            WhatsNewTelemetry.logTourtipInteraction(
                WhatsNewTelemetry.InteractionType.DISMISS,
                arg1.currentEntry.id,
                WhatsNewTelemetry.Button.CLOSE,
                arg1
            )
        end

        local currentScopeTour = arg1.currentScopeTour
        local currentEntry = arg1.currentEntry
        if currentScopeTour ~= nil and currentEntry ~= nil then
            markTipsSeenFromCurrent(currentScopeTour, currentEntry.id, arg1)
        end

        WhatsNewTelemetry.logTourLifecycle(
            WhatsNewTelemetry.LifecycleType.TOUR_STOPPED,
            arg1,
            WhatsNewTelemetry.StopReason.DISMISS
        )
    end

    local function completeTour(arg1)
        local var3 = getRuntimeStateSignal(false)
        if var3.surface == Enums.WhatsNewSurface.Idle then
            return
        end

        local bool3 = not (arg1 == nil) and arg1.earlyDismiss == true

        if bool3 then
            markActiveScopeEndedEarly(var3)
        end

        local scopeStack = var3.scopeStack
        assertInitialized()
        local var4 = scopeActions

        if not (#scopeStack > 0) then
            if not bool3 then
                WhatsNewTelemetry.logTourLifecycle(WhatsNewTelemetry.LifecycleType.TOUR_COMPLETED, var3)
            end

            local currentScopeTour = var3.currentScopeTour
            if currentScopeTour ~= nil and var3.activeTourType ~= nil and var3.screenScopeId ~= "" then
                assertInitialized()
                local var5 = rootTourMap[LoadWhatsNewRegistry.makeRootTourKey(var3.screenScopeId, var3.activeTourType)]
                if var5 ~= nil then
                    local closeActionKeyForScope = findCloseActionKeyForScope(var5.scopeTree, currentScopeTour.id)
                    if closeActionKeyForScope ~= nil then
                        invokeCloseAction(var4, closeActionKeyForScope)
                    end
                end
            end

            resetToIdle()
            return
        end

        if not bool3 then
            WhatsNewTelemetry.logTourLifecycle(WhatsNewTelemetry.LifecycleType.TOUR_COMPLETED, var3)
        end

        while #scopeStack > 0 do
            local var5
            var5, scopeStack = exitNestedScope(var4, scopeStack)
            local nextVisibleTipIndexFrom = findNextVisibleTipIndexFrom(var5.parentScopeTour, var5.parentTipIndex + 1)
            if nextVisibleTipIndexFrom ~= nil then
                showTipAt(var5.parentScopeTour, nextVisibleTipIndexFrom, var5.parentScopeTour.tourTips[nextVisibleTipIndexFrom], {
                    scopeStack = scopeStack,
                    globalStepIndex = var5.parentGlobalStepIndex + 1,
                    globalTotalSteps = var5.parentGlobalTotalSteps
                })
                return
            end

            local currentEntry = var5.parentScopeTour.tourTips[var5.parentTipIndex]
            local tbl2 = {
                screenScopeId = var3.screenScopeId,
                activeTourType = var3.activeTourType,
                globalTotalSteps = var5.parentGlobalTotalSteps,
                globalStepIndex = var5.parentGlobalStepIndex,
                currentScopeTour = var5.parentScopeTour,
                currentEntry = currentEntry,
                currentTipIndex = var5.parentTipIndex,
                scopeStack = scopeStack,
                surface = var3.surface
            }
            WhatsNewTelemetry.logTourLifecycle(WhatsNewTelemetry.LifecycleType.TOUR_COMPLETED, tbl2)
        end

        resetToIdle()
    end
    local function startTour(screenScopeId: string, activeTourType)
        assertInitialized()
        local var3 = rootTourMap[LoadWhatsNewRegistry.makeRootTourKey(screenScopeId, activeTourType)]
        if var3 == nil then
            return
        end

        local firstEligibleTipIndex = findFirstEligibleTipIndex(var3.scopeTree)
        if firstEligibleTipIndex == nil then
            return
        end

        local tourTip = var3.scopeTree.tourTips[firstEligibleTipIndex]
        showTipAt(var3.scopeTree, firstEligibleTipIndex, tourTip, {
            screenScopeId = screenScopeId,
            activeTourType = activeTourType,
            globalTotalSteps = countEligibleTips(var3.scopeTree),
            globalStepIndex = 0,
            scopeStack = {}
        })
        WhatsNewTelemetry.logTourLifecycle(
            WhatsNewTelemetry.LifecycleType.TOUR_STARTED,
            getRuntimeStateSignal(false),
            nil,
            WhatsNewTelemetry.StartContext.ROOT
        )
    end

    local function tryStartTour(str1: string, arg1): boolean -- Luacid: unused: defined but never referenced
        assertInitialized()
        local var3 = rootTourMap[LoadWhatsNewRegistry.makeRootTourKey(str1, arg1)]

        if var3 == nil or not tourHasEligibleRootTips(var3.scopeTree) then
            return false
        end

        startTour(str1, arg1)
        return true
    end

    local function startEligibleTour(screenScopeId: string)
        assertInitialized()

        if getRuntimeStateSignal(false).surface == Enums.WhatsNewSurface.Idle then
            var2((createIdleState(screenScopeId)))
        end

        for _, value in Enums.TourTypeList do
            assertInitialized()
            local var3 = rootTourMap[LoadWhatsNewRegistry.makeRootTourKey(screenScopeId, value)]
            local bool3

            if var3 == nil or not tourHasEligibleRootTips(var3.scopeTree) then
                bool3 = false
            else
                startTour(screenScopeId, value)
                bool3 = true
            end

            if bool3 then
                return
            end
        end
    end

    local bool3 = false

    local function tryEnterNestedScope(tbl2): boolean
        if bool3 then
            return false
        end

        local var3 = getRuntimeStateSignal(false)

        if var3.surface == Enums.WhatsNewSurface.Idle
            or var3.currentEntry == nil
            or var3.currentScopeTour == nil
            or var3.globalStepIndex == nil
        then
            return false
        end

        local currentEntry = var3.currentEntry
        local currentScopeTour = var3.currentScopeTour
        local gateway = currentEntry.gateway
        if gateway == nil or tbl2.openActionKey ~= nil and gateway.openActionKey ~= tbl2.openActionKey then
            return false
        end

        local scope = gateway.scope
        local firstEligibleTipIndex = findFirstEligibleTipIndex(scope)

        if firstEligibleTipIndex == nil then
            return false
        end

        bool3 = true
        local success, result = pcall(function()
            local scopeStack = table.clone(var3.scopeStack)
            table.insert(scopeStack, {
                parentTipIndex = var3.currentTipIndex,
                parentScopeTour = currentScopeTour,
                parentGlobalStepIndex = var3.globalStepIndex,
                parentGlobalTotalSteps = var3.globalTotalSteps
            })

            local tourTip = scope.tourTips[firstEligibleTipIndex]
            showTipAt(
                scope,
                firstEligibleTipIndex,
                tourTip,
                {
                    scopeStack = scopeStack,
                    globalStepIndex = 0,
                    globalTotalSteps = countEligibleTips(scope)
                }
            )
            WhatsNewTelemetry.logTourLifecycle(
                WhatsNewTelemetry.LifecycleType.TOUR_STARTED,
                getRuntimeStateSignal(false),
                nil,
                WhatsNewTelemetry.StartContext.GATEWAY
            )
        end)
        bool3 = false
        if not success then
            error(result)
        end
        return true
    end

    local function tryStartNestedFromIdle(openActionKey: string)
        local screenScopeId = getRuntimeStateSignal(false).screenScopeId
        if screenScopeId == "" then
            return false
        end

        assertInitialized()
        local var3 = rootTourMap

        for _, activeTourType in Enums.TourTypeList do
            local var4 = var3[LoadWhatsNewRegistry.makeRootTourKey(screenScopeId, activeTourType)]
            if var4 == nil then
                continue
            end

            local gatewayTipByOpenActionKey = findGatewayTipByOpenActionKey(var4.scopeTree, openActionKey)
            local gateway = if gatewayTipByOpenActionKey == nil then nil else gatewayTipByOpenActionKey.gateway

            if gateway == nil then
                continue
            end

            local scope = gateway.scope
            local firstEligibleTipIndex = findFirstEligibleTipIndex(scope)

            if firstEligibleTipIndex == nil then
                continue
            end

            local tourTip = scope.tourTips[firstEligibleTipIndex]
            showTipAt(scope, firstEligibleTipIndex, tourTip, {
                screenScopeId = screenScopeId,
                activeTourType = activeTourType,
                scopeStack = {},
                globalStepIndex = 0,
                globalTotalSteps = countEligibleTips(scope)
            })
            WhatsNewTelemetry.logTourLifecycle(
                WhatsNewTelemetry.LifecycleType.TOUR_STARTED,
                getRuntimeStateSignal(false),
                nil,
                WhatsNewTelemetry.StartContext.IDLE
            )
            return true
        end

        return false
    end

    local function notifyScopeOpened(openActionKey: string)
        local var3 = getRuntimeStateSignal(false)
        if var3.surface == Enums.WhatsNewSurface.Idle then
            tryStartNestedFromIdle(openActionKey)
            return
        end

        if var3.currentEntry == nil then
            return
        end

        local currentEntry = var3.currentEntry
        local gateway = currentEntry.gateway
        if gateway ~= nil
            and gateway.openActionKey == openActionKey
            and (var3.currentScopeTour == nil or var3.currentScopeTour.id ~= gateway.scope.id)
            and findFirstEligibleTipIndex(gateway.scope) ~= nil
        then
            markEntrySeen(currentEntry.id)
            tryEnterNestedScope({ openActionKey = openActionKey })
        end
    end

    local function notifyScopeClosed(str1: string)
        local var3 = getRuntimeStateSignal(false)
        if bool2 or bool3 or var3.surface == Enums.WhatsNewSurface.Idle then
            return
        end

        local scopeStack = var3.scopeStack
        local var4 = scopeStack[#scopeStack]
        if var4 ~= nil then
            if getCloseActionKeyForFrame(var4) ~= str1 then
                return
            end
            completeTour({ earlyDismiss = true })
            return
        end

        local currentScopeTour = var3.currentScopeTour
        if currentScopeTour == nil or var3.activeTourType == nil or var3.screenScopeId == "" then
            return
        end

        assertInitialized()
        local var5 = rootTourMap[LoadWhatsNewRegistry.makeRootTourKey(var3.screenScopeId, var3.activeTourType)]
        if var5 ~= nil and findCloseActionKeyForScope(var5.scopeTree, currentScopeTour.id) == str1 then
            completeTour({ earlyDismiss = true })
        end
    end

    return {
        initialize = function(arg1)
            if bool1 then
                return
            end
            rootTourMap = arg1.rootTourMap
            scopeActions = arg1.scopeActions
            assert(scopeActions ~= nil, "scopeActions is required")
            bool1 = true
            scopeActions:startOpenStateWiring({
                notifyScopeOpened = notifyScopeOpened,
                notifyScopeClosed = notifyScopeClosed,
                getRuntimeStateSignal = getRuntimeStateSignal
            })
        end,
        resetForTests = function()
            if scopeActions ~= nil then
                scopeActions:stopOpenStateWiring()
            end
            bool1 = false
            rootTourMap = nil
            scopeActions = nil
            table.clear(tbl1)
            var2((createIdleState("")))
        end,
        getRuntimeState = function()
            return getRuntimeStateSignal(false)
        end,
        getRuntimeStateSignal = getRuntimeStateSignal,
        getCurrentScope = function()
            return getRuntimeStateSignal(false).currentScopeTour
        end,
        getCurrentEntry = function()
            return getRuntimeStateSignal(false).currentEntry
        end,
        getGlobalStepIndex = function()
            return getRuntimeStateSignal(false).globalStepIndex
        end,
        getGlobalTotalSteps = function()
            local var3 = getRuntimeStateSignal(false)
            return if var3.activeTourType == nil then 0 else var3.globalTotalSteps
        end,
        registerAnchor = function(anchorId: string, ref)
            local var3 = tbl1[anchorId]
            if var3 ~= nil and var3.ref == ref then
                return
            end

            if var3 ~= nil and var3.ref.Parent ~= nil then
                warn(`WhatsNew anchor '{anchorId}' is already registered; replacing with new registration`)
            end

            tbl1[anchorId] = { ref = ref, isReady = false }

            local var4 = getRuntimeStateSignal(false)
            if var4.currentEntry ~= nil and var4.currentEntry.anchorId == anchorId then
                refreshSurfaceForCurrentEntry()
            end
        end,
        getAnchorRef = function(str1: string)
            local var3 = tbl1[str1]
            return if var3 == nil then nil else var3.ref
        end,
        setAnchorReady = function(anchorId: string, isReady: boolean, ref)
            local var3 = tbl1[anchorId]
            if var3 == nil or ref ~= nil and var3.ref ~= ref then
                return
            end

            var3.isReady = isReady
            local var4 = getRuntimeStateSignal(false)
            if var4.currentEntry ~= nil and var4.currentEntry.anchorId == anchorId then
                refreshSurfaceForCurrentEntry()
            end
        end,
        unregisterAnchor = function(anchorId: string, ref)
            local var3 = tbl1[anchorId]
            if var3 == nil or ref ~= nil and var3.ref ~= ref then
                return
            end

            tbl1[anchorId] = nil
            local var4 = getRuntimeStateSignal(false)
            if var4.currentEntry ~= nil and var4.currentEntry.anchorId == anchorId then
                refreshSurfaceForCurrentEntry()
            end
        end,
        startEligibleTour = startEligibleTour,
        startTour = startTour,
        stopTour = stopTour,
        next = function()
            local var3 = getRuntimeStateSignal(false)
            if var3.surface == Enums.WhatsNewSurface.Idle then
                return
            end

            assert(
                not (var3.currentEntry == nil or var3.currentScopeTour == nil) and var3.globalStepIndex ~= nil,
                "next() called with inconsistent active tour state"
            )

            local currentEntry = var3.currentEntry

            markEntrySeen(currentEntry.id)
            WhatsNewTelemetry.logTourtipInteraction(
                WhatsNewTelemetry.InteractionType.CLICK,
                currentEntry.id,
                WhatsNewTelemetry.Button.NEXT,
                var3
            )

            local currentScopeTour = var3.currentScopeTour

            local globalStepIndex = var3.globalStepIndex + 1
            if var3.globalTotalSteps <= globalStepIndex then
                completeTour()
                return
            end

            local nextVisibleTipIndexFrom = findNextVisibleTipIndexFrom(currentScopeTour, var3.currentTipIndex + 1)
            if nextVisibleTipIndexFrom ~= nil then
                showTipAt(
                    currentScopeTour,
                    nextVisibleTipIndexFrom,
                    currentScopeTour.tourTips[nextVisibleTipIndexFrom],
                    { globalStepIndex = globalStepIndex }
                )
                return
            end

            completeTour()
        end,
        back = function()
            local var3 = getRuntimeStateSignal(false)
            if var3.surface == Enums.WhatsNewSurface.Idle then
                return
            end

            assert(
                not (var3.currentEntry == nil or var3.currentScopeTour == nil) and var3.globalStepIndex ~= nil,
                "back() called with inconsistent active tour state"
            )

            if var3.globalStepIndex == 0 then
                return
            end

            WhatsNewTelemetry.logTourtipInteraction(
                WhatsNewTelemetry.InteractionType.CLICK,
                var3.currentEntry.id,
                WhatsNewTelemetry.Button.BACK,
                var3
            )

            local currentScopeTour = var3.currentScopeTour
            local globalStepIndex = var3.globalStepIndex - 1
            local previousVisibleTipIndexFrom = findPreviousVisibleTipIndexFrom(currentScopeTour, var3.currentTipIndex - 1)
            if previousVisibleTipIndexFrom ~= nil then
                showTipAt(
                    currentScopeTour,
                    previousVisibleTipIndexFrom,
                    currentScopeTour.tourTips[previousVisibleTipIndexFrom],
                    { globalStepIndex = globalStepIndex }
                )
                return
            end

            assert(false, "back() cannot resolve previous tip at globalStepIndex > 0 within current scope")
        end,
        notifyScopeOpened = notifyScopeOpened,
        notifyScopeClosed = notifyScopeClosed,
        completeTour = completeTour
    }
end
return createWhatsNewStore
