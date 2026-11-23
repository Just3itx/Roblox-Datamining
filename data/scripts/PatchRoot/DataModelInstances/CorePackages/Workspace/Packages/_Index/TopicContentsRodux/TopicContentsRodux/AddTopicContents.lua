-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T00:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TopicContentsRoduxParent = script:FindFirstAncestor("TopicContentsRodux").Parent
local makeActionCreator = require(TopicContentsRoduxParent.Rodux).makeActionCreator
local _DiscoveryTypes = require(TopicContentsRoduxParent.DiscoveryTypes)

return makeActionCreator(script.Name, function(topicKey: string, topicContents, isAppend: boolean?)
    return { topicKey = topicKey, topicContents = topicContents, isAppend = isAppend }
end)
