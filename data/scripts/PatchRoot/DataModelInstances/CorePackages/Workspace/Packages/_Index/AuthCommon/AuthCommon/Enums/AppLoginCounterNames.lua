-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
return {
    Success = "AppLogin-Success",
    Failure = "AppLogin-Failure",
    FailureAuthCode = "AppLogin-AuthCode-Failure",
    FailureTimeout = "AppLogin-Failure-0-Timeout",
    FailureBadRequest = "AppLogin-Failure-400-BadRequest",
    FailureTwoStepVerification = "AppLogin-Failure-403-TwoStepVerification",
    FailureCredentials = "AppLogin-Failure-403-Credentials",
    FailureCaptcha = "AppLogin-Failure-403-Captcha",
    FailurePasswordReset = "AppLogin-Failure-403-PasswordReset",
    FailureNotFound = "AppLogin-Failure-404-NotFound",
    FailureThrottled = "AppLogin-Failure-429-Throttled",
    FailureInternalServerError = "AppLogin-Failure-500-InternalServerError",
    FailureUnknownError = "AppLogin-Failure-UnknownError",
    FailureSecurityQuestions = "AppLogin-403-SecurityQuestions",
    FailureMultipleUsersPerCredential = "AppLogin-403-MultipleUsersPerCredential"
}
