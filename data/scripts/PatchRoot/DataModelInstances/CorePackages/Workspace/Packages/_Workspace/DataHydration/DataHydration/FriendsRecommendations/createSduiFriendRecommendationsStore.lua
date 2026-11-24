-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")

local createDataCache = require(DataHydration.createDataCache)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local _SduiFriendRecommendationTypes = require(script.Parent.SduiFriendRecommendationTypes)
local SduiRecommendationType = require(script.Parent.SduiRecommendationType)

local function createFriendRecommendationsStore()
    local dataCache = createDataCache()
    local tbl1 = ({})

    return {
        getFriendRecommendation = function(str1: string)
            local item = dataCache.getItem(str1)
            return {
                data = function(arg1)
                    local var1 = item.data(arg1)
                    return if var1 and var1.recommendationType ~= SduiRecommendationType.Invalid then var1 else nil
                end,
                status = item.status
            }
        end,
        replaceFriendRecommendations = function(tbl2)
            for value in tbl1 do
                if tbl2[value] ~= nil then
                    continue
                end
                local replaceItem = dataCache.replaceItem
                local tbl3 = {
                    recommendationType = SduiRecommendationType.Invalid
                }
                replaceItem(value, tbl3)
            end

            dataCache.replaceItems(tbl2)
            tbl1 = {}
            for value in tbl2 do
                tbl1[value] = true
            end
        end,
        dispose = function()
            tbl1 = {}
            dataCache.dispose()
        end
    }
end
return createFriendRecommendationsStore
