-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParentParentParent = script.Parent.Parent.Parent
local ReactGlobals = require(scriptParentParentParent.ReactGlobals)

local module = {}

local var1 = nil

function module.setExtraStackFrame(str1: string?)
    if ReactGlobals.__DEV__ then
        var1 = str1
    end
end

if ReactGlobals.__DEV__ then
    module.getCurrentStack = nil

    function module.getStackAddendum()
        local str1 = ""

        if var1 then
            str1 ..= var1
        end

        local getCurrentStack = module.getCurrentStack
        if getCurrentStack then
            str1 ..= getCurrentStack() or ""
        end

        return str1
    end
end

return module
