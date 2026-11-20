-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")
local AmpV2WizardParent = AmpV2Wizard.Parent

local React = require(AmpV2WizardParent.React)

local _ComponentRegistry = require(AmpV2Wizard.ComponentRegistry)
local _Types = require(AmpV2Wizard.Types)

local function usePresentedOverPage(node, component, bool1: boolean)
    local var1 = React.useRef(nil)
    if node == nil or component == nil then
        return nil
    end
    if node.behavior ~= nil and node.behavior.presentsOverPrevious == true then
        return var1.current
    end

    var1.current = bool1 and { node = node, component = component } or nil

    return nil
end

return usePresentedOverPage
