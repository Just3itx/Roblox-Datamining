-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpStatusCode = {
    BAD_REQUEST = 400,
    UNAUTHORIZED = 401,
    FORBIDDEN = 403,
    NOT_FOUND = 404,
    INTERNAL_SERVER_ERROR = 500,
    BAD_GATEWAY = 502,
    SERVICE_UNAVAILABLE = 503
}

local ErrorType = {
    TIMEOUT = "timeout",
    AUTHENTICATION = "authentication",
    PERMISSION = "permission",
    VALIDATION = "validation",
    SERVER_ERROR = "server_error",
    NETWORK = "network",
    UNKNOWN = "unknown"
}

local ERROR_MESSAGES = {
    [ErrorType.TIMEOUT] = "Request timed out. Please try again.",
    [ErrorType.AUTHENTICATION] = "Authentication failed. Please log in again.",
    [ErrorType.PERMISSION] = "You don't have permission to update this profile.",
    [ErrorType.VALIDATION] = "Invalid request. Please check your input.",
    [ErrorType.SERVER_ERROR] = "Server error. Please try again later.",
    [ErrorType.NETWORK] = "Network error. Please check your connection and try again.",
    [ErrorType.UNKNOWN] = "An unexpected error occurred. Please try again."
}

local DEFAULT_ERROR_MESSAGES = {
    SAVE_BACKGROUND = "Failed to save background",
    LOAD_BACKGROUND = "Failed to load background",
    UPDATE_PROFILE = "Failed to update profile"
}

local function getErrorType(arg1)
    if typeof(arg1) == "table" then
        if arg1.message and string.find(string.lower(arg1.message), "timeout") then
            return ErrorType.TIMEOUT
        end

        local var1 = arg1.StatusCode or arg1.statusCode
        if var1 then
            if var1 == HttpStatusCode.UNAUTHORIZED then
                return ErrorType.AUTHENTICATION
            end

            if var1 == HttpStatusCode.FORBIDDEN then
                return ErrorType.PERMISSION
            end

            if var1 == HttpStatusCode.BAD_REQUEST then
                return ErrorType.VALIDATION
            end

            if HttpStatusCode.INTERNAL_SERVER_ERROR <= var1 then
                return ErrorType.SERVER_ERROR
            end
        end
    elseif typeof(arg1) == "string" then
        if string.find(string.lower(arg1), "timeout") then
            return ErrorType.TIMEOUT
        end

        if string.find(string.lower(arg1), "network") or string.find(string.lower(arg1), "connection") then
            return ErrorType.NETWORK
        end
    end

    return ErrorType.UNKNOWN
end

return {
    HttpStatusCode = HttpStatusCode,
    ErrorType = ErrorType,
    ERROR_MESSAGES = ERROR_MESSAGES,
    DEFAULT_ERROR_MESSAGES = DEFAULT_ERROR_MESSAGES,
    getErrorType = getErrorType,
    getErrorMessage = function(arg1, arg2)
        local errorType = getErrorType(arg1)
        local var1 = ERROR_MESSAGES[errorType]

        return if arg2 and DEFAULT_ERROR_MESSAGES[arg2] then var1 or DEFAULT_ERROR_MESSAGES[arg2] else var1 or DEFAULT_ERROR_MESSAGES.SAVE_BACKGROUND
    end
}
