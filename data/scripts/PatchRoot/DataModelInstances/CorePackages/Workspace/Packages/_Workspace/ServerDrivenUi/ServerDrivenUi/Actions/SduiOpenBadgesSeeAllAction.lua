-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local IXPService = game:GetService("IXPService")
local ServerDrivenUiParent = ServerDrivenUi.Parent

local navigateToBadgesSeeAll = require(ServerDrivenUiParent.Badges).navigateToBadgesSeeAll

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType

local FFlagLuaAppBadgesSeeAllLogExposure = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppBadgesSeeAllLogExposure
local FStringLuaAppBadgesSeeAllIxpLayer = require(ServerDrivenUiParent.SharedFlags).FStringLuaAppBadgesSeeAllIxpLayer

return function(arg1, _, arg2, _)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenBadgesSeeAll,
                message = "Missing actionParams"
            },
            arg2.appPage
        )
        return
    end

    local universeId = actionParams.universeId
    if typeof(universeId) ~= "string" or universeId == "" then
        arg2.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = SduiActionType.OpenBadgesSeeAll,
            message = `Invalid or missing universeId: {tostring(universeId)}`,
            propName = "universeId"
        }, arg2.appPage)
        return
    end

    if FFlagLuaAppBadgesSeeAllLogExposure then
        IXPService:LogFlagLinkedUserLayerExposure(FStringLuaAppBadgesSeeAllIxpLayer)
    end

    navigateToBadgesSeeAll(arg2.dependencies.getNavigation(), universeId)
end
