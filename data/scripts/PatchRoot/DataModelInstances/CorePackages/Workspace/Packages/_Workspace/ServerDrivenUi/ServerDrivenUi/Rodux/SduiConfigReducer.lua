-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:40:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent
local ArgCheck = require(ServerDrivenUiParent.ArgCheck)
local Cryo = require(ServerDrivenUiParent.Cryo)

local AddSduiRootConfig = require(ServerDrivenUi.Rodux.AddSduiRootConfig)
local RemoveSduiRootConfig = require(ServerDrivenUi.Rodux.RemoveSduiRootConfig)

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiErrors = SduiCoreSystem.SduiErrors
local SduiLogger = SduiCoreSystem.SduiLogger
local getItemCollectionKey = require(ServerDrivenUi.DataStore.getItemCollectionKey)

return {
    key = "SduiConfigKey",
    reducer = function(tbl1, arg1)
        tbl1 = tbl1 or {}
        assert(tbl1, "state must exist")

        ArgCheck.assert(typeof(tbl1) == "table", "state must be a table")

        if arg1.type ~= AddSduiRootConfig.name then
            if arg1.type == RemoveSduiRootConfig.name then
                local feedStoreKey = arg1.feedStoreKey
                if tbl1[feedStoreKey] then
                    tbl1 = Cryo.Dictionary.omit(tbl1, feedStoreKey)
                end
            end

            return tbl1
        end

        local var1 = arg1.customFeedStoreKey or arg1.page

        local var2 = tbl1[var1]
        local itemCollections = var2 and var2.itemCollections or {}
        local tbl2 = {
            rootConfig = arg1.rootConfig,
            dataUpdatedTimestamp = arg1.dataUpdatedTimestamp,
            itemCollections = itemCollections
        }

        local var4 = arg1.rootConfig.feed or arg1.rootConfig or nil
        if typeof(var4) ~= "table" then
            SduiLogger.reportError(
                SduiErrors.SduiErrorType.InvalidFeedInResponse,
                {
                    message = `Invalid sdui.feed in response of type {typeof(var4)}`
                },
                arg1.page
            )
            return tbl1
        end

        local feedItems = var4.props and var4.props.feedItems or nil
        if feedItems then
            for _, sduiConfig in feedItems do
                local feedItemKey = sduiConfig.feedItemKey

                if feedItemKey then
                    if tbl2.itemCollections[feedItemKey] ~= nil then
                        SduiLogger.reportError(
                            SduiErrors.SduiErrorType.DuplicateFeedItemKey,
                            {
                                message = `Multiple item collections with same feedItemKey {feedItemKey}`
                            },
                            arg1.page
                        )
                    end
                    if arg1.expectedSduiFeedItems then
                        local topicId = nil
                        local sortIndex = nil
                        for _, expectedSduiFeedItem in arg1.expectedSduiFeedItems do
                            if expectedSduiFeedItem.feedItemKey == feedItemKey then
                                topicId = expectedSduiFeedItem.topicId
                                sortIndex = expectedSduiFeedItem.sortIndex
                                break
                            end
                        end

                        if topicId == nil or sortIndex == nil then
                            SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToFindCollectionId, {
                                message = `Missing topicId or sortIndex for {feedItemKey} in ConfigReducer. sortIndex = {sortIndex} topicId = {topicId}`
                            }, arg1.page)
                        end
                        local itemCollectionKey = getItemCollectionKey(topicId, sortIndex)
                        local itemCollections = tbl2.itemCollections
                        itemCollections[itemCollectionKey] = {
                            sduiConfig = sduiConfig,
                            dataUpdatedTimestamp = arg1.dataUpdatedTimestamp,
                            topicId = topicId,
                            sortIndex = sortIndex
                        }
                    else
                        local itemCollections = tbl2.itemCollections
                        itemCollections[feedItemKey] = {
                            sduiConfig = sduiConfig,
                            dataUpdatedTimestamp = arg1.dataUpdatedTimestamp
                        }
                    end
                else
                    SduiLogger.reportError(
                        SduiErrors.SduiErrorType.NilFeedItemKey,
                        { message = "Missing feedItemKey for itemCollection in ConfigReducer" },
                        arg1.page
                    )
                end
            end
        end
        if arg1.expectedSduiFeedItems then
            for _, expectedSduiFeedItem in arg1.expectedSduiFeedItems do
                local itemCollectionKey = getItemCollectionKey(expectedSduiFeedItem.topicId, expectedSduiFeedItem.sortIndex)

                if tbl2.itemCollections[itemCollectionKey] == nil then
                    SduiLogger.reportError(SduiErrors.SduiErrorType.NilItemCollection, {
                        message = `Missing item collection data for an sdui feed item for topic: {expectedSduiFeedItem.topicId} sortIndex: {expectedSduiFeedItem.sortIndex}`,
                        name = expectedSduiFeedItem.topicId
                    }, arg1.page)
                end
            end
        end
        return (Cryo.Dictionary.union(tbl1, { [var1] = tbl2 }))
    end
}
