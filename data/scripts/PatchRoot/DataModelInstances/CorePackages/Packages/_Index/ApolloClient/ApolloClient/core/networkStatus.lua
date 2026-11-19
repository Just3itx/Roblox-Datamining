-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:20:51Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local module = {
    NetworkStatus = {
        loading = 1,
        setVariables = 2,
        fetchMore = 3,
        refetch = 4,
        poll = 6,
        ready = 7,
        error = 8
    }
}

function module.isNetworkRequestInFlight(num1: number?): boolean
    return if num1 then num1 < 7 else false
end
return module
