-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
local CorePackages = game:GetService("CorePackages")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local HttpService = game:GetService("HttpService")
local Url = require(CorePackages.Workspace.Packages.CoreScriptsCommon).Url

local FFlagAXEnableInspectAndBuyBulkPurchase = require(CorePackages.Workspace.Packages.SharedFlags).FFlagAXEnableInspectAndBuyBulkPurchase
local FIntBulkPurchaseRequestLimit = require(CorePackages.Workspace.Packages.SharedFlags).FIntBulkPurchaseRequestLimit
local FIntBulkPurchaseThrottleLimit = require(CorePackages.Workspace.Packages.SharedFlags).FIntBulkPurchaseThrottleLimit

local FFlagFilterOutShopOnlyItemsOnBulkPurchase = require(CorePackages.Workspace.Packages.SharedFlags).FFlagFilterOutShopOnlyItemsOnBulkPurchase

local FFlagAXEnableTimedOptionsServerScript = require(CorePackages.Workspace.Packages.SharedFlags).FFlagAXEnableTimedOptionsServerScript

if not FFlagAXEnableInspectAndBuyBulkPurchase then
    return
end

local serverSideBulkPurchaseEvent = Instance.new("RemoteEvent")
serverSideBulkPurchaseEvent.Name = "ServerSideBulkPurchaseEvent"
serverSideBulkPurchaseEvent.Parent = RobloxReplicatedStorage
local tbl1 = ({})

local var1 = FFlagFilterOutShopOnlyItemsOnBulkPurchase and { ShopOnly = "ShopOnly" } or nil

local tbl2 = {
    Bundle = Enum.MarketplaceProductType.AvatarBundle,
    Asset = Enum.MarketplaceProductType.AvatarAsset
}

local function getBatchItemDetailsServerSide(items) -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(function()
        local apiUrl = Url.CATALOG_URL .. "v1/catalog/items/details"
        local var2

        if FFlagAXEnableTimedOptionsServerScript then
            local tbl3 = {}
            for _, item in items do
                table.insert(tbl3, { id = item.id, itemType = item.itemType })
            end

            var2 = HttpService:JSONEncode({ items = tbl3 })
        else
            var2 = HttpService:JSONEncode({ items = items })
        end

        local input = HttpRbxApiService:PostAsyncFullUrl(apiUrl, var2, Enum.ThrottlingPriority.Default, Enum.HttpContentType.ApplicationJson)

        return HttpService:JSONDecode(input)
    end)

    return if success then result else nil
end

local function isLimited(arg1): boolean
    local itemRestrictions = arg1.itemRestrictions
    local var2 = itemRestrictions and table.find(itemRestrictions, "Limited")
    local var3 = itemRestrictions and table.find(itemRestrictions, "LimitedUnique")
    local var4 = itemRestrictions and table.find(itemRestrictions, "Collectible")
    return var2 ~= nil or var3 ~= nil or var4 ~= nil
end

local function validatePlayer(player: Player): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not not (player.UserId and not (player.UserId <= 0))
end

local function validateItem(tbl3): boolean
    return type(tbl3) == "table"
        and tbl3.id ~= nil
        and tbl3.itemType ~= nil
        and type(tbl3.itemType) == "number"
        and type(tbl3.id) == "number"
        and tbl3.id ~= 0
        and (tbl3.itemType == Enum.AvatarItemType.Asset.Value or tbl3.itemType == Enum.AvatarItemType.Bundle.Value)
end

local function validateIncomingItems(arguments)
    local result = {}

    if not arguments then
        return nil
    end

    if type(arguments) ~= "table" then
        return nil
    end

    if #arguments > FIntBulkPurchaseRequestLimit then
        return nil
    end

    local num1 = 0
    for _, argument in arguments do
        if FIntBulkPurchaseRequestLimit <= num1 then
            break
        end

        if not validateItem(argument) then
            continue
        end

        table.insert(result, {
            id = argument.id,
            itemType = argument.itemType,
            PurchaseOptions = if FFlagAXEnableTimedOptionsServerScript then argument.PurchaseOptions else nil
        })
        num1 += 1
    end
    return result
end

local function isThrottled(player: Player): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local var2 = tbl1[player]
    if var2 and tick() < var2 then
        return true
    end
    tbl1[player] = tick() + FIntBulkPurchaseThrottleLimit
    return false
end

Players.PlayerRemoving:Connect(function(player: Player)
    tbl1[player] = nil
end)

serverSideBulkPurchaseEvent.OnServerEvent:Connect(function(player: Player, arguments)
    if not validatePlayer(player) or isThrottled(player) then
        return
    end

    local var2 = validateIncomingItems(arguments)

    if var2 == nil or #var2 == 0 then
        return
    end

    local batchItemDetailsServerSide = getBatchItemDetailsServerSide(var2)
    local var3 = FFlagAXEnableTimedOptionsServerScript and {} or nil
    if FFlagAXEnableTimedOptionsServerScript then
        for _, value in var2 do
            if value.PurchaseOptions and var3 then
                var3[value.id] = value.PurchaseOptions
            end
        end
    end
    local lineItems = {}
    if batchItemDetailsServerSide ~= nil then
        for _, value in batchItemDetailsServerSide.data do
            if (value.saleLocationType == "MyExperiencesOnly"
                or value.saleLocationType == "ExperiencesById"
                or value.saleLocationType == "ExperiencesDevApiOnly")
                and (value.unitsAvailableForConsumption ~= 0 or not isLimited(value))
                or FFlagFilterOutShopOnlyItemsOnBulkPurchase
                    and var1
                    and value.saleLocationType == var1.ShopOnly
                    and (value.unitsAvailableForConsumption ~= 0 or not isLimited(value))
            then
                continue
            end

            table.insert(lineItems, {
                Id = tostring(value.id),
                Type = tbl2[value.itemType],
                PurchaseOptions = if FFlagAXEnableTimedOptionsServerScript and var3 and var3[value.id] then var3[value.id] else nil
            })
        end
    end

    if #lineItems > 0 then
        MarketplaceService:PromptBulkPurchase(player, lineItems, {})
    end
end)
