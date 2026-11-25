-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PhoneUpsell = script:FindFirstAncestor("PhoneUpsell")
local PhoneUpsellParent = PhoneUpsell.Parent

local upsellCardModalAction = require(PhoneUpsell.DuplicateAnalytics.upsellCardModalAction)
local upsellCardFormInteraction = require(PhoneUpsell.DuplicateAnalytics.upsellCardFormInteraction)
local EventStreamConstants = require(PhoneUpsell.DuplicateAnalytics.EventStreamConstants)
local RoactAnalytics = require(PhoneUpsellParent.RoactServiceTags).RoactAnalytics

local module = {}
function module.get(arg1)
    local var1 = RoactAnalytics.get(arg1)

    return {
        reportModalShownWithSection = function(arg2, arg3, arg4)
            upsellCardModalAction(var1.EventStream, arg2, "", EventStreamConstants.ActionType.Shown, arg3, arg4)
        end,
        reportModalShownWithSectionAndError = function(arg2, arg3, arg4, arg5, arg6)
            upsellCardModalAction(var1.EventStream, arg2, arg3, EventStreamConstants.ActionType.Shown, arg4, arg5, arg6)
        end,
        reportModalDismissedWithSection = function(arg2, arg3, arg4)
            upsellCardModalAction(var1.EventStream, arg2, "", EventStreamConstants.ActionType.Dismiss, arg3, arg4)
        end,
        reportModalActionWithSection = function(arg2, arg3, arg4, arg5, arg6, arg7)
            upsellCardModalAction(var1.EventStream, arg2, arg3, arg4, arg5, arg6, arg7)
        end,
        reportInteractWithActionAndSection = function(arg2, arg3, arg4, arg5, arg6, arg7)
            upsellCardFormInteraction(var1.EventStream, arg2, arg3, arg4, arg5, arg6, arg7)
        end
    }
end

return module
