-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:21:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local UserInputService = game:GetService("UserInputService")

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local VersionHistoryContainer = require(BuildExperience.Components.VersionHistory.VersionHistoryContainer)
local FriendsOnlyShareDialog = require(BuildExperience.Components.ShareAudience.FriendsOnlyShareDialog)
local ExperienceShareOverlays = require(BuildExperience.Components.ShareAudience.ExperienceShareOverlays)
local leaveExperience = require(BuildExperience.utils.leaveExperience)
local useExperienceShareFlow = require(BuildExperience.utils.useExperienceShareFlow)
local useSharePublishedExperience = require(BuildExperience.utils.sharePublishedExperience).useSharePublishedExperience
local useOpenWebView = require(BuildExperienceParent.WebViewUtils).useOpenWebView
local FFlagBuildExperienceMonetizationNativeUI = require(BuildExperience.Flags.FFlagBuildExperienceMonetizationNativeUI)
local var1 = if FFlagBuildExperienceMonetizationNativeUI then nil else require(BuildExperienceParent.UrlBuilder).UrlBuilder.fromString(
    "create:dashboard/creations/experiences/{universeId}/monetization/developer-products"
)
local useCreatorCreditMenuItem = require(script.Parent.useCreatorCreditMenuItem).useCreatorCreditMenuItem
local FFlagBuildExperiencePrivateInvites = require(BuildExperience.Flags.FFlagBuildExperiencePrivateInvites)
local FFlagEnableBuildAdPromotion = require(BuildExperience.Flags.FFlagEnableBuildAdPromotion)
local FFlagBuildCheckGamePermissions = require(BuildExperience.Flags.FFlagBuildCheckGamePermissions)
local FFlagBuildExperiencePageImpressions = require(BuildExperience.Flags.FFlagBuildExperiencePageImpressions)
local useBuildPageImpression = require(BuildExperience.Telemetry.useBuildPageImpression)
local FFlagBuildExperienceOverflowMenuTelemetry = require(BuildExperience.Flags.FFlagBuildExperienceOverflowMenuTelemetry)
local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)
local useGamePermissions = require(BuildExperience.useGamePermissions)
local useGetAdCampaignEligibility = require(BuildExperience.Components.Ads.useGetAdCampaignEligibility)
local adCampaignEligibilityUtils = require(BuildExperience.Components.Ads.adCampaignEligibilityUtils)

local IconButton = Foundation.IconButton
local Menu = Foundation.Menu
local useScaledValue = Foundation.Hooks.useScaledValue

local BadgeVariant = Foundation.Enums.BadgeVariant
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize
local PopoverAlign = Foundation.Enums.PopoverAlign
local PopoverSide = Foundation.Enums.PopoverSide

local _createBuildOverflowMenuStore = require(BuildExperience.Stores.GetBuildOverflowMenuStore.createBuildOverflowMenuStore)
local releaseAnyFocus = require(BuildExperienceParent.BuildExperiencePlaytestLaunch.releaseAnyFocus)

local num1 = game:DefineFastInt("BuildOverflowMenuWidth", 172)

