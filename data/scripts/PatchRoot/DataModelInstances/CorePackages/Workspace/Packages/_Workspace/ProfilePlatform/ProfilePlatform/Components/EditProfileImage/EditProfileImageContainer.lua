-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local Foundation = require(ProfilePlatformParent.Foundation)
local RoactUtils = require(ProfilePlatformParent.RoactUtils)
local NavigationRodux = require(ProfilePlatformParent.NavigationRodux)
local RobloxAppEnums = require(ProfilePlatformParent.RobloxAppEnums)
local AvatarExperienceProfilePictureEditor = require(ProfilePlatformParent.AvatarExperienceProfilePictureEditor)
local EditProfileImage = AvatarExperienceProfilePictureEditor.EditProfileImage
local Enums = AvatarExperienceProfilePictureEditor.Enums
local closeProfilePictureEditor = AvatarExperienceProfilePictureEditor.closeProfilePictureEditor
local showEditProfileImageToast = AvatarExperienceProfilePictureEditor.showEditProfileImageToast
local Enums2 = require(ProfilePlatform.Common.Enums)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local RobloxAppHooks = require(ProfilePlatformParent.RobloxAppHooks)
local FFlagEditProfileImageR15UpgradePrompt = require(ProfilePlatformParent.SharedFlags).FFlagEditProfileImageR15UpgradePrompt
local FFlagEditProfileFramesEnabled = require(ProfilePlatformParent.SharedFlags).FFlagEditProfileFramesEnabled
local FFlagEditProfileFramesImpression = require(ProfilePlatformParent.EditProfile).Flags.FFlagEditProfileFramesImpression
local FFlagSignalsNavP3hMisc = require(ProfilePlatformParent.SharedFlags).FFlagSignalsNavP3hMisc
local FFlagProfilePlatformExitStandaloneEditor = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformExitStandaloneEditor
local FFlagSplitPaneProfileEditFillPane = require(ProfilePlatformParent.SharedFlags).FFlagSplitPaneProfileEditFillPane
local SplitPane = if FFlagSplitPaneProfileEditFillPane then require(ProfilePlatformParent.SplitPane) else nil
local useReportFramesImpression = require(ProfilePlatform.Hooks.useReportFramesImpression)

local View = Foundation.View
local useScreenSize = RobloxAppHooks.useScreenSize
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useSignalState = require(ProfilePlatformParent.SignalsReact).useSignalState
local Signals = require(ProfilePlatformParent.Signals)
local Selectors = NavigationRodux.Selectors
local GetLegacyNavigationStore = NavigationRodux.GetLegacyNavigationStore
local AppPage = RobloxAppEnums.AppPage

local bool1 = game:DefineFastFlag("AXEditProfileImageFillCardHeight", false)

local function isAppItemDetailsPage(str1: string): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return str1 == AppPage.AvatarExperienceWrapper or str1 == AppPage.AvatarExperienceWrapperTransparent
end

