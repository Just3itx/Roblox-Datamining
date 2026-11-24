-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericChallenges = script:FindFirstAncestor("GenericChallenges")

local _ChallengeMetadata = require(GenericChallenges.Types.ChallengeMetadata)

return {
    getPrompt = function(arg1): string?
        local promptUser = arg1.promptUser
        local prompt = if typeof(promptUser) == "table" then promptUser.prompt else nil
        return if typeof(prompt) == "string" then prompt else nil
    end,
    DeniedReason = { PromptUser = "DENIED_REASON_PROMPT_USER" },
    DeniedPrompt = {
        WasmGameJoinRedirect = "DENIED_PROMPT_WASM_GAME_JOIN_REDIRECT",
        WasmInExpDeny = "DENIED_PROMPT_WASM_IN_EXP_DENY"
    }
}
