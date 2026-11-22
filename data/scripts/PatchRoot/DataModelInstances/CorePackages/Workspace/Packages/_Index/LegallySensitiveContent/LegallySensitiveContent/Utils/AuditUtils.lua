-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local CryptoUtils = require(script.Parent.CryptoUtils)
local LegallySensitiveContentConstants = require(scriptParentParent.Constants.LegallySensitiveContentConstants)
local Base64 = require(scriptParentParent.dependencies).Base64
local ConsentName = require(scriptParentParent.Enums.ConsentName)

local _LegallySensitiveContentTypes = require(scriptParentParent.Types.LegallySensitiveContentTypes)

local function getAuditDataForConsent(arg1, tbl1)
    return ({
        [ConsentName.phoneNumberDiscoverabilityUpsell] = {
            {
                consentStringTemplate = tbl1.phoneNumberDiscoverabilityUpsellNotNow,
                sourceContentId = LegallySensitiveContentConstants.phoneNumberDiscoverabilityUpsell.notNowSourceContentId
            },
            {
                consentStringTemplate = tbl1.phoneNumberDiscoverabilityUpsellTurnOn,
                sourceContentId = LegallySensitiveContentConstants.phoneNumberDiscoverabilityUpsell.turnOnSourceContentId
            },
            {
                consentStringTemplate = tbl1.phoneNumberDiscoverabilityUpsellTitle,
                sourceContentId = LegallySensitiveContentConstants.phoneNumberDiscoverabilityUpsell.titleSourceContentId
            },
            {
                consentStringTemplate = tbl1.phoneNumberDiscoverabilityUpsellContent,
                sourceContentId = LegallySensitiveContentConstants.phoneNumberDiscoverabilityUpsell.contentSourceContentId
            }
        },
        [ConsentName.PhotoToAvatar] = {
            {
                consentStringTemplate = tbl1.photoToAvatarTitle,
                sourceContentId = LegallySensitiveContentConstants.photoToAvatar.titleSourceContentId
            },
            {
                consentStringTemplate = tbl1.photoToAvatarBodyText,
                sourceContentId = LegallySensitiveContentConstants.photoToAvatar.bodyTextSourceContentId
            },
            {
                consentStringTemplate = tbl1.photoToAvatarPrivacyLinkText,
                sourceContentId = LegallySensitiveContentConstants.photoToAvatar.privacyLinkTextSourceContentId
            },
            {
                consentStringTemplate = tbl1.photoToAvatarAgreeButton,
                sourceContentId = LegallySensitiveContentConstants.photoToAvatar.agreeButtonSourceContentId
            },
            {
                consentStringTemplate = tbl1.photoToAvatarCancelButton,
                sourceContentId = LegallySensitiveContentConstants.photoToAvatar.cancelButtonSourceContentId
            }
        },
        [ConsentName.allowMarketingEmailCheckboxAccountUpgrade] = {{
            consentStringTemplate = tbl1.allowMarketingEmailCheckboxAccountUpgradeConsent,
            sourceContentId = LegallySensitiveContentConstants.allowMarketingEmailCheckboxAccountUpgrade.consentSourceContentId
        }},
        [ConsentName.allowMarketingEmailAutoOptInAccountUpgrade] = {}
    })[arg1]
        or {}
end

local function getAuditHeaderValue(tbl1, surface: string, tbl2): string
    local tbl3 = {}

    for _, value in ipairs(tbl1) do
        local tbl4 = {
            hash = CryptoUtils.hashStringWithFnv1a32(value.consentStringTemplate)
        }
        if value.vars ~= nil then
            for k, var in pairs(value.vars) do
                tbl4[k] = var
            end
        end

        tbl3[value.sourceContentId] = tbl4
    end

    local input = { surface = surface, content = 0 }

    if next(tbl3) == nil then
        tbl3 = nil
    end

    input.content = tbl3

    if tbl2 then
        for k, value in pairs(tbl2) do
            input[k] = value
        end
    end
    return game:GetService("HttpService"):JSONEncode(input)
end

return {
    getAuditDataForConsent = getAuditDataForConsent,
    getAuditHeaderValue = getAuditHeaderValue,
    getEncodedAuditHeader = function(arg1, tbl1, surface: string, tbl2)
        local auditDataForConsent = getAuditDataForConsent(arg1, tbl1)
        local auditHeaderValue = getAuditHeaderValue(auditDataForConsent, surface, tbl2)
        return (Base64.EncodeUrl(auditHeaderValue))
    end
}
