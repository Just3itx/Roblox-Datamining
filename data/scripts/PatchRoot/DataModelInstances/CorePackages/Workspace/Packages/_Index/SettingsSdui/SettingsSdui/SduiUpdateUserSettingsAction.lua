-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SettingsSduiParent = script:FindFirstAncestor("SettingsSdui").Parent
local updateUserSettings = require(SettingsSduiParent.LegallySensitiveContent).updateUserSettings

local LinkingProtocol = require(SettingsSduiParent.LinkingProtocol)
local LinkingProtocol2 = LinkingProtocol.LinkingProtocol
local AdConsentAttributionAdapter = LinkingProtocol.AdConsentAttributionAdapter
local readCachedAdConsentRegion = LinkingProtocol.readCachedAdConsentRegion
local SharedFlags = require(SettingsSduiParent.SharedFlags)
local FFlagEnableAdConsentUserSettingsPublish = SharedFlags.FFlagEnableAdConsentUserSettingsPublish
local FFlagAdConsentForwardCachedRegion = SharedFlags.FFlagAdConsentForwardCachedRegion

local SduiCoreSystem = require(SettingsSduiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType

return function(arg1, _, arg2, _)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.UpdateUserSettings,
                message = "Missing actionParams"
            },
            arg2.appPage
        )
        return
    end
    assert(actionParams, "actionParams must exist")

    local settings = actionParams.settings
    if typeof(settings) ~= "table" or next(settings) == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.UpdateUserSettings,
                message = `Invalid settings {settings}`
            },
            arg2.appPage
        )
        return
    end

    local auditData = actionParams.auditData
    if auditData ~= nil and typeof(auditData) ~= "string" then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.UpdateUserSettings,
                message = `Invalid auditData {auditData}`
            },
            arg2.appPage
        )
        return
    end

    local success, result = pcall(function()
        local var1 = updateUserSettings(settings, auditData)
        if FFlagEnableAdConsentUserSettingsPublish then
            var1 = var1:andThen(function()
                local allowSellShareData = settings.allowSellShareData
                if allowSellShareData ~= nil then
                    local var2 = if FFlagAdConsentForwardCachedRegion then readCachedAdConsentRegion() else nil

                    AdConsentAttributionAdapter.resolveAndPublish(LinkingProtocol2.default, "ConsentChanged", function()
                        return allowSellShareData
                    end, var2)
                end
            end)
        end

        var1:catch(function(arg3)
            arg2.dependencies.logger.reportError(
                SduiErrorType.FailedToExecuteAction,
                {
                    name = SduiActionType.UpdateUserSettings,
                    message = tostring(arg3)
                },
                arg2.appPage
            )
        end)
    end)

    if success then
        return
    end

    arg2.dependencies.logger.reportError(
        SduiErrorType.FailedToExecuteAction,
        {
            name = SduiActionType.UpdateUserSettings,
            message = tostring(result)
        },
        arg2.appPage
    )
end
