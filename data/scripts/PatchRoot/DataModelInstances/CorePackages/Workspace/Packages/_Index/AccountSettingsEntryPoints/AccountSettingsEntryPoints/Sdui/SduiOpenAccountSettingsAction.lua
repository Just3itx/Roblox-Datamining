-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountSettingsEntryPoints = script:FindFirstAncestor("AccountSettingsEntryPoints")
local AccountSettingsEntryPointsParent = AccountSettingsEntryPoints.Parent

local SduiCoreSystem = require(AccountSettingsEntryPointsParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType

local AccountSettingsPage = require(AccountSettingsEntryPoints.AccountSettingsPage)
local openAccountSettings = require(AccountSettingsEntryPoints.openAccountSettings)

local PersonalizedRecommendations = AccountSettingsPage.PersonalizedRecommendations

local function SduiOpenAccountSettingsAction(arg1, _, arg2, _)
    local actionParams = arg1 and arg1.actionParams
    local surfaceKey = actionParams and actionParams.surfaceKey
    if typeof(surfaceKey) ~= "string" or string.match(surfaceKey, "^%s*$") then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenAccountSettings,
                message = `Missing or invalid surfaceKey {surfaceKey}`
            },
            arg2.appPage
        )
        return
    end

    openAccountSettings(PersonalizedRecommendations, { surfaceKey = surfaceKey })
end

return SduiOpenAccountSettingsAction
