-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheetParent = script:FindFirstAncestor("InExperienceSideSheet").Parent

local _Chrome = require(InExperienceSideSheetParent.Chrome)
local Signals = require(InExperienceSideSheetParent.Signals)

local function createIntegrationsStore()
    local getUnibarIntegrations, setUnibarIntegrations = Signals.createSignal({})
    local getAboveFoldIntegrations, setAboveFoldIntegrations = Signals.createSignal({})
    local getBelowFoldIntegrations, setBelowFoldIntegrations = Signals.createSignal({})

    local getSessionActionIntegrations, setSessionActionIntegrations = Signals.createSignal({})

    local getScrollableContentTopWidgetIntegrations, setScrollableContentTopWidgetIntegrations = Signals.createSignal({})

    local getScrollableContentBottomWidgetIntegrations, setScrollableContentBottomWidgetIntegrations = Signals.createSignal({})

    return {
        getUnibarIntegrations = getUnibarIntegrations,
        setUnibarIntegrations = setUnibarIntegrations,
        getAboveFoldIntegrations = getAboveFoldIntegrations,
        setAboveFoldIntegrations = setAboveFoldIntegrations,
        getBelowFoldIntegrations = getBelowFoldIntegrations,
        setBelowFoldIntegrations = setBelowFoldIntegrations,
        getSessionActionIntegrations = getSessionActionIntegrations,
        setSessionActionIntegrations = setSessionActionIntegrations,
        getScrollableContentTopWidgetIntegrations = getScrollableContentTopWidgetIntegrations,
        setScrollableContentTopWidgetIntegrations = setScrollableContentTopWidgetIntegrations,
        getScrollableContentBottomWidgetIntegrations = getScrollableContentBottomWidgetIntegrations,
        setScrollableContentBottomWidgetIntegrations = setScrollableContentBottomWidgetIntegrations
    }
end

return createIntegrationsStore
