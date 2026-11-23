-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsell = script:FindFirstAncestor("AmpUpsell")
local Enums = require(script.Parent.Enums)
local VPCErrorCategoriesEnum = Enums.VPCErrorCategoriesEnum
local VPCRetryBehaviorEnum = Enums.VPCRetryBehaviorEnum
local VPCErrorCodesEnum = Enums.VPCErrorCodesEnum
local vpcErrorCategoryToMessageStrings = require(AmpUpsell.Common.LocalizationStrings).vpcErrorCategoryToMessageStrings

local tbl1 = {
    [VPCErrorCodesEnum.InvalidEmailAddress] = VPCErrorCategoriesEnum.InvalidEmail,
    [VPCErrorCodesEnum.EmailNotUnique] = VPCErrorCategoriesEnum.InvalidEmail,
    [VPCErrorCodesEnum.LinkingIneligible] = VPCErrorCategoriesEnum.InvalidEmail,
    [VPCErrorCodesEnum.ParentAtLinkLimit] = VPCErrorCategoriesEnum.InvalidEmail,
    [VPCErrorCodesEnum.SenderFlooded] = VPCErrorCategoriesEnum.SenderFlooded,
    [VPCErrorCodesEnum.ReceiverFlooded] = VPCErrorCategoriesEnum.ReceiverFlooded,
    [VPCErrorCodesEnum.InvalidParameter] = VPCErrorCategoriesEnum.BadUserInput,
    [VPCErrorCodesEnum.UpdateUserSettingRequestInvalid] = VPCErrorCategoriesEnum.BadUserInput,
    [VPCErrorCodesEnum.AlreadyLinked] = VPCErrorCategoriesEnum.UserStateRecoursePathMismatch,
    [VPCErrorCodesEnum.ChildAtLinkLimit] = VPCErrorCategoriesEnum.UserStateRecoursePathMismatch,
    [VPCErrorCodesEnum.NoLinkedParents] = VPCErrorCategoriesEnum.UserStateRecoursePathMismatch,
    [VPCErrorCodesEnum.SenderFloodedRequestCreated] = VPCErrorCategoriesEnum.SenderFloodedRequestCreated,
    [VPCErrorCodesEnum.Unknown] = VPCErrorCategoriesEnum.InternalVPCError,
    [VPCErrorCodesEnum.ServiceUnavailable] = VPCErrorCategoriesEnum.InternalVPCError,
    [VPCErrorCodesEnum.IllegalState] = VPCErrorCategoriesEnum.InternalVPCError,
    [VPCErrorCodesEnum.InvalidUserID] = VPCErrorCategoriesEnum.GenericError,
    [VPCErrorCodesEnum.ConsentAlreadyApplied] = VPCErrorCategoriesEnum.GenericError,
    [VPCErrorCodesEnum.ConsentAlreadyRequestedConflictingData] = VPCErrorCategoriesEnum.ConflictingPendingConsent,
    [VPCErrorCodesEnum.ReceiverNotWhitelisted] = VPCErrorCategoriesEnum.GenericError,
    [VPCErrorCodesEnum.InvalidComplianceFeature] = VPCErrorCategoriesEnum.GenericError,
    [VPCErrorCodesEnum.ChildTooOld] = VPCErrorCategoriesEnum.GenericError,
    [VPCErrorCodesEnum.UserForgotten] = VPCErrorCategoriesEnum.GenericError,
    [VPCErrorCodesEnum.UnsupportedNotificationType] = VPCErrorCategoriesEnum.GenericError,
    [VPCErrorCodesEnum.UnsupportedRequestType] = VPCErrorCategoriesEnum.GenericError,
    [VPCErrorCodesEnum.ChildIneligibleForConsent] = VPCErrorCategoriesEnum.GenericError
}

local tbl2 = {
    [VPCErrorCategoriesEnum.InternalVPCError] = VPCRetryBehaviorEnum.RetryVPC,
    [VPCErrorCategoriesEnum.InvalidEmail] = VPCRetryBehaviorEnum.RetryVPC,
    [VPCErrorCategoriesEnum.Flooded] = VPCRetryBehaviorEnum.NoRetry,
    [VPCErrorCategoriesEnum.SenderFlooded] = VPCRetryBehaviorEnum.NoRetry,
    [VPCErrorCategoriesEnum.ReceiverFlooded] = VPCRetryBehaviorEnum.NoRetry,
    [VPCErrorCategoriesEnum.BadUserInput] = VPCRetryBehaviorEnum.NoRetry,
    [VPCErrorCategoriesEnum.UserStateRecoursePathMismatch] = VPCRetryBehaviorEnum.RetryAMP,
    [VPCErrorCategoriesEnum.SenderFloodedRequestCreated] = VPCRetryBehaviorEnum.Success,
    [VPCErrorCategoriesEnum.GenericError] = VPCRetryBehaviorEnum.NoRetry,
    [VPCErrorCategoriesEnum.ConflictingPendingConsent] = VPCRetryBehaviorEnum.NoRetry
}

return {
    getStringsFromErrorCodeAndRetryNum = function(str1: string, num1: number)
        if num1 >= 4 then
            str1 = VPCErrorCodesEnum.SenderFlooded
        end

        local var1 = tbl1[str1]

        if var1 == nil then
            var1 = VPCErrorCategoriesEnum.GenericError
        end

        return vpcErrorCategoryToMessageStrings[var1]
    end,
    getRetryBehaviorFromErrorCodeAndRetryNum = function(str1: string, num1: number)
        if num1 >= 4 then
            str1 = VPCErrorCodesEnum.SenderFlooded
        end

        local var1 = tbl1[str1]

        if var1 == nil then
            var1 = VPCErrorCategoriesEnum.GenericError
        end

        return tbl2[var1]
    end,
    VPCErrorCategoriesEnum = VPCErrorCategoriesEnum,
    VPCRetryBehaviorEnum = VPCRetryBehaviorEnum
}
