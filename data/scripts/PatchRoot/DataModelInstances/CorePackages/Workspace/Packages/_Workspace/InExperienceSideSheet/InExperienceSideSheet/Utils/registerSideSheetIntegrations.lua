-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")

local InExperienceSideSheetParent = InExperienceSideSheet.Parent

local _Chrome = require(InExperienceSideSheetParent.Chrome)

local GetIntegrationsStore = require(InExperienceSideSheet.Stores.GetIntegrationsStore)

return function(tbl1)
    local integrationsStore = GetIntegrationsStore()

    integrationsStore.setUnibarIntegrations(tbl1.unibarIntegrations)
    integrationsStore.setAboveFoldIntegrations(tbl1.aboveFoldIntegrations)
    integrationsStore.setBelowFoldIntegrations(tbl1.belowFoldIntegrations)
    integrationsStore.setSessionActionIntegrations(tbl1.sessionActionIntegrations)
    integrationsStore.setScrollableContentTopWidgetIntegrations(tbl1.scrollableContentTopWidgetIntegrations)
    integrationsStore.setScrollableContentBottomWidgetIntegrations(tbl1.scrollableContentBottomWidgetIntegrations)
end
