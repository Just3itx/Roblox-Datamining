-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent

local AppPage = require(scriptParentParent.RobloxAppEnums).AppPage

local SharedFlags = require(scriptParentParent.SharedFlags)
local FFlagAppIaHomeSubTab = SharedFlags.FFlagAppIaHomeSubTab
local FFlagAppIaHomeCampaignSubTab = SharedFlags.FFlagAppIaHomeCampaignSubTab
local FFlagEnableIsChartsInSubTab = SharedFlags.FFlagEnableIsChartsInSubTab
local FlyoutSidePanelIXP = require(scriptParentParent.SharedExperimentDefinition).FlyoutSidePanelIXP

local tbl1 = {
    STUDIO_CTA_EVENT_CONTEXT = "StudioCTA",
    STUDIO_CTA_EVENT_NAME_OPEN = "OpenStudioCreatePage",
    STUDIO_CTA_EVENT_NAME_MOUNT = "MountStudioButton",
    HOME_CONTAINER_SUB_TAB_PAGES = FFlagAppIaHomeSubTab and { AppPage.Home, AppPage.Games } or nil
}
if FFlagEnableIsChartsInSubTab and FFlagAppIaHomeSubTab and not FlyoutSidePanelIXP.isChartsInSubTab() then
    table.remove(tbl1.HOME_CONTAINER_SUB_TAB_PAGES, 2)
end
if FFlagAppIaHomeCampaignSubTab and FFlagAppIaHomeSubTab then
    table.insert(tbl1.HOME_CONTAINER_SUB_TAB_PAGES, AppPage.Campaign)
end

return tbl1
