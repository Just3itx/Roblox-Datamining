-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IXPService = game:GetService("IXPService")

local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType

local FFlagPinShortcutEnableOnCompleteCallback = require(ServerDrivenUiParent.SharedFlags).FFlagPinShortcutEnableOnCompleteCallback
local FFlagEdpPinnedShortcutsLogExposure = require(ServerDrivenUiParent.SharedFlags).FFlagEdpPinnedShortcutsLogExposure
local FStringEdpPinnedShortcutsIxpLayer = require(ServerDrivenUiParent.SharedFlags).FStringEdpPinnedShortcutsIxpLayer
local pinExperienceAndNotify = require(ServerDrivenUiParent.PinShortcut).pinExperienceAndNotify

local PinExperienceShortcut = SduiActionType.PinExperienceShortcut

local function isPinShortcutServiceEnabled(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return game:GetEngineFeature("PinShortcutServiceEnabled")
end

local function SduiPinShortcutAction(arg1, _, arg2, _)
    local actionParams = if arg1 then arg1.actionParams else nil

    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            { name = PinExperienceShortcut, message = "Missing actionParams" },
            arg2.appPage
        )
        return
    end

    local var1 = tonumber(actionParams.placeId)
    if var1 == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            { name = PinExperienceShortcut, message = "Missing placeId", propName = "placeId" },
            arg2.appPage
        )
        return
    end

    local num1 = tonumber(actionParams.universeId) or 0
    local gameName = actionParams.gameName or ""

    if not isPinShortcutServiceEnabled() then
        return
    end

    if FFlagEdpPinnedShortcutsLogExposure and game:GetEngineFeature("EnableLogFlagLinkedUserLayerExposure") then
        pcall(function()
            IXPService:LogFlagLinkedUserLayerExposure(FStringEdpPinnedShortcutsIxpLayer)
        end)
    end

    task.spawn(function()
        if FFlagPinShortcutEnableOnCompleteCallback then
            local success, result = pcall(function()
                pinExperienceAndNotify(var1, num1, gameName, arg2.dependencies.dispatch)
            end)
            if not success then
                arg2.dependencies.logger.reportError(
                    SduiErrorType.FailedToExecuteAction,
                    {
                        name = PinExperienceShortcut,
                        message = tostring(result)
                    },
                    arg2.appPage
                )
            end

            return
        end

        local success, result = pcall(game.GetService, game, "PinShortcutService")
        if not success or result == nil then
            arg2.dependencies.logger.reportError(
                SduiErrorType.FailedToExecuteAction,
                { name = PinExperienceShortcut, message = "PinShortcutService unavailable" },
                arg2.appPage
            )
            return
        end
        local success2, result2 = pcall(function()
            result:PinExperience(var1, num1, gameName)
        end)
        if not success2 then
            arg2.dependencies.logger.reportError(
                SduiErrorType.FailedToExecuteAction,
                {
                    name = PinExperienceShortcut,
                    message = tostring(result2)
                },
                arg2.appPage
            )
        end
    end)
end

return SduiPinShortcutAction
