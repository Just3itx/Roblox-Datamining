-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialServerDrivenUiParent = script:FindFirstAncestor("SocialServerDrivenUi").Parent

local navigateToExperienceLeaderboardSeeAll = require(SocialServerDrivenUiParent.Leaderboards).navigateToExperienceLeaderboardSeeAll

local SduiCoreSystem = require(SocialServerDrivenUiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType

return function(arg1, _, arg2, _)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenExperienceLeaderboardSeeAll,
                message = "Missing actionParams"
            },
            arg2.appPage
        )
        return
    end

    local universeId = actionParams.universeId
    if typeof(universeId) ~= "string" or universeId == "" then
        arg2.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = SduiActionType.OpenExperienceLeaderboardSeeAll,
            message = `Invalid or missing universeId: {tostring(universeId)}`,
            propName = "universeId"
        }, arg2.appPage)
        return
    end

    local initialTab = actionParams.initialTab
    if initialTab ~= nil and initialTab ~= "friends" and initialTab ~= "global" then
        arg2.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = SduiActionType.OpenExperienceLeaderboardSeeAll,
            message = `Unrecognized initialTab: {tostring(initialTab)}`,
            propName = "initialTab"
        }, arg2.appPage)
        initialTab = nil
    end

    navigateToExperienceLeaderboardSeeAll(arg2.dependencies.getNavigation(), universeId, initialTab)
end
