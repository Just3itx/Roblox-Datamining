-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSlotBasedEditor = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor")
local AvatarExperienceSlotBasedEditorParent = AvatarExperienceSlotBasedEditor.Parent

local Signals = require(AvatarExperienceSlotBasedEditorParent.Signals)

local DeviceOrientationMode = require(AvatarExperienceSlotBasedEditorParent.RobloxAppEnums).DeviceOrientationMode
local Constants = require(AvatarExperienceSlotBasedEditor.Constants)
local Categories = require(AvatarExperienceSlotBasedEditor.Enums.Categories)

local createSelectorSignal = require(AvatarExperienceSlotBasedEditorParent.AXCommon).Utils.createSelectorSignal

local buildSlots = require(AvatarExperienceSlotBasedEditor.Utils.buildSlots)

local _Types = require(AvatarExperienceSlotBasedEditor.Types)

local FFlagAXSlotsDesktopRedesign = require(AvatarExperienceSlotBasedEditorParent.AvatarExperienceFlags).FFlagAXSlotsDesktopRedesign

local function createSlotBasedEditorStore(arg1)
    local selectorSignal = createSelectorSignal(arg1, function(arg2): boolean
        return arg2.DeviceOrientation == DeviceOrientationMode.Portrait
    end)

    local var1 = if FFlagAXSlotsDesktopRedesign then if selectorSignal(false) then Categories.Avatars else Categories.All elseif selectorSignal(false) then Categories.Avatars else Categories.Body
    local getSlotCategory, setSlotCategory = Signals.createSignal(var1)
    local getSlotIndex, setSlotIndex = Signals.createSignal(1)

    local selectorSignal2 = createSelectorSignal(arg1, function(arg2)
        return arg2.AvatarExperience.AvatarEditor.Character.EquippedAssets or {}
    end)

    return {
        getSlotCategory = getSlotCategory,
        setSlotCategory = setSlotCategory,
        getSlotIndex = getSlotIndex,
        setSlotIndex = setSlotIndex,
        getSlots = Signals.createComputed(function(arg2)
            return buildSlots(Constants.SlotEditorCategories[getSlotCategory(arg2)].slots, selectorSignal2(arg2))
        end)
    }
end
return createSlotBasedEditorStore
