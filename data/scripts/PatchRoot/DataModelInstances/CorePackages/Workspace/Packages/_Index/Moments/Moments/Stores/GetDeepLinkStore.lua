-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local createDeepLinkStore = require(script.createDeepLinkStore)

local var1 = nil

local function getDeepLinkStore()
    if var1 == nil then
        var1 = createDeepLinkStore()
    end
    return var1
end

return getDeepLinkStore
