-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")

local _Types = require(InExperienceShop.Types)
local _multiGetProductInfo = require(script.Parent.multiGetProductInfo)
local shopItemMapping = require(script.Parent.shopItemMapping)

local makeRequestKey = shopItemMapping.makeRequestKey
local toShopItem = shopItemMapping.toShopItem

local GamePass = Enum.InfoType.GamePass

return {
    appendBonusItemRequests = function<T>(tbl1, tbl2): {T}
        local tbl3 = ({})
        for _, value in ipairs(tbl1) do
            tbl3[makeRequestKey(value.id, value.infoType)] = true
        end

        for _, value in ipairs(tbl2) do
            local robuxPackages = value.robuxPackages
            if robuxPackages == nil then
                continue
            end

            for _, value2 in robuxPackages do
                local bonusItem = value2.bonusItem
                if bonusItem == nil or bonusItem.type ~= "GamePass" then
                    continue
                end

                local requestKey = makeRequestKey(bonusItem.id, GamePass)
                if tbl3[requestKey] then
                    continue
                end

                tbl3[requestKey] = true
                table.insert(tbl1, { id = bonusItem.id, infoType = GamePass })
            end
        end

        return tbl1
    end,
    mergeBonusItemDetailsIntoSections = function(tbl1, tbl2)
        local tbl3 = {}
        for _, value in ipairs(tbl2) do
            tbl3[makeRequestKey(value.request.id, value.request.infoType)] = value
        end

        local var1 = table.create(#tbl1)
        for i, value in ipairs(tbl1) do
            local robuxPackages = value.robuxPackages
            if robuxPackages == nil or #robuxPackages == 0 then
                var1[i] = value
            else
                local var2 = nil
                for i2, value2 in ipairs(robuxPackages) do
                    local bonusItem = value2.bonusItem
                    if bonusItem ~= nil then
                        local var3 = tbl3[makeRequestKey(bonusItem.id, GamePass)]
                        if var3 ~= nil and var3.ok then
                            if var2 == nil then
                                var2 = table.create(#robuxPackages)
                                for j = 1, i2 - 1 do
                                    var2[j] = robuxPackages[j]
                                end
                            end

                            local tbl4 = {
                                id = value2.id,
                                robuxAmount = value2.robuxAmount,
                                currencyAmountStr = value2.currencyAmountStr,
                                robuxImage = value2.robuxImage,
                                productId = value2.productId,
                                mobileProductId = value2.mobileProductId,
                                bonusItem = value2.bonusItem,
                                bonusItemDetails = toShopItem(var3.value, "GamePass", bonusItem.id),
                                isPrimaryRobuxPackage = value2.isPrimaryRobuxPackage
                            }
                            var2[i2] = tbl4
                        elseif var2 ~= nil then
                            var2[i2] = value2
                        end
                    elseif var2 ~= nil then
                        var2[i2] = value2
                    end
                end

                if var2 == nil then
                    var1[i] = value
                else
                    for j = #var2 + 1, #robuxPackages do
                        var2[j] = robuxPackages[j]
                    end
                    local tbl4 = {
                        id = value.id,
                        name = value.name,
                        items = value.items,
                        categoryType = value.categoryType,
                        stableCategoryId = value.stableCategoryId,
                        categoryGroup = value.categoryGroup,
                        paymentSessionId = value.paymentSessionId,
                        bonusJwt = value.bonusJwt,
                        robuxPackages = var2
                    }
                    var1[i] = tbl4
                end
            end
        end

        return var1
    end
}
