-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local isSubjectToDesktopPolicies = require(scriptParentParent.SharedFlags).isSubjectToDesktopPolicies

local function SharePolicies(arg1)
    return {
        getAccountProviderName = function()
            return arg1.AccountProviderName or ""
        end,
        shouldShowGameDetailsShareButton = function()
            return not isSubjectToDesktopPolicies() and (arg1.GameDetailsShareButton or false)
        end,
        shouldShowCatalogShareButton = function()
            return not isSubjectToDesktopPolicies() and (arg1.CatalogShareButton or false)
        end,
        shouldShareToAccountProvider = function()
            return arg1.ShareToAccountProvider or false
        end,
        shouldInviteFromAccountProvider = function()
            return arg1.InviteFromAccountProvider or false
        end,
        getShareToAccountProviderTimeout = function()
            return arg1.ShareToAccountProviderTimeout or 5
        end
    }
end

return SharePolicies
