-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T23:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local WhatsNew = script:FindFirstAncestor("WhatsNew")
local Constants = require(WhatsNew.Constants)
local _Types = require(WhatsNew.Types)
local DeriveResolvedFields = require(script.Parent.DeriveResolvedFields)

local function appendWarning(warnings, str1: string, str2: string) -- Luacid: Inlined by compiler; 5 call sites recovered
    if warnings == nil then
        return
    end
    table.insert(warnings, `{str1}:{str2}`)
end

local function createBuildContext(document, deps, screenScopeId: string, tourType, warnings) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        document = document,
        deps = deps,
        screenScopeId = screenScopeId,
        tourType = tourType,
        warnings = warnings,
        constants = document.constants,
        scopeTours = document.scopeTours
    }
end

local function filterEntriesInSubtree(tbl1, buildContext)
    local result = {}
    for _, value in tbl1 do
        if DeriveResolvedFields.isEntryInScopeSubtree(value, buildContext.screenScopeId, buildContext.scopeTours) then
            table.insert(result, value)
        end
    end
    return result
end

local function groupEntriesByScopeId(tbl1)
    local result = {}
    for _, value in tbl1 do
        local tbl2 = result[value.scopeId]
        if tbl2 == nil then
            tbl2 = {}
            result[value.scopeId] = tbl2
        end
        table.insert(tbl2, value)
    end
    return result
end

local function collectRelevantScopeIds(screenScopeId: string, tbl1, scopeTours)
    local tbl2 = {
        [screenScopeId] = true
    }

    local function addAncestorChain(str1: string)
        while str1 ~= nil and not tbl2[str1] do
            tbl2[str1] = true
            if str1 == screenScopeId then
                break
            end

            local scopeTour = scopeTours[str1]
            if scopeTour then
                str1 = scopeTour.parentScopeId
            else
                str1 = nil
            end
        end
    end
    for value in tbl1 do
        addAncestorChain(value)
    end

    local result = {}
    for value in tbl2 do
        table.insert(result, value)
    end
    return result
end

local function buildEmptyScopeTree(tbl1, scopeTours)
    local emptyScopeTree = ({})
    for _, id in tbl1 do
        local scopeTour = scopeTours[id]
        local tbl2 = {
            id = id,
            parentScopeId = if scopeTour then scopeTour.parentScopeId else nil,
            tourTips = {}
        }
        emptyScopeTree[id] = tbl2
    end

    return emptyScopeTree
end

local function tryConsumeSteps(tbl1, globalRemaining: number): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    if tbl1.globalRemaining < globalRemaining then
        return false
    end
    tbl1.globalRemaining -= globalRemaining
    return true
end

