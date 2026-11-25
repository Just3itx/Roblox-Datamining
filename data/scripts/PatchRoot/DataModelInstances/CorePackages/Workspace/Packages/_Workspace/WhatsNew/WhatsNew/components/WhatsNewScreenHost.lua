-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T23:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local WhatsNew = script:FindFirstAncestor("WhatsNew")
local WhatsNewParent = WhatsNew.Parent

local React = require(WhatsNewParent.React)
local GetWhatsNewStore = require(WhatsNew.store.GetWhatsNewStore)
local ensureWhatsNewStoreInitialized = require(WhatsNew.store.ensureWhatsNewStoreInitialized)
local _ScopeActions = require(WhatsNew.registry.ScopeActions)
local WhatsNewTourtip = require(script.Parent.WhatsNewTourtip)

return React.memo(function(tbl1) -- name: WhatsNewScreenHost
    local screenScopeId = tbl1.screenScopeId
    local scopeActions = tbl1.scopeActions
    local bool1 = tbl1.isEnabled == true
    local onReady = tbl1.onReady
    local whatsNewStore = GetWhatsNewStore()

    React.useEffect(function()
        if not bool1 then
            whatsNewStore.stopTour()
            return
        end

        ensureWhatsNewStoreInitialized.ensureWhatsNewStoreInitialized({ scopeActions = scopeActions })

        if onReady ~= nil then
            onReady()
        end

        whatsNewStore.startEligibleTour(screenScopeId)

        return function()
            whatsNewStore.stopTour()
        end
    end, {
        bool1,
        onReady,
        screenScopeId,
        scopeActions,
        whatsNewStore
    })
    return React.createElement(
        React.Fragment,
        nil,
        {
            Children = React.createElement(React.Fragment, nil, tbl1.children),
            Tooltip = React.createElement(WhatsNewTourtip)
        }
    )
end)
