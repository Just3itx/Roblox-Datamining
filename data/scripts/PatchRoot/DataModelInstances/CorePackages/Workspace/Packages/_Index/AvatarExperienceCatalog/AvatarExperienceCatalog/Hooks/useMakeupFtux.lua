-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)
local AvatarExperienceFlags = require(AvatarExperienceCatalogParent.AvatarExperienceFlags)

local SafeAppStorageService = AvatarExperienceCommon.Lib.SafeAppStorageService

local FFlagAXMakeupReleaseFTUX = AvatarExperienceFlags.FFlagAXMakeupReleaseFTUX
local bool1 = game:DefineFastFlag("AXCatalogMakeupFtuxUseMemStorage", false)
local FFlagAXMakeupLayeringTooltipFTUX = AvatarExperienceFlags.FFlagAXMakeupLayeringTooltipFTUX
local FFlagAXSkipMakeupFTUX = AvatarExperienceFlags.FFlagAXSkipMakeupFTUX

local num1 = game:DefineFastInt("AXMakeupLayeringTooltipMaxSeenCount", 2)
local num2 = game:DefineFastInt("AXMakeupMax6LayersPromptMaxSeenCount", 3)
local bool2 = not FFlagAXMakeupLayeringTooltipFTUX and nil

local function getStorage()
    local item = SafeAppStorageService.getItem("AXCatalogMakeupFTUX", bool1)
    item = item and item ~= "" and item or "{}"

    local storage = {}
    pcall(function()
        storage = HttpService:JSONDecode(item)
    end)

    return storage
end

local function setStorage(input) -- Luacid: Inlined by compiler; 4 call sites recovered
    pcall(function()
        local str1 = HttpService:JSONEncode(input)
        SafeAppStorageService.setItem("AXCatalogMakeupFTUX", str1, bool1)
        SafeAppStorageService.flush()
    end)
end

local function useMakeupFtux()
    return {
        shouldShowMakeupMax6LayersPrompt = function(): boolean
            if FFlagAXSkipMakeupFTUX then
                return false
            end
            local storage = getStorage()

            return not storage.hideMakeupMax6LayersPrompt
                and (storage.seenMakeupMax6LayersCount == nil or storage.seenMakeupMax6LayersCount < num2)
        end,
        hideMakeupMax6LayersPrompt = function()
            local storage = getStorage()

            storage.hideMakeupMax6LayersPrompt = true
            setStorage(storage)
        end,
        shouldShowMakeupLayeringTooltip = FFlagAXMakeupLayeringTooltipFTUX and function(): boolean
            return not FFlagAXSkipMakeupFTUX and not bool2 and (getStorage().makeupLayeringTooltipSeenCount or 0) < num1
        end or nil,
        markMakeupLayeringTooltipSeen = FFlagAXMakeupLayeringTooltipFTUX and function()
            bool2 = true

            local storage = getStorage()
            storage.makeupLayeringTooltipSeenCount = (storage.makeupLayeringTooltipSeenCount or 0) + 1
            setStorage(storage)
        end or nil,
        shouldShowMakeupReleasePrompt = FFlagAXMakeupReleaseFTUX and function(): boolean
            return not FFlagAXSkipMakeupFTUX and not getStorage().shownMakeupReleasePrompt
        end or nil,
        setShownMakeupReleasePrompt = FFlagAXMakeupReleaseFTUX and function()
            local storage = getStorage()

            storage.shownMakeupReleasePrompt = true
            setStorage(storage)
        end or nil,
        incrementSeenMakeupMax6LayersPrompt = function()
            local storage = getStorage()

            storage.seenMakeupMax6LayersCount = if storage.seenMakeupMax6LayersCount == nil then 1 else storage.seenMakeupMax6LayersCount + 1
            setStorage(storage)
        end
    }
end
return useMakeupFtux
