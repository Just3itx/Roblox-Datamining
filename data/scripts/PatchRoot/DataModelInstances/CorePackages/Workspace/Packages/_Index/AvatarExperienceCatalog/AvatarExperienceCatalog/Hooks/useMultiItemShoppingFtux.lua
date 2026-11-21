-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local SafeAppStorageService = require(AvatarExperienceCatalogParent.AvatarExperienceCommon).Lib.SafeAppStorageService

local FFlagAXDisableMultiItemShoppingFtux = require(AvatarExperienceCatalogParent.AvatarExperienceFlags).FFlagAXDisableMultiItemShoppingFtux

local bool1 = game:DefineFastFlag("AXCatalogMultiItemShoppingFtuxUseMemStorage", false)

local num1 = game:DefineFastInt("AXCatalogMultiItemShoppingFtuxOtherPromptMaxCount", 3)

local function getStorage()
    local item = SafeAppStorageService.getItem("AXCatalogMultiItemShoppingFTUX", bool1)
    item = item and item ~= "" and item or "{}"

    local storage = {}
    pcall(function()
        storage = HttpService:JSONDecode(item)
    end)

    return storage
end

local function setStorage(input) -- Luacid: Inlined by compiler; 6 call sites recovered
    pcall(function()
        local str1 = HttpService:JSONEncode(input)
        SafeAppStorageService.setItem("AXCatalogMultiItemShoppingFTUX", str1, bool1)

        SafeAppStorageService.flush()
    end)
end

local function useMultiItemShoppingFtux()
    return {
        shouldShowTooltipOnCheckoutButton = function(): boolean
            return not FFlagAXDisableMultiItemShoppingFtux and not getStorage().seenTooltipOnCheckoutButton
        end,
        shouldShowClearAllItemsPrompt = function(): boolean
            if FFlagAXDisableMultiItemShoppingFtux then
                return false
            end
            local storage = getStorage()

            return not storage.hideClearAllItemsPrompt
                and (storage.clearAllItemsPromptCount == nil or storage.clearAllItemsPromptCount < num1)
        end,
        shouldShowWearAvatarReplaceAllItemsPrompt = function(): boolean
            if FFlagAXDisableMultiItemShoppingFtux then
                return false
            end
            local storage = getStorage()

            return not storage.hideWearAvatarReplaceAllItemsPrompt
                and (storage.wearAvatarReplaceAllItemsPromptCount == nil or storage.wearAvatarReplaceAllItemsPromptCount < num1)
        end,
        setSeenTooltipOnCheckoutButton = function()
            local storage = getStorage()

            storage.seenTooltipOnCheckoutButton = true
            setStorage(storage)
        end,
        hideClearAllItemsPrompt = function()
            local storage = getStorage()

            storage.hideClearAllItemsPrompt = true
            setStorage(storage)
        end,
        incrementClearAllItemsPromptCount = function()
            local storage = getStorage()

            storage.clearAllItemsPromptCount = if storage.clearAllItemsPromptCount == nil then 1 else storage.clearAllItemsPromptCount + 1
            setStorage(storage)
        end,
        hideWearAvatarReplaceAllItemsPrompt = function()
            local storage = getStorage()

            storage.hideWearAvatarReplaceAllItemsPrompt = true
            setStorage(storage)
        end,
        incrementWearAvatarReplaceAllItemsPromptCount = function()
            local storage = getStorage()

            storage.wearAvatarReplaceAllItemsPromptCount = if storage.wearAvatarReplaceAllItemsPromptCount == nil then 1 else storage.wearAvatarReplaceAllItemsPromptCount + 1
            setStorage(storage)
        end,
        shouldShowItemReplacedOnAvatarPrompt = function(): boolean
            return not FFlagAXDisableMultiItemShoppingFtux and not getStorage().seenItemReplacedOnAvatarPrompt
        end,
        setSeenItemReplaceOnAvatarPrompt = function()
            local storage = getStorage()

            storage.seenItemReplacedOnAvatarPrompt = true
            setStorage(storage)
        end
    }
end
return useMultiItemShoppingFtux