local function EditProfileImageContainer(tbl1)
    local var1 = useProfileWrapperContext()
    local renderRecommendedEmotePurchaseFooter = var1.renderRecommendedEmotePurchaseFooter
    assert(renderRecommendedEmotePurchaseFooter, "Edit Profile Image requires a host purchase-footer renderer")
    local var2 = useScreenSize()
    local var3 = useSelector(function(arg1)
        return arg1.GlobalGuiInset
    end)

    local var4

    if FFlagSignalsNavP3hMisc then
        local var5 = React.useMemo(function()
            return Signals.createComputed(function(arg1): boolean
                return (isAppItemDetailsPage((GetLegacyNavigationStore(false).getCurrentPageName(arg1))))
            end)
        end, {})
        var4 = useSignalState(var5)
    else
        var4 = isAppItemDetailsPage((useSelector(Selectors.selectCurrentPageName)))
    end

    local var5 = useDispatch()
    local xOffset = math.max(0, var2.X - var3.left - var3.right)

    local var6 = nil
    local bool2

    if FFlagSplitPaneProfileEditFillPane then
        local store = SplitPane.SplitPaneStore.getStore()
        local var7 = useSignalState(store.getSupportPaneModeIfActive)
        local var8 = useSignalState(store.getSupportWidthFraction)
        if var7 == nil then
            bool2 = false
        else
            bool2 = SplitPane.SplitPaneVariant.getProfileSplitPaneEligibility(var7) ~= nil
        end

        if bool2 then
            local x = if var7 == SplitPane.SupportPaneMode.Expanded then xOffset else var2.X * var8
            var6 = Vector2.new(x, var2.Y)
        end
    else
        bool2 = false
    end

    local closeProfileRoute = if FFlagProfilePlatformExitStandaloneEditor then var1.navigateTo.closeProfileRoute else nil

    local onClose = React.useCallback(function()
        if closeProfileRoute then
            closeProfileRoute()
            return
        end
        closeProfilePictureEditor(tbl1.navigation)
    end, { tbl1.navigation, closeProfileRoute })

    local onSaveSuccess = React.useCallback(function()
        showEditProfileImageToast.showSaveSuccessToast(var5)
        onClose()
    end, { var5, onClose })

    local onOpenEmoteDetails = React.useCallback(function(str1: string)
        local navigateTo = var1.navigateTo

        local tbl2 = { mountAnimation = true }
        if navigateTo.itemOrBundleDetails then
            navigateTo.itemOrBundleDetails(str1, Enums2.ItemTypes.Asset, tbl2)
            return
        end
        navigateTo.itemDetails(str1, tbl2)
    end, { var1.navigateTo })

    local onPrepareRecommendedEmotePurchase = React.useCallback(function(str1: string)
        local preparePurchaseItem = var1.navigateTo.preparePurchaseItem
        if preparePurchaseItem then
            preparePurchaseItem(str1, Enums2.ItemTypes.Asset)
        end
    end, { var1.navigateTo })

    local onShopForMoreEmotes = React.useCallback(function()
        local shopForMoreEmotes = var1.navigateTo.shopForMoreEmotes
        if shopForMoreEmotes then
            shopForMoreEmotes()
        end
    end, { var1.navigateTo })

    local onPromptR15Upgrade = if FFlagEditProfileImageR15UpgradePrompt then React.useCallback(function(func1: (...any) -> (...any))
        local promptR15Upgrade = var1.navigateTo.promptR15Upgrade
        if promptR15Upgrade then
            promptR15Upgrade(func1)
        end
    end, { var1.navigateTo }) else nil

    if FFlagEditProfileFramesImpression and FFlagEditProfileFramesEnabled then
        useReportFramesImpression()
    end

    local mode = if tbl1.navigation.getParam then tbl1.navigation.getParam("mode", Enums.EditProfileImageMode.Default) else Enums.EditProfileImageMode.Default
    local createElement = React.createElement
    local var14 = View
    local tbl2 = {
        Size = if FFlagSplitPaneProfileEditFillPane and bool2 then UDim2.fromScale(1, 1) elseif bool1 then UDim2.new(0, xOffset, 1, 0) else UDim2.fromOffset(xOffset, var2.Y),
        padding = {
            bottom = UDim.new(0, var3.bottom)
        },
        tag = "bg-surface-0"
    }

    local tbl3 = { Content = 0, DetailsInputBlocker = 0 }
    local createElement2 = React.createElement
    local var15 = View
    local tbl4 = { tag = "size-full-full" }

    local tbl5 = { EditProfileImage = 0 }
    local createElement3 = React.createElement
    local var16 = EditProfileImage
    local tbl6 = {
        mode = mode,
        onClose = onClose,
        onSaveSuccess = onSaveSuccess,
        onOpenEmoteDetails = onOpenEmoteDetails,
        onPrepareRecommendedEmotePurchase = onPrepareRecommendedEmotePurchase,
        onShopForMoreEmotes = onShopForMoreEmotes,
        onPromptR15Upgrade = onPromptR15Upgrade,
        accountRigType = if FFlagEditProfileImageR15UpgradePrompt then var1.accountRigType else nil,
        renderRecommendedEmotePurchaseFooter = renderRecommendedEmotePurchaseFooter,
        containerSize = 0
    }

    if not (FFlagSplitPaneProfileEditFillPane and bool2) then
        var6 = nil
    end

    tbl6.containerSize = var6
    tbl5.EditProfileImage = createElement3(var16, tbl6)
    tbl3.Content = createElement2(var15, tbl4, tbl5)

    tbl3.DetailsInputBlocker = if var4 then React.createElement(View, { tag = "position-top-left size-full", ZIndex = 10, Active = true }) else nil
    return createElement(var14, tbl2, tbl3)
end

return EditProfileImageContainer
