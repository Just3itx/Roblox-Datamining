-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
return {
    Analytics = require(script.Analytics),
    EditDisplayNameErrorModal = require(script.Components.ErrorModals.EditDisplayNameErrorModal),
    EditSocialNetworksErrorModal = require(script.Components.ErrorModals.EditSocialNetworksErrorModal),
    UsernameInsufficientFundsModal = require(script.Components.ErrorModals.UsernameInsufficientFundsModal),
    EditSocialLinksModal = require(script.Components.EditSocialLinksModal),
    Flags = require(script.Flags),
    Constants = require(script.Common.Constants),
    ["jest.config"] = script["jest.config"],
    installReducer = require(script.installReducer),
    RoduxKey = require(script.Common.Constants).RODUX_KEY,
    EditUsernameWrapper = require(script.EditUsernameWrapper),
    useDisplayNameText = require(script.Hooks.useDisplayNameText),
    Enums = require(script.Common.Enums),
    EditProfileScreenViewAdapter = require(script.Components.EditProfileScreenViewAdapter),
    EditProfileLanding = require(script.Components.EditProfileLanding),
    EditProfileToastScreen = require(script.Components.EditProfileToast)
}
