-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T00:19:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TopicInfosRodux = script:FindFirstAncestor("TopicInfosRodux")
local AddTopicInfos = require(TopicInfosRodux.AddTopicInfos)

local TopicInfosRoduxParent = TopicInfosRodux.Parent
local Cryo = require(TopicInfosRoduxParent.Cryo)
local _DiscoveryTypes = require(TopicInfosRoduxParent.DiscoveryTypes)

return {
    key = "TopicInfosKey",
    reducer = function(tbl1, arg1)
        tbl1 = tbl1 or {}
        assert(tbl1, "")

        if arg1.type == AddTopicInfos.name then
            local tbl2 = {}
            for _, topicInfo in arg1.topicInfos do
                tbl2[topicInfo.uniqueKey] = topicInfo
            end
            tbl1 = Cryo.Dictionary.join(tbl1, tbl2)
        end

        return tbl1
    end
}
