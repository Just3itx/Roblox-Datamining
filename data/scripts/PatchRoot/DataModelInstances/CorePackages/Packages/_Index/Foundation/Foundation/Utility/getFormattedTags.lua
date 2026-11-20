-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local Flags = require(Foundation.Utility.Flags)
local _Types = require(Foundation.Components.Types)
local devAssert = require(Foundation.Utility.devAssert)

local function getFormattedTags(arg1)
    if arg1 ~= nil then
        if typeof(arg1) == "table" then
            local tbl1 = {}
            for value, value2 in arg1 do
                if value2 then
                    table.insert(tbl1, value)
                end
            end
            return table.concat(tbl1, " ")
        end

        if typeof(arg1) == "string" then
            return arg1
        end
        if Flags.FoundationDevOnlyPropAsserts then
            devAssert(false, "Invalid argument to useStyleTags. Expected a table or string, got " .. typeof(arg1))
        else
            assert(false, "Invalid argument to useStyleTags. Expected a table or string, got " .. typeof(arg1))
        end
    end

    return nil
end

return getFormattedTags
