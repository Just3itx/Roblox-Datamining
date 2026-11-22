-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPane = script:FindFirstAncestor("SplitPane")
local SplitPaneParent = SplitPane.Parent

local AppSplitView = require(SplitPaneParent.AppSplitView)
local NavigationRodux = require(SplitPaneParent.NavigationRodux)
local SessionType = require(SplitPaneParent.RobloxAppSessionization).SessionType
local Signals = require(SplitPaneParent.Signals)
local SessionType2 = require(SplitPane.SessionType)
local SplitL3Store = require(SplitPane.Stores.SplitL3Store)
local SplitPaneStore = require(SplitPane.Stores.SplitPaneStore)
local AppPage = require(SplitPaneParent.RobloxAppEnums).AppPage
local SplitPaneSlot = AppSplitView.Enums.SplitPaneSlot
local TempRnSwitchNavigatorName = NavigationRodux.Constants.TempRnSwitchNavigatorName

local function routeHasSupportAboveContent(arg1, tbl1)
    if tbl1 == nil then
        return false
    end
    local bool1 = false
    for i = #arg1, 1, -1 do
        local var1 = tbl1[arg1[i].name]
        if var1 == SplitPaneSlot.Support then
            bool1 = true
        elseif bool1 and var1 == SplitPaneSlot.Content then
            return true
        end
    end
    return false
end

local function createResolveEligibility(arg1): ((string) -> any)? -- Luacid: Inlined by compiler; 1 call site recovered
    return if arg1 == nil then nil else function(routeName: string)
        local tbl1 = {
            state = { routeName = routeName }
        }

        local success, result = pcall(function()
            return arg1.getScreenOptions(tbl1, {})
        end)
        if success and result ~= nil and result.splitPaneEligibility ~= nil then
            return result.splitPaneEligibility
        end

        local childRouter = if arg1.childRouters then arg1.childRouters[TempRnSwitchNavigatorName] else nil

        if childRouter ~= nil then
            local success2, result2 = pcall(function()
                return childRouter.getScreenOptions(tbl1, {})
            end)
            if success2 and result2 ~= nil and result2.splitPaneEligibility ~= nil then
                return result2.splitPaneEligibility
            end
        end
        return nil
    end
end

local var1 = nil

local function getLevel2RouteAndExclusions(arg1, tbl1)
    if not routeHasSupportAboveContent(arg1, tbl1) then
        var1 = nil
        return arg1, nil
    end
    local tbl2 = {}
    local tbl3 = {}
    local bool1 = false
    local bool2 = var1 == nil
    local var2 = var1 or {}
    for _, value in arg1 do
        local var3 = tbl1[value.name]
        if var3 == SplitPaneSlot.Support then
            bool1 = true
            tbl3[value.name] = true
            if not bool2 and var2[value.name] == nil then
                bool2 = true
            end
        elseif var3 == SplitPaneSlot.Content or not bool1 then
            table.insert(tbl2, value)
        else
            tbl3[value.name] = true
            if not bool2 and var2[value.name] == nil then
                bool2 = true
            end
        end
    end

    if not bool2 then
        for value in var2 do
            if tbl3[value] == nil then
                bool2 = true
                break
            end
        end
    end

    if bool2 then
        var1 = tbl3
    end
    return tbl2, var1
end

local function isAppPageName(name: string?): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not (name == nil) and AppPage[name] ~= nil
end

local function resolveL3Page(arg1, tbl1)
    local var2 = nil
    for i = #arg1, 1, -1 do
        local var3 = arg1[i]
        local var4 = tbl1[var3.name]
        if var4 == SplitPaneSlot.Content then
            continue
        end

        if var4 == SplitPaneSlot.Support then
            if var2 ~= nil then
                return var2, var3
            end
            return var3, var3
        end

        if var2 == nil and not isAppPageName(var3.name) then
            var2 = var3
        end
    end

    return nil, nil
end

