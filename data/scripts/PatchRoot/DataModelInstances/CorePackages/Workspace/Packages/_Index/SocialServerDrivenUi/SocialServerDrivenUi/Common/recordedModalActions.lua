-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialServerDrivenUiParent = script:FindFirstAncestor("SocialServerDrivenUi").Parent

local _AppChatNetworking = require(SocialServerDrivenUiParent.AppChatNetworking)

local ModalAction = { View = "RecordHasSeen", Close = "RecordDontShowAgain" }

local tbl2 = {
    [ModalAction.View] = "record_has_seen",
    [ModalAction.Close] = "record_dont_show_again"
}

return {
    ModalAction = ModalAction,
    toRecordedModalAction = function(arg1)
        return if typeof(arg1) == "string" then tbl2[arg1] else nil
    end
}
