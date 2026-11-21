-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local AvatarExperienceSlotBasedEditor = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor")
local AvatarExperienceSlotBasedEditorParent = AvatarExperienceSlotBasedEditor.Parent

local Signals = require(AvatarExperienceSlotBasedEditorParent.Signals)
local mutedError = require(AvatarExperienceSlotBasedEditorParent.Loggers).mutedError

local InventoryItemType = require(AvatarExperienceSlotBasedEditor.Enums.InventoryItemType)
local _InventoryItemAvailability = require(AvatarExperienceSlotBasedEditor.Enums.InventoryItemAvailability)
local _Types = require(script.Parent.Parent.Types)

local FFlagAXInventoryDurablesSupport = require(AvatarExperienceSlotBasedEditorParent.AvatarExperienceFlags).FFlagAXInventoryDurablesSupport
local FFlagAXBackgroundGeneration = require(AvatarExperienceSlotBasedEditorParent.AvatarExperienceFlags).FFlagAXBackgroundGeneration
local FFlagAXRefetchInventoryOnUpdate = require(AvatarExperienceSlotBasedEditorParent.AvatarExperienceFlags).FFlagAXRefetchInventoryOnUpdate

local function createCategoryInventoryStore()
    local var1 = nil

    local getItems, var3 = Signals.createSignal(nil)
    local getHasReachedLastPage, var5 = Signals.createSignal(false)
    local getSearchUuid, var7 = Signals.createSignal(HttpService:GenerateGUID(true))
    local bool1 = not FFlagAXRefetchInventoryOnUpdate and nil

    var1 = {
        getItems = getItems,
        getHasReachedLastPage = getHasReachedLastPage,
        getSearchUuid = getSearchUuid,
        nextPageCursor = nil,
        isRefreshPending = function(): boolean
            return bool1 == true
        end,
        startNewSearch = function()
            var1.nextPageCursor = nil
            if FFlagAXRefetchInventoryOnUpdate then
                bool1 = false
            end
            var3(nil)
            var5(false)
            var7(HttpService:GenerateGUID(true))
        end,
        startRefresh = function()
            var1.nextPageCursor = nil
            bool1 = true
            var5(false)
            var7(HttpService:GenerateGUID(true))
        end,
        removeItems = function(tbl1)
            local var8 = getItems(false)
            if not var8 then
                return
            end

            local tbl2 = ({})
            for _, value in tbl1 do
                tbl2[value] = true
            end

            local tbl3 = {}
            for _, value in var8 do
                if not tbl2[value.itemId] then
                    tbl3[#tbl3 + 1] = value
                end
            end

            if #tbl3 == #var8 then
                return
            end

            local var9 = var3

            if not (#tbl3 > 0) then
                tbl3 = nil
            end

            var9(tbl3)
        end,
        addResultsPage = function(arg1, str1: string?)
            if FFlagAXRefetchInventoryOnUpdate and str1 ~= nil and str1 ~= getSearchUuid(false) then
                return
            end

            local var8 = FFlagAXRefetchInventoryOnUpdate and bool1 == true
            if FFlagAXRefetchInventoryOnUpdate then
                bool1 = false
            end

            local var9 = if var8 then nil else getItems(false)
            local var10 = not var9 and {} or table.clone(var9)

            for _, avatarInventoryItem in arg1.avatarInventoryItems do
                local inventoryItemType = if avatarInventoryItem.itemCategory.itemType == Enum.AvatarItemType.Asset.Value then InventoryItemType.Asset elseif avatarInventoryItem.itemCategory.itemType == Enum.AvatarItemType.Bundle.Value then InventoryItemType.Outfit else InventoryItemType.Unknown

                if inventoryItemType == InventoryItemType.Unknown then
                    mutedError(
                        `Unknown item type received from user inventory endpoint: {avatarInventoryItem.itemCategory.itemType}`
                    )
                else
                    table.insert(var10, {
                        itemId = tostring(avatarInventoryItem.itemId),
                        inventoryItemType = inventoryItemType,
                        availabilityStatus = avatarInventoryItem.availabilityStatus,
                        expirationTime = if FFlagAXInventoryDurablesSupport then avatarInventoryItem.expirationTime else nil,
                        isPlusExclusive = if FFlagAXBackgroundGeneration then avatarInventoryItem.isPlusExclusive else nil
                    })
                end
            end

            var3(var10)

            local nextPageToken = arg1.nextPageToken
            var1.nextPageCursor = nextPageToken
            if nextPageToken == nil or nextPageToken == "" then
                var5(true)
            end
        end
    }

    return var1
end

return createCategoryInventoryStore
