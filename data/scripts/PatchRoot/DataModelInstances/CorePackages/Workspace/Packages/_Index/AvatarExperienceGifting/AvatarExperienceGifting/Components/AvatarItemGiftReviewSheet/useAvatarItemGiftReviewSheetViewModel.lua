-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceGifting = script:FindFirstAncestor("AvatarExperienceGifting")
local AvatarExperienceGiftingParent = AvatarExperienceGifting.Parent

local React = require(AvatarExperienceGiftingParent.React)
local AvatarExperienceNavigation = require(AvatarExperienceGiftingParent.AvatarExperienceNavigation)
local useNavigation = require(AvatarExperienceGiftingParent.Navigation).useNavigation

local _AvatarItemGiftReviewSheetPlaceholderView = require(script.Parent.AvatarItemGiftReviewSheetPlaceholderView)
local buildGiftItem = require(AvatarExperienceGifting.Utils.buildGiftItem)
local _GiftSendFlowNavigationOverrides = require(AvatarExperienceGifting.Types.GiftSendFlowNavigationOverrides)

local closeGiftSendFlow = AvatarExperienceNavigation.Utils.closeGiftSendFlow
local useAvatarRoute = AvatarExperienceNavigation.AvatarRoute.Hooks.useAvatarRoute

local function useAvatarItemGiftReviewSheetViewModel(arg1)
    local var1 = useNavigation()
    local var2 = useAvatarRoute()

    local param = var1.getParam("collectibleItemId")
    local param2 = var1.getParam("recipientId")

    local var3 = React.useMemo(function()
        return buildGiftItem(param)
    end, { param })

    local goBack = if arg1 then arg1.goBack else nil

    local onBack = React.useCallback(function()
        if goBack then
            goBack()
            return
        end
        var1.pop()
    end, { var1, goBack })

    local closeSendFlow = if arg1 then arg1.closeSendFlow else nil

    local onClose = React.useCallback(function()
        if closeSendFlow then
            closeSendFlow()
            return
        end
        closeGiftSendFlow(var1)
    end, { var1, closeSendFlow })

    local var6 = var2.isVisible and var2.current.key == var1.state.key

    local tbl1 = { isVisible = 0, onBack = 0, onClose = 0 }
    if var3 == nil or param2 == nil then
        var6 = false
    end

    tbl1.isVisible = var6
    tbl1.onBack = onBack
    tbl1.onClose = onClose
    return tbl1
end

return useAvatarItemGiftReviewSheetViewModel
