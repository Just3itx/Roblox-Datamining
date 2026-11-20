-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _LuauPolyfill = require(scriptParentParent.LuauPolyfill)

local supportsTestSelectors = require(script.Parent.ReactFiberHostConfig).supportsTestSelectors

local module = {}

local tbl1 = {}

function module.onCommitRoot()
    if not supportsTestSelectors then
        return
    end

    for _, value in tbl1 do
        value()
    end
end

return module
