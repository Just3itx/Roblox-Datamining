-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)
local SignalsReact = require(MomentsParent.SignalsReact)

local GetUsersStore = require(Moments.Stores.GetUsersStore)

local Players = game:GetService("Players")

local useSignalState = SignalsReact.useSignalState

return function(userId: number): number
    local usersStore = GetUsersStore(false)
    local username = useSignalState(usersStore.getUserProfile(tostring(userId))).username

    React.useEffect(function()
        if username ~= nil then
            return
        end

        local bool1 = false

        task.spawn(function()
            local success, result = pcall(function(): string
                return Players:GetNameFromUserIdAsync(userId)
            end)
            if success and not bool1 then
                usersStore.updateUsername(userId, result)
            end
        end)

        return function()
            bool1 = true
        end
    end, { userId, username, usersStore.updateUsername })

    return username
end
