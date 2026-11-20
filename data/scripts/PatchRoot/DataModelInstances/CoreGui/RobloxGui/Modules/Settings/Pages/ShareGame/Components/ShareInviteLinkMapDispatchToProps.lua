-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:21:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local ReducerDependencies = require(CorePackages.Workspace.Packages.NotificationsCommon).ReducerDependencies

local ShareLinksNetworking = ReducerDependencies.ShareLinksNetworking
local ShareLinksRodux = ReducerDependencies.ShareLinksRodux

return function(callback)
    return {
        fetchShareInviteLink = function()
            callback(
                ShareLinksNetworking.GenerateLink.API({ linkType = ShareLinksRodux.Enums.LinkType.ExperienceInvite.rawValue() })
            )
        end
    }
end
