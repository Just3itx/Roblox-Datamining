-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UsageGraphKey = newproxy(true)
getmetatable(UsageGraphKey).__tostring = function(): string
    return "UsageGraphSentinel"
end

return {
    UsageGraphKey = UsageGraphKey,
    getUsageGraph = function(arg1)
        return table.clone(arg1[UsageGraphKey])
    end
}
