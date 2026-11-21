-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceControlBar = script:FindFirstAncestor("AvatarExperienceControlBar")

local AvatarExperienceControlBarParent = AvatarExperienceControlBar.Parent
local React = require(AvatarExperienceControlBarParent.React)
local UserLib = require(AvatarExperienceControlBarParent.UserLib)
local Navigation = require(AvatarExperienceControlBarParent.Navigation)
local AvatarExperienceNavigation = require(AvatarExperienceControlBarParent.AvatarExperienceNavigation)
local Localization = require(AvatarExperienceControlBarParent.Localization)
local AvatarExperienceCommon = require(AvatarExperienceControlBarParent.AvatarExperienceCommon)
local AvatarExperienceAnalytics = require(AvatarExperienceControlBarParent.AvatarExperienceAnalytics)
local Foundation = require(AvatarExperienceControlBarParent.Foundation)

local selectColorAdjustmentButtonColor = AvatarExperienceCommon.State.Selectors.selectColorAdjustmentButtonColor
local selectHasDynamicHead = AvatarExperienceCommon.State.Selectors.selectHasDynamicHead
local SlotBasedEditorAnalytics = AvatarExperienceAnalytics.Surfaces.SlotBasedEditorAnalytics

local useSelector = require(AvatarExperienceControlBarParent.RoactUtils).Hooks.RoactRodux.useSelector
local useNavigation = Navigation.useNavigation
local useAvatarRoute = AvatarExperienceNavigation.AvatarRoute.Hooks.useAvatarRoute
local useSemanticTokens = require(AvatarExperienceControlBar.Hooks.useSemanticTokens)
local useLocalization = Localization.Hooks.useLocalization

local useUndoRedoBarViewModel = require(script.Parent.UndoRedoBar.useUndoRedoBarViewModel)

local IconName = Foundation.Enums.IconName
local PopoverAlign = Foundation.Enums.PopoverAlign

local AvatarScreen = AvatarExperienceNavigation.Enums.AvatarScreen
local getRbxthumbWithTypeSizeAndOptions = UserLib.Utils.getRbxthumbWithTypeSizeAndOptions
local Constants = UserLib.Utils.Constants

local MenuItemEnum = require(AvatarExperienceControlBar.Enums.MenuItemEnum)
local _ControlBarTypes = require(AvatarExperienceControlBar.ControlBarTypes)

local AvatarExperienceFlags = require(AvatarExperienceControlBarParent.AvatarExperienceFlags)
local FFlagAXAvatarSharingEntryPoint = AvatarExperienceFlags.FFlagAXAvatarSharingEntryPoint
local FFlagAXMigrateBuilderIcons = AvatarExperienceFlags.FFlagAXMigrateBuilderIcons
local FFlagAXResetAvatarButton = require(AvatarExperienceControlBarParent.AvatarExperienceFlags).FFlagAXResetAvatarButton

local FFlagAXHideHeadAdjustmentForDefaultHead = require(AvatarExperienceControlBarParent.AvatarExperienceFlags).FFlagAXHideHeadAdjustmentForDefaultHead
local FFlagAXFavoritesManagerNavEntry = require(AvatarExperienceControlBarParent.AvatarExperienceFlags).FFlagAXFavoritesManagerNavEntry
local FFlagAXUseProfileIconEntryPoint = AvatarExperienceFlags.FFlagAXUseProfileIconEntryPoint
local FFlagMeProfileEntryTooltipEnabled = AvatarExperienceFlags.FFlagMeProfileEntryTooltipEnabled
local FFlagMeProfileEntryTooltipVerticalCenter = AvatarExperienceFlags.FFlagMeProfileEntryTooltipVerticalCenter
local useMeProfileEntryTooltip = require(AvatarExperienceControlBar.Hooks.useMeProfileEntryTooltip)
local FFlagControlBarUseProfileFrameThumbnail = AvatarExperienceFlags.FFlagControlBarUseProfileFrameThumbnail
local FFlagAXPPEReturnToEntrySurface = require(AvatarExperienceControlBarParent.SharedFlags).FFlagAXPPEReturnToEntrySurface
local FFlagEditProfileImageV2Enabled = require(AvatarExperienceControlBarParent.SharedFlags).FFlagEditProfileImageV2Enabled

local AvatarHeadShot = Constants.RbxthumbTypes.AvatarHeadShot

local tbl1 = {
    [AvatarScreen.Catalog] = true,
    [AvatarScreen.AvatarEditor] = true,
    [AvatarScreen.MySharedAvatars] = true,
    [AvatarScreen.CatalogSearch] = true,
    [AvatarScreen.CatalogSearchLanding] = true,
    [AvatarScreen.SearchLandingFocusedWidgetPage] = true
}

local function selectUserId(arg1)
    return arg1.LocalUserId
