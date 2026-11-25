-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local bool1 = game:DefineFastFlag("PPDebugLogging", false)

return function(arg1)
    if not (bool1 and arg1) then
        return
    end
    print("[PurchasePrompt]" .. arg1())
end
