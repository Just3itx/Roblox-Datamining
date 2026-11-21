-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CloudClientOffer = script:FindFirstAncestor("CloudClientOffer")
local CloudClientOfferParent = CloudClientOffer.Parent

local Signals = require(CloudClientOfferParent.Signals)

local _CloudClientServiceAdapter = require(CloudClientOffer.CloudClientServiceAdapter)
local _CloudClientExperiment = require(CloudClientOffer.CloudClientExperiment)

local _createCloudClientSessionStore = require(CloudClientOffer.Stores.GetCloudClientSessionStore.createCloudClientSessionStore)
local FFlagLuaAppCloudClientOfferDryRun = require(CloudClientOffer.Flags.FFlagLuaAppCloudClientOfferDryRun)

local FFlagLuaAppCloudClientOfferDecisionTelemetry = require(CloudClientOffer.Flags.FFlagLuaAppCloudClientOfferDecisionTelemetry)

local function getRefusalKey(kind: string, str1: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    return `{kind}/{str1}`
end

local function createCloudClientOffer(tbl1)
    local service = tbl1.service
    local experiment = tbl1.experiment
    local session = tbl1.session
    local candidates = tbl1.candidates

    local getHeldOffer, var2 = Signals.createSignal(nil)
    local var3 = nil
    local var4 = nil
    local var5 = nil
    local num1 = 0
    local bool1 = false

    local function decide(tbl2) -- Luacid: Inlined by compiler; 7 call sites recovered
        local var6 = var4
        var4 = nil
        var5 = nil
        if var3 ~= nil then
            var3 = nil
            var2(nil)
        end
        if var6 ~= nil then
            var6(tbl2)
        end
    end

    local function releaseHeldOffer() -- Luacid: Inlined by compiler; 3 call sites recovered
        local var6 = var3
        if var6 ~= nil then
            service.releaseReservation(var6.reservationToken)
        end
    end

    local function tryCandidate(str1: string, num2: number, num3: number)
        local function isStale(): boolean -- Luacid: Inlined by compiler; 7 call sites recovered
            return bool1 or num3 ~= num1
        end
        local var6 = candidates[num2]
        if var6 == nil then
            decide({ kind = "Local" })
            return
        end
        local function tryNextCandidate() -- Luacid: Inlined by compiler; 3 call sites recovered
            if not isStale() then
                tryCandidate(str1, num2 + 1, num3)
            end
        end

        local refusalKey = getRefusalKey(var6.kind, str1)
        local tbl2 = {
            kind = var6.kind
        }

        if session.isPlaceRefused(refusalKey) then
            tryNextCandidate()
            return
        end

        local function onReserved(reservationToken: string)
            if isStale() then
                service.releaseReservation(reservationToken)
                return
            end
            local tbl3 = {
                kind = var6.kind,
                reservationToken = reservationToken
            }
            var3 = tbl3
            var2(tbl3)
            local var7 = var5
            if var7 ~= nil then
                var7(tbl3)
            end
        end

        local function onReservationFailed(arg1)
            if isStale() then
                return
            end

            if FFlagLuaAppCloudClientOfferDryRun and arg1.kind == "Unavailable" and arg1.reason == "DryRun" then
                decide({ kind = "Local" })
            else
                if arg1.kind == "Ineligible" then
                    session.markPlaceRefused(refusalKey)
                end

                tryNextCandidate()
            end
        end

        service.checkEligibility(tbl2):andThen(function(bool2: boolean)
            if isStale() then
                return
            end

            if not bool2 then
                tryNextCandidate()
                return
            end

            experiment.logExposure()
            if not experiment.isTreatment() then
                decide({ kind = "Local" })
                return
            end
            service.makeReservation(str1, tbl2):andThen(onReserved, onReservationFailed)
        end, tryNextCandidate)
    end

    local function request(str1: string, func1: (...any) -> (...any), func2: (...any) -> (...any))
        if bool1 or var4 ~= nil then
            return nil
        end
        num1 += 1
        var4 = func1
        var5 = func2
        tryCandidate(str1, 1, num1)
        return num1
    end

    local function cancel(num2: number)
        if bool1 or num2 ~= num1 or var3 ~= nil or var4 == nil then
            return
        end
        num1 += 1
        var4 = nil
        var5 = nil
    end

    local function accept()
        local offer = var3
        if bool1 or offer == nil then
            return
        end
        if FFlagLuaAppCloudClientOfferDecisionTelemetry then
            service.reportDecision(offer.reservationToken, "accepted")
        end
        decide({ kind = "Stream", offer = offer })
    end

    local function decline()
        if bool1 or var3 == nil then
            return
        end
        if FFlagLuaAppCloudClientOfferDecisionTelemetry then
            service.reportDecision(var3.reservationToken, "rejected")
        end

        releaseHeldOffer()
        decide({ kind = "Local" })
    end

    local function dismiss()
        if bool1 or var3 == nil then
            return
        end
        if FFlagLuaAppCloudClientOfferDecisionTelemetry then
            service.reportDecision(var3.reservationToken, "dismissed")
        end

        releaseHeldOffer()
        decide({ kind = "Stay", expired = false })
    end

    local var6 = service.onReservationExpired(function(reservationToken: string)
        local var6 = var3
        if bool1 or var6 == nil or var6.reservationToken ~= reservationToken then
            return
        end
        decide({ kind = "Stay", expired = true })
    end)

    return {
        getHeldOffer = getHeldOffer,
        request = request,
        cancel = cancel,
        accept = accept,
        decline = decline,
        dismiss = dismiss,
        dispose = function()
            bool1 = true
            var4 = nil
            var5 = nil
            releaseHeldOffer()
            var3 = nil
            var6:Disconnect()
        end
    }
end
return createCloudClientOffer
