-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local default = require(BuildExperienceParent.ExternalContentSharingProtocol).ExternalContentSharingProtocol.default
local UniversalShareSheet = require(BuildExperienceParent.ShareSheet).UniversalShareSheet
local SharedFlags = require(BuildExperienceParent.SharedFlags)

local createExperienceShareLink = require(BuildExperience.utils.createExperienceShareLink)

local FFlagEnableShareSheet = SharedFlags.FFlagEnableShareSheet
local isSubjectToDesktopPolicies = SharedFlags.isSubjectToDesktopPolicies

local function sharePrivateExperience(num1: number)
    return createExperienceShareLink(num1):andThen(function(str1: string?)
        if str1 == nil then
            error("sharePrivateExperience: no share link returned")
        end

        if FFlagEnableShareSheet then
            UniversalShareSheet.show({
                url = str1,
                context = "BuildExperiencePrivateInvitesShareLink",
                recipientSource = UniversalShareSheet.RecipientSource.OneToOneFriends
            })

            return nil
        elseif isSubjectToDesktopPolicies() then
            default:setClipboardText({ text = str1, context = "BuildExperiencePrivateInvitesShareLink" })

            return { url = str1, copiedToClipboard = true }
        else
            default:shareUrl({ url = str1, context = "BuildExperiencePrivateInvitesShareLink" })

            return { url = str1, copiedToClipboard = false }
        end
    end)
end

return sharePrivateExperience
