-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthSignup = script:FindFirstAncestor("AuthSignup")
local AuthSignupParent = AuthSignup.Parent

local HttpService = game:GetService("HttpService")
local MemStorageService = game:GetService("MemStorageService")

local Promise = require(AuthSignupParent.Promise)

local SignUpRequests = require(AuthSignup.Requests.SignUpRequests)
local SignUpV2ErrorCodes = require(AuthSignup.Enums.SignUpV2ErrorCodes)
local AppSignupCounterNames = require(AuthSignup.Enums.AppSignupCounterNames)

local NotificationType = require(AuthSignupParent.RobloxAppEnums).NotificationType

local AuthCommon = require(AuthSignupParent.AuthCommon)
local AuthMemStorageKeys = AuthCommon.Enums.AuthMemStorageKeys
local reportEphemeralCounter = AuthCommon.Analytics.reportEphemeralCounter
local shouldSkipLegacyPasswordSaveEvent = AuthCommon.Utils.shouldSkipLegacyPasswordSaveEvent

local StatusCodes = require(AuthSignupParent.Http).StatusCodes

local Logger = require(AuthSignupParent.Loggers).Logger
local SharedFlags = require(AuthSignupParent.SharedFlags)
local FFlagDisableMemStorageServicePasswordEvent = SharedFlags.FFlagDisableMemStorageServicePasswordEvent
local FFlagLuaAppSkipDuplicateIosPasswordSavePrompt = SharedFlags.FFlagLuaAppSkipDuplicateIosPasswordSavePrompt

local CredentialsProtocol = require(AuthSignupParent.CredentialsProtocol)
local Constants = CredentialsProtocol.Constants
local default = CredentialsProtocol.CredentialsProtocol.default

local function signUpRequest(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    return SignUpRequests.signUpV2(arg1, arg2, {})
end

return function(arg1, _, arg2, _, _, arg3, arg4, _, _)
    return signUpRequest(arg1, arg3):andThen(function(arg5)
        arg2:BroadcastNotification("", NotificationType.DID_SIGN_UP)

        reportEphemeralCounter(AppSignupCounterNames.Success, 1)

        local password = arg3.username and arg3.password and string.len(arg3.password) > 0

        local var1 = FFlagLuaAppSkipDuplicateIosPasswordSavePrompt and shouldSkipLegacyPasswordSaveEvent(arg4 == true and password == true)

        if not FFlagDisableMemStorageServicePasswordEvent and password and not var1 then
            MemStorageService:Fire(
                AuthMemStorageKeys.AuthenticatedCredentials,
                HttpService:JSONEncode({ cvalue = arg3.username, password = arg3.password, authType = "signup" })
            )
        end

        if arg4 and arg3.password and #arg3.password > 0 then
            local input = {
                username = arg3.username,
                password = arg3.password
            }

            local str1 = HttpService:JSONEncode(input)

            default:registerCredentials(
                default.CredentialsTypes.password,
                str1,
                Constants.Defaults.PASSWORD_REGISTRATION_CREDENTIALSPROTOCOL_TIMEOUT
            ):andThen(
                function(input2: string)
                    local var2 = not input2 and {} or HttpService:JSONDecode(input2)

                    if var2 and var2.errorCode == nil then
                        Logger:info("Successfully registered password.")
                        return
                    end
                    Logger:warning("Error registering password: " .. tostring(var2.errorMsg))
                end,
                function(arg6)
                    Logger:warning("Error registering password: " .. tostring(arg6))
                end
            ):await()
        end

        return Promise.resolve(arg5)
    end, function(arg5)
        local success, result = pcall(function()
            return HttpService:JSONDecode(arg5.Body)
        end)

        if not success then
            return Promise.reject()
        end

        local code = result.errors and result.errors[1] and result.errors[1].code

        reportEphemeralCounter(AppSignupCounterNames.Failure, 1)

        if code == SignUpV2ErrorCodes.Captcha then
            reportEphemeralCounter(AppSignupCounterNames.FailureCaptcha, 1)
        elseif code == SignUpV2ErrorCodes.TooManyAttempts then
            reportEphemeralCounter(AppSignupCounterNames.FailureThrottled, 1)
        elseif code == SignUpV2ErrorCodes.InvalidBirthdate then
            reportEphemeralCounter(AppSignupCounterNames.FailureBirthdayInvalid, 1)
        elseif code == SignUpV2ErrorCodes.InvalidUsername then
            reportEphemeralCounter(AppSignupCounterNames.FailureUsernameInvalid, 1)
        elseif code == SignUpV2ErrorCodes.UsernameAlreadyTaken then
            reportEphemeralCounter(AppSignupCounterNames.FailureUsernameTaken, 1)
        elseif code == SignUpV2ErrorCodes.InvalidPassword then
            reportEphemeralCounter(AppSignupCounterNames.FailurePasswordInvalid, 1)
        elseif code == SignUpV2ErrorCodes.UsernameAndPasswordTheSame then
            reportEphemeralCounter(AppSignupCounterNames.FailurePasswordMatchesUsername, 1)
        elseif code == SignUpV2ErrorCodes.UnavailableInRegion then
            reportEphemeralCounter(AppSignupCounterNames.FailureUnavailableInRegion, 1)
        elseif code == SignUpV2ErrorCodes.PasswordTooSimple then
            reportEphemeralCounter(AppSignupCounterNames.FailurePasswordTooSimple, 1)
        elseif arg5.HttpError == Enum.HttpError.OK and arg5.StatusCode == StatusCodes.TOO_MANY_REQUESTS then
            reportEphemeralCounter(AppSignupCounterNames.FailureThrottled, 1)
        elseif arg5.HttpError == Enum.HttpError.OK and arg5.StatusCode == StatusCodes.INTERNAL_SERVER_ERROR then
            reportEphemeralCounter(AppSignupCounterNames.FailureInternalServerError, 1)
        elseif arg5.HttpError == Enum.HttpError.OK and arg5.StatusCode == StatusCodes.BAD_REQUEST then
            reportEphemeralCounter(AppSignupCounterNames.FailureBadRequest, 1)
        elseif arg5.HttpError == Enum.HttpError.OK and arg5.StatusCode == StatusCodes.NOT_FOUND then
            reportEphemeralCounter(AppSignupCounterNames.FailureNotFound, 1)
        else
            reportEphemeralCounter(AppSignupCounterNames.FailureUnknownError, 1)
        end

        return Promise.reject(code)
    end)
end
