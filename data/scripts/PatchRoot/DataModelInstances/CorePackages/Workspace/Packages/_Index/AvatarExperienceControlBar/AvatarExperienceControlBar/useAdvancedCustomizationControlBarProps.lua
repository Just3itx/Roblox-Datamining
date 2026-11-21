-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceControlBar = script:FindFirstAncestor("AvatarExperienceControlBar")

local AvatarExperienceControlBarParent = AvatarExperienceControlBar.Parent
local React = require(AvatarExperienceControlBarParent.React)
local Foundation = require(AvatarExperienceControlBarParent.Foundation)
local Navigation = require(AvatarExperienceControlBarParent.Navigation)
local AvatarExperienceNavigation = require(AvatarExperienceControlBarParent.AvatarExperienceNavigation)
local useSelector = require(AvatarExperienceControlBarParent.RoactUtils).Hooks.RoactRodux.useSelector
local AvatarExperienceCommon = require(AvatarExperienceControlBarParent.AvatarExperienceCommon)
local AvatarExperienceAnalytics = require(AvatarExperienceControlBarParent.AvatarExperienceAnalytics)

local selectColorAdjustmentButtonColor = AvatarExperienceCommon.State.Selectors.selectColorAdjustmentButtonColor
local selectHasDynamicHead = AvatarExperienceCommon.State.Selectors.selectHasDynamicHead
local SlotBasedEditorAnalytics = AvatarExperienceAnalytics.Surfaces.SlotBasedEditorAnalytics

local useTokens = Foundation.Hooks.useTokens
local useNavigation = Navigation.useNavigation
local useAvatarRoute = AvatarExperienceNavigation.AvatarRoute.Hooks.useAvatarRoute

local AvatarScreen = AvatarExperienceNavigation.Enums.AvatarScreen

local MenuItemEnum = require(AvatarExperienceControlBar.Enums.MenuItemEnum)
local _ControlBarTypes = require(AvatarExperienceControlBar.ControlBarTypes)

local IconName = Foundation.Enums.IconName
local IconVariant = Foundation.Enums.IconVariant

local AvatarExperienceFlags = require(AvatarExperienceControlBarParent.AvatarExperienceFlags)
local FFlagAXMigrateBuilderIcons = AvatarExperienceFlags.FFlagAXMigrateBuilderIcons
local FFlagAXHideHeadAdjustmentForDefaultHead = AvatarExperienceFlags.FFlagAXHideHeadAdjustmentForDefaultHead

