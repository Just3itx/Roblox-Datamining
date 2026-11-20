-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:10:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getOverflowWindowStart(num1: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    return math.max(num1 - 2, 1)
end

local function getDefaultDots(num1: number, num2: number, size: number)
    local defaultDots = {}

    for page = 1, num2 do
        table.insert(defaultDots, { isActive = page == num1, page = page, size = size })
    end

    return defaultDots
end

local function getOverflowDots(num1: number, num2: number, num3: number, size: number, num4: number)
    local overflowDots = {}
    local num5 = num1 + 2

    for page = num3, math.min(num5, num2) do
        table.insert(
            overflowDots,
            {
                isActive = page == num1,
                page = page,
                size = if math.abs(page - num1) == 2 then num4 else size
            }
        )
    end
    return overflowDots
end

local function getCarouselIndicatorDotsConfig(size: number, num1: number, num2: number, num3: number)
    local count = math.max(math.floor(num3), 1)
    local page = math.clamp(math.floor(num2), 1, count)
    local num6 = math.min(count, 5)
    local bool1 = count > 5
    local num7 = if bool1 then getOverflowWindowStart(page) else 1
    return {
        activeVisibleIndex = page - num7 + 1,
        page = page,
        dots = if bool1 then getOverflowDots(page, count, num7, size, num1) else getDefaultDots(page, num6, size),
        count = count
    }
end

return getCarouselIndicatorDotsConfig
