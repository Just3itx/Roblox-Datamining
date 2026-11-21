-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local SafeAppStorageService = require(AvatarExperienceCatalogParent.AvatarExperienceCommon).Lib.SafeAppStorageService

local bool1 = game:DefineFastFlag("AXTimedOptionsFtuxUseMemStorage", false)
local bool2 = game:DefineFastFlag("AXDisableTimedOptionsFtux", false)

local function getStorage()
    local item = SafeAppStorageService.getItem("AXSlotBasedEditorCustomizeFtux", bool1)
    item = item and item ~= "" and item or "{}"

    local storage = {}
    pcall(function()
        storage = HttpService:JSONDecode(item)
    end)

    return storage
end

local function setStorage(input) -- Luacid: Inlined by compiler; 3 call sites recovered
    pcall(function()
        local str1 = HttpService:JSONEncode(input)
        SafeAppStorageService.setItem("AXSlotBasedEditorCustomizeFtux", str1, bool1)
        SafeAppStorageService.flush()
    end)
end

local function useTimedOptionsFtux()
    return {
        shouldShow2OptionToolTipOnBuyActionBar = function(): boolean
            return not bool2 and not getStorage().hide2OptionToolTipOnBuyActionBar
        end,
        hide2OptionToolTipOnBuyActionBar = function()
            local storage = getStorage()

            storage.hide2OptionToolTipOnBuyActionBar = true
            setStorage(storage)
        end,
        shouldShow2OptionToolTipInCheckoutPage = function(): boolean
            return not bool2 and not getStorage().hide2OptionToolTipInCheckoutPage
        end,
        hide2OptionToolTipInCheckoutPage = function()
            local storage = getStorage()

            storage.hide2OptionToolTipInCheckoutPage = true
            setStorage(storage)
        end,
        shouldShow2OptionOfferPillTooltip = function(): boolean
            return not bool2 and not getStorage().hide2OptionOfferPillTooltip
        end,
        hide2OptionOfferPillTooltip = function()
            local storage = getStorage()

            storage.hide2OptionOfferPillTooltip = true
            setStorage(storage)
        end
    }
end
return useTimedOptionsFtux
