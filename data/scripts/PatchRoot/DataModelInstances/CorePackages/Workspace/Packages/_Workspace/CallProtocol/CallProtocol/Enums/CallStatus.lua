-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
local CallProtocolParent = script:FindFirstAncestor("CallProtocol").Parent

return require(CallProtocolParent.enumerate)(script.Name, {
    Idle = "Idle",
    Ringing = "Ringing",
    Accepting = "Accepting",
    Initializing = "Initializing",
    Connecting = "Connecting",
    Active = "Active"
})
