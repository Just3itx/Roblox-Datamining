-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local SduiSharedUtilities = require(SduiSharedContentParent.SduiSharedUtilities)
local SduiLoadTimer = SduiSharedUtilities.SduiLoadTimer
local getSduiApiStore = SduiSharedUtilities.getSduiApiStore

local SduiCoreSystem = require(SduiSharedContentParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType

return function(arg1, _, arg2)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.RefreshFromApi,
                message = "Missing actionParams"
            },
            arg2.appPage
        )
        return
    end

    assert(actionParams, "actionParams must exist")
    local configKey = actionParams.configKey
    if typeof(configKey) ~= "string" then
        arg2.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = SduiActionType.RefreshFromApi,
            message = `Invalid or missing configKey: {configKey}`,
            propName = "configKey"
        }, arg2.appPage)
        return
    end

    local surfaceKey = actionParams.surfaceKey
    if typeof(surfaceKey) ~= "string" then
        arg2.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = SduiActionType.RefreshFromApi,
            message = `Invalid or missing surfaceKey: {surfaceKey}`,
            propName = "surfaceKey"
        }, arg2.appPage)
        return
    end

    local loadTimer = SduiLoadTimer.createLoadTimer(surfaceKey)
    loadTimer.start("refresh")
    return getSduiApiStore().refreshFromApi({ configKey = configKey, loadTimer = loadTimer }):finally(function()
        loadTimer.logRefreshComplete()
    end)
end
