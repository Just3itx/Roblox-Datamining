-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:21:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StyleParent = script:FindFirstAncestor("Style").Parent

local var1 = require(StyleParent.Lumberyak).Logger.new(nil, "StylePackage")

var1:addSink({
    maxLevel = var1.Levels.Warning,
    log = function(_, arg1, _)
        print(arg1)
    end
})

return var1