local function getSplitSubPaneTagFromRoute(arg1, tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local var2 = resolveL3Page(arg1, tbl1)

    if var2 == nil then
        return nil
    end

    return SessionType2.Tag.SplitSubPane[var2.name] or var2.name
end

local function getSplitSubPaneDetailFromRoute(arg1, tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local var2, var3 = resolveL3Page(arg1, tbl1)

    if var2 == nil then
        return nil
    end

    if var2.detail == nil then
        if var3 == nil then
            return nil
        end

        return var3.detail
    end

    return var2.detail
end

local function getIsSplitL3Enabled(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
    return SplitPaneStore.getStore().getIsBreakpointEnabled(arg1)
end

local function resolveEligibilityMap(arg1, func1: ((...any) -> (...any))?)
    local result = {}
    for i = #arg1, 1, -1 do
        local var2 = arg1[i]
        if func1 == nil then
            continue
        end

        local var3 = func1(var2.name)
        if var3 ~= nil then
            result[var2.name] = var3
        end
    end

    return result
end

return {
    createGetL2Exclusions = function(arg1)
        local resolveEligibility = createResolveEligibility(arg1)

        return function(arg2, arg3)
            if not getIsSplitL3Enabled(arg2) or arg3 == nil then
                return nil
            end
            local tbl1 = resolveEligibilityMap(arg3, resolveEligibility)
            local _, var2 = getLevel2RouteAndExclusions(arg3, tbl1)
            return var2
        end
    end,
    createResolveEligibility = createResolveEligibility,
    subscribeToRouteSignal = function(func1: (...any) -> (...any), func2: ((...any) -> (...any))?)
        local var2 = nil
        local store = SplitL3Store.getStore()
        local function handleRouteChange(arg1, isSplitL3Enabled: boolean)
            if not isSplitL3Enabled or func2 == nil then
                store.setPendingSplitSubPaneTag(nil)
                store.setPendingSplitSubPaneDetail(nil)
                return
            end
            local tbl1 = resolveEligibilityMap(arg1, func2)
            local bool1 = routeHasSupportAboveContent(arg1, tbl1)
            store.setPendingSplitSubPaneTag(if bool1 then getSplitSubPaneTagFromRoute(arg1, tbl1) else nil)
            store.setPendingSplitSubPaneDetail(if bool1 then getSplitSubPaneDetailFromRoute(arg1, tbl1) else nil)
        end
        local var3 = func1(function(arg1)
            var2 = arg1
            handleRouteChange(arg1, getIsSplitL3Enabled(false))
        end)
        local effect = Signals.createEffect(function(arg1)
            local isSplitL3Enabled = getIsSplitL3Enabled(arg1)

            if var2 ~= nil then
                handleRouteChange(var2, isSplitL3Enabled)
            end
        end)
        return function()
            if var3 ~= nil and var3.disconnect ~= nil then
                var3:disconnect()
            end
            effect()
        end
    end,
    onSessionsUpdated = function()
        if not getIsSplitL3Enabled(false) then
            return
        end
        local store = SplitL3Store.getStore()
        store.setSplitL2SessionVersion(store.getSplitL2SessionVersion(false) + 1)
    end,
    applySplitSubPaneSession = function(sessionService, str1: string?, ...)
        local select = select
        local bool1 = select("#", ...) > 0
        local var2 = if bool1 then ... else nil

        if not getIsSplitL3Enabled(false) then
            str1 = nil
            bool1 = true
            var2 = nil
        end
        local store = SplitL3Store.getStore()
        local splitL3AppliedDetail = store.getSplitL3AppliedDetail(false)
        local level2b = SessionType.StructuralIdentifier.Level2b
        local splitSubPane = SessionType2.StructuralIdentifier.SplitSubPane
        local var3 = sessionService:SessionExists(splitSubPane)
        local sessionTag = if var3 then sessionService:GetSessionTag(splitSubPane) else nil

        local function writeAppliedDetail() -- Luacid: Inlined by compiler; 2 call sites recovered
            if bool1 then
                store.setSplitL3AppliedDetail(var2)
                return
            end
            store.setSplitL3AppliedDetail(nil)
        end

        if str1 == nil then
            if var3 then
                sessionService:RemoveSession(splitSubPane)
            end
            store.setSplitL3AppliedDetail(nil)
            return
        end

        if not sessionService:SessionExists(level2b) then
            return
        end

        local bool2 = bool1 and splitL3AppliedDetail ~= var2
        if not sessionService:SessionExists(splitSubPane) then
            sessionService:SetSession(level2b, splitSubPane, str1)
            writeAppliedDetail()
        elseif sessionTag ~= str1 or bool2 then
            sessionService:ReplaceSession(splitSubPane, str1)
            writeAppliedDetail()
        end
    end
}
