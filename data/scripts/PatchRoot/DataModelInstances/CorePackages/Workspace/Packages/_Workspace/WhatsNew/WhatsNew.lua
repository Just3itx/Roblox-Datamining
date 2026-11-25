-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T23:00:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Constants = require(script.Constants)
local Enums = require(script.Enums)
local LoadWhatsNewRegistry = require(script.registry.LoadWhatsNewRegistry)
local ScopeActions = require(script.registry.ScopeActions)
local validateRegistry = require(script.registry.validateRegistry)
local GetWhatsNewStore = require(script.store.GetWhatsNewStore)
local useWhatsNewRuntimeState = require(script.hooks.useWhatsNewRuntimeState)
local WhatsNewAnchor = require(script.components.WhatsNewAnchor)
local WhatsNewScreenHost = require(script.components.WhatsNewScreenHost)
local WhatsNewTourtip = require(script.components.WhatsNewTourtip)
local EntryStorage = require(script.storage.EntryStorage)
local createInGameWhatsNewHost = require(script.createInGameWhatsNewHost)

return {
    ["jest.config"] = script["jest.config"],
    Constants = Constants,
    Enums = Enums,
    scopeActions = ScopeActions,
    Loader = {
        validateRegistry = validateRegistry,
        loadWhatsNewRegistry = LoadWhatsNewRegistry.loadWhatsNewRegistry,
        loadBundledRegistry = LoadWhatsNewRegistry.loadBundledRegistry
    },
    GetWhatsNewStore = GetWhatsNewStore,
    useWhatsNewRuntimeState = useWhatsNewRuntimeState,
    WhatsNewAnchor = WhatsNewAnchor,
    WhatsNewScreenHost = WhatsNewScreenHost,
    WhatsNewTourtip = WhatsNewTourtip,
    EntryStorage = EntryStorage,
    createInGameWhatsNewHost = createInGameWhatsNewHost.createInGameWhatsNewHost
}