local function markTruncated(tbl1, warnings, screenScopeId: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    if tbl1.truncated then
        return
    end
    tbl1.truncated = true
    appendWarning(warnings, Constants.WarningCodes.TOUR_TIPS_TRUNCATED, screenScopeId)
end

local function getScopePathFromScreen(str1: string, screenScopeId: string, scopeTours)
    local scopePathFromScreen = {}

    while str1 ~= nil do
        table.insert(scopePathFromScreen, 1, str1)
        if str1 == screenScopeId then
            break
        end

        local scopeTour = scopeTours[str1]
        if scopeTour then
            str1 = scopeTour.parentScopeId
        else
            str1 = nil
        end
    end

    return scopePathFromScreen
end

local function entryToTourTip(arg1, arg2)
    return {
        id = arg1.id,
        scopeId = arg1.scopeId,
        title = arg1.title,
        text = arg1.text,
        icon = arg1.icon,
        enabled = arg1.enabled,
        publishedTime = arg1.publishedTime,
        disabledTime = arg1.disabledTime,
        expired = arg1.expired,
        seen = arg1.seen,
        optOutCount = arg1.optOutCount,
        adopted = arg1.adopted,
        toShow = arg1.toShow,
        anchorId = arg2.anchorId,
        stepCount = 1,
        side = arg2.side,
        align = arg2.align
    }
end

local function buildNestedGatewayTip(scopeTour, scope, labels)
    local openActionKey = scopeTour.openActionKey or ""
    local closeActionKey = scopeTour.closeActionKey or ""
    local anchorId = scopeTour.anchorId or ""

    return {
        id = `gateway:{scopeTour.id}`,
        scopeId = scopeTour.parentScopeId or scopeTour.id,
        title = labels.title,
        text = labels.text,
        icon = nil,
        enabled = true,
        publishedTime = nil,
        disabledTime = nil,
        expired = false,
        seen = nil,
        optOutCount = 0,
        adopted = false,
        toShow = true,
        anchorId = anchorId,
        stepCount = 1,
        side = scopeTour.side,
        align = scopeTour.align,
        gateway = { openActionKey = openActionKey, closeActionKey = closeActionKey, scope = scope }
    }
end

local function addPlainTipToScope(scopeId: string, tbl1: {adopted: any, align: any, anchorId: any, disabledTime: any, enabled: any, expired: any, icon: any, id: any, optOutCount: any, publishedTime: any, scopeId: any, seen: any, side: any, stepCount: number, text: any, title: any, toShow: any}, emptyScopeTree, _, tbl2, buildContext): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if not tryConsumeSteps(tbl2, 1) then
        markTruncated(tbl2, buildContext.warnings, buildContext.screenScopeId)
        return false
    end

    table.insert(emptyScopeTree[scopeId].tourTips, tbl1)
    return true
end

local function ensureNestedGateway(parentScopeId: string, str1: string, emptyScopeTree, tbl1, tbl2, buildContext): boolean
    if tbl1[str1] ~= nil then
        return true
    end

    local scopeTour = buildContext.scopeTours[str1]
    if scopeTour == nil then
        return false
    end

    if not tryConsumeSteps(tbl2, 1) then
        markTruncated(tbl2, buildContext.warnings, buildContext.screenScopeId)
        return false
    end

    local labels = DeriveResolvedFields.getLabels(scopeTour, buildContext.tourType)
    if not DeriveResolvedFields.hasLabels(labels) then
        appendWarning(buildContext.warnings, Constants.WarningCodes.GATEWAY_COPY_FALLBACK, str1)
    end

    local var1 = emptyScopeTree[str1]
    local tip = buildNestedGatewayTip(scopeTour, var1, labels)
    table.insert(emptyScopeTree[parentScopeId].tourTips, tip)
    tbl1[str1] = { parentScopeId = parentScopeId, tip = tip }

    return true
end

local function ensureScopeChainForEntry(scopeId: string, emptyScopeTree, tbl1, tbl2, buildContext)
    local scopePathFromScreen = getScopePathFromScreen(scopeId, buildContext.screenScopeId, buildContext.scopeTours)
    for i = 1, #scopePathFromScreen - 1 do
        local parentScopeId = scopePathFromScreen[i]
        local var1 = scopePathFromScreen[i + 1]
        if not ensureNestedGateway(parentScopeId, var1, emptyScopeTree, tbl1, tbl2, buildContext) then
            return false
        end
    end
    return true
end

local function buildScopeTourForScreen(buildContext, tbl1)
    local scopeTour = buildContext.scopeTours[buildContext.screenScopeId]
    local parentScopeId = if scopeTour then scopeTour.parentScopeId else nil
    local maxTourTips = buildContext.constants.maxTourTips

    local tbl2 = filterEntriesInSubtree(tbl1, buildContext)
    local tbl3 = groupEntriesByScopeId(tbl2)
    local tbl4 = collectRelevantScopeIds(buildContext.screenScopeId, tbl3, buildContext.scopeTours)
    local emptyScopeTree = buildEmptyScopeTree(tbl4, buildContext.scopeTours)
    local tbl5 = { globalRemaining = maxTourTips, truncated = false }

    local tbl6 = {}

    for _, value in tbl2 do
        local var1 = DeriveResolvedFields.deriveEntryDisplay(value, buildContext.tourType, buildContext.deps)
        if var1.toShow and ensureScopeChainForEntry(value.scopeId, emptyScopeTree, tbl6, tbl5, buildContext) then
            local tbl7 = entryToTourTip(var1, value)
            addPlainTipToScope(value.scopeId, tbl7, emptyScopeTree, nil, tbl5, buildContext)
        end
    end

    local scope = emptyScopeTree[buildContext.screenScopeId]

    if scope ~= nil then
        return {
            scope = scope,
            truncated = tbl5.truncated,
            globalTotalSteps = DeriveResolvedFields.countScopeSteps(scope)
        }
    end

    return {
        scope = {
            id = buildContext.screenScopeId,
            parentScopeId = parentScopeId,
            tourTips = {}
        },
        truncated = false,
        globalTotalSteps = 0
    }
end

local function buildTourTips(document, deps, screenScopeId: string, tourType, tbl1, warnings)
    local buildContext = createBuildContext(document, deps, screenScopeId, tourType, warnings)
    return (buildScopeTourForScreen(buildContext, tbl1))
end

return buildTourTips