end

local function useCustomizeControlBarProps(arg1)
    local var1 = useSemanticTokens()
    local var2 = useNavigation()
    local var3 = if FFlagAXUseProfileIconEntryPoint or FFlagAXPPEReturnToEntrySurface then useAvatarRoute() else nil

    local bool1 = FFlagAXUseProfileIconEntryPoint

    if bool1 then
        if var3 == nil then
            bool1 = false
        else
            bool1 = var3.opaque.name == AvatarScreen.Profile
        end
    end

    local var4 = useSelector(selectColorAdjustmentButtonColor)
    local var5 = useSelector(selectUserId)
    local var6 = nil
    if FFlagMeProfileEntryTooltipEnabled then
        local var7 = useMeProfileEntryTooltip
        local bool2

        if var3 == nil then
            bool2 = false
        else
            bool2 = var3.isVisible and not var3.isOverlayVisible

            if bool2 then
                if var3.current.key == var2.state.key then
                    bool2 = tbl1[var3.current.name] == true
                else
                    bool2 = false
                end
            end
        end

        var6 = var7(bool2, if var3 then var3.current.key else nil)
    end

    local var7 = useLocalization({
        profileTooltip = if FFlagMeProfileEntryTooltipEnabled then "Feature.Avatar.profile.tooltip" else nil,
        adjustAccessory = "Feature.Avatar.Label.Title.AccessoryAdjustment",
        bodyShape = "Feature.Avatar.Label.Title.BodyShape",
        clothingLayering = "Feature.Avatar.Label.Title.ClothingLayering",
        makeupLayering = "Feature.Avatar.Label.Title.MakeupLayering",
        headAdjustment = "Feature.Avatar.Label.Title.HeadAdjustment",
        profilePhoto = "Feature.Avatar.Label.Title.ProfilePhoto",
        skinColor = "Feature.Avatar.ColorAdjustmentPage.Title",
        shareAvatar = if FFlagAXAvatarSharingEntryPoint then "Feature.Avatar.Action.ShareAvatar" else nil,
        myPublishedAvatars = if FFlagAXAvatarSharingEntryPoint then "Feature.Avatar.Action.MyPublishedAvatars" else nil
    })

    local onActivated = React.useCallback(function()
        var2.navigate(AvatarScreen.AccessoryAdjustment)
        SlotBasedEditorAnalytics.trackControlBarClick(MenuItemEnum.AvatarRefinement.AdjustAccessory)
    end, { var2 })

    local var8 = React.useCallback(function()
        var2.navigate(AvatarScreen.BodyShape)
        SlotBasedEditorAnalytics.trackControlBarClick(MenuItemEnum.AvatarRefinement.BodyScale)
    end, { var2 })

    local var9 = React.useCallback(function()
        var2.navigate(AvatarScreen.HeadRefinement)
        SlotBasedEditorAnalytics.trackControlBarClick(MenuItemEnum.AvatarRefinement.CustomizeHead)
    end, { var2 })

    local var10 = React.useCallback(function()
        var2.navigate(AvatarScreen.LayeredClothingSort)
        SlotBasedEditorAnalytics.trackControlBarClick(MenuItemEnum.AvatarRefinement.ClothingLayers)
    end, { var2 })

    local var11 = React.useCallback(function()
        var2.navigate(AvatarScreen.LayeredMakeupSort)
        SlotBasedEditorAnalytics.trackControlBarClick(MenuItemEnum.AvatarRefinement.MakeupLayers)
    end, { var2 })

    local var12 = React.useCallback(function()
        var2.navigate(AvatarScreen.ColorAdjustment)
        SlotBasedEditorAnalytics.trackControlBarClick(MenuItemEnum.AvatarRefinement.ColorAdjustment)
    end, { var2 })

    local var14 = nil
    local var15 = nil
    if FFlagAXAvatarSharingEntryPoint then
        var14 = React.useCallback(function()
            local key = if var2.state and var2.state.key then var2.state.key else nil
            var2.navigate(AvatarScreen.LookComposerPage, { prevNavPage = key })

            SlotBasedEditorAnalytics.trackControlBarClick(MenuItemEnum.SharedCommunityAvatars.ShareAvatar)
        end, { var2 })

        var15 = React.useCallback(function()
            var2.navigate(AvatarScreen.MySharedAvatars)
            SlotBasedEditorAnalytics.trackControlBarClick(MenuItemEnum.SharedCommunityAvatars.MyPublishedAvatars)
        end, { var2 })
    end

    local useCallback = React.useCallback

    local function func1()
        local key = if var2.state and var2.state.key then var2.state.key else nil

        if FFlagEditProfileImageV2Enabled then
            local screenName = if var3 then var3.opaque.name else key

            if FFlagAXUseProfileIconEntryPoint and tbl1[screenName] then
                var2.navigate(
                    AvatarScreen.Profile,
                    {
                        entryOrigin = {
                            screenName = screenName,
                            screenParams = if var3 then var3.opaque.params else nil
                        }
                    }
                )

                if FFlagMeProfileEntryTooltipEnabled and var6 then
                    var6.dismiss()
                end
            elseif FFlagAXPPEReturnToEntrySurface then
                var2.navigate(
                    AvatarScreen.EditProfileImage,
                    {
                        entryOrigin = var3 and {
                            screenName = var3.opaque.name,
                            screenParams = var3.opaque.params
                        } or nil
                    }
                )
            else
                var2.navigate(AvatarScreen.EditProfileImage, { prevNavPage = key })
            end
        else
            local screenName = if var3 then var3.opaque.name else key
            local var17 = if FFlagAXUseProfileIconEntryPoint and tbl1[screenName] then AvatarScreen.Profile else AvatarScreen.ProfilePictureEditorEmotes
            local tbl2

            if var17 == AvatarScreen.Profile then
                tbl2 = {
                    entryOrigin = {
                        screenName = screenName,
                        screenParams = if var3 then var3.opaque.params else nil
                    }
                }
            else
                tbl2 = FFlagAXPPEReturnToEntrySurface
                    and {
                        entryOrigin = var3 and {
                            screenName = var3.opaque.name,
                            screenParams = var3.opaque.params
                        } or nil
                    }
                    or { prevNavPage = key }
            end

            var2.navigate(var17, tbl2)
            if FFlagMeProfileEntryTooltipEnabled and var6 and var17 == AvatarScreen.Profile then
                var6.dismiss()
            end
        end
        SlotBasedEditorAnalytics.trackControlBarClick(MenuItemEnum.More.ProfilePhoto)
    end

    local var16 = if FFlagAXUseProfileIconEntryPoint or FFlagAXPPEReturnToEntrySurface then var3 else nil
    local dismiss = if FFlagMeProfileEntryTooltipEnabled and var6 then var6.dismiss else nil
    local var13 = useCallback(func1, { var2, var16, dismiss })

    local var17 = if FFlagAXFavoritesManagerNavEntry then React.useCallback(function()
        var2.navigate(AvatarScreen.FavoritesSaved)
        SlotBasedEditorAnalytics.trackControlBarClick(MenuItemEnum.Main.Favorites)
    end, { var2 }) else nil

    local var19 = if FFlagAXHideHeadAdjustmentForDefaultHead then useSelector(selectHasDynamicHead) else nil
    local var20 = if FFlagAXResetAvatarButton then useUndoRedoBarViewModel() else nil
    local useMemo = React.useMemo
    local function func2()
        local tbl2 = {
            type = "image",
            id = MenuItemEnum.Main.AvatarSwitcher,
            thumbnailUrl = if arg1.thumbnailUrl then arg1.thumbnailUrl else getRbxthumbWithTypeSizeAndOptions(var5, AvatarHeadShot, 150, true, true, FFlagControlBarUseProfileFrameThumbnail),
            onActivated = var13,
            visible = if FFlagAXUseProfileIconEntryPoint then not bool1 else nil,
            hideIndicator = true,
            toolTipConfig = if FFlagMeProfileEntryTooltipEnabled and var6 then {
                align = if FFlagMeProfileEntryTooltipVerticalCenter then PopoverAlign.Center else nil,
                bodyText = var7.profileTooltip,
                open = var6.showTooltip,
                compact = true,
                onShown = var6.onShown,
                onDismiss = var6.dismiss
            } else nil,
            enableFocusAnimation = if arg1.focusAnimation then arg1.focusAnimation.enabled and arg1.focusAnimation.menuItemId == MenuItemEnum.Main.AvatarSwitcher else nil
        }

        local tbl4 = {
            type = "icon",
            id = MenuItemEnum.Main.AvatarRefinement,
            icon = if FFlagAXMigrateBuilderIcons then IconName.PersonStandingGear else "icons/menu/customize",
            onActivated = function()
                SlotBasedEditorAnalytics.trackControlBarClick(MenuItemEnum.Main.AvatarRefinement)
            end,
            children = {
                {
                    type = "icon",
                    id = MenuItemEnum.AvatarRefinement.AdjustAccessory,
                    text = var7.adjustAccessory,
                    icon = if FFlagAXMigrateBuilderIcons then IconName.HatFedora else "icons/menu/clothing/hats_off",
                    iconSize = var1.defaultLegacyIconSize,
                    onActivated = onActivated
                },
                {
                    type = "icon",
                    id = MenuItemEnum.AvatarRefinement.BodyScale,
                    text = var7.bodyShape,
                    icon = if FFlagAXMigrateBuilderIcons then IconName.PersonStandingDualArrowsVertical else "icons/menu/clothing/build_off",
                    iconSize = var1.defaultLegacyIconSize,
                    onActivated = var8
                },
                {
                    type = "icon",
                    id = MenuItemEnum.AvatarRefinement.CustomizeHead,
                    text = var7.headAdjustment,
                    icon = if FFlagAXMigrateBuilderIcons then IconName.HeadBlank else "icons/menu/clothing/classicHead_off",
                    iconSize = var1.defaultLegacyIconSize,
                    onActivated = var9,
                    visible = if FFlagAXHideHeadAdjustmentForDefaultHead then var19 else nil
                },
                {
                    type = "icon",
                    id = MenuItemEnum.AvatarRefinement.ClothingLayers,
                    text = var7.clothingLayering,
                    icon = if FFlagAXMigrateBuilderIcons then IconName.ClothesHanger else "icons/menu/clothing/clothing_off",
                    iconSize = var1.defaultLegacyIconSize,
                    onActivated = var10
                },
                {
                    type = "icon",
                    id = MenuItemEnum.AvatarRefinement.MakeupLayers,
                    text = var7.makeupLayering,
                    icon = if FFlagAXMigrateBuilderIcons then IconName.LipsLipstickMakeupBrush else "icons/menu/clothing/eyelash_off",
                    iconSize = var1.defaultLegacyIconSize,
                    onActivated = var11
                },
                var4
                    and {
                        type = "color",
                        id = MenuItemEnum.AvatarRefinement.ColorAdjustment,
                        text = var7.skinColor,
                        colors = { var4 },
                        colorSize = var1.defaultLegacyIconSize,
                        onActivated = var12
                    }
                    or nil
            }
        }

        local tbl5 = {
            tbl2,
            tbl4,
            FFlagAXAvatarSharingEntryPoint
                and {
                    type = "icon",
                    id = MenuItemEnum.Main.SharedCommunityAvatars,
                    icon = if FFlagAXMigrateBuilderIcons then IconName.CirclePlus else "icons/actions/edit/add",
                    onActivated = function()
                        SlotBasedEditorAnalytics.trackControlBarClick(MenuItemEnum.Main.SharedCommunityAvatars)
                    end,
                    children = {
                        {
                            type = "icon",
                            id = MenuItemEnum.SharedCommunityAvatars.ShareAvatar,
                            text = var7.shareAvatar,
                            icon = if FFlagAXMigrateBuilderIcons then IconName.PlusLarge else "icons/common/plus_heavy",
                            iconSize = var1.defaultLegacyIconSize,
                            onActivated = var14
                        },
                        {
                            type = "icon",
                            id = MenuItemEnum.SharedCommunityAvatars.MyPublishedAvatars,
                            text = var7.myPublishedAvatars,
                            icon = if FFlagAXMigrateBuilderIcons then IconName.Person else "icons/actions/friend_sort/my_profile",
                            iconSize = var1.defaultLegacyIconSize,
                            onActivated = var15
                        }
                    }
                }
                or nil
        }

        if FFlagAXFavoritesManagerNavEntry then
            table.insert(
                tbl5,
                {
                    type = "icon",
                    id = MenuItemEnum.Main.Favorites,
                    icon = IconName.Star,
                    onActivated = var17,
                    isActive = false
                }
            )
        end

        if FFlagAXResetAvatarButton and arg1.showUndoRedo then
            table.insert(tbl5, { type = "divider", id = MenuItemEnum.UndoRedoDivider })

            for _, item in var20.items do
                table.insert(tbl5, item)
            end
        end
        return tbl5
    end

    local thumbnailUrl = arg1.thumbnailUrl
    local focusAnimation = arg1.focusAnimation
    local showUndoRedo = if FFlagAXResetAvatarButton then arg1.showUndoRedo else nil
    local var21 = if FFlagAXResetAvatarButton then var20 else nil
    local var22 = if FFlagAXHideHeadAdjustmentForDefaultHead then var19 else nil
    local var23 = if FFlagAXUseProfileIconEntryPoint then bool1 else nil
    local showTooltip = if FFlagMeProfileEntryTooltipEnabled and var6 then var6.showTooltip else nil
    local name = if FFlagMeProfileEntryTooltipEnabled and var3 then var3.opaque.name else nil
    return {
        config = useMemo(func2, {
            var5,
            onActivated,
            var8,
            var9,
            var10,
            var13,
            var12,
            var4,
            thumbnailUrl,
            focusAnimation,
            showUndoRedo,
            var21,
            var22,
            var23,
            showTooltip,
            name,
            if FFlagMeProfileEntryTooltipEnabled then var7.profileTooltip else nil
        })
    }
end

return useCustomizeControlBarProps
