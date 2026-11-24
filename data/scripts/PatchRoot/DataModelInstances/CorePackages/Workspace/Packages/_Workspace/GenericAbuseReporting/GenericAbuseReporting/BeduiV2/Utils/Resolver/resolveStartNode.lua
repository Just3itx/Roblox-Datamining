-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")

local _AbuseSheetFlowTypes = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.AbuseSheetFlowTypes)
local configResolvers = require(script.Parent.configResolvers)

return {
    resolveStartNode = function(arg1): string
        if arg1.startNode == nil or arg1.startNode == "" then
            return "root"
        end

        local var1 = configResolvers.resolveConfig(arg1.startNode, { attribute = arg1.attributes or {}, resources = {}, store = {} })

        return if type(var1) == "string" then var1 else "root"
    end,
    DEFAULT_START_NODE_ID = "root"
}
