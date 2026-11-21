-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExperienceStoreServerDrivenUi = script:FindFirstAncestor("ExperienceStoreServerDrivenUi")
local ExperienceStoreServerDrivenUiParent = ExperienceStoreServerDrivenUi.Parent

local FFlagSduiDevStoreSeeAllSupport = require(ExperienceStoreServerDrivenUiParent.SharedFlags).FFlagSduiDevStoreSeeAllSupport

local SduiCoreSystem = require(ExperienceStoreServerDrivenUiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local getSduiActionHandlerRegistry = SduiCoreSystem.getSduiActionHandlerRegistry

local function registerExperienceStoreActions()
    local tbl1 = {
        [SduiActionType.RefreshDeveloperProducts] = FFlagSduiDevStoreSeeAllSupport and {
            lazyHandler = function()
                return require(ExperienceStoreServerDrivenUi.Actions.SduiRefreshDeveloperProductsAction)
            end
        } or nil
    }

    getSduiActionHandlerRegistry().registerActionHandlerConfigs(tbl1)
end

return registerExperienceStoreActions
