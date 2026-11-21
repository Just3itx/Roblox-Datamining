-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent
local HttpService = game:GetService("HttpService")

local React = require(AvatarExperienceProfilePictureEditorParent.React)
local FFlagEditProfileFramesEnabled = require(AvatarExperienceProfilePictureEditorParent.SharedFlags).FFlagEditProfileFramesEnabled
local useLocalUserId = require(AvatarExperienceProfilePictureEditorParent.RobloxAppHooks).useLocalUserId
local Localization = require(AvatarExperienceProfilePictureEditorParent.Localization)
local RoactUtils = require(AvatarExperienceProfilePictureEditorParent.RoactUtils)

local useProfileFrames = require(AvatarExperienceProfilePictureEditor.Hooks.useProfileFrames)
local useUserAvatarConfigurations = require(AvatarExperienceProfilePictureEditor.Hooks.useUserAvatarConfigurations)
local useProfileFramesGating = require(AvatarExperienceProfilePictureEditor.Hooks.useProfileFramesGating)
local useEditProfileImageDraft = require(AvatarExperienceProfilePictureEditor.Hooks.useEditProfileImageDraft)
local useEditProfileImageEmotes = require(AvatarExperienceProfilePictureEditor.Hooks.useEditProfileImageEmotes)
local useEditProfileImageNavigation = require(AvatarExperienceProfilePictureEditor.Hooks.useEditProfileImageNavigation)
local useEditProfileImageSave = require(AvatarExperienceProfilePictureEditor.Hooks.useEditProfileImageSave)
local useFocusOnMountEffect = require(AvatarExperienceProfilePictureEditorParent.AvatarExperienceCommon).Hooks.useFocusOnMountEffect

local openProfileFramesSubscriptionUpsell = require(AvatarExperienceProfilePictureEditor.Utils.openProfileFramesSubscriptionUpsell)
local editProfileImageHelpers = require(AvatarExperienceProfilePictureEditor.Utils.editProfileImageHelpers)
local buildEditProfileImageAssetItems = require(AvatarExperienceProfilePictureEditor.Utils.buildEditProfileImageAssetItems)
local _AssetPickerTile = require(AvatarExperienceProfilePictureEditor.Components.AssetPicker.AssetPickerTile)
local EditProfileImageAnalytics = require(AvatarExperienceProfilePictureEditor.Analytics.EditProfileImageAnalytics)
local _Enums = require(AvatarExperienceProfilePictureEditor.Common.Enums)
local Constants = require(AvatarExperienceProfilePictureEditor.Constants)
local TextKeys = require(AvatarExperienceProfilePictureEditor.Common.TextKeys)

local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useLocalization = Localization.Hooks.useLocalization

