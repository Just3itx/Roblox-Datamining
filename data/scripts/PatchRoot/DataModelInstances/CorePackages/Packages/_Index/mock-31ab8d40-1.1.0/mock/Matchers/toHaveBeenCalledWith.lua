-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local MagicMock = require(scriptParentParent.MagicMock)
local Spy = require(scriptParentParent.Spy)
local AnyCallMatches = require(scriptParentParent.AnyCallMatches)
local fmtArgs = require(scriptParentParent.fmtArgs)
local symbols = require(scriptParentParent.symbols)

local function getLiteralPredicate(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(arg2): boolean
        return arg2 == arg1
    end
end

local function isPredicate(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if type(arg1) == "table" and arg1[symbols.isPredicate] then
        return not MagicMock.is(arg1)
    end
end

return function(arg1, ...)
    if not (MagicMock.is(arg1) or Spy.is(arg1)) then
        return {
            pass = false,
            message = string.format(
                "expect(mock) must be a MagicMock or Spy when .toHaveBeenCalledWith is used. Given %s instead",
                tostring(arg1)
            )
        }
    end
    local tbl1 = table.pack(...)

    local tbl2 = {}
    for _, value in ipairs(tbl1) do
        if isPredicate(value) then
            table.insert(tbl2, value.predicate)
        else
            table.insert(tbl2, (getLiteralPredicate(value)))
        end
    end

    local pass, var2 = AnyCallMatches.predicates(arg1, table.unpack(tbl2))
    return {
        pass = pass,
        message = pass and string.format("Expected %s to never have been called with args: %s", tostring(arg1), fmtArgs(tbl1))
            or string.format("Expected %s to have been called with args: %s", tostring(arg1), var2)
    }
end
