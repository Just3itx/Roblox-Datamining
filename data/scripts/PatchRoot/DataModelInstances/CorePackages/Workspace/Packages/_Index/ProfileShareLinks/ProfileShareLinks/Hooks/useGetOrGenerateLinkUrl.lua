-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:00:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileShareLinks = script:FindFirstAncestor("ProfileShareLinks")
local ProfileShareLinksParent = ProfileShareLinks.Parent
local React = require(ProfileShareLinksParent.React)
local useDispatch = require(ProfileShareLinksParent.RoactUtils).Hooks.RoactRodux.useDispatch

local Networking = require(ProfileShareLinks.Networking.Networking)

return function()
    local var1 = useDispatch()

    return (React.useCallback(function()
        return var1(Networking.ShareLinksNetworking.GetOrGenerateLink.API({ linkType = "Profile" })):catch(function() end)
    end, { var1 }))
end