local function isItemPermitted(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    return arg2 == nil or arg1.requiredPermission == nil or arg2[arg1.requiredPermission]
end

local function getSourceText(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1.getText ~= nil then
        return (arg1.getText(arg2))
    end

    return arg1.text
end

local function sendOverflowMenuEvent(str1: string, target, str2: string?)
    local tbl1 = {
        isInExperience = if game.GameId == 0 then "false" else "true"
    }
    if str2 ~= nil then
        tbl1.item = str2
    end
    sendBuildExperienceEvent(
        str1,
        {
            universeId = target.universeId,
            placeId = target.placeId,
            conversationId = target.sessionId
        },
        tbl1
    )
end

local function BuildOverflowMenuButton(tbl1)
    local offset = useScaledValue(num1)
    local var2 = useOpenWebView()
    local var3, var4 = React.useState(false)
    local var5, var6 = React.useState(false)
    if FFlagBuildExperiencePageImpressions then
        useBuildPageImpression("version-history", tbl1.target, var5 and tbl1.target.placeId ~= nil)
    end
    local var7 = if FFlagBuildCheckGamePermissions then useGamePermissions({ universeId = tbl1.target.universeId, isNewGame = tbl1.target.isNewGameTarget }) else nil

    local var8 = useExperienceShareFlow(tbl1.target.universeId, tbl1.target.placeId)

    local onShare = var8.onShare

    local var9 = useSharePublishedExperience(tbl1.target.universeId)
    local var10, var11 = React.useState(nil)
    local bool1 = tbl1.onOpenCreatorCreditPage ~= nil

    local bool2 = FFlagEnableBuildAdPromotion

    if bool2 then
        if tbl1.onOpenGetUsersPage == nil or tbl1.target.universeId == nil then
            bool2 = false
        else
            bool2 = tbl1.target.universeId ~= 0
        end
    end

    local var12 = if FFlagEnableBuildAdPromotion then useGetAdCampaignEligibility(if bool2 then tbl1.target.universeId else nil) else nil
    local getUsersUserEligible = not (var12 == nil) and var12.userEligible == true
    local getUsersUniverseEligible = not (var12 == nil or var12.universeEligible ~= true) and tbl1.isUniversePublic == true
    local getUsersFreeCreditsRemaining = adCampaignEligibilityUtils.freeCreditsRemaining(var12)
    local bool5 = tbl1.target.universeId == nil and bool1
    local isDisabled = tbl1.isDisabled == true or tbl1.target.universeId == nil and not bool5
    local hasPublishedTurn = tbl1.hasPublishedTurn == true

    local var14 = React.useMemo(function()
        if tbl1.target.universeId == nil then
            return nil
        end

        return {
            universeId = tbl1.target.universeId,
            placeId = tbl1.target.placeId,
            sessionId = tbl1.target.sessionId,
            shareAudience = var8.audience,
            isNewGameTarget = tbl1.target.isNewGameTarget,
            hasPublishedTurn = hasPublishedTurn,
            hasPublishedVersion = tbl1.hasPublishedVersion == true,
            canOpenGetUsers = bool2,
            getUsersUserEligible = getUsersUserEligible,
            getUsersUniverseEligible = getUsersUniverseEligible,
            getUsersFreeCreditsRemaining = getUsersFreeCreditsRemaining
        }
    end, {
        tbl1.target.universeId,
        tbl1.target.placeId,
        tbl1.target.sessionId,
        var8.audience,
        tbl1.target.isNewGameTarget,
        hasPublishedTurn,
        tbl1.hasPublishedVersion,
        bool2,
        getUsersUserEligible,
        getUsersUniverseEligible,
        getUsersFreeCreditsRemaining
    })

    local var15 = tbl1.store.useItems(var14)
    local tbl2 = {}
    if var14 ~= nil then
        for _, value in var15 do
            for _, item in value.items do
                tbl2[item.id] = getSourceText(item, var14)
                local trailingText = if item.getTrailingText == nil then nil else item.getTrailingText(var14)

                if trailingText ~= nil then
                    tbl2[item.id .. ":trailing"] = trailingText
                end
            end
        end
    end
    local var16 = useLocalization(tbl2)
    local var17 = useCreatorCreditMenuItem({ onOpenCreatorCreditPage = tbl1.onOpenCreatorCreditPage })

    local function getItemText(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
        return var16[arg1.id]
    end

    local function getItemTrailing(arg1) -- Luacid: unused: defined but never referenced
        if arg1.getTrailingText == nil then
            return nil
        end

        if arg1.getTrailingText(var14) == nil then
            return nil
        end

        return {
            type = "Badge",
            text = var16[arg1.id .. ":trailing"],
            variant = BadgeVariant.Standard
        }
    end

    local function buildMenuItems()
        local menuItems = {}
        if not isDisabled then
            if var14 ~= nil then
                for _, value in var15 do
                    local tbl3 = {
                        items = {}
                    }
                    for _, item in value.items do
                        local var13 = not isItemPermitted(item, var7) or (if item.isDisabled == nil then nil else item.isDisabled(var14))
                        local tbl4 = {
                            id = item.id,
                            text = getItemText(item),
                            icon = item.icon,
                            isDisabled = var13,
                            trailing = if item.getTrailingText == nil or item.getTrailingText(var14) == nil then nil else {
                                type = "Badge",
                                text = var16[item.id .. ":trailing"],
                                variant = BadgeVariant.Standard
                            }
                        }
                        table.insert(tbl3.items, tbl4)
                    end
                    table.insert(menuItems, tbl3)
                end
            end

            if bool1 then
                table.insert(menuItems, { items = { var17.item } })
            end
        end
        return menuItems
    end

    local items = buildMenuItems()

    local useCallback = React.useCallback
    local function func1()
        if isDisabled then
            return
        end
        local textBox = UserInputService:GetFocusedTextBox()
        if textBox then
            textBox:ReleaseFocus()
        end
        if FFlagBuildExperienceOverflowMenuTelemetry and not var3 then
            sendOverflowMenuEvent("OVERFLOW_MENU_OPEN", tbl1.target)
        end
        var4(function(arg1): boolean
            return not arg1
        end)
        if tbl1.onActivated then
            tbl1.onActivated()
        end
    end

    local onActivated = tbl1.onActivated
    local var18 = if FFlagBuildExperienceOverflowMenuTelemetry then var3 else nil
    local target = if FFlagBuildExperienceOverflowMenuTelemetry then tbl1.target else nil
    local var13 = useCallback(func1, { isDisabled, onActivated, var18, target })

    local onPressedOutside = React.useCallback(function()
        var4(false)
    end, {})

    local useCallback2 = React.useCallback
    local function func2(id)
        local textBox = UserInputService:GetFocusedTextBox()
        if textBox then
            textBox:ReleaseFocus()
        end
        if FFlagBuildExperienceOverflowMenuTelemetry then
            sendOverflowMenuEvent("OVERFLOW_MENU_ITEM_CLICK", tbl1.target, tostring(id))
        end
        if bool1 and var17 ~= nil and id == var17.item.id then
            var17.activate()
            var4(false)
            return
        end

        if var14 == nil then
            return
        end

        for _, value in var15 do
            for _, item in value.items do
                if item.id ~= id then
                    continue
                end

                local var21 = if item.onActivated then item.onActivated(var14) else nil

                if var21 ~= nil then
                    if var21.type == "openPage" then
                        if var21.page == "monetization" and not FFlagBuildExperienceMonetizationNativeUI then
                            var2(var1({ universeId = var14.universeId }), LocalizationStrings.GAME_CONFIGURATION_CREATOR_HUB)
                        elseif tbl1.onAction then
                            tbl1.onAction(var21)
                        end
                    elseif var21.type == "openInvitePicker" or var21.type == "openInviteManagement" then
                        if tbl1.onAction then
                            tbl1.onAction(var21)
                        end
                    elseif var21.type == "openGetUsers" then
                        if tbl1.onOpenGetUsersPage then
                            tbl1.onOpenGetUsersPage()
                        end
                    elseif var21.type == "openVersionHistory" then
                        releaseAnyFocus()
                        var6(true)
                    elseif var21.type == "share" then
                        if FFlagBuildExperiencePrivateInvites then
                            onShare()
                        elseif var21.placeId ~= nil then
                            var9(var21.placeId)
                        end
                    elseif var21.type == "confirmFriendsShare" then
                        var11(var21.placeId)
                    elseif var21.type == "leaveExperience" then
                        var4(false)
                        leaveExperience()
                        return
                    end
                end
                var4(false)
                return
            end
        end
    end

    local onAction = tbl1.onAction
    local onOpenGetUsersPage = tbl1.onOpenGetUsersPage
    local target2 = if FFlagBuildExperienceOverflowMenuTelemetry then tbl1.target else nil
    local var19 = useCallback2(func2, { var15, var14, var2, onAction, onOpenGetUsersPage, onShare, var9, bool1, var17, target2 })

    local var22 = React.useCallback(function()
        var6(false)
    end, {})

    local var20 = React.useCallback(function()
        local var23 = var10
        var11(nil)
        if var23 ~= nil then
            var9(var23)
        end
    end, { var10, var9 })

    local onCancel = React.useCallback(function()
        var11(nil)
    end, {})

    local versionHistory = if var5 and tbl1.target.placeId ~= nil then React.createElement(VersionHistoryContainer, {
        universeId = tbl1.target.universeId,
        placeId = tbl1.target.placeId,
        isOpen = true,
        onClose = var22,
        onAgentRollbackStarted = var22,
        testId = "build-version-history"
    }) else nil
    return React.createElement(React.Fragment, nil, {
        Menu = React.createElement(
            Menu,
            {
                isOpen = var3 and not isDisabled,
                items = items,
                side = PopoverSide.Bottom,
                size = InputSize.Large,
                align = PopoverAlign.End,
                onPressedOutside = onPressedOutside,
                onActivated = var19,
                LayoutOrder = tbl1.layoutOrder,
                width = UDim.new(0, offset)
            },
            React.createElement(IconButton, {
                icon = tbl1.icon,
                variant = ButtonVariant.Utility,
                size = InputSize.Medium,
                isCircular = true,
                isDisabled = isDisabled,
                onActivated = var13,
                testId = "build-header-overflow-button"
            })
        ),
        ShareOverlays = if FFlagBuildExperiencePrivateInvites then React.createElement(ExperienceShareOverlays, {
            activeDialog = var8.activeDialog,
            hasShareError = var8.hasShareError,
            onCancel = var8.onCancelDialog,
            onConfirmFriends = var8.onConfirmFriends,
            onConfirmPlaytesters = var8.onConfirmPlaytesters
        }) else nil,
        FriendsOnlyShareDialog = if FFlagBuildExperiencePrivateInvites or var10 == nil then nil else React.createElement(FriendsOnlyShareDialog, { onCancel = onCancel, onShare = var20 }),
        VersionHistory = versionHistory
    })
end

return BuildOverflowMenuButton
