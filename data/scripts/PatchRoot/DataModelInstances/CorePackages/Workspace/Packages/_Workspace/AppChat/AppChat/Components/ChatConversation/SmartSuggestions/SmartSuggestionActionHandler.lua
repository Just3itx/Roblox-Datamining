-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:41:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SuggestionType = require(script.Parent.Types).SuggestionType

return {
    createSmartSuggestionActionHandler = function(tbl1)
        local tbl2 = {}
        tbl2[SuggestionType.Message] = function(arg1, str1: string)
            return tbl1.sendMessage(str1, arg1.message.text)
        end
        tbl2[SuggestionType.GameCard] = function(arg1, str1: string)
            return tbl1.sendGameLinkChatMessage(str1, arg1.game_card.universe_id)
        end
        tbl2[SuggestionType.StartParty] = function(_, str1: string)
            return tbl1.startParty(str1)
        end

        return function(arg1, str1: string)
            local var1 = tbl2[arg1.type]
            if not var1 then
                local error = error
                local type = arg1.type
                error(`SmartSuggestionActionHandler: unknown suggestion type "{tostring(type)}"`)
            end
            return var1(arg1, str1)
        end
    end
}
