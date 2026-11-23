-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local AccountUpgradeAppShellFlow = require(script.AppShell.AccountUpgradeAppShellFlow)
local AccountUpgradeField = require(script.AccountUpgradeField)
local AccountUpgradeError = require(script.AccountUpgradeError)
local AccountUpgradeFlow = require(script.AccountUpgradeFlow)
local Eligibility = require(script.Eligibility)
local FlowSpec = require(script.FlowSpec)
local InExperienceController = require(script.InExperience.InExperienceController)
local _useAccountUpgradeViewModel = require(script.Components.useAccountUpgradeViewModel)

return {
    AccountUpgradeAppShellFlow = AccountUpgradeAppShellFlow,
    AccountUpgradeField = AccountUpgradeField,
    AccountUpgradeError = AccountUpgradeError,
    AccountUpgradeFlow = AccountUpgradeFlow,
    Components = require(script.Components),
    Eligibility = Eligibility,
    FlowSpec = FlowSpec,
    Hooks = require(script.Hooks),
    InExperienceController = InExperienceController,
    Utils = require(script.Utils),
    SuccessModal = require(script.SuccessModal),
    ["jest.config"] = script["jest.config"]
}
