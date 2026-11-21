-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local SafeAppStorageService = require(AvatarExperienceCatalogParent.AvatarExperienceCommon).Lib.SafeAppStorageService

local bool1 = game:DefineFastFlag("AXCatalogSaveOptionsUseMemStorage", false)
local bool2 = game:DefineFastFlag("AXSetSaveAsAvatarDefault", false)

local function getStorage()
    local item = SafeAppStorageService.getItem("AXCatalogCheckoutPageSaveOptionValues", bool1)
    item = item and item ~= "" and item or "{}"

    local storage = {}
    pcall(function()
        storage = HttpService:JSONDecode(item)
    end)

    return storage
end

local function setStorage(input) -- Luacid: Inlined by compiler; 2 call sites recovered
    pcall(function()
        local str1 = HttpService:JSONEncode(input)
        SafeAppStorageService.setItem("AXCatalogCheckoutPageSaveOptionValues", str1, bool1)
        SafeAppStorageService.flush()
    end)
end

local function useSaveOptionsStoredValues()
    return {
        setWearAfterPurchase = function(wearAfterPurchase: boolean)
            local storage = getStorage()
            storage.wearAfterPurchase = wearAfterPurchase
            setStorage(storage)
        end,
        getWearAfterPurchase = function()
            local storage = getStorage()

            return storage.wearAfterPurchase == nil or storage.wearAfterPurchase
        end,
        setAddToAvatars = function(addToAvatars: boolean)
            local storage = getStorage()
            storage.addToAvatars = addToAvatars
            setStorage(storage)
        end,
        getAddToAvatars = function()
            local storage = getStorage()
            return if storage.addToAvatars == nil then not not bool2 else storage.addToAvatars
        end
    }
end
return useSaveOptionsStoredValues
