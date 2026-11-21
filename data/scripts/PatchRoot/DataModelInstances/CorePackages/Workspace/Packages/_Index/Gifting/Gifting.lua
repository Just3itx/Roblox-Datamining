-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local GiftAcceptView = require(script.Components.GiftAccept.GiftAcceptView)
local GiftAgeCheckContainer = require(script.Components.GiftAgeCheck.GiftAgeCheckContainer)
local GiftAllowanceView = require(script.Components.GiftAllowance.GiftAllowanceView)
local GiftIconButtonView = require(script.Components.GiftIconButton.GiftIconButtonView)
local GiftSendView = require(script.Components.GiftSend.GiftSendView)
local GiftRobuxBreakdownView = require(script.Components.GiftRobuxBreakdown.GiftRobuxBreakdownView)
local GiftSheetLayoutView = require(script.Components.GiftSheetLayout.GiftSheetLayoutView)
local GiftStateEnum = require(script.Components.GiftState.GiftStateEnum)
local GiftStateView = require(script.Components.GiftState.GiftStateView)
local InfoTooltip = require(script.Components.InfoTooltip.InfoTooltip)
local RecipientPickerView = require(script.Components.RecipientPicker.RecipientPickerView)
local GiftRejectConfirmationView = require(script.Components.GiftRejectConfirmation.GiftRejectConfirmationView)
local _Types = require(script.Types)
local UserInfoPanelView = require(script.Components.UserInfoPanel.UserInfoPanelView)
local getFriendDuration = require(script.Utils.getFriendDuration)

local _CanGiftResponseModel = require(script.Models.CanGiftResponseModel)
local _GiftErrorModel = require(script.Models.GiftErrorModel)
local _FindRecipientsResponseModel = require(script.Models.FindRecipientsResponseModel)
local _PendingGiftsResponseModel = require(script.Models.PendingGiftsResponseModel)
local _PrepareGiftResponseModel = require(script.Models.PrepareGiftResponseModel)
local _ReceiverPreviewResponseModel = require(script.Models.ReceiverPreviewResponseModel)

local postAcceptGift = require(script.WebApi.postAcceptGift)
local postPurchaseGift = require(script.WebApi.postPurchaseGift)
local postRejectGift = require(script.WebApi.postRejectGift)

local _createCanGiftStore = require(script.Stores.createCanGiftStore)

local useGiftEligibility = require(script.Hooks.useGiftEligibility)
local useGiftRecipients = require(script.Hooks.useGiftRecipients)

return {
    ["jest.config"] = script["jest.config"],
    Components = {
        GiftAcceptView = GiftAcceptView,
        GiftAgeCheckContainer = GiftAgeCheckContainer,
        GiftAllowanceView = GiftAllowanceView,
        GiftIconButtonView = GiftIconButtonView,
        GiftSendView = GiftSendView,
        GiftRobuxBreakdownView = GiftRobuxBreakdownView,
        GiftSheetLayoutView = GiftSheetLayoutView,
        GiftStateView = GiftStateView,
        InfoTooltip = InfoTooltip,
        RecipientPickerView = RecipientPickerView,
        GiftRejectConfirmationView = GiftRejectConfirmationView,
        UserInfoPanelView = UserInfoPanelView
    },
    Constants = require(script.Constants),
    Hooks = { useGiftEligibility = useGiftEligibility, useGiftRecipients = useGiftRecipients },
    Utils = { getFriendDuration = getFriendDuration },
    Flags = {},
    Enums = {
        GiftState = GiftStateEnum,
        ItemType = require(script.Enums.ItemType),
        GiftEligibility = require(script.Enums.GiftEligibility),
        RequiredAction = require(script.Enums.RequiredAction),
        UserRelationship = require(script.Enums.UserRelationship),
        FailureReason = require(script.Enums.FailureReason),
        AmpRecourseAction = require(script.Enums.AmpRecourseAction)
    },
    WebApi = {
        Urls = require(script.WebApi.Urls),
        postCanGift = require(script.WebApi.postCanGift),
        postFindRecipients = require(script.WebApi.postFindRecipients),
        postPrepareGift = require(script.WebApi.postPrepareGift),
        postPurchaseGift = postPurchaseGift,
        postAcceptGift = postAcceptGift,
        postRejectGift = postRejectGift,
        getPendingGifts = require(script.WebApi.getPendingGifts),
        getReceiverPreview = require(script.WebApi.getReceiverPreview)
    },
    Stores = {
        getCanGiftStore = require(script.Stores.getCanGiftStore)
    }
}
