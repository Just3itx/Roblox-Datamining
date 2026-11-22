-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxAppToastsRoduxParent = script:FindFirstAncestor("RobloxAppToastsRodux").Parent
local StatusCodes = require(RobloxAppToastsRoduxParent.Http).StatusCodes

local tbl1 = {
    [StatusCodes.BAD_REQUEST] = "Feature.Toast.NetworkingError.SomethingIsWrong",
    [StatusCodes.UNAUTHORIZED] = "Feature.Toast.NetworkingError.Unauthorized",
    [StatusCodes.FORBIDDEN] = "Feature.Toast.NetworkingError.Forbidden",
    [StatusCodes.NOT_FOUND] = "Feature.Toast.NetworkingError.NotFound",
    [StatusCodes.REQUEST_TIMEOUT] = "Feature.Toast.NetworkingError.Timeout",
    [StatusCodes.TOO_MANY_REQUESTS] = "Feature.Toast.NetworkingError.TooManyRequests",
    [StatusCodes.INTERNAL_SERVER_ERROR] = "Feature.Toast.NetworkingError.SomethingIsWrong",
    [StatusCodes.NOT_IMPLEMENTED] = "Feature.Toast.NetworkingError.SomethingIsWrong",
    [StatusCodes.BAD_GATEWAY] = "Feature.Toast.NetworkingError.SomethingIsWrong",
    [StatusCodes.SERVICE_UNAVAILABLE] = "Feature.Toast.NetworkingError.ServiceUnavailable",
    [StatusCodes.GATEWAY_TIMEOUT] = "Feature.Toast.NetworkingError.Timeout"
}

local function getLocalizedToastStringFromHttpError(httpError, arg1)
    if httpError == Enum.HttpError.DnsResolve
        or httpError == Enum.HttpError.ConnectFail
        or httpError == Enum.HttpError.NetFail
        or httpError == Enum.HttpError.SslConnectFail
    then
        return "Feature.Toast.NetworkingError.UnableToConnect"
    end

    if httpError == Enum.HttpError.TimedOut then
        return "Feature.Toast.NetworkingError.Timeout"
    end

    if httpError == Enum.HttpError.Aborted then
        return nil
    end

    if httpError == Enum.HttpError.OK and arg1 ~= nil and tbl1[arg1] ~= nil then
        return tbl1[arg1]
    end

    return "Feature.Toast.NetworkingError.SomethingIsWrong"
end

return getLocalizedToastStringFromHttpError
