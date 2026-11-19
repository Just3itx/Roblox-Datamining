-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local UserProfileStore = require(CorePackages.Workspace.Packages.UserProfiles).Stores.UserProfileStore
local SignalsReact = require(CorePackages.Packages.SignalsReact)

local function usePlayerCombinedName(str1: string, str2: string)
    local var1 = UserProfileStore.get().fetchNamesByUserIds({ str1 })(false).data[1]
    return SignalsReact.useSignalBinding(var1.names.getInExperienceCombinedName):map(function(arg1)
        return if string.len(arg1) == 0 then str2 else arg1
    end)
end

return usePlayerCombinedName
