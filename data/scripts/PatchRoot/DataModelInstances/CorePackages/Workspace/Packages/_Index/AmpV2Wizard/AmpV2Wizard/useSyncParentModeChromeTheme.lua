-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:50:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")
local AmpV2WizardParent = AmpV2Wizard.Parent

local React = require(AmpV2WizardParent.React)

local _ComponentRegistry = require(AmpV2Wizard.ComponentRegistry)
local _Types = require(AmpV2Wizard.Types)
local getFFlagAmpV2WizardDebugUnknownNodes = require(AmpV2Wizard.getFFlagAmpV2WizardDebugUnknownNodes)
local isParentModeThemedNode = require(AmpV2Wizard.isParentModeThemedNode)
local getParentModeChromeThemeStore = require(AmpV2Wizard.getParentModeChromeThemeStore)
local FFlagAmpV2WizardServerParentFacing = require(AmpV2Wizard.FFlagAmpV2WizardServerParentFacing)
local _usePresentedOverPage = require(AmpV2Wizard.usePresentedOverPage)

local function useSyncParentModeChromeTheme(bool1: boolean, bool2: boolean, arg1, str1: string?, arg2, arg3)
    local bool3 = false
    local bool4 = not (bool1 or bool2)

    if bool4 then
        if arg1 == nil then
            bool4 = false
        else
            bool4 = arg2 ~= nil or getFFlagAmpV2WizardDebugUnknownNodes()
        end
    end

    if bool4 then
        if arg3 ~= nil then
            arg1 = arg3.node
        end

        if FFlagAmpV2WizardServerParentFacing then
            bool3 = not (arg1.behavior == nil) and arg1.behavior.parentFacing == true
        else
            bool3 = isParentModeThemedNode(arg1.type, str1)
        end
    end

    React.useLayoutEffect(function()
        getParentModeChromeThemeStore(false).setIsActive(bool3)
    end, { bool3 })

    React.useLayoutEffect(function()
        return function()
            getParentModeChromeThemeStore(false).setIsActive(false)
        end
    end, {})
end

return useSyncParentModeChromeTheme
