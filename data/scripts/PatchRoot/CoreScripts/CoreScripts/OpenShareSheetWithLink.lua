-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:31:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local CorePackages = game:GetService("CorePackages")
local SocialService = game:GetService("SocialService")

local default = require(CorePackages.Workspace.Packages.ExternalContentSharingProtocol).ExternalContentSharingProtocol.default
local isContentSharingAllowed = require(CorePackages.Workspace.Packages.CachedPolicyService):IsContentSharingAllowed()

local var1 = require(CorePackages.Packages.PolicyProvider).GetPolicyImplementations.MemStorageService("app-policy")

local bool1 = game:DefineFastFlag("DifferentiateSharingBaseOnPlatform", false)

local EligibleForCapturesFeature = false
if bool1 then
    local var2 = var1.read()
    EligibleForCapturesFeature = var2 and var2.EnableShareCaptureCTA and var2.EligibleForCapturesFeature or false
end

SocialService.OpenShareSheetWithLink:Connect(function(link: string)
    if not default then
        return
    end

    assert(default ~= nil, "ExternalContentSharingProtocol is required")
    if bool1 then
        if not EligibleForCapturesFeature then
            default:setClipboardText({ context = "PromptLinkSharing", text = link })

            return
        end
    elseif not isContentSharingAllowed then
        default:setClipboardText({ context = "PromptLinkSharing", text = link })

        return
    end

    default:shareUrl({ context = "PromptLinkSharing", url = link })
end)
