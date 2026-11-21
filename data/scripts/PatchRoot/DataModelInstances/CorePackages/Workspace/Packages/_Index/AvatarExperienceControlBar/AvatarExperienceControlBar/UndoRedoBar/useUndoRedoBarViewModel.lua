-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceControlBar = script:FindFirstAncestor("AvatarExperienceControlBar")

local AvatarExperienceControlBarParent = AvatarExperienceControlBar.Parent
local React = require(AvatarExperienceControlBarParent.React)
local AvatarExperienceSave = require(AvatarExperienceControlBarParent.AvatarExperienceSave)
local AvatarExperienceCommon = require(AvatarExperienceControlBarParent.AvatarExperienceCommon)
local SignalsReact = require(AvatarExperienceControlBarParent.SignalsReact)
local Navigation = require(AvatarExperienceControlBarParent.Navigation)
local AvatarExperienceNavigation = require(AvatarExperienceControlBarParent.AvatarExperienceNavigation)
local AvatarExperienceAnalytics = require(AvatarExperienceControlBarParent.AvatarExperienceAnalytics)
local AvatarExperienceFlags = require(AvatarExperienceControlBarParent.AvatarExperienceFlags)
local Foundation = require(AvatarExperienceControlBarParent.Foundation)
local ToastRodux = require(AvatarExperienceControlBarParent.ToastRodux)
local tutils = require(AvatarExperienceControlBarParent.tutils)

local IconName = Foundation.Enums.IconName

local FFlagAXExtendUndoRedoTracking = AvatarExperienceFlags.FFlagAXExtendUndoRedoTracking

local FFlagAXMigrateBuilderIcons = AvatarExperienceFlags.FFlagAXMigrateBuilderIcons
local FFlagAXResetAvatarButton = AvatarExperienceFlags.FFlagAXResetAvatarButton

local SlotBasedEditorAnalytics = AvatarExperienceAnalytics.Surfaces.SlotBasedEditorAnalytics

local SetCurrentToastMessage = ToastRodux.Actions.SetCurrentToastMessage
local ToastType = ToastRodux.Enums.ToastType

local useSelectorSignal = AvatarExperienceCommon.Hooks.useSelectorSignal
local useTokens = Foundation.Hooks.useTokens

