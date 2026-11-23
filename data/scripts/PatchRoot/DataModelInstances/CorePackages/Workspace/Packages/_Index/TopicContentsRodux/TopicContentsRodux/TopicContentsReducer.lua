-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T00:11:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TopicContentsRodux = script:FindFirstAncestor("TopicContentsRodux")
local TopicContentsModel = require(TopicContentsRodux.TopicContentsModel)
local AddTopicContents = require(TopicContentsRodux.AddTopicContents)

local TopicContentsRoduxParent = TopicContentsRodux.Parent
local Cryo = require(TopicContentsRoduxParent.Cryo)
local AddTopicInfos = require(TopicContentsRoduxParent.TopicInfosRodux).AddTopicInfos
local _DiscoveryTypes = require(TopicContentsRoduxParent.DiscoveryTypes)

return {
    key = "TopicContentsKey",
    reducer = function(arg1, arg2)
        local var1 = arg1 or {}

        if arg2.type == AddTopicInfos.name then
            local tbl1 = {}
            for _, topicInfo in pairs(arg2.topicInfos) do
                tbl1[topicInfo.uniqueKey] = var1[topicInfo.uniqueKey] or TopicContentsModel.new()
            end
            return (Cryo.Dictionary.join(var1, tbl1))
        end

        if arg2.type == AddTopicContents.name then
            local topicContents = arg2.topicContents
            local var2 = var1[arg2.topicKey]
            if var2 ~= nil then
                if arg2.isAppend then
                    topicContents.entries = Cryo.List.join(var2.entries, topicContents.entries)
                end

                if topicContents.updatedTimestamp == nil then
                    topicContents.updatedTimestamp = var2.updatedTimestamp
                end
            end

            if topicContents.updatedTimestamp == nil then
                topicContents.updatedTimestamp = tick()
            end

            var1 = Cryo.Dictionary.join(var1, { [arg2.topicKey] = topicContents })
        end

        return var1
    end
}
