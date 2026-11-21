-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceRodux = script:FindFirstAncestor("AvatarExperienceRodux")

local AvatarExperienceRoduxParent = AvatarExperienceRodux.Parent
local Rodux = require(AvatarExperienceRoduxParent.Rodux)

local _AvatarExperienceCommon = require(AvatarExperienceRoduxParent.AvatarExperienceCommon)
local _AvatarExperienceModel = require(AvatarExperienceRoduxParent.AvatarExperienceModel)
local FFlagAXDurablesForMIS = require(AvatarExperienceRoduxParent.AvatarExperienceFlags).FFlagAXDurablesForMIS

local _OutfitTryOn = require(AvatarExperienceRodux.Types.OutfitTryOn)

return Rodux.makeActionCreator(script.Name, function(itemType, itemSubType: string, itemId: string, selectedInTryOnManager: boolean, overrideOrder: number?, bundleInfo, widgetInfo, receivedBundleInfo: boolean, isRecolorable: boolean?, bundleItems, resetTryOnsBeforeToggleOn: boolean?, selectedTimedOptionIndex: number?)
    local tbl1 = {
        itemType = itemType,
        itemSubType = itemSubType,
        itemId = itemId,
        selectedInTryOnManager = selectedInTryOnManager,
        overrideOrder = overrideOrder,
        bundleInfo = bundleInfo,
        widgetInfo = widgetInfo,
        receivedBundleInfo = receivedBundleInfo,
        isRecolorable = isRecolorable,
        bundleItems = bundleItems,
        resetTryOnsBeforeToggleOn = resetTryOnsBeforeToggleOn,
        selectedTimedOptionIndex = 0
    }

    if not FFlagAXDurablesForMIS then
        selectedTimedOptionIndex = nil
    end

    tbl1.selectedTimedOptionIndex = selectedTimedOptionIndex
    return tbl1
end)
