-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CloudClientOffer = script:FindFirstAncestor("CloudClientOffer")
local CloudClientOfferParent = CloudClientOffer.Parent

local Promise = require(CloudClientOfferParent.Promise)

local FFlagLuaAppCloudClientSyncOfferEligibility = require(CloudClientOffer.Flags.FFlagLuaAppCloudClientSyncOfferEligibility)

local function parseReservationError(arg1)
    local str1 = tostring(arg1)
    local reason = string.match(str1, "Ineligible:%s*(%w+)")

    if reason then
        return { kind = "Ineligible", reason = reason }
    end

    return {
        kind = "Unavailable",
        reason = string.match(str1, "Unavailable:%s*(%w+)") or "Unknown"
    }
end

local function createCloudClientServiceAdapter(arg1)
    return {
        checkEligibility = function(tbl1)
            return Promise.new(function(callback, callback2)
                local success, result = pcall(function()
                    if FFlagLuaAppCloudClientSyncOfferEligibility then
                        return arg1:CheckOfferEligibility(tbl1.kind)
                    end
                    return arg1:CheckOfferEligibilityAsync(tbl1.kind)
                end)

                if success then
                    callback(result == true)
                    return
                end
                callback2((parseReservationError(result)))
            end)
        end,
        makeReservation = function(str1: string, tbl1)
            return Promise.new(function(callback, callback2)
                local var1 = tonumber(str1)
                if var1 == nil then
                    callback2({ kind = "Unavailable", reason = "InvalidPlaceId" })
                    return
                end
                local success, result = pcall(function()
                    return arg1:MakeOfferReservationAsync(var1, tbl1.kind)
                end)
                if success and type(result) == "string" and result ~= "" then
                    callback(result)
                    return
                end
                callback2((parseReservationError(result)))
            end)
        end,
        releaseReservation = function(str1: string)
            pcall(function()
                arg1:ReleaseReservation(str1)
            end)
        end,
        reportDecision = function(str1: string, str2: string)
            pcall(function()
                arg1:ReportOfferDecision(str1, str2)
            end)
        end,
        onReservationExpired = function(func1: (...any) -> (...any))
            local success, result = pcall(function()
                return arg1.ReservationExpired:Connect(func1)
            end)
            return if success then result else {
                Disconnect = function() end
            }
        end
    }
end

return {
    createCloudClientServiceAdapter = createCloudClientServiceAdapter,
    getCloudClientServiceAdapter = function()
        local success, result = pcall(function(): CloudClientService
            return game:GetService("CloudClientService")
        end)
        local func1 = createCloudClientServiceAdapter

        if not success then
            result = nil
        end

        return (func1(result))
    end,
    parseReservationError = parseReservationError
}
