-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:31:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent
local React = require(ServerDrivenUiParent.React)
local SignalsReact = require(ServerDrivenUiParent.SignalsReact)

local useSduiContext = require(ServerDrivenUi.System.useSduiContext)
local getSduiFeedStore = require(ServerDrivenUi.DataStore.getSduiFeedStore)
local processCollectionConfig = require(ServerDrivenUi.System.processCollectionConfig)
local getItemCollectionKey = require(ServerDrivenUi.DataStore.getItemCollectionKey)

local _SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)

local function useSduiContextFromSignalAndProcessConfigs(str1: string, appPage: string, bool1: boolean?)
    local var1 = React.useMemo(function()
        return function(arg1)
            if not bool1 then
                return {}
            end

            local sduiFeedStore = getSduiFeedStore(str1)
            local templates = sduiFeedStore.getTemplates(arg1)
            local dataUpdatedTimestamp = sduiFeedStore.getDataUpdatedTimestamp(arg1)

            local unprocessedItemCollections = ({})

            for _, value in not sduiFeedStore.getItemCollectionKeys and {} or sduiFeedStore.getItemCollectionKeys(arg1) do
                local itemCollection = sduiFeedStore.getItemCollection(value)
                if itemCollection then
                    unprocessedItemCollections[value] = itemCollection(arg1)
                end
            end
            return {
                templates = templates,
                dataUpdatedTimestamp = dataUpdatedTimestamp,
                unprocessedItemCollections = unprocessedItemCollections
            }
        end
    end, { str1, bool1 })

    local var2 = SignalsReact.useSignalState(var1)

    local var3 = useSduiContext({ appPage = appPage, templates = var2.templates, dataUpdatedTimestamp = var2.dataUpdatedTimestamp })

    React.useEffect(function()
        if not bool1 then
            return
        end

        local sduiFeedStore = getSduiFeedStore(appPage)
        local itemCollections = ({})
        if not var2.unprocessedItemCollections then
            return
        end

        for _, unprocessedItemCollection in var2.unprocessedItemCollections do
            local itemCollectionKey = getItemCollectionKey(unprocessedItemCollection.topicId, unprocessedItemCollection.sortIndex)

            itemCollections[itemCollectionKey] = {
                sduiConfig = processCollectionConfig(unprocessedItemCollection.componentConfig, unprocessedItemCollection.topicId, var3),
                dataUpdatedTimestamp = var2.dataUpdatedTimestamp
            }
        end
        sduiFeedStore.updateData(
            {
                templates = var2.templates,
                itemCollections = itemCollections,
                dataUpdatedTimestamp = var2.dataUpdatedTimestamp
            }
        )
    end, {
        var3,
        var2.unprocessedItemCollections,
        var2.templates,
        var2.dataUpdatedTimestamp,
        appPage,
        bool1
    })

    return var3
end
return useSduiContextFromSignalAndProcessConfigs
