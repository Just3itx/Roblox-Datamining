-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExperienceStoreServerDrivenUi = script:FindFirstAncestor("ExperienceStoreServerDrivenUi")
local ExperienceStoreServerDrivenUiParent = ExperienceStoreServerDrivenUi.Parent

local SduiCoreSystem = require(ExperienceStoreServerDrivenUiParent.SduiCoreSystem)
local getSduiComponentRegistry = SduiCoreSystem.getSduiComponentRegistry
local SduiComponentType = SduiCoreSystem.SduiComponentType

local FFlagSduiGameItemsComponent = require(ExperienceStoreServerDrivenUiParent.SharedFlags).FFlagSduiGameItemsComponent
local FFlagSduiLocalFeedFilter = require(ExperienceStoreServerDrivenUiParent.SharedFlags).FFlagSduiLocalFeedFilter

local function registerExperienceStoreComponents()
    local tbl1 = {
        [SduiComponentType.PillTabsCarousel] = FFlagSduiLocalFeedFilter and {
            getLazyComponent = function()
                return require(ExperienceStoreServerDrivenUi.Components.SduiPillTabsCarousel)
            end
        } or nil,
        [SduiComponentType.VirtualGameItemText] = FFlagSduiGameItemsComponent and {
            getLazyComponent = function()
                return require(ExperienceStoreServerDrivenUi.Components.SduiVirtualGameItemText)
            end
        } or nil
    }

    getSduiComponentRegistry().registerComponentDefinitions(tbl1)
end

return registerExperienceStoreComponents
