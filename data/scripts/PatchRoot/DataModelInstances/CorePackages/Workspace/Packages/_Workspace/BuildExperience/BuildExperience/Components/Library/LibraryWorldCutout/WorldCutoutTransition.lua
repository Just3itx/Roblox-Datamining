-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:51:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local initialState = { phase = "Home", progress = 0 }
local tbl2 = { phase = "World", progress = 1 }

return {
    initialState = initialState,
    reduce = function(tbl3, tbl4)
        if tbl4.type == "Expand" then
            return if tbl3.phase == "Home" or tbl3.phase == "Collapsing" then {
                phase = "Expanding",
                progress = tbl3.progress
            } else tbl3
        elseif tbl4.type == "Collapse" then
            return if tbl3.phase == "World" or tbl3.phase == "Expanding" then {
                phase = "Collapsing",
                progress = tbl3.progress
            } else tbl3
        end

        if tbl4.type ~= "Progress" then
            if tbl4.type == "Settle" then
                if tbl3.phase == "Expanding" then
                    return tbl2
                elseif tbl3.phase == "Collapsing" then
                    return initialState
                end

                return tbl3
            end

            if tbl3.phase == "Home" then
                return tbl3
            end

            return initialState
        end

        local progress = math.clamp(tbl4.progress, 0, 1)

        if tbl3.phase == "Expanding" then
            if progress >= 1 then
                return tbl2
            end

            return { phase = "Expanding", progress = progress }
        end

        if tbl3.phase ~= "Collapsing" then
            return tbl3
        end

        if progress <= 0 then
            return initialState
        end

        return { phase = "Collapsing", progress = progress }
    end,
    isTransitioning = function(str1: string): boolean
        return str1 == "Expanding" or str1 == "Collapsing"
    end,
    getTarget = function(str1: string): number
        return if str1 == "Expanding" or str1 == "World" then 1 else 0
    end,
    interpolateRect = function(rect: Rect, rect2: Rect, num1: number): Rect
        local num2 = math.clamp(num1, 0, 1)
        return Rect.new(rect.Min:Lerp(rect2.Min, num2), rect.Max:Lerp(rect2.Max, num2))
    end
}
