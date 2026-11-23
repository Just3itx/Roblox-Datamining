-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T00:19:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TopicInfosRoduxParent = script:FindFirstAncestor("TopicInfosRodux").Parent
local makeActionCreator = require(TopicInfosRoduxParent.Rodux).makeActionCreator
local _DiscoveryTypes = require(TopicInfosRoduxParent.DiscoveryTypes)

return makeActionCreator(script.Name, function(topicInfos)
    return { topicInfos = topicInfos }
end)
