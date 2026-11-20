-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local ScrollAlignment = require(ViewRecycler.Core.Enums.ScrollAlignment)

local function getInitialOffset(num1: number, start, func1: (...any) -> (...any)) -- Luacid: Inlined by compiler; 3 call sites recovered
    if start == nil or start == ScrollAlignment.Start or num1 == 0 then
        return nil
    end
    return func1(num1, start)
end

local function createInitialScrollPosition()
    local bool1 = false

    return {
        onDataSourceChange = function(arg1, start, arg2)
            if bool1 then
                return nil
            end

            local initialOffset = getInitialOffset(arg1, start, arg2)

            if initialOffset ~= nil then
                bool1 = true
            end
            return initialOffset
        end,
        onDataSourceReplaced = function(arg1, start, arg2)
            bool1 = true
            return getInitialOffset(arg1, start, arg2) or 0
        end,
        onViewportChanged = function(arg1, start, arg2)
            if bool1 then
                return nil
            end

            local initialOffset = getInitialOffset(arg1, start, arg2)

            if initialOffset ~= nil or start == nil or start == ScrollAlignment.Start then
                bool1 = true
            end
            return initialOffset
        end
    }
end

return createInitialScrollPosition
