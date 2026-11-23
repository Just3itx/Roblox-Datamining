-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
local SuggestionType = require(script.Parent.Types).SuggestionType

return {
    SUGGESTION_TYPES = { SuggestionType.Message, SuggestionType.GameCard, SuggestionType.StartParty },
    MAX_SUGGESTIONS = 4
}