local function useEditProfileImageViewModel(tbl1)
    local dispatch = useDispatch()
    local localUserId = useLocalUserId()
    local savedCloseupConfig, savedFrameAssetId, isSavedConfigLoading = useUserAvatarConfigurations(localUserId)
    local var6 = useProfileFrames()
    local var7 = useProfileFramesGating()
    local bool1 = var7.shouldShowFrames == true
    local isInitialFrameAvailable = React.useMemo(function()
        if tbl1.initialFrameAssetId == nil then
            return false
        end
        for _, frameItem in var6.frameItems do
            if frameItem.id == tbl1.initialFrameAssetId then
                return true
            end
        end
        return false
    end, { tbl1.initialFrameAssetId, var6.frameItems })

    local var9 = useEditProfileImageDraft({
        savedCloseupConfig = savedCloseupConfig,
        savedFrameAssetId = savedFrameAssetId,
        isSavedConfigLoading = isSavedConfigLoading,
        showFrames = bool1,
        initialFrameAssetId = tbl1.initialFrameAssetId,
        initialFrameSelectionRequestId = tbl1.initialFrameSelectionRequestId,
        isInitialFrameSelectionLoading = not (tbl1.initialFrameAssetId == nil) and var6.isLoading,
        isInitialFrameAvailable = isInitialFrameAvailable
    })
    local var10 = useEditProfileImageNavigation({ mode = tbl1.mode })

    local var11 = useEditProfileImageEmotes({ selectedEmoteId = var9.selectedEmoteId })

    local var12, var13 = React.useState(false)
    local var14 = var7.canEquipFrame or var12
    local shouldShowUpsell = var7.shouldShowUpsell and not var12
    local onGranted = React.useCallback(function()
        var13(true)
        var7.refetchAmpAccess()
    end, { var7.refetchAmpAccess })
    local onOpenSubscriptionUpsell = React.useCallback(function(source)
        local purchaseFlowUuid = HttpService:GenerateGUID(false)
        local var17 = if var9.selectedFrameId == nil or var9.selectedFrameId == Constants.ProfileFrameNoneId then nil else tonumber(var9.selectedFrameId)
        EditProfileImageAnalytics.logSubscribe(
            {
                mode = tbl1.mode,
                purchaseFlowUuid = purchaseFlowUuid,
                frameAssetId = var17,
                source = source
            }
        )
        openProfileFramesSubscriptionUpsell({ dispatch = dispatch, onGranted = onGranted, purchaseFlowUuid = purchaseFlowUuid })
    end, {
        dispatch,
        var9.selectedFrameId,
        onGranted,
        tbl1.mode
    })
    local selectedImage = React.useMemo(function()
        if not var9.selectedFrameId or var9.selectedFrameId == Constants.ProfileFrameNoneId then
            return nil
        end
        for _, frameItem in var6.frameItems do
            if frameItem.id == var9.selectedFrameId then
                return frameItem.previewImage or frameItem.image
            end
        end
        return nil
    end, { var9.selectedFrameId, var6.frameItems })

    local var19 = useLocalization({ frames = TextKeys.Frames, subscribe = TextKeys.Subscribe, save = TextKeys.Save })

    local var20 = React.useMemo(function()
        return buildEditProfileImageAssetItems({
            ownedEmotes = var11.ownedEmotes,
            recommendedEmotes = var11.recommendedEmotes,
            frameItems = var6.frameItems,
            freeLabel = var11.freeLabel
        })
    end, {
        var11.ownedEmotes,
        var11.recommendedEmotes,
        var6.frameItems,
        var11.freeLabel
    })

    local var21 = useEditProfileImageSave({
        mode = tbl1.mode,
        activeView = var10.activeView,
        titleBackAvailable = var10.titleBackAvailable,
        selectedEmoteId = var9.selectedEmoteId,
        savedEmoteAssetId = savedCloseupConfig.emoteAssetId,
        selectedFrameId = var9.selectedFrameId,
        showFrames = bool1,
        distanceScale = var9.distanceScale,
        yRotDeg = var9.yRotDeg,
        cutoutFieldOfViewDeg = tbl1.cutoutFieldOfViewDeg,
        localUserId = localUserId,
        isPlusSubscriber = if var7.ampAccess then var7.ampAccess.granted else false,
        dispatch = dispatch,
        onReturnToCombined = var10.onReturnToCombined,
        onClose = tbl1.onClose,
        onSaveSuccess = tbl1.onSaveSuccess
    })

    local onLeaveScreen = React.useCallback(function()
        var9.resetFromSavedConfig()
        var21.resetTransientState()
        tbl1.onClose()
    end, { var9.resetFromSavedConfig, var21.resetTransientState, tbl1.onClose })

    local onBack = React.useCallback(function()
        local var23, str1

        if var10.isFramesOnlyEntry then
            var23 = onLeaveScreen
            str1 = "exit"
        elseif var10.activeView == "emotes" and not FFlagEditProfileFramesEnabled then
            if var11.isRecommendedEmoteSelected then
                var23 = var9.clearSelectedEmote
                str1 = "clear_emote"
            else
                var23 = onLeaveScreen
                str1 = "exit"
            end
        elseif var10.titleBackAvailable then
            var23 = var10.onReturnToCombined
            str1 = "return_to_combined"
        elseif var11.isRecommendedEmoteSelected then
            var23 = var9.clearSelectedEmote
            str1 = "clear_emote"
        else
            var23 = onLeaveScreen
            str1 = "exit"
        end

        EditProfileImageAnalytics.logBack({ mode = tbl1.mode, activeView = var10.activeView, outcome = str1 })

        var23()
    end, {
        tbl1.mode,
        var10.isFramesOnlyEntry,
        var10.activeView,
        var10.titleBackAvailable,
        var10.onReturnToCombined,
        var11.isRecommendedEmoteSelected,
        onLeaveScreen,
        var9.clearSelectedEmote
    })

    local onRetry = React.useCallback(function()
        EditProfileImageAnalytics.logRetry({ mode = tbl1.mode, assetType = "emotes" })

        var11.onRetry()
    end, { tbl1.mode, var11.onRetry })

    local var1 = React.useCallback(function()
        EditProfileImageAnalytics.logRetry({ mode = tbl1.mode, assetType = "frames" })

        var6.refetch()
    end, { tbl1.mode, var6.refetch })

    local bool2 = FFlagEditProfileFramesEnabled and bool1 and not var14

    if bool2 then
        if var9.selectedFrameId == nil then
            bool2 = false
        else
            bool2 = var9.selectedFrameId ~= Constants.ProfileFrameNoneId
        end
    end

    local cta = editProfileImageHelpers.resolveFooterCta({
        isFramesOnlyEntry = var10.isFramesOnlyEntry,
        isRecommendedEmoteSelected = var11.isRecommendedEmoteSelected,
        isEquipRestrictedFrameSelected = bool2
    })

    local closeButtonRef = React.useRef(nil)
    useFocusOnMountEffect(closeButtonRef, 0)

    return {
        navigation = {
            activeView = var10.activeView,
            closeButtonRef = closeButtonRef,
            onExpandEmotes = var10.onExpandEmotes,
            onExpandFrames = var10.onExpandFrames,
            onTitleBack = var10.onTitleBack,
            onBack = onBack,
            onLeaveScreen = onLeaveScreen,
            onDidFocus = var21.resetTransientState
        },
        emotes = {
            selectedEmoteId = var9.selectedEmoteId,
            ownedItems = var20.ownedEmoteItems,
            recommendedItems = var20.recommendedEmoteItems,
            items = var20.combinedEmoteItems,
            isLoading = var11.isLoading,
            hasError = var11.hasError,
            hasMore = var11.hasMoreEmotes,
            isLoadingMore = var11.isLoadingMoreEmotes,
            hasLoadMoreError = var11.hasLoadMoreError,
            onSelect = var9.onSelectEmote,
            onRetry = onRetry,
            onMore = var11.onMoreEmotes
        },
        frames = {
            show = bool1,
            shouldShowUpsell = shouldShowUpsell,
            selectedFrameId = var9.selectedFrameId,
            items = var20.frameAssetItems,
            isLoading = var6.isLoading,
            hasError = var6.hasError,
            selectedImage = selectedImage,
            localizedTitle = var19.frames,
            onSelect = var9.onSelectFrame,
            onRetry = var1,
            onOpenSubscriptionUpsell = onOpenSubscriptionUpsell
        },
        preview = {
            localUserId = localUserId,
            yRotDeg = var9.yRotDeg,
            distanceScale = var9.distanceScale,
            onYRotDegChanged = var9.onYRotDegChanged,
            onDistanceScaleChanged = var9.onDistanceScaleChanged
        },
        footer = {
            isSaving = var21.isSaving,
            cta = cta,
            subscribeLabel = var19.subscribe,
            saveLabel = var19.save,
            onSave = var21.onSave
        }
    }
end

return useEditProfileImageViewModel
