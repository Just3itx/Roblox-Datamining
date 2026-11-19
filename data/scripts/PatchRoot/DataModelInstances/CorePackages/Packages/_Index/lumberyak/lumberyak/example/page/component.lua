-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:01:19Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local var1 = require(script.Parent.pageLogger):new()
var1:setContext({ bar = "bar" })

return function(): string
    var1:info("calling {root} {foo} {bar}")
    return "done"
end
