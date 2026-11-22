-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IdentityVerificationParent = script:FindFirstAncestor("IdentityVerification").Parent

local React = require(IdentityVerificationParent.React)
local Promise = require(IdentityVerificationParent.Promise)

local IDVApiProvider = require(script.Parent.Parent.Utils.IDVApiProvider)
local Enums = require(script.Parent.Parent.Common.Enums)
local IDVSessionStatusEnum = Enums.IDVSessionStatusEnum
local IDVSessionErrorEnum = Enums.IDVSessionErrorEnum

local GetFIntIDVPollDelay = require(script.Parent.Parent.Flags.GetFIntIDVPollDelay)
local GetFIntIDVMaxRetries = require(script.Parent.Parent.Flags.GetFIntIDVMaxRetries)

local GetFFlagIDVGuardStartPollingAfterUnmount = require(script.Parent.Parent.Flags.GetFFlagIDVGuardStartPollingAfterUnmount)

local fIntIDVPollDelay = GetFIntIDVPollDelay()
local fIntIDVMaxRetries = GetFIntIDVMaxRetries()
local fFlagIDVGuardStartPollingAfterUnmount = GetFFlagIDVGuardStartPollingAfterUnmount()

local function isFailure(num1: number): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return num1 == IDVSessionStatusEnum.RequiresManualReview
        or num1 == IDVSessionStatusEnum.RequiresRetry
        or num1 == IDVSessionStatusEnum.Expired
end

local function usePollIDVStatus(tbl1)
    local var1 = tbl1.retries or fIntIDVMaxRetries
    local var2 = tbl1.delay or fIntIDVPollDelay

    local onStatusUpdate = tbl1.onStatusUpdate

    local var3 = nil
    var3 = React.useCallback(function(str1: string, retriesLeft: number, arg1, arg2)
        if retriesLeft == 0 then
            arg2({ sessionStatus = IDVSessionStatusEnum.Expired })
            return
        end

        IDVApiProvider.getVerifiedStatus(str1):andThen(function(arg3)
            local isVerified = arg3.isVerified
            local sessionStatus = arg3.sessionStatus
            local sessionErrorCode = arg3.sessionErrorCode
            local ageEstimationNextStep = arg3.ageEstimationNextStep

            if onStatusUpdate then
                onStatusUpdate({ sessionStatus = sessionStatus, retriesLeft = retriesLeft })
            end

            if isVerified and sessionStatus == IDVSessionStatusEnum.Stored then
                if sessionErrorCode == IDVSessionErrorEnum.UnknownError and ageEstimationNextStep == nil then
                    return arg2({ sessionStatus = IDVSessionStatusEnum.Failure })
                end
                return arg1()
            elseif isFailure(sessionStatus) then
                arg2({ sessionStatus = sessionStatus })
            else
                task.spawn(function()
                    task.wait(var2)
                    if var3 then
                        var3(str1, retriesLeft - 1, arg1, arg2)
                    end
                end)
            end
        end):catch(function(_)
            arg2({ sessionStatus = IDVSessionStatusEnum.RequiresRetry })
        end)
    end, { var2, onStatusUpdate })

    return React.useCallback(function(arg1)
        return Promise.new(function(callback, arg2)
            if not fFlagIDVGuardStartPollingAfterUnmount then
                var3(arg1, var1, callback, arg2)

                return
            end

            if var3 then
                var3(arg1, var1, callback, arg2)
                return
            end
            callback()
        end)
    end, { var3, var1 }), (React.useCallback(function()
        var3 = nil
    end, {}))
end

return usePollIDVStatus
