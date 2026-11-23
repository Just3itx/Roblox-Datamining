-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local default = require(BuildExperienceParent.ExternalContentSharingProtocol).ExternalContentSharingProtocol.default
local Localization = require(BuildExperienceParent.Localization)
local React = require(BuildExperienceParent.React)
local UniversalShareSheet = require(BuildExperienceParent.ShareSheet).UniversalShareSheet
local SharedFlags = require(BuildExperienceParent.SharedFlags)

local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local createExperienceShareLink = require(BuildExperience.utils.createExperienceShareLink)
local FFlagEnableShareSheet = SharedFlags.FFlagEnableShareSheet
local isSubjectToDesktopPolicies = SharedFlags.isSubjectToDesktopPolicies
local DataHydration = if FFlagEnableShareSheet then require(BuildExperienceParent.DataHydration) else nil
local Signals = if FFlagEnableShareSheet then require(BuildExperienceParent.Signals) else nil
local SignalsReact = if FFlagEnableShareSheet then require(BuildExperienceParent.SignalsReact) else nil

local function getGameShareUrl(num1: number): string -- Luacid: Inlined by compiler; 2 call sites recovered
    return `https://www.roblox.com/games/{num1}`
end

local function formatSuccessSnackbarText(tbl1)
    local var1 = tbl1[1]
    return LocalizationStrings.formatGameSharedWithTarget(if var1 then var1.displayName else "")
end

local function sharePublishedExperience(num1: number, str1: string?)
    local gameShareUrl = getGameShareUrl(num1)

    if FFlagEnableShareSheet then
        UniversalShareSheet.show({
            context = "BuildExperienceGameShare",
            telemetryId = tostring(num1),
            formatSuccessSnackbarText = formatSuccessSnackbarText,
            messagePlaceholder = if str1 then LocalizationStrings.formatShareExperience(str1) else nil,
            url = gameShareUrl
        })

        return nil
    elseif isSubjectToDesktopPolicies() then
        default:setClipboardText({ text = gameShareUrl, context = "BuildExperienceGameShare" })

        return { url = gameShareUrl, copiedToClipboard = true }
    else
        default:shareUrl({ url = gameShareUrl, context = "BuildExperienceGameShare" })

        return { url = gameShareUrl, copiedToClipboard = false }
    end
end

return {
    getGameShareUrl = getGameShareUrl,
    sharePublishedExperience = sharePublishedExperience,
    useSharePublishedExperience = FFlagEnableShareSheet and function(num1: number?)
        local var1 = if num1 then tostring(num1) else nil

        local var2 = React.useMemo(function()
            return Signals.createComputed(function(arg1)
                if var1 == nil then
                    return nil
                end
                return DataHydration.Game.getGameInfoStore(arg1).getAndFetchGameInfo(var1).data(arg1)
            end)
        end, { var1 })
        local var3 = SignalsReact.useSignalState(var2)
        local name = if var3 and not var3.isUnavailable and var3.name ~= "" then var3.name else nil
        local var4 = Localization.Hooks.useLocalization({
            gameShared = LocalizationStrings.SHARE_GAME_SHARED,
            messagePlaceholder = name ~= nil and {
                LocalizationStrings.SHARE_EXPERIENCE,
                EXPERIENCE_NAME = name
            } or nil
        })

        local var5 = React.useContext(Localization.LocalizationRoactContext)
        local var6 = React.useCallback(function(tbl1)
            local var6 = tbl1[1]
            if var6 == nil or var6.displayName == "" then
                return var4.gameShared
            end
            return var5:Format(LocalizationStrings.SHARE_GAME_SHARED_WITH_TARGET, { DISPLAY_NAME = var6.displayName })
        end, { var4.gameShared, var5 })

        local messagePlaceholder = var4.messagePlaceholder
        return React.useCallback(function(num2: number)
            local function showShareSheet(url: string?)
                UniversalShareSheet.show({
                    context = "BuildExperienceGameShare",
                    recipientSource = UniversalShareSheet.RecipientSource.OneToOneFriends,
                    telemetryId = tostring(num2),
                    formatSuccessSnackbarText = var6,
                    messagePlaceholder = messagePlaceholder,
                    url = url or getGameShareUrl(num2)
                })
            end
            if num1 ~= nil then
                createExperienceShareLink(num1, false):andThen(showShareSheet, function()
                    showShareSheet(nil)
                end)

                return
            end

            showShareSheet(nil)
        end, { var6, messagePlaceholder, num1 })
    end or function()
        return React.useCallback(function(num1: number)
            sharePublishedExperience(num1, nil)
        end, {})
    end
}
