-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Immutable = require(script.Parent.Parent.Immutable)

local ServerJobsUpdateSearchFilter = require(script.Parent.Parent.Actions.ServerJobsUpdateSearchFilter)

return function(tbl1, tbl2)
    local var1 = tbl1 or { jobsSearchTerm = "" }

    if tbl2.type == ServerJobsUpdateSearchFilter.name then
        return (Immutable.Set(var1, "jobsSearchTerm", tbl2.searchTerm))
    end

    return var1
end
