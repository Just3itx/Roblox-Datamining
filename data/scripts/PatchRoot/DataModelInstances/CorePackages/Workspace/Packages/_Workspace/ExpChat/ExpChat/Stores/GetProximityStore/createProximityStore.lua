-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local createSignal = require(ExpChatParent.Signals).createSignal

local function createProximityStore()
    local tbl1 = ({})

    local tbl2 = { isInsideRenderDistance = false, isInsideMaximizeDistance = false }

    local function getKey(arg1): string -- Luacid: Inlined by compiler; 4 call sites recovered
        return tostring(arg1)
    end

    local function getUserProximityState(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
        local key = getKey(arg1)

        if not tbl1[key] then
            local getter, setter = createSignal(tbl2)
            tbl1[key] = { getter = getter, setter = setter }
        end
        return tbl1[key].getter
    end

    return {
        getUserProximityState = getUserProximityState,
        updateProximity = function(arg1, isInsideRenderDistance: boolean, isInsideMaximizeDistance: boolean)
            local key = getKey(arg1)

            if not tbl1[key] then
                getUserProximityState(arg1)
            end

            tbl1[key].setter(
                {
                    isInsideRenderDistance = isInsideRenderDistance,
                    isInsideMaximizeDistance = isInsideMaximizeDistance
                }
            )
        end,
        removeUser = function(arg1)
            local key = getKey(arg1)

            if tbl1[key] then
                tbl1[key].setter(tbl2)
                tbl1[key] = nil
            end
        end
    }
end

return createProximityStore
