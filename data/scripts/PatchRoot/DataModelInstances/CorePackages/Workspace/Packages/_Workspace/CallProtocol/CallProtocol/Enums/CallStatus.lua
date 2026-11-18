-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:10:55Z
-- Luau bytecode version: 9 | Luau type version: 3
local CallProtocolParent = script:FindFirstAncestor("CallProtocol").Parent

return require(CallProtocolParent.enumerate)(script.Name, {
    Idle = "Idle",
    Ringing = "Ringing",
    Accepting = "Accepting",
    Initializing = "Initializing",
    Connecting = "Connecting",
    Active = "Active"
})
