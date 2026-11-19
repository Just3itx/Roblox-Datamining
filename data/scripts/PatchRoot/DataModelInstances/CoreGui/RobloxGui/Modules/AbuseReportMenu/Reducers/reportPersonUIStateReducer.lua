-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")

local Constants = require(AbuseReportMenu.Components.Constants)
local _Types = require(AbuseReportMenu.Components.Types)
local PlayerMenuActions = Constants.PlayerMenuActions

local function reportPersonUIStateReducer(arg1, arg2)
    local var1 = table.clone(arg1)
    local type = arg2.type
    if type == PlayerMenuActions.UpdateAbuseReason then
        var1.abuseReason = arg2.abuseReason
        return var1
    end

    if type == PlayerMenuActions.UpdateComment then
        var1.comment = arg2.comment
        return var1
    end

    if type == PlayerMenuActions.UpdateMethodOfAbuse then
        var1.playerObjects = {}
        var1.abuseReason = nil
        var1.methodOfAbuse = arg2.methodOfAbuse
        return var1
    end

    if type == PlayerMenuActions.UpdateAbuser then
        var1.allegedAbuserId = arg2.abuseId
        var1.allegedAbuser = arg2.abuser
        return var1
    end

    if type == PlayerMenuActions.UpdatePlayerNameMap then
        var1.playerObjects = arg2.playerObjects
        return var1
    end

    if type == PlayerMenuActions.SetVoiceEnabled then
        var1.isVoiceEnabled = arg2.enabled
        return var1
    end

    if type == PlayerMenuActions.SetMenuOpenTimestamp then
        var1.menuOpenedUnixTimestampMilliseconds = arg2.timestamp
        return var1
    end

    if type == PlayerMenuActions.ClearState then
        return (table.clone(Constants.InitPersonUIState))
    end

    if type ~= PlayerMenuActions.SetShowModalSelector then
        if type == PlayerMenuActions.SetPreselectedPlayer then
            var1.preselectedPlayer = arg2.player
        end
        return var1
    end

    var1.isModalSelectorShown = arg2.isShown
    var1.modalSelectorCellData = arg2.cellData
    return var1
end

return reportPersonUIStateReducer
