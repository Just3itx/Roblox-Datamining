-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceGifting = script:FindFirstAncestor("AvatarExperienceGifting")
local AvatarExperienceGiftingParent = AvatarExperienceGifting.Parent

local React = require(AvatarExperienceGiftingParent.React)
local AvatarExperienceCommon = require(AvatarExperienceGiftingParent.AvatarExperienceCommon)
local AvatarExperienceNavigation = require(AvatarExperienceGiftingParent.AvatarExperienceNavigation)
local Foundation = require(AvatarExperienceGiftingParent.Foundation)
local Gifting = require(AvatarExperienceGiftingParent.Gifting)
local useNavigation = require(AvatarExperienceGiftingParent.Navigation).useNavigation

local _AvatarItemGiftRecipientPickerView = require(script.Parent.AvatarItemGiftRecipientPickerView)
local buildGiftItem = require(AvatarExperienceGifting.Utils.buildGiftItem)
local _GiftSendFlowNavigationOverrides = require(AvatarExperienceGifting.Types.GiftSendFlowNavigationOverrides)

local AvatarScreen = AvatarExperienceNavigation.Enums.AvatarScreen
local closeGiftSendFlow = AvatarExperienceNavigation.Utils.closeGiftSendFlow
local debounce = AvatarExperienceCommon.Utils.debounce
local useAvatarRoute = AvatarExperienceNavigation.AvatarRoute.Hooks.useAvatarRoute
local useTokens = Foundation.Hooks.useTokens

local Constants = Gifting.Constants
local GiftState = Gifting.Enums.GiftState
local useGiftRecipients = Gifting.Hooks.useGiftRecipients

local RecipientPickerStrings = Constants.RecipientPickerStrings

local function useAvatarItemGiftRecipientPickerViewModel(arg1)
    local var1 = useNavigation()
    local var2 = useAvatarRoute()
    local var3 = useTokens()

    local collectibleItemId = var1.getParam("collectibleItemId")

    local var4 = React.useMemo(function()
        return buildGiftItem(collectibleItemId)
    end, { collectibleItemId })

    local var5 = React.useMemo(function(): {any}?
        return if var4 == nil then nil else { var4 }
    end, { var4 })

    local closeSendFlow = if arg1 then arg1.closeSendFlow else nil

    local onClose = React.useCallback(function()
        if closeSendFlow then
            closeSendFlow()
            return
        end
        closeGiftSendFlow(var1)
    end, { var1, closeSendFlow })

    local var7 = React.useCallback(function(recipientId: number)
        var1.navigate(AvatarScreen.SendGiftReview, { collectibleItemId = collectibleItemId, recipientId = recipientId })
    end, { var1, collectibleItemId })

    local searchText, var9 = React.useState("")
    local var10, var11 = React.useState("")
    local var12 = React.useMemo(function()
        return debounce(var11, 0.25)
    end, {})
    local onSearchChanged = React.useCallback(function(str1: string)
        var9(str1)
        var12(str1)
    end, { var12 })

    local var14 = useGiftRecipients(var5, var10)
    local rows = React.useMemo(function()
        local result = {}
        for _, recipient in var14.recipients do
            table.insert(result, {
                userId = tostring(recipient.userId),
                displayName = recipient.displayName,
                username = recipient.username,
                isAvailable = true
            })
        end

        return result
    end, { var14.recipients })

    local onRecipientSelected = React.useCallback(function(str1: string)
        local var16 = tonumber(str1)
        if var16 == nil then
            return
        end
        var7(var16)
    end, { var7 })

    local state = React.useMemo(function()
        if var14.isLoading then
            return {
                state = GiftState.Loading
            }
        end

        if var14.hasFailed then
            return {
                state = GiftState.Error,
                titleText = RecipientPickerStrings.ErrorTitle,
                bodyText = RecipientPickerStrings.ErrorBody,
                retryLabel = RecipientPickerStrings.RetryLabel,
                onRetry = var14.retry
            }
        end

        if #rows ~= 0 then
            return nil
        end

        return {
            state = GiftState.Empty,
            titleText = RecipientPickerStrings.EmptyTitle,
            bodyText = RecipientPickerStrings.EmptyBody
        }
    end, {
        var14.isLoading,
        var14.hasFailed,
        var14.retry,
        rows
    })

    local sectionTitle = React.useMemo(function(): string
        local num1 = 0
        for _, recipient in var14.recipients do
            if recipient.userRelationship == Gifting.Enums.UserRelationship.Friend then
                num1 += 1
            end
        end
        return string.format(RecipientPickerStrings.FriendsSectionTitleFormat, num1)
    end, { var14.recipients })

    local var19 = var2.isVisible and var2.current.key == var1.state.key

    local tbl1 = { isVisible = 0, pickerProps = 0 }
    if var4 == nil then
        var19 = false
    end

    tbl1.isVisible = var19
    tbl1.pickerProps = {
        isOpen = true,
        titleText = RecipientPickerStrings.SheetTitle,
        searchPlaceholder = RecipientPickerStrings.SearchPlaceholder,
        searchText = searchText,
        isSearchVisible = not var14.hasFailed or var10 ~= "" or false,
        onSearchChanged = onSearchChanged,
        sectionTitle = sectionTitle,
        rows = rows,
        state = state,
        onRecipientSelected = onRecipientSelected,
        unavailableLabel = RecipientPickerStrings.UnavailableLabel,
        avatarBackgroundStyle = var3.Color.Shift.Shift_200,
        onClose = onClose
    }
    return tbl1
end

return useAvatarItemGiftRecipientPickerViewModel
