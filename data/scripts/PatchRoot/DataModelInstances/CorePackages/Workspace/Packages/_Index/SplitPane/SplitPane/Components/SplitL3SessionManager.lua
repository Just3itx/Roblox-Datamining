-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:21:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local React = require(SplitPaneParent.React)
local RoactServices = require(SplitPaneParent.RoactServices).RoactServices
local AppSessionService = require(SplitPaneParent.RoactServiceTags).AppSessionService
local SignalsReact = require(SplitPaneParent.SignalsReact)
local SplitL3SessionHelper = require(script.Parent.Parent.Utils.SplitL3SessionHelper)
local SplitL3Store = require(script.Parent.Parent.Stores.SplitL3Store)
local SplitPaneStore = require(script.Parent.Parent.Stores.SplitPaneStore)
local SplitPaneContext = require(script.Parent.Parent.Context.SplitPaneContext)

local function SplitL3SessionManagerActive(arg1)
    local store = SplitL3Store.getStore()
    local var1 = SignalsReact.useSignalState(store.getSplitL2SessionVersion)
    local var2 = SignalsReact.useSignalState(store.getPendingSplitSubPaneTag)
    local var3 = SignalsReact.useSignalState(store.getPendingSplitSubPaneDetail)
    local sessionService = arg1.sessionService

    React.useLayoutEffect(function()
        if sessionService == nil then
            return
        end
        SplitL3SessionHelper.applySplitSubPaneSession(sessionService, var2, var3)
    end, {
        var1,
        var2,
        var3,
        sessionService
    })
    React.useEffect(function()
        if sessionService == nil or sessionService.SessionChangedSignal == nil then
            return
        end

        local connection = sessionService.SessionChangedSignal:connect(function()
            local store2 = SplitL3Store.getStore()
            SplitL3SessionHelper.applySplitSubPaneSession(
                sessionService,
                store2.getPendingSplitSubPaneTag(false),
                store2.getPendingSplitSubPaneDetail(false)
            )
        end)
        return function()
            connection:disconnect()
            SplitL3SessionHelper.applySplitSubPaneSession(sessionService, nil)
        end
    end, { sessionService })

    return nil
end

return RoactServices.connect({ sessionService = AppSessionService })(function(arg1) -- name: SplitL3SessionManager
    local sessionService = arg1.sessionService
    local var1 = SignalsReact.useSignalState(SplitPaneStore.getStore().getIsBreakpointEnabled)
    local resolveEligibility = React.useContext(SplitPaneContext).resolveEligibility

    React.useLayoutEffect(function()
        if not var1 and sessionService ~= nil then
            SplitL3SessionHelper.applySplitSubPaneSession(sessionService, nil)
        end
    end, { var1, sessionService })

    React.useLayoutEffect(function()
        if arg1.connectRouteSignal ~= nil then
            return SplitL3SessionHelper.subscribeToRouteSignal(arg1.connectRouteSignal, resolveEligibility)
        end
    end, { arg1.connectRouteSignal, resolveEligibility })

    if not var1 then
        return nil
    end

    return React.createElement(SplitL3SessionManagerActive, { sessionService = sessionService })
end)
