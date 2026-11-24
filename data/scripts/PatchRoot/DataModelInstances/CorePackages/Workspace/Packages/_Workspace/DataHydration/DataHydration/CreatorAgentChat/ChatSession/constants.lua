-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastInt("CreatorAgentChatRpcTimeoutSeconds", 30)
game:DefineFastInt("CreatorAgentChatRtnIdleFallbackSeconds", 10)
game:DefineFastInt("CreatorAgentChatRtnSequenceGapFallbackSeconds", 10)
game:DefineFastInt("CreatorAgentChatPollMinIntervalSeconds", 2)
game:DefineFastInt("CreatorAgentChatPollMaxIntervalSeconds", 30)
game:DefineFastInt("CreatorAgentChatPollBackoffMultiplier", 2)
game:DefineFastInt("CreatorAgentChatMaxReconciliationHistoryPages", 3)
game:DefineFastInt("CreatorAgentChatMaxCachedSessionHistories", 5)
game:DefineFastInt("CreatorAgentChatPrefetchHistoryPagesOnRefresh", 1)

return {
    getRpcTimeoutSeconds = function(): number
        return game:GetFastInt("CreatorAgentChatRpcTimeoutSeconds")
    end,
    getRtnIdleFallbackSeconds = function(): number
        return game:GetFastInt("CreatorAgentChatRtnIdleFallbackSeconds")
    end,
    getRtnSequenceGapFallbackSeconds = function(): number
        return game:GetFastInt("CreatorAgentChatRtnSequenceGapFallbackSeconds")
    end,
    getPollMinIntervalSeconds = function(): number
        return game:GetFastInt("CreatorAgentChatPollMinIntervalSeconds")
    end,
    getPollMaxIntervalSeconds = function(): number
        return game:GetFastInt("CreatorAgentChatPollMaxIntervalSeconds")
    end,
    getPollBackoffMultiplier = function(): number
        return game:GetFastInt("CreatorAgentChatPollBackoffMultiplier")
    end,
    getMaxReconciliationHistoryPages = function(): number
        return game:GetFastInt("CreatorAgentChatMaxReconciliationHistoryPages")
    end,
    getMaxCachedSessionHistories = function(): number
        return game:GetFastInt("CreatorAgentChatMaxCachedSessionHistories")
    end,
    getPrefetchHistoryPagesOnRefresh = function(): number
        return game:GetFastInt("CreatorAgentChatPrefetchHistoryPagesOnRefresh")
    end
}
