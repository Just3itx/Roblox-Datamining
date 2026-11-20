-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VerificationPresentation = {
    Native = "Native",
    InAppWebView = "InAppWebView",
    ExternalLink = "ExternalLink"
}

return {
    VerificationPresentation = VerificationPresentation,
    resolveVerificationPresentation = function(bool1: boolean, bool2: boolean): string
        return if bool1 then VerificationPresentation.Native elseif bool2 then VerificationPresentation.InAppWebView else VerificationPresentation.ExternalLink
    end
}
