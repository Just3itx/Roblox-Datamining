-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {
    Invalid = "Invalid",
    InvalidInput = "InvalidInput",
    TransferNotFound = "TransferNotFound",
    Unauthorized = "Unauthorized",
    InternalError = "InternalError",
    TransferDailyLimitExceeded = "TransferDailyLimitExceeded",
    TransferMonthlyLimitExceeded = "TransferMonthlyLimitExceeded",
    InsufficientFunds = "InsufficientFunds",
    UserNotAllowed = "UserNotAllowed",
    TransferExpired = "TransferExpired",
    TooManyRequests = "TooManyRequests",
    TransferAlreadyProcessed = "TransferAlreadyProcessed",
    InvalidTransferState = "InvalidTransferState",
    AmpRecourseAvailable = "AmpRecourseAvailable",
    TransferDisabledForUser = "TransferDisabledForUser",
    ReceiverNotAllowed = "ReceiverNotAllowed",
    ReceiveLimitExceeded = "ReceiveLimitExceeded",
    TransferAmountBelowMinimum = "TransferAmountBelowMinimum",
    TransferAmountExceedsMaximum = "TransferAmountExceedsMaximum",
    TransferAmountExceedsNonSecuredMaximum = "TransferAmountExceedsNonSecuredMaximum",
    NoFreeTransfersRemaining = "NoFreeTransfersRemaining"
}

local tbl1 = {
    [0] = module.Invalid,
    [1] = module.InvalidInput,
    [2] = module.TransferNotFound,
    [3] = module.Unauthorized,
    [4] = module.InternalError,
    [5] = module.TransferDailyLimitExceeded,
    [6] = module.TransferMonthlyLimitExceeded,
    [7] = module.InsufficientFunds,
    [8] = module.UserNotAllowed,
    [9] = module.TransferExpired,
    [10] = module.TooManyRequests,
    [11] = module.TransferAlreadyProcessed,
    [12] = module.InvalidTransferState,
    [13] = module.AmpRecourseAvailable,
    [14] = module.TransferDisabledForUser,
    [15] = module.ReceiverNotAllowed,
    [16] = module.TransferAmountBelowMinimum,
    [17] = module.TransferAmountExceedsMaximum,
    [18] = module.TransferAmountExceedsNonSecuredMaximum,
    [19] = module.ReceiveLimitExceeded,
    [21] = module.NoFreeTransfersRemaining
}

function module.fromValue(arg1)
    if arg1 == nil then
        return nil
    end

    if type(arg1) == "number" then
        return tbl1[arg1]
    end

    if type(arg1) == "string" then
        for _, value in pairs(module) do
            if value == arg1 then
                return arg1
            end
        end
    end

    return nil
end

return module
