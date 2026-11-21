-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSlotBasedEditorParent = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor").Parent
local _Types = require(script.Parent.Parent.Types)
local SlotType = require(script.Parent.Parent.Enums.SlotType)
local FFlagEnableSlotsHeadShapeThumbnail = require(AvatarExperienceSlotBasedEditorParent.AvatarExperienceFlags).FFlagEnableSlotsHeadShapeThumbnail

local function buildSlotSubcategory(arg1, thumbnailUrl: string?, currentAssetType) -- Luacid: Inlined by compiler; 6 call sites recovered
    return {
        nameTranslationKey = arg1.nameTranslationKey,
        icon = arg1.icon,
        thumbnailUrl = thumbnailUrl,
        assetTypes = arg1.assetTypes,
        editorSubcategory = arg1.editorSubcategory,
        eligibleSubcategories = arg1.eligibleSubcategories,
        currentAssetType = currentAssetType,
        hide = arg1.hide,
        deselectable = arg1.deselectable
    }
end

local function buildLayeredSlotSubcategory(arg1, thumbnailUrl: string?, currentAssetType, layerIndex: number) -- Luacid: unused: defined but never referenced
    local slotSubcategory = buildSlotSubcategory(arg1, thumbnailUrl, currentAssetType)
    slotSubcategory.slotType = SlotType.LayeredSlot
    slotSubcategory.layerLimit = arg1.layerLimit
    slotSubcategory.layerIndex = layerIndex

    return slotSubcategory
end

local function getHeadShapeFromEquippedAssets(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = tbl1[tostring(Enum.AvatarAssetType.DynamicHead.Value)]
    if var1 then
        for _, value in var1 do
            return if value.headShape == "Default" then nil else value.headShape
        end
    end
    return nil
end

local function getClassicFaceOrDynamicHeadThumbnail(tbl1, bool1: boolean)
    local var1 = if bool1 then tostring(Enum.AvatarAssetType.DynamicHead.Value) else tostring(Enum.AvatarAssetType.Face.Value)
    local var2 = tbl1[var1]
    if var2 then
        for value, _ in var2 do
            return `rbxthumb://type=Asset&id={value}&w=150&h=150`
        end
    end
    return nil
end

local function buildSlots(tbl1, tbl2)
    local slots = {}
    local bool1 = false
    local bool2 = false

    for _, value in tbl1 do
        if value.slotType == SlotType.LayeredSlot then
            for layerIndex = 0, value.layerLimit - 1 do
                local bool3 = false
                for _, currentAssetType in value.assetTypes do
                    local var1 = tbl2[tostring(currentAssetType.Value)]

                    if var1 == nil or not next(var1) then
                        continue
                    end

                    for value3, value4 in var1 do
                        if value4.order ~= layerIndex then
                            continue
                        end

                        local tbl3 = buildSlotSubcategory(value, `rbxthumb://type=Asset&id={value3}&w=150&h=150`, currentAssetType)

                        tbl3.slotType = SlotType.LayeredSlot
                        tbl3.layerLimit = value.layerLimit
                        tbl3.layerIndex = layerIndex

                        table.insert(slots, tbl3)
                        bool3 = true
                        break
                    end
                end

                if bool3 then
                    continue
                end

                local tbl3 = buildSlotSubcategory(value, nil, nil)

                tbl3.slotType = SlotType.LayeredSlot
                tbl3.layerLimit = value.layerLimit
                tbl3.layerIndex = layerIndex

                table.insert(slots, tbl3)
            end
        else
            local assetTypes = value.assetTypes
            local bool3 = false

            for _, currentAssetType in assetTypes do
                local var1 = tbl2[tostring(currentAssetType.Value)]

                if var1 == nil or not next(var1) then
                    continue
                end

                if currentAssetType == Enum.AvatarAssetType.Face then
                    bool2 = true
                else
                    if currentAssetType == Enum.AvatarAssetType.DynamicHead then
                        bool1 = true
                    end

                    for value3, _ in var1 do
                        local str1 = `rbxthumb://type=Asset&id={value3}&w=150&h=150`
                        if bool1 and FFlagEnableSlotsHeadShapeThumbnail then
                            local headShapeFromEquippedAssets = getHeadShapeFromEquippedAssets(tbl2)

                            if headShapeFromEquippedAssets then
                                str1 = `rbxthumb://type=Asset&id={value3}&headshape={headShapeFromEquippedAssets}&w=150&h=150`
                            end
                        end

                        table.insert(slots, buildSlotSubcategory(value, str1, currentAssetType))
                        bool3 = true
                    end
                end
            end

            for _, currentAssetType in assetTypes do
                if currentAssetType == Enum.AvatarAssetType.Face and (bool1 or bool2) then
                    table.insert(slots, buildSlotSubcategory(value, getClassicFaceOrDynamicHeadThumbnail(tbl2, bool1), currentAssetType))
                    bool3 = true
                end
            end

            if not bool3 then
                table.insert(slots, buildSlotSubcategory(value, nil, nil))
            end
        end
    end

    return slots
end

return buildSlots
