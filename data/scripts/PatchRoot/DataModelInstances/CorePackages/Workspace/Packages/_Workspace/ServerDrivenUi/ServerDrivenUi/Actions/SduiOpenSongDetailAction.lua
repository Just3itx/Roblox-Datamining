-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:01:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local OpenSongDetail = require(ServerDrivenUiParent.DiscoveryRouting).OpenSongDetail
local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType

return function(arg1, _, arg2, _)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenSongDetail,
                message = "Missing actionParams"
            },
            arg2.appPage
        )
        return
    end

    assert(actionParams, "actionParams must exist")
    local songId = actionParams.songId
    if typeof(songId) == "string" and songId ~= "" then
        arg2.dependencies.dispatch(OpenSongDetail(songId))
        return
    end

    arg2.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
        name = SduiActionType.OpenSongDetail,
        message = `Invalid or missing songId: {songId}`,
        propName = "songId"
    }, arg2.appPage)
end
