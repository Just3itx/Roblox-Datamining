-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsParent = script:FindFirstAncestor("Squads").Parent

local HttpService = game:GetService("HttpService")

local SquadPromptType = require(SquadsParent.SquadsCore.Enums).SquadPromptType

return function(tbl1)
    return function(arg1)
        return tbl1.squadExternalContext.inviteToParentChannel(tbl1.dispatch, tbl1.parentChannel, tbl1.userIds):andThen(function(arg2)
            if tbl1.onSuccessCallback then
                tbl1.onSuccessCallback(arg2)
            end
        end):catch(
            function(arg2)
                local success, result = pcall(function()
                    return HttpService:JSONDecode(arg2.Body)
                end)

                tbl1.squadExternalContext.setSquadPrompt(arg1, {
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