local useDispatch = require(AvatarExperienceControlBarParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useAvatarSaveContext = AvatarExperienceSave.Context.useAvatarSaveContext
local useNavigation = Navigation.useNavigation
local useAvatarRoute = AvatarExperienceNavigation.AvatarRoute.Hooks.useAvatarRoute
local AvatarScreen = AvatarExperienceNavigation.Enums.AvatarScreen

local CharacterHistoryStateChangeButtonActivated = AvatarExperienceCommon.State.Actions.CharacterHistoryStateChangeButtonActivated
local ClearScreens = AvatarExperienceNavigation.Actions.ClearScreens

local MenuItemEnum = require(AvatarExperienceControlBar.Enums.MenuItemEnum)
local selectCharacterData = if FFlagAXResetAvatarButton then AvatarExperienceSave.Selectors.selectCharacterData else nil
local ClearTryOns = require(AvatarExperienceControlBarParent.AvatarExperienceRodux).Actions.ClearTryOns

local _ControlBarTypes = require(AvatarExperienceControlBar.ControlBarTypes)
local Constants = require(AvatarExperienceControlBar.Constants)

local var1 = FFlagAXResetAvatarButton
    and {
        toastMessage = "Feature.Avatar.Message.OutfitCleared",
        isLocalized = false,
        toastType = ToastType.SuccessConfirmation
    }
    or nil

local function useUndoRedoBarViewModel()
    local var2 = useNavigation()
    local var3 = useDispatch()
    local var4 = if FFlagAXMigrateBuilderIcons then useTokens() else nil
    local var5 = useAvatarSaveContext()
    local getHistorySignal = var5.getHistorySignal
    local getCurrentHistoryIndexSignal = var5.getCurrentHistoryIndexSignal
    local var6 = if FFlagAXResetAvatarButton then useSelectorSignal(selectCharacterData, tutils.deepEqual) else nil
    local var7 = if FFlagAXExtendUndoRedoTracking then useAvatarRoute() else nil
    local var8 = SignalsReact.useSignalState(getHistorySignal)
    local var9 = SignalsReact.useSignalState(getCurrentHistoryIndexSignal)
    local var10 = if FFlagAXResetAvatarButton then SignalsReact.useSignalState(var6) else nil

    local disabled = React.useMemo(function(): boolean
        local var11 = var9
        return not (var11 and var8) or var11 == 1
    end, { var9, var8 })

    local var11 = React.useMemo(function(): boolean
        local var12 = var9
        return not (var12 and var8) or var12 == #var8
    end, { var9, var8 })

    local var12 = if FFlagAXResetAvatarButton then React.useMemo(function()
        if var10 and var10.tryOn and var10.tryOn.OutfitTryOn and next(var10.tryOn.OutfitTryOn.TryOnItems) ~= nil then
            return false
        end

        if not (var10 and var10.equipped and var10.equipped.EquippedAssets) then
            return true
        end

        for k in var10.equipped.EquippedAssets do
            if table.find(Constants.AssetTypeStringsToKeep, k) == nil then
                return false
            end
        end

        return true
    end, { var10, var8 }) else nil

    local var14 = React.useCallback(function(isUndo: boolean)
        if not var5 then
            return
        end

        local var14 = var5.updateHistoryIndexAndGetCharacterData(var9 + (if isUndo then -1 else 1))

        if not var14 then
            return
        end

        SlotBasedEditorAnalytics.trackUndoRedoClick(
            isUndo,
            if FFlagAXExtendUndoRedoTracking and var7 and var7.opaque then var7.opaque.name else nil
        )

        var3(CharacterHistoryStateChangeButtonActivated({ isUndo = isUndo, equipped = var14.equipped, tryOn = var14.tryOn }))

        var2.dispatch(ClearScreens({ AvatarScreen.LookDetails }))
    end, {
        var3,
        var5,
        var9,
        var2,
        var7,
        var8
    })

    local var15 = if FFlagAXResetAvatarButton then React.useCallback(function()
        local var15 = var6(false)

        if not var15 then
            return
        end

        if SlotBasedEditorAnalytics.trackAvatarRemoveAllClick and var7 and var7.opaque then
            SlotBasedEditorAnalytics.trackAvatarRemoveAllClick(var7.opaque.name)
        end

        local equippedAssets = ({})

        for _, value in Constants.AssetTypeStringsToKeep do
            equippedAssets[value] = var15.equipped.EquippedAssets[value]
        end

        var15.equipped.EquippedAssets = equippedAssets

        var3(CharacterHistoryStateChangeButtonActivated(var15))

        var3(ClearTryOns())

        var3(SetCurrentToastMessage(var1))
    end, { var3 }) else nil

    if FFlagAXExtendUndoRedoTracking then
        React.useEffect(function()
            if SlotBasedEditorAnalytics.trackUndoHistoryCount and var7 and var7.opaque and var8 and #var8 then
                SlotBasedEditorAnalytics.trackUndoHistoryCount(var7.opaque.name, #var8)
            end
        end, { var8, var7 })
    end

    return {
        items = React.useMemo(function(): {{disabled: any, icon: any, id: any, isActive: boolean, onActivated: () -> (), type: string}} | {{disabled: any, icon: any, iconSize: any, id: any, isActive: boolean, onActivated: () -> (), type: string} | {disabled: any, icon: any, id: any, isActive: boolean, onActivated: () -> (), type: string}}
            if not FFlagAXResetAvatarButton then
                return {
                    {
                        type = "icon",
                        id = MenuItemEnum.Undo,
                        icon = if FFlagAXMigrateBuilderIcons then IconName.ArrowCurlToLeft else "icons/actions/edit/undo",
                        onActivated = function()
                            var14(true)
                        end,
                        disabled = disabled,
                        isActive = false
                    },
                    {
                        type = "icon",
                        id = MenuItemEnum.Redo,
                        icon = if FFlagAXMigrateBuilderIcons then IconName.ArrowCurlToRight else "icons/actions/edit/redo",
                        onActivated = function()
                            var14(false)
                        end,
                        disabled = var11,
                        isActive = false
                    }
                }
            end

            return {
                {
                    type = "icon",
                    id = MenuItemEnum.Reset.Reset,
                    icon = IconName.ArrowSpinClockwise,
                    iconSize = var4.Size.Size_500,
                    isActive = false,
                    onActivated = function()
                        var15()
                    end,
                    disabled = var12
                },
                {
                    type = "icon",
                    id = MenuItemEnum.Undo,
                    icon = if FFlagAXMigrateBuilderIcons then IconName.ArrowCurlToLeft else "icons/actions/edit/undo",
                    onActivated = function()
                        var14(true)
                    end,
                    disabled = disabled,
                    isActive = false
                },
                {
                    type = "icon",
                    id = MenuItemEnum.Redo,
                    icon = if FFlagAXMigrateBuilderIcons then IconName.ArrowCurlToRight else "icons/actions/edit/redo",
                    onActivated = function()
                        var14(false)
                    end,
                    disabled = var11,
                    isActive = false
                }
            }
        end, FFlagAXResetAvatarButton and {
            disabled,
            var11,
            var12,
            var14,
            var15
        } or { disabled, var11, var14 })
    }
end
return useUndoRedoBarViewModel
