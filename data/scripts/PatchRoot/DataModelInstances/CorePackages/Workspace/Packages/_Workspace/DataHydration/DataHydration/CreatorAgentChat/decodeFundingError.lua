-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:21:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _model = require(script.Parent.Types.model)
local AcpProtocol = require(script.Parent.Acp.AcpProtocol)

local function isAmount(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return typeof(arg1) == "number" and arg1 >= 0 and arg1 <= 9007199254740991
end

local function decodeFundingError(arg1)
    if typeof(arg1) ~= "table" or arg1.code ~= AcpProtocol.ErrorCodes.OutOfCredits then
        return nil, nil
    end

    local message = arg1.message
    if message == "FreeTrialExhausted" then
        return message, nil
    elseif message ~= "InsufficientRobuxBalance" and message ~= "DailyLimitReached" then
        return nil, nil
    else
        local data = arg1.data

        if typeof(data) ~= "table"
            or data.model ~= "default" and data.model ~= "advanced"
            or not (isAmount(data.requiredRobux) and isAmount(data.availableRobux))
        then
            return message, nil
        end

        return message, {
            model = data.model,
            requiredRobux = data.requiredRobux,
            availableRobux = data.availableRobux
        }
    end
end
return decodeFundingError
