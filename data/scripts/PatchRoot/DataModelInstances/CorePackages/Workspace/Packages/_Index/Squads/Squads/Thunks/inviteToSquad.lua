-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:51:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")
local HttpService = game:GetService("HttpService")

local dependencies = require(Squads.dependencies)

local Cryo = dependencies.Cryo
local NetworkingSquads = dependencies.NetworkingSquads

local function encodeInvitees(invitedUserIds)
    local input = Cryo.List.map(invitedUserIds, function(arg1): number?
        return tonumber(arg1)
    end)

    local success, result = pcall(function(): string
        return HttpService:JSONEncode(input)
    end)

    return if success then result else "[]"
end

return function(squadId: string, parentChannelId: string, str1: string, invitedUserIds, callback: (...any) -> (...any), isReparented: boolean)
    return function(arg1)
        return arg1:dispatch(
            NetworkingSquads.SquadInvite.API(
                {
                    squadId = squadId,
                    parentChannelId = parentChannelId,
                    invitedUserIds = invitedUserIds,
                    isReparented = isReparented
                }
            )
        ):andThen(
            function()
                local inviteeUserIds = encodeInvitees(invitedUserIds)

                callback({ isSuccess = true, inviteeUserIds = inviteeUserIds, inviteeCount = #invitedUserIds, userId = tonumber(str1) })
            end
        ):catch(
            function(tbl1)
                local body = tbl1.Body
                local success, result = pcall(function()
                    return HttpService:JSONDecode(body)
                end)

                local errorType = if success then result.errorType else nil
                local inviteeUserIds = encodeInvitees(invitedUserIds)

                local func1 = callback
                local tbl2 = {
                    isSuccess = false,
                    errorMessage = errorType,
                    errorType = if tbl1.StatusCode then tostring(tbl1.StatusCode) else nil,
                    inviteeUserIds = inviteeUserIds,
                    inviteeCount = #invitedUserIds,
                    userId = tonumber(str1)
                }
                func1(tbl2)
            end
        )
    end
end
