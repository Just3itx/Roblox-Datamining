-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountSettingsEntryPoints = script:FindFirstAncestor("AccountSettingsEntryPoints")
local AccountSettingsEntryPointsParent = AccountSettingsEntryPoints.Parent

local SduiCoreSystem = require(AccountSettingsEntryPointsParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local getSduiActionHandlerRegistry = SduiCoreSystem.getSduiActionHandlerRegistry

local function registerAccountSettingsEntryPointsActions()
    local tbl1 = {
        [SduiActionType.OpenAccountSettings] = {
            lazyHandler = function()
                return require(AccountSettingsEntryPoints.Sdui.SduiOpenAccountSettingsAction)
            end,
            skipUnifiedLogging = false
        }
    }

    getSduiActionHandlerRegistry().registerActionHandlerConfigs(tbl1)
end

return registerAccountSettingsEntryPointsActions
