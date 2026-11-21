-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local dependencies = require(scriptParentParent.dependencies)

local SetContactImporterDisplayLogic = require(scriptParentParent.Actions.SetContactImporterDisplayLogic)
local UpdateContactImporterModalLogic = dependencies.SocialModalsCommon.Actions.UpdateContactImporterModalLogic
local SetIsPhoneVerified = require(scriptParentParent.Actions.SetIsPhoneVerified)
local UpdateIsDiscoverabilityUnset = dependencies.SocialModalsCommon.Actions.UpdateIsDiscoverabilityUnset

local Rodux = dependencies.Rodux
local llama = dependencies.llama
local Constants = require(scriptParentParent.Common.Constants)

local tbl1 = {
    [Constants.SHOULD_SHOW_CONTACT_IMPORTER_FEATURE] = false,
    [Constants.SHOULD_SHOW_CONTACT_IMPORTER_UPSELL_MODAL] = false,
    hasOSPermissions = false,
    isPhoneVerified = false,
    isDiscoverabilityUnset = false
}

local createReducer = Rodux.createReducer
local tbl2 = {}
tbl2[SetContactImporterDisplayLogic.name] = function(_, arg1)
    local hasOsPermissions = arg1.hasOSPermissions
    local isPhoneVerified = arg1.isPhoneVerified
    local shouldShowContactImporterUpsellAgain = arg1.shouldShowContactImporterUpsellAgain
    local phoneNumberDiscoverability = arg1.phoneNumberDiscoverability

    local isUserOptedInLocalStorage = hasOsPermissions and arg1.isUserOptedInLocalStorage

    return {
        [Constants.SHOULD_SHOW_CONTACT_IMPORTER_FEATURE] = true,
        [Constants.SHOULD_SHOW_CONTACT_IMPORTER_UPSELL_MODAL] = not isUserOptedInLocalStorage and shouldShowContactImporterUpsellAgain,
        hasOSPermissions = hasOsPermissions,
        isPhoneVerified = isPhoneVerified,
        isDiscoverabilityUnset = phoneNumberDiscoverability == Constants.DISCOVERABILITY_UNSET
    }
end

tbl2[UpdateContactImporterModalLogic.name] = function(tbl3, tbl4)
    return (llama.Dictionary.join(tbl3, {
        hasOSPermissions = tbl4.hasOSPermissions,
        [Constants.SHOULD_SHOW_CONTACT_IMPORTER_UPSELL_MODAL] = tbl4[Constants.SHOULD_SHOW_CONTACT_IMPORTER_UPSELL_MODAL]
    }))
end

tbl2[SetIsPhoneVerified.name] = function(tbl3, arg1)
    return llama.Dictionary.join(tbl3, { isPhoneVerified = arg1.isPhoneVerified })
end

tbl2[UpdateIsDiscoverabilityUnset.name] = function(tbl3, tbl4)
    return llama.Dictionary.join(tbl3, { isDiscoverabilityUnset = tbl4.isDiscoverabilityUnset })
end

return createReducer(tbl1, tbl2)
