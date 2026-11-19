-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T15:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagDataHydrationAccountReset = require(script.Parent.FFlagDataHydrationAccountReset)
local FFlagProfileInsightsKeyByRankingStrategy = require(script.Parent.FFlagProfileInsightsKeyByRankingStrategy)

return game:DefineFastFlag("TrustedFriendCandidatesSection", false)
    and FFlagDataHydrationAccountReset
    and FFlagProfileInsightsKeyByRankingStrategy
