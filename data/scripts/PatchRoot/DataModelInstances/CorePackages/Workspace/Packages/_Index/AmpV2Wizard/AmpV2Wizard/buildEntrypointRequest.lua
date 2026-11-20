-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")

local _Types = require(AmpV2Wizard.Types)
local ComponentRegistry = require(AmpV2Wizard.ComponentRegistry)

local function buildEntrypointRequest(target, flow, surface: string, arg1, extraProps)
    return {
        target = target,
        flow = flow,
        surface = surface,
        client = {
            clientCapabilities = ComponentRegistry.capabilities(arg1)
        },
        extraProps = extraProps
    }
end

return buildEntrypointRequest
