-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")

local HttpService = game:GetService("HttpService")

local SquadPromptType = require(SquadsCore.Enums.SquadPromptType)

return function(tbl1)
    return function(arg1)
        arg1:dispatch(tbl1.squadContext.createConversation(tbl1.conversationType, tbl1.userIds, nil, tbl1.source)):andThen(
            function(arg2)
                if tbl1.onSuccessCallback then
                    tbl1.onSuccessCallback(arg2.id)
                end
            end
        ):catch(
            function(arg2)
                local success, result = pcall(function()
                    return HttpService:JSONDecode(arg2.Body)
                end)

                tbl1.squadContext.setSquadPrompt(arg1, {
                    hideCancelButton = true,
                    promptType = if success and result and result.reason_code == "participant_chat_disabled" then SquadPromptType.ParticipantChatDisabled else SquadPromptType.Error
                })

                if tbl1.onErrorCallback then
                    tbl1.onErrorCallback()
                end
            end
        )
    end
end
