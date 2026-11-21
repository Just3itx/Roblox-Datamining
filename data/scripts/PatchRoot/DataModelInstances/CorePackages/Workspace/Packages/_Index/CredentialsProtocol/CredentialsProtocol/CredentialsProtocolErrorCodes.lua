-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:40:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
return {
    GetCredentialsErrorCodes = {
        [0] = "UNKNOWN",
        [1] = "CANCELLATION_ERROR",
        [2] = "INTERRUPTED_ERROR",
        [3] = "INVALID_REQUEST",
        [4] = "JSON_EXCEPTION",
        [5] = "CREDENTIALS_PROTOCOL_NOT_SUPPORTED",
        [6] = "NO_CREDENTIALS_FOUND",
        [7] = "CREDENTIAL_UNSUPPORTED",
        [11] = "INVALID_STATE_ERROR"
    },
    RegisterCredentialsErrorCodes = {
        PASSWORD_SAVE_FAILED = "PasswordSaveFailed",
        PASSWORD_AUTOFILL_DISABLED = "PasswordAutoFillDisabled",
        INVALID_PARAMETERS = "InvalidParameters"
    },
    UNMAPPED_ERROR_CODE = "UNMAPPED_ERROR_CODE: [%s]"
}
