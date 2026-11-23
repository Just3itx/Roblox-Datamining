-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserList = script:FindFirstAncestor("UserList")
local UserListParent = UserList.Parent

local React = require(UserListParent.React)
local SignalsReact = require(UserListParent.SignalsReact)
local ProfileCtaService = require(UserListParent.ProfileCtaService)
local _Types = require(UserList.Common.Types)

local ProfileCTAService = ProfileCtaService.ProfileCTAService
local useSignalState = SignalsReact.useSignalState

local function useProfileCta(str1: string)
    local var1 = React.useMemo(function()
        return ProfileCTAService.getProfileCTA(str1)
    end, { str1 })

    return useSignalState(var1.data), (useSignalState(var1.status))
end

return useProfileCta
