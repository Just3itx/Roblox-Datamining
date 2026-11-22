-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LegallySensitiveContent = script:FindFirstAncestor("LegallySensitiveContent")
local LegallySensitiveContentParent = LegallySensitiveContent.Parent

local _React = require(LegallySensitiveContentParent.React)

local updateUserSetting = require(LegallySensitiveContent.Services.userSettingsService).updateUserSetting
local grantOneTimeUserConsent = require(LegallySensitiveContent.Services.usersConsentsService).grantOneTimeUserConsent
local useLocalization = require(LegallySensitiveContent.dependencies).Localization.Hooks.useLocalization
local LegallySensitiveContentConstants = require(LegallySensitiveContent.Constants.LegallySensitiveContentConstants)
local getEncodedAuditHeader = require(LegallySensitiveContent.Utils.AuditUtils).getEncodedAuditHeader
local ConsentName = require(LegallySensitiveContent.Enums.ConsentName)
local _LegallySensitiveContentTypes = require(LegallySensitiveContent.Types.LegallySensitiveContentTypes)

local function useTranslatedLegallySensitiveContentAndActions(allowMarketingEmailCheckboxAccountUpgrade, str1: string)
    local var1 = useLocalization({
        phoneNumberDiscoverabilityUpsellNotNow = LegallySensitiveContentConstants.phoneNumberDiscoverabilityUpsell.notNow,
        phoneNumberDiscoverabilityUpsellTurnOn = LegallySensitiveContentConstants.phoneNumberDiscoverabilityUpsell.turnOn,
        phoneNumberDiscoverabilityUpsellTitle = LegallySensitiveContentConstants.phoneNumberDiscoverabilityUpsell.title,
        phoneNumberDiscoverabilityUpsellContent = LegallySensitiveContentConstants.phoneNumberDiscoverabilityUpsell.content,
        photoToAvatarTitle = LegallySensitiveContentConstants.photoToAvatar.title,
        photoToAvatarBodyText = LegallySensitiveContentConstants.photoToAvatar.bodyText,
        photoToAvatarPrivacyLinkText = LegallySensitiveContentConstants.photoToAvatar.privacyLinkText,
        photoToAvatarAgreeButton = LegallySensitiveContentConstants.photoToAvatar.agreeButton,
        photoToAvatarCancelButton = LegallySensitiveContentConstants.photoToAvatar.cancelButton,
        allowMarketingEmailCheckboxAccountUpgradeConsent = if allowMarketingEmailCheckboxAccountUpgrade == ConsentName.allowMarketingEmailCheckboxAccountUpgrade
            and LegallySensitiveContentConstants.allowMarketingEmailCheckboxAccountUpgrade.consentSourceContentId ~= "" then LegallySensitiveContentConstants.allowMarketingEmailCheckboxAccountUpgrade.consent else nil
    })

    local tbl1 = {
        [ConsentName.phoneNumberDiscoverabilityUpsell] = {
            wordsOfConsent = {
                notNow = var1.phoneNumberDiscoverabilityUpsellNotNow,
                turnOn = var1.phoneNumberDiscoverabilityUpsellTurnOn,
                title = var1.phoneNumberDiscoverabilityUpsellTitle,
                content = var1.phoneNumberDiscoverabilityUpsellContent
            }
        },
        [ConsentName.allowMarketingEmailCheckboxAccountUpgrade] = {
            wordsOfConsent = {
                consent = var1.allowMarketingEmailCheckboxAccountUpgradeConsent
            }
        },
        [ConsentName.allowMarketingEmailAutoOptInAccountUpgrade] = {
            wordsOfConsent = {}
        }
    }

    return tbl1[allowMarketingEmailCheckboxAccountUpgrade], {
        getBase64EncodedAuditHeader = function(tbl2)
            return getEncodedAuditHeader(allowMarketingEmailCheckboxAccountUpgrade, var1, str1, tbl2)
        end,
        updateSettingWithAuditing = function(str2: string, arg1, tbl2)
            local encodedAuditHeader = getEncodedAuditHeader(allowMarketingEmailCheckboxAccountUpgrade, var1, str1, tbl2)
            local success, result = pcall(function()
                updateUserSetting(str2, arg1, encodedAuditHeader)
            end)
            if not success then
                warn("Failed to update setting with auditing:", result)
            end
        end,
        grantOneTimeUserConsentWithAuditing = function(num1: number?, tbl2)
            local encodedAuditHeader = getEncodedAuditHeader(allowMarketingEmailCheckboxAccountUpgrade, var1, str1, tbl2)
            local success, result = pcall(function()
                grantOneTimeUserConsent(allowMarketingEmailCheckboxAccountUpgrade, num1, encodedAuditHeader)
            end)
            if not success then
                warn("Failed to grant one time user consent with auditing:", result)
            end
        end
    }
end

return useTranslatedLegallySensitiveContentAndActions
