-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:41:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Cryo = require(AppChatParent.Cryo)
local DataHydration = require(AppChatParent.DataHydration)
local React = require(AppChatParent.React)
local Signals = require(AppChatParent.Signals)
local SignalsReact = require(AppChatParent.SignalsReact)

local DataStatus = DataHydration.DataStatus
local getAndFetchUserNames = DataHydration.UserProfile.getAndFetchUserNames
local getAndFetchUserNamesByUserIds = DataHydration.UserProfile.getAndFetchUserNamesByUserIds
local useSignalState = SignalsReact.useSignalState

local FFlagHomeFriendNamesUseUserProfileHydration = require(AppChatParent.SharedFlags).FFlagHomeFriendNamesUseUserProfileHydration

local tbl1 = {
    status = DataStatus.Ready,
    namesByUserId = {}
}

local function nonEmpty(str1: string?): string? -- Luacid: Inlined by compiler; 2 call sites recovered
    return if str1 == "" then nil else str1
end

local function useProfileNames(tbl2)
    local str1 = table.concat(Cryo.List.filter(tbl2, function(arg1): boolean
        return tonumber(arg1) ~= nil
    end), ",")

    local var1 = React.useMemo(function()
        if FFlagHomeFriendNamesUseUserProfileHydration then
            return getAndFetchUserNamesByUserIds(string.split(str1, ","))
        end

        if str1 == "" then
            return Signals.createComputed(function()
                return tbl1
            end)
        end

        local tbl3 = ({})
        for _, value in string.split(str1, ",") do
            tbl3[value] = getAndFetchUserNames(value)
        end

        return Signals.createComputed(function(arg1)
            local ready = DataStatus.Ready
            local namesByUserId = ({})
            for value, value2 in tbl3 do
                local var1 = value2.status(arg1)
                if var1 == DataStatus.NotReady then
                    ready = DataStatus.NotReady
                elseif var1 == DataStatus.Failed and ready == DataStatus.Ready then
                    ready = DataStatus.Failed
                end

                local var2 = value2.names(arg1)
                if not var2 then
                    continue
                end

                local tbl5 = {
                    combinedName = nonEmpty(var2.combinedName),
                    username = nonEmpty(var2.username)
                }
                namesByUserId[value] = tbl5
            end

            return { status = ready, namesByUserId = namesByUserId }
        end)
    end, { str1 })

    return useSignalState(var1)
end

return useProfileNames
