-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarSwitcher = script:FindFirstAncestor("AvatarSwitcher")
local AvatarSwitcherParent = AvatarSwitcher.Parent

local jest = require(AvatarSwitcherParent.Dev.JestGlobals).jest
local Signals = require(AvatarSwitcherParent.Signals)

local _ExperienceAvatarSupportType = require(AvatarSwitcher.Enums.ExperienceAvatarSupportType)

local _types = require(AvatarSwitcher.types)

local function createMockAvatarSwitcherStore()
    local getOutfits, setOutfits = Signals.createSignal({})
    local getLastPageReached, setLastPageReached = Signals.createSignal(false)
    local getSelectedOutfitId, setSelectedOutfitId = Signals.createSignal(nil)
    local getSelectedOutfitDetails, setSelectedOutfitDetails = Signals.createSignal(nil)
    local getRespawnPromptShown, setRespawnPromptShown = Signals.createSignal(false)
    local getIsSwitching, setIsSwitching = Signals.createSignal(false)
    local getIsEmpty, setIsEmpty = Signals.createSignal(false)

    local getExperienceAvatarSupportType, setExperienceAvatarSupportType = Signals.createSignal(nil)
    local getExperienceAvatarType, setExperienceAvatarType = Signals.createSignal(nil)
    local getPendingAvatarName, setPendingAvatarName = Signals.createSignal(nil)

    return {
        store = {
            getOutfits = getOutfits,
            getLastPageReached = getLastPageReached,
            getSelectedOutfitId = getSelectedOutfitId,
            getSelectedOutfitDetails = getSelectedOutfitDetails,
            getRespawnPromptShown = getRespawnPromptShown,
            getIsSwitching = getIsSwitching,
            getIsEmpty = getIsEmpty,
            getExperienceAvatarSupportType = getExperienceAvatarSupportType,
            getExperienceAvatarType = getExperienceAvatarType,
            getPendingAvatarName = getPendingAvatarName,
            toggleRespawnPrompt = jest.fn(),
            selectOutfit = jest.fn(),
            fetchNextOutfitsPage = jest.fn(),
            switchAvatar = jest.fn(),
            fetchExperienceAvatarSupportType = jest.fn(),
            clearPendingAvatarName = jest.fn()
        },
        setOutfits = setOutfits,
        setLastPageReached = setLastPageReached,
        setSelectedOutfitId = setSelectedOutfitId,
        setSelectedOutfitDetails = setSelectedOutfitDetails,
        setRespawnPromptShown = setRespawnPromptShown,
        setIsSwitching = setIsSwitching,
        setIsEmpty = setIsEmpty,
        setExperienceAvatarSupportType = setExperienceAvatarSupportType,
        setExperienceAvatarType = setExperienceAvatarType,
        setPendingAvatarName = setPendingAvatarName
    }
end

return createMockAvatarSwitcherStore
