-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleServiceParent = script:FindFirstAncestor("PeopleService").Parent

local Signals = require(PeopleServiceParent.Signals)

function createPersonStore(getPerson)
    local getOrder, setOrder = Signals.createSignal(0)

    return {
        getPerson = function()
            return getPerson
        end,
        getOrder = getOrder,
        setOrder = setOrder
    }
end

return createPersonStore
