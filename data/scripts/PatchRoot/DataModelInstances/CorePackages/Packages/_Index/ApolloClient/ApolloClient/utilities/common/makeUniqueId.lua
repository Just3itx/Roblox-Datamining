-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Boolean = LuauPolyfill.Boolean
local map = LuauPolyfill.Map.new(nil)
local tbl1 = {
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z"
}

math.randomseed(os.clock())

local function uuid(): string
    local str1 = ""
    for _ = 1, 11 do
        str1 ..= tbl1[math.random(1, 36)]
    end

    return str1
end

module.uuid = uuid

function module.makeUniqueId(str1: string): string
    local str2 = uuid()
    local var1 = Boolean.toJSBoolean(map:get(str1)) and map:get(str1) or 1
    map:set(str1, var1 + 1)
    return ("%s:%s:%s"):format(str1, tostring(var1), str2)
end

return module
