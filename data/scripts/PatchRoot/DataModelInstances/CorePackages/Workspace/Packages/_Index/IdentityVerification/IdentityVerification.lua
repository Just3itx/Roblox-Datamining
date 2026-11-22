-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:50:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
return {
    Enums = require(script.Common.Enums),
    IDVApiProvider = require(script.Utils.IDVApiProvider),
    usePollIDVStatus = require(script.Hooks.usePollIDVStatus),
    GetFIntIDVPollDelay = require(script.Flags.GetFIntIDVPollDelay),
    GetFIntIDVMaxRetries = require(script.Flags.GetFIntIDVMaxRetries),
    QRDeepLinkDialog = require(script.Components.QRDeepLinkDialog),
    ["jest.config"] = script["jest.config"]
}
