-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local Signals = require(AuthCommonParent.Signals)

return function()
    local getLoggedinUsingSavedPassword, setLoggedinUsingSavedPassword = Signals.createSignal(false)
    local getSavedPasswordAfterLogin, setSavedPasswordAfterLogin = Signals.createSignal(false)
    local getPasswordManagerMediatedSignup, setPasswordManagerMediatedSignup = Signals.createSignal(false)

    return {
        getLoggedinUsingSavedPassword = getLoggedinUsingSavedPassword,
        setLoggedinUsingSavedPassword = setLoggedinUsingSavedPassword,
        getSavedPasswordAfterLogin = getSavedPasswordAfterLogin,
        setSavedPasswordAfterLogin = setSavedPasswordAfterLogin,
        getPasswordManagerMediatedSignup = getPasswordManagerMediatedSignup,
        setPasswordManagerMediatedSignup = setPasswordManagerMediatedSignup,
        resetAll = function()
            setLoggedinUsingSavedPassword(false)
            setSavedPasswordAfterLogin(false)
            setPasswordManagerMediatedSignup(false)
        end
    }
end
