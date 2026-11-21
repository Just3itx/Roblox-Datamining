-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CloudClientOffer = script:FindFirstAncestor("CloudClientOffer")
local CloudClientOfferParent = CloudClientOffer.Parent

local Promise = require(CloudClientOfferParent.Promise)

local _CloudClientServiceAdapter = require(CloudClientOffer.CloudClientServiceAdapter)

local function createDeferred() -- Luacid: Inlined by compiler; 2 call sites recovered
    local tbl1 = ({})
    return Promise.new(function(resolve, reject)
        tbl1.resolve = resolve
        tbl1.reject = reject
    end), tbl1
end

local function createFakeCloudClientService()
    local eligibilityChecks = {}
    local reservations = {}
    local releasedTokens = {}
    local reportedDecisions = {}
    local tbl5 = ({})

    return {
        adapter = {
            checkEligibility = function(arg1)
                local var1, tbl6 = createDeferred()
                table.insert(eligibilityChecks, { kind = arg1.kind, resolve = tbl6.resolve, reject = tbl6.reject })

                return var1
            end,
            makeReservation = function(placeId: string, arg1)
                local var1, tbl6 = createDeferred()
                table.insert(reservations, { placeId = placeId, kind = arg1.kind, resolve = tbl6.resolve, reject = tbl6.reject })

                return var1
            end,
            releaseReservation = function(str1: string)
                table.insert(releasedTokens, str1)
            end,
            reportDecision = function(reservationToken: string, decision)
                table.insert(reportedDecisions, {
                    reservationToken = reservationToken,
                    decision = decision,
                    wasReleased = table.find(releasedTokens, reservationToken) ~= nil
                })
            end,
            onReservationExpired = function(func1: (...any) -> (...any))
                tbl5[func1] = true
                return {
                    Disconnect = function()
                        tbl5[func1] = nil
                    end
                }
            end
        },
        eligibilityChecks = eligibilityChecks,
        reservations = reservations,
        releasedTokens = releasedTokens,
        reportedDecisions = reportedDecisions,
        getExpiredListenerCount = function(): number
            local num1 = 0
            for _ in tbl5 do
                num1 += 1
            end
            return num1
        end,
        fireReservationExpired = function(str1: string)
            for value in table.clone(tbl5) do
                value(str1)
            end
        end
    }
end

return createFakeCloudClientService
