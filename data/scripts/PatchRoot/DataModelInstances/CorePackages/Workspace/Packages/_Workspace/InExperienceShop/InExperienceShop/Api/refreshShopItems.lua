-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")

local _Types = require(InExperienceShop.Types)
local _multiGetProductInfo = require(script.Parent.multiGetProductInfo)
local shopItemMapping = require(script.Parent.shopItemMapping)

local makeRequestKey = shopItemMapping.makeRequestKey
local toShopItem = shopItemMapping.toShopItem

local function infoTypeForShopItemType(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
    if arg1 == "Product" then
        return Enum.InfoType.Product
    elseif arg1 == "GamePass" then
        return Enum.InfoType.GamePass
    end

    return nil
end

local function refreshShopItemFromProductInfo(arg1, arg2)
    local var1 = toShopItem(arg2, arg1.itemType, tonumber(arg1.id))
    return {
        id = arg1.id,
        itemType = arg1.itemType,
        isOwned = arg1.isOwned,
        creator = var1.creator or arg1.creator,
        universeId = arg1.universeId,
        originalIndex = arg1.originalIndex,
        name = var1.name,
        thumbnail = var1.thumbnail,
        price = var1.price,
        userBasePriceInRobux = var1.userBasePriceInRobux,
        description = var1.description,
        updated = var1.updated
    }
end

return {
    infoTypeForShopItemType = infoTypeForShopItemType,
    buildRequestsFromSections = function(tbl1)
        local requestsFromSections = {}
        local tbl2 = ({})
        for _, value in ipairs(tbl1) do
            for _, item in ipairs(value.items) do
                local itemType = item.itemType
                local infoType = if itemType == "Product" then infoTypeForShopItemType("Product") elseif itemType == "GamePass" then infoTypeForShopItemType("GamePass") else nil

                if infoType == nil then
                    continue
                end

                local id = tonumber(item.id)
                if id == nil then
                    continue
                end

                local requestKey = makeRequestKey(id, infoType)
                if tbl2[requestKey] then
                    continue
                end

                tbl2[requestKey] = true
                table.insert(requestsFromSections, { id = id, infoType = infoType })
            end
        end

        return requestsFromSections
    end,
    appendFailedItemRequests = function<T>(tbl1, tbl2): {T}
        local tbl3 = ({})
        for _, value in ipairs(tbl1) do
            tbl3[makeRequestKey(value.id, value.infoType)] = true
        end
        for _, value in ipairs(tbl2) do
            local requestKey = makeRequestKey(value.id, value.infoType)
            if tbl3[requestKey] then
                continue
            end

            tbl3[requestKey] = true
            table.insert(tbl1, { id = value.id, infoType = value.infoType })
        end

        return tbl1
    end,
    refreshShopItemFromProductInfo = refreshShopItemFromProductInfo,
    mergeProductInfoIntoSections = function(tbl1, tbl2)
        local tbl3 = {}
        for _, value in ipairs(tbl2) do
            tbl3[makeRequestKey(value.request.id, value.request.infoType)] = value
        end

        local var1 = table.create(#tbl1)
        for i, value in ipairs(tbl1) do
            local var2 = nil
            for i2, item in ipairs(value.items) do
                local itemType = item.itemType
                local var3 = if itemType == "Product" then infoTypeForShopItemType("Product") elseif itemType == "GamePass" then infoTypeForShopItemType("GamePass") else nil
                local var4 = tonumber(item.id)
                local var5 = if var3 == nil or var4 == nil then nil else tbl3[makeRequestKey(var4, var3)]

                if var5 ~= nil and var5.ok then
                    if var2 == nil then
                        var2 = table.create(#value.items)
                        for j = 1, i2 - 1 do
                            var2[j] = value.items[j]
                        end
                    end
                    var2[i2] = refreshShopItemFromProductInfo(item, var5.value)
                elseif var2 ~= nil then
                    var2[i2] = item
                end
            end

            if var2 == nil then
                var1[i] = value
            else
                local tbl4 = {
                    id = value.id,
                    name = value.name,
                    items = var2,
                    categoryType = value.categoryType,
                    stableCategoryId = value.stableCategoryId,
                    categoryGroup = value.categoryGroup,
                    paymentSessionId = value.paymentSessionId,
                    bonusJwt = value.bonusJwt,
                    robuxPackages = value.robuxPackages
                }
                var1[i] = tbl4
            end
        end

        return var1
    end,
    insertRecoveredItemsIntoSections = function(tbl1, tbl2, tbl3)
        local tbl4 = {}
        for _, value in ipairs(tbl2) do
            tbl4[makeRequestKey(value.request.id, value.request.infoType)] = value
        end

        local tbl5 = {}
        local tbl6 = {}
        for _, value in ipairs(tbl3) do
            local var1 = tbl4[makeRequestKey(value.id, value.infoType)]
            if var1 == nil or not var1.ok then
                table.insert(tbl6, value)
            else
                local tbl7 = tbl5[value.sectionId]
                if tbl7 == nil then
                    tbl7 = {}
                    tbl5[value.sectionId] = tbl7
                end

                local var2 = toShopItem(var1.value, value.itemType, value.id)
                var2.originalIndex = value.originalIndex
                table.insert(tbl7, var2)
            end
        end
        local var1 = table.create(#tbl1)
        for i, value in ipairs(tbl1) do
            local var2 = tbl5[value.id]
            if var2 == nil then
                var1[i] = value
            else
                table.sort(var2, function(arg1, arg2): boolean
                    return (arg1.originalIndex or 0) < (arg2.originalIndex or 0)
                end)

                local items = table.create(#value.items + #var2)
                local num1 = 1
                local num2 = 1

                while num1 <= #value.items or num2 <= #var2 do
                    local item = value.items[num1]
                    local var4 = var2[num2]
                    if var4 == nil then
                        table.insert(items, item)
                        num1 += 1
                    elseif item == nil then
                        table.insert(items, var4)
                        num2 += 1
                    elseif (item.originalIndex or 0) <= (var4.originalIndex or 0) then
                        table.insert(items, item)
                        num1 += 1
                    else
                        table.insert(items, var4)
                        num2 += 1
                    end
                end
                local tbl7 = {
                    id = value.id,
                    name = value.name,
                    items = items,
                    categoryType = value.categoryType,
                    stableCategoryId = value.stableCategoryId,
                    categoryGroup = value.categoryGroup,
                    paymentSessionId = value.paymentSessionId,
                    bonusJwt = value.bonusJwt,
                    robuxPackages = value.robuxPackages
                }
                var1[i] = tbl7
            end
        end
        return var1, tbl6
    end
}