local function useAdvancedCustomizationControlBarProps(arg1)
    local var1 = useTokens()
    local var2 = useNavigation()
    local var3 = useAvatarRoute()

    local var4 = useSelector(selectColorAdjustmentButtonColor)

    local size600 = var1.Size.Size_600

    local name = arg1.avatarRoute and arg1.avatarRoute.opaque and arg1.avatarRoute.opaque.name

    local onActivated = React.useCallback(function()
        var2.navigate(AvatarScreen.AccessoryAdjustment)
        if var3 and var3.opaque then
            SlotBasedEditorAnalytics.trackAdvancedCustomizationControlBarClickFromSurface(
                MenuItemEnum.AvatarRefinement.AdjustAccessory,
                var3.opaque.name
            )
        end
    end, { var2, var3 })

    local var5 = React.useCallback(function()
        var2.navigate(AvatarScreen.BodyShape)
        if var3 and var3.opaque then
            SlotBasedEditorAnalytics.trackAdvancedCustomizationControlBarClickFromSurface(
                MenuItemEnum.AvatarRefinement.BodyScale,
                var3.opaque.name
            )
        end
    end, { var2, var3 })

    local var6 = React.useCallback(function()
        var2.navigate(AvatarScreen.HeadRefinement)
        if var3 and var3.opaque then
            SlotBasedEditorAnalytics.trackAdvancedCustomizationControlBarClickFromSurface(
                MenuItemEnum.AvatarRefinement.CustomizeHead,
                var3.opaque.name
            )
        end
    end, { var2, var3 })

    local var7 = React.useCallback(function()
        if var3 and var3.current and var3.current.name == AvatarScreen.LayeredMakeupSort then
            var2.pop()
        end
        var2.navigate(AvatarScreen.LayeredClothingSort)

        if var3 and var3.opaque then
            SlotBasedEditorAnalytics.trackAdvancedCustomizationControlBarClickFromSurface(
                MenuItemEnum.AvatarRefinement.ClothingLayers,
                var3.opaque.name
            )
        end
    end, { var2, var3 })

    local var8 = React.useCallback(function()
        if var3 and var3.current and var3.current.name == AvatarScreen.LayeredClothingSort then
            var2.pop()
        end
        var2.navigate(AvatarScreen.LayeredMakeupSort)

        if var3 and var3.opaque then
            SlotBasedEditorAnalytics.trackAdvancedCustomizationControlBarClickFromSurface(
                MenuItemEnum.AvatarRefinement.MakeupLayers,
                var3.opaque.name
            )
        end
    end, { var2, var3 })

    local var9 = React.useCallback(function()
        var2.navigate(AvatarScreen.ColorAdjustment)
        if var3 and var3.opaque then
            SlotBasedEditorAnalytics.trackAdvancedCustomizationControlBarClickFromSurface(
                MenuItemEnum.AvatarRefinement.ColorAdjustment,
                var3.opaque.name
            )
        end
    end, { var2, var3 })

    local var11 = if FFlagAXHideHeadAdjustmentForDefaultHead then useSelector(selectHasDynamicHead) else nil
    local useMemo = React.useMemo
    local function func1()
        return {
            {
                type = "icon",
                id = MenuItemEnum.AvatarRefinement.AdjustAccessory,
                icon = if FFlagAXMigrateBuilderIcons then IconName.HatFedora else "icons/menu/clothing/hats_off",
                activeIcon = if FFlagAXMigrateBuilderIcons then IconName.HatFedora else "icons/menu/clothing/hats_on",
                activeIconVariant = if FFlagAXMigrateBuilderIcons then IconVariant.Filled else nil,
                onActivated = onActivated,
                isActive = name == AvatarScreen.AccessoryAdjustment,
                iconSize = size600
            },
            {
                type = "icon",
                id = MenuItemEnum.AvatarRefinement.BodyScale,
                icon = if FFlagAXMigrateBuilderIcons then IconName.PersonStandingDualArrowsVertical else "icons/menu/clothing/build_off",
                activeIcon = if FFlagAXMigrateBuilderIcons then IconName.PersonStandingDualArrowsVertical else "icons/menu/clothing/build_on",
                activeIconVariant = if FFlagAXMigrateBuilderIcons then IconVariant.Filled else nil,
                onActivated = var5,
                isActive = name == AvatarScreen.BodyShape,
                iconSize = size600
            },
            {
                type = "icon",
                id = MenuItemEnum.AvatarRefinement.CustomizeHead,
                icon = if FFlagAXMigrateBuilderIcons then IconName.HeadBlank else "icons/menu/clothing/classicHead_off",
                activeIcon = if FFlagAXMigrateBuilderIcons then IconName.HeadBlank else "icons/menu/clothing/classicHead_on",
                activeIconVariant = if FFlagAXMigrateBuilderIcons then IconVariant.Filled else nil,
                onActivated = var6,
                isActive = name == AvatarScreen.HeadRefinement,
                iconSize = size600,
                visible = if FFlagAXHideHeadAdjustmentForDefaultHead then var11 else nil
            },
            {
                type = "icon",
                id = MenuItemEnum.AvatarRefinement.ClothingLayers,
                icon = if FFlagAXMigrateBuilderIcons then IconName.ClothesHanger else "icons/menu/clothing/clothing_off",
                activeIcon = if FFlagAXMigrateBuilderIcons then IconName.ClothesHanger else "icons/menu/clothing/clothing_on",
                activeIconVariant = if FFlagAXMigrateBuilderIcons then IconVariant.Filled else nil,
                onActivated = var7,
                isActive = name == AvatarScreen.LayeredClothingSort,
                iconSize = size600
            },
            {
                type = "icon",
                id = MenuItemEnum.AvatarRefinement.MakeupLayers,
                icon = if FFlagAXMigrateBuilderIcons then IconName.LipsLipstickMakeupBrush else "icons/menu/clothing/eyelash_on",
                activeIcon = if FFlagAXMigrateBuilderIcons then IconName.LipsLipstickMakeupBrush else "icons/menu/clothing/eyelash_off",
                activeIconVariant = if FFlagAXMigrateBuilderIcons then IconVariant.Filled else nil,
                onActivated = var8,
                isActive = name == AvatarScreen.LayeredMakeupSort,
                iconSize = size600
            },
            var4
                and {
                    type = "color",
                    id = MenuItemEnum.AvatarRefinement.ColorAdjustment,
                    colorSize = size600,
                    colors = { var4 },
                    onActivated = var9,
                    isActive = name == AvatarScreen.ColorAdjustment,
                    Selectable = true
                }
                or nil
        }
    end

    local var12 = if FFlagAXHideHeadAdjustmentForDefaultHead then var11 else nil
    return {
        config = useMemo(func1, { name, onActivated, var5, var6, var7, var8, var9, var4, var12 })
    }
end
return useAdvancedCustomizationControlBarProps
