-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
if game:DefineFastFlag("DebugVersionedFlagTest_RealConsumerCpp", false) then
    print("DebugVersionedFlagTest_RealConsumerCpp is flipped, version ONE (Lua)")
end

game:DefineFastFlag("DebugVersionedFastFlagTest_RealConsumerLua", false)

if game:GetFastFlag("DebugVersionedFastFlagTest_RealConsumerLua") then
    print("DebugVersionedFastFlagTest_RealConsumerLua is flipped, version ONE (Lua)")
end
