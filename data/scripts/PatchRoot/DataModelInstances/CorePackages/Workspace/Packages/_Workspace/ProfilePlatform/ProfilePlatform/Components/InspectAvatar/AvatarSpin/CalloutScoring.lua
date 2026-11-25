-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _ItemAnchors = require(script.Parent.ItemAnchors)
local ItemVisibility = require(script.Parent.ItemVisibility)

local tbl1 = { purchasable = 3, resale = 3, owned = 2, unavailable = 1 }

local module = {
    APPEAR_WEIGHT = 0.45,
    KEEP_WEIGHT = 0.3,
    PIN_WEIGHT = 0.15,
    viewCoverage = function(tbl2): number
        local num1 = 0
        for i = 0, 71 do
            local num2 = i / 72 * 2 * math.pi
            local vec3 = Vector3.new(math.sin(num2), 0, -math.cos(num2))
            local num3 = 0
            for _, value in tbl2 do
                num3 = math.max(num3, ItemVisibility.facingWeight(value, CFrame.identity, vec3, Vector3.new(0, 0, 0)))
            end
            if num3 >= 0.6 then
                num1 += 1
            end
        end
        return num1 / 72
    end
}

function module.priceRanks(tbl2)
    local tbl3 = {}
    local tbl4 = ({})
    for _, value in tbl2 do
        if not tbl4[value] then
            tbl4[value] = true
            table.insert(tbl3, value)
        end
    end
    table.sort(tbl3)
    local tbl5 = ({})
    for value, value2 in tbl3 do
        tbl5[value2] = value - 1
    end
    local result = ({})
    for value, value2 in tbl2 do
        result[value] = tbl5[value2]
    end
    return result
end

function module.score(num1: number, str1: string, num2: number, num3: number)
    local num4 = num1 * ((1 - num2) * 0.8 + 1)
    return tbl1[str1] * 10000 + num3 * 2 + num4
end

function module.isLastResort(str1: string): boolean
    return str1 == "unavailable"
end

function module.isEligible(num1: number, bool1: boolean, bool2: boolean): boolean
    if bool2 then
        return num1 > 0.15
    end

    return (if bool1 then 0.3 else 0.45) <= num1
end

return module
