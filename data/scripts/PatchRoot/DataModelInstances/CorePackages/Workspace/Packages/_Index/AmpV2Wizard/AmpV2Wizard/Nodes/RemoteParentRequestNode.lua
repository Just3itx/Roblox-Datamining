-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")

local _Types = require(AmpV2Wizard.Types)
local createVpcNode = require(AmpV2Wizard.Nodes.createVpcNode)

local vpcNode = createVpcNode("ParentConsent")
local vpcNode2 = createVpcNode("ParentLink")

local function RemoteParentRequestNode(arg1)
    if (arg1.props.action or "ParentLink") == "ParentConsent" then
        return vpcNode(arg1)
    end
    return vpcNode2(arg1)
end

return RemoteParentRequestNode
