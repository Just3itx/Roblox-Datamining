-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:30:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Signals = require(DataHydrationParent.Signals)

local AcpProtocol = require(script.Parent.Acp.AcpProtocol)
local createCreatorAgentChatStore = require(script.Parent.createCreatorAgentChatStore)
local debug2 = require(script.Parent.debug)
local getDefaultAuthHeaders = require(script.Parent.Acp.getDefaultAuthHeaders)
local resolveAcpUrl = require(script.Parent.Env.resolveAcpUrl)
local _types = require(script.Parent.types)
local wireCapDelivery = require(script.Parent.Acp.wireCapDelivery)

return Signals.createComputed(function() -- name: createDefaultStore
    local var1 = resolveAcpUrl.resolveCreatorAgentAcp()
    debug2.log("info", "creating CreatorAgentChatStore", {
        acpUrl = var1.url,
        gateway = var1.gateway,
        sitetestNumber = var1.sitetestNumber,
        capRtnNamespace = AcpProtocol.CapRtnNamespace
    })

    local creatorAgentChatStore = createCreatorAgentChatStore({ baseUrl = var1.url, getAuthHeaders = getDefaultAuthHeaders })

    wireCapDelivery(creatorAgentChatStore)
    return creatorAgentChatStore
end)
