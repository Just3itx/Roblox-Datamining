-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T23:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local WhatsNew = script:FindFirstAncestor("WhatsNew")

local _Types = require(WhatsNew.Types)
local GetWhatsNewStore = require(WhatsNew.store.GetWhatsNewStore)
local LoadWhatsNewRegistry = require(WhatsNew.registry.LoadWhatsNewRegistry)
local _ScopeActions = require(WhatsNew.registry.ScopeActions)
local createResolveDeps = require(WhatsNew.storage.createResolveDeps)

local bool1 = false

return {
    ensureWhatsNewStoreInitialized = function(tbl1)
        if bool1 then
            return
        end

        local var1 = tbl1.deps or createResolveDeps.createResolveDeps()

        local rootTourMap = LoadWhatsNewRegistry.loadBundledRegistry(var1, { scopeActions = tbl1.scopeActions })

        GetWhatsNewStore().initialize({ rootTourMap = rootTourMap, scopeActions = tbl1.scopeActions })

        bool1 = true
    end,
    resetForTests = function()
        bool1 = false
        GetWhatsNewStore().resetForTests()
    end
}
