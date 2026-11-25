-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VoiceChatParent = script:FindFirstAncestor("VoiceChat").Parent
local AppPage = require(VoiceChatParent.RobloxAppEnums).AppPage
local NavigateDown = require(VoiceChatParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(VoiceChatParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(VoiceChatParent.RobloxAppNavigation).NavigationCommands else nil

return function(detail: string)
    return function(arg1)
        local tbl1 = {
            name = AppPage.AgeVerificationRequired,
            detail = detail
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
            return
        end
        arg1:dispatch(NavigateDown(tbl1))
    end
end
