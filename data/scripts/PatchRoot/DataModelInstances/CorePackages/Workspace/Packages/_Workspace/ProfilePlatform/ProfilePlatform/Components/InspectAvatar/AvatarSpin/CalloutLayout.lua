-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _ViewportProjection = require(script.Parent.ViewportProjection)

local tbl1 = { 16, 44, 72 }

local function rectOverlapArea(arg1, arg2, num1: number): number
    return math.max(0, math.min(arg1.x + arg1.width + num1, arg2.x + arg2.width + num1) - math.max(arg1.x - num1, arg2.x - num1))
        * math.max(0, math.min(arg1.y + arg1.height + num1, arg2.y + arg2.height + num1) - math.max(arg1.y - num1, arg2.y - num1))
end

local function pointInRect(num1: number, num2: number, arg1, num3: number): boolean -- Luacid: Inlined by compiler; 5 call sites recovered
    return arg1.x - num3 <= num1
        and num1 <= arg1.x + arg1.width + num3
        and arg1.y - num3 <= num2
        and num2 <= arg1.y + arg1.height + num3
end

local function clipEdge(num1: number, num2: number, num3: number, num4: number) -- Luacid: unused: defined but never referenced
    if num1 == 0 then
        return num2 > 0, num3, num4
    end
    local num5 = num2 / num1
    if num1 < 0 then
        num3 = math.max(num3, num5)
    else
        num4 = math.min(num4, num5)
    end
    return num3 < num4, num3, num4
end

local function segmentCrossesRect(num1: number, num2: number, num3: number, num4: number, arg1)
    local num5 = num3 - num1
    local num6 = num4 - num2
    local num7 = -num5
    local var1 = num1 - arg1.x
    local num8 = 0
    local num9 = 1
    local bool1

    if num7 == 0 then
        bool1 = var1 > 0
    else
        local var2 = var1 / num7
        if num7 < 0 then
            num8 = math.max(num8, var2)
        else
            num9 = math.min(num9, var2)
        end
        bool1 = num8 < num9
    end

    if bool1 then
        local var2 = arg1.x + arg1.width - num1

        if num5 == 0 then
            bool1 = var2 > 0
        else
            local var3 = var2 / num5
            if num5 < 0 then
                num8 = math.max(num8, var3)
            else
                num9 = math.min(num9, var3)
            end
            bool1 = num8 < num9
        end
    end

    if bool1 then
        local num10 = -num6
        local var2 = num2 - arg1.y

        if num10 == 0 then
            bool1 = var2 > 0
        else
            local var3 = var2 / num10
            if num10 < 0 then
                num8 = math.max(num8, var3)
            else
                num9 = math.min(num9, var3)
            end
            bool1 = num8 < num9
        end
    end

    if bool1 then
        local var2 = arg1.y + arg1.height - num2

        if num6 == 0 then
            return var2 > 0
        end
        local var3 = var2 / num6
        if num6 < 0 then
            num8 = math.max(num8, var3)
        else
            num9 = math.min(num9, var3)
        end
        bool1 = num8 < num9
    end
    return bool1
end

local function orientation(num1: number, num2: number, num3: number, num4: number, num5: number, num6: number): number -- Luacid: Inlined by compiler; 4 call sites recovered
    local num7 = (num3 - num1) * (num6 - num2) - (num4 - num2) * (num5 - num1)
    return if num7 > 0 then 1 elseif num7 < 0 then -1 else 0
end

local function segmentsCross(num1: number, num2: number, num3: number, num4: number, anchorX: number, anchorY: number, attachX: number, attachY: number): boolean
    return orientation(num1, num2, num3, num4, anchorX, anchorY) * orientation(num1, num2, num3, num4, attachX, attachY) < 0
        and orientation(anchorX, anchorY, attachX, attachY, num1, num2) * orientation(anchorX, anchorY, attachX, attachY, num3, num4) < 0
end

local function optionsFor(tbl2, vector2: number, vector2_2: number, x: number, num1: number)
    local result = {}
    for _, value in tbl1 do
        for _, directionX in { -1, 1 } do
            local var1 = if directionX > 0 then tbl2.x + value else tbl2.x - value - vector2
            local var2 = if directionX > 0 then tbl2.x + value * 0.4 else tbl2.x - value * 0.4 - vector2
            table.insert(
                result,
                {
                    key = `s{directionX}{value}`,
                    directionX = directionX,
                    x = var1,
                    y = tbl2.y - vector2_2 / 2
                }
            )
            table.insert(
                result,
                {
                    key = `u{directionX}{value}`,
                    directionX = directionX,
                    x = var2,
                    y = tbl2.y - vector2_2 - value * 0.7
                }
            )
            table.insert(
                result,
                {
                    key = `d{directionX}{value}`,
                    directionX = directionX,
                    x = var2,
                    y = tbl2.y + value * 0.7
                }
            )
        end
    end

    table.insert(result, { key = "gl", directionX = -1, x = x, y = tbl2.y - vector2_2 / 2 })
    table.insert(result, { key = "gr", directionX = 1, x = num1, y = tbl2.y - vector2_2 / 2 })
    return result
end

local module = {}

function module.findProblems(tbl2, tbl3)
    local tbl4 = {}
    for _, value in tbl3 do
        tbl4[value.id] = value
    end

    local tbl5 = ({})
    for value, value2 in tbl2 do
        local var1 = tbl4[value2.id]
        local anchorX = if var1 then var1.x else value2.anchorX
        local anchorY = if var1 then var1.y else value2.anchorY
        local tbl6 = {
            anchorX = anchorX,
            anchorY = anchorY,
            attachX = math.clamp(anchorX, value2.x, value2.x + value2.width),
            attachY = math.clamp(anchorY, value2.y, value2.y + value2.height)
        }
        tbl5[value] = tbl6
    end

    local problems = {}
    for value, value2 in tbl2 do
        local var1 = tbl5[value]
        for _, value3 in tbl3 do
            local num1 = if value3.id == value2.id then 6 else 4

            if pointInRect(value3.x, value3.y, value2, num1) then
                table.insert(problems, "coversPin")
            end
        end
        for i = value + 1, #tbl2 do
            local var2 = tbl2[i]
            local var3 = tbl5[i]
            if rectOverlapArea(value2, var2, 0) > 0 then
                table.insert(problems, "overlap")
            end

            if segmentsCross(
                var1.anchorX,
                var1.anchorY,
                var1.attachX,
                var1.attachY,
                var3.anchorX,
                var3.anchorY,
                var3.attachX,
                var3.attachY
            ) then
                table.insert(problems, "leadersCross")
            end

            if segmentCrossesRect(var1.anchorX, var1.anchorY, var1.attachX, var1.attachY, var2)
                or segmentCrossesRect(var3.anchorX, var3.anchorY, var3.attachX, var3.attachY, value2)
            then
                table.insert(problems, "leaderThroughCard")
            end
        end
    end
    return problems
end

function module.layout(tbl2, tbl3)
    local var1 = table.clone(tbl2)
    table.sort(var1, function(arg1, arg2): boolean
        local bool1 = arg1.id == tbl3.focusId

        if bool1 == (arg2.id == tbl3.focusId) then
            if arg1.score == arg2.score then
                return arg1.id < arg2.id
            end

            return arg1.score > arg2.score
        end

        return bool1
    end)

    local tbl4 = {}

    while #var1 > tbl3.maxCount do
        table.insert(tbl4, 1, table.remove(var1))
    end

    local cardSizeX = tbl3.cardSize.X
    local cardSizeY = tbl3.cardSize.Y
    local margin = tbl3.margin
    local var2 = tbl3.viewportSize.X - tbl3.margin - cardSizeX
    local top = tbl3.top
    local var3 = tbl3.viewportSize.Y - tbl3.bottom - cardSizeY
    local var4 = tbl3.viewportSize.X / 2
    local var5 = tbl3.pins or {}

    local function place(tbl5, tbl6, key: string?)
        local var6 = nil
        for _, value in optionsFor(tbl5, cardSizeX, cardSizeY, margin, var2) do
            if key and value.key ~= key then
                continue
            end

            local x = math.clamp(value.x, margin, math.max(margin, var2))
            local y = math.clamp(value.y, top, math.max(top, var3))
            local tbl7 = { x = x, y = y, width = cardSizeX, height = cardSizeY }
            local attachX = math.clamp(tbl5.x, x, x + cardSizeX)
            local attachY = math.clamp(tbl5.y, y, y + cardSizeY)

            local num5 = math.abs(x - value.x) + math.abs(y - value.y)

            if pointInRect(tbl5.x, tbl5.y, tbl7, 6) then
                num5 += 5000
            end
            local num6 = math.sign(x + cardSizeX / 2 - tbl5.x)
            for _, value2 in tbl6 do
                num5 += rectOverlapArea(tbl7, value2, tbl3.gap) * 2400 / (cardSizeX * cardSizeY)
                if rectOverlapArea(tbl7, value2, 0) > 0 then
                    num5 += 1000
                end

                if segmentsCross(tbl5.x, tbl5.y, attachX, attachY, value2.anchorX, value2.anchorY, value2.attachX, value2.attachY) then
                    num5 += 1000
                end

                if pointInRect(value2.anchorX, value2.anchorY, tbl7, 4) then
                    num5 += 1000
                end

                if segmentCrossesRect(tbl5.x, tbl5.y, attachX, attachY, value2)
                    or segmentCrossesRect(value2.anchorX, value2.anchorY, value2.attachX, value2.attachY, tbl7)
                then
                    num5 += 1000
                end

                if num6 == math.sign(value2.x + cardSizeX / 2 - value2.anchorX) and (tbl5.y - value2.anchorY) * (y - value2.y) < 0 then
                    num5 += 120
                end
            end
            for _, value2 in var5 do
                if value2.id ~= tbl5.id and pointInRect(value2.x, value2.y, tbl7, 4) then
                    num5 += 1000
                end
            end
            if tbl3.avatarRect then
                num5 += rectOverlapArea(tbl7, tbl3.avatarRect, 0) * 200 / (cardSizeX * cardSizeY)
            end
            local var7 = num5 + math.sqrt((attachX - tbl5.x) ^ 2 + (attachY - tbl5.y) ^ 2) * 0.5
            if value.directionX * (tbl5.x - var4) < -8 then
                var7 += 22
            end
            if tbl3.previousKeys and tbl3.previousKeys[tbl5.id] == value.key then
                var7 -= 30
            end

            if var6 ~= nil and not (var7 < var6.cost) then
                continue
            end

            var6 = {
                id = tbl5.id,
                x = x,
                y = y,
                width = cardSizeX,
                height = cardSizeY,
                anchorX = tbl5.x,
                anchorY = tbl5.y,
                attachX = attachX,
                attachY = attachY,
                key = value.key,
                cost = var7
            }
        end

        return var6
    end

    local tbl5 = ({})
    for _, value in var1 do
        table.insert(tbl5, (place(value, tbl5)))
    end

    local function othersOf(num1: number) -- Luacid: Inlined by compiler; 2 call sites recovered
        local result = {}
        for value, value2 in tbl5 do
            if value ~= num1 then
                table.insert(result, value2)
            end
        end
        return result
    end

    local function refine()
        for _ = 1, 2 do
            for i = 1, #tbl5 do
                tbl5[i] = place(var1[i], (othersOf(i)))
            end
        end

        for i = 1, #tbl5 do
            tbl5[i] = place(var1[i], othersOf(i), tbl5[i].key)
        end
    end
    refine()

    local function isCoveredByFocus(arg1)
        for _, value in tbl5 do
            if value.id == tbl3.focusId and value ~= arg1 and pointInRect(arg1.anchorX, arg1.anchorY, value, 4) then
                return true
            end
        end
        return false
    end

    while true do
        local var6 = nil
        for value, value2 in tbl5 do
            if value2.id ~= tbl3.focusId
                and (value2.cost > 520 or isCoveredByFocus(value2))
                and (var6 == nil or var1[value].score <= var1[var6].score)
            then
                var6 = value
            end
        end

        if var6 == nil then
            local result = {}
            for _, value in tbl5 do
                table.insert(result, {
                    id = value.id,
                    x = value.x,
                    y = value.y,
                    width = value.width,
                    height = value.height,
                    anchorX = value.anchorX,
                    anchorY = value.anchorY,
                    attachX = value.attachX,
                    attachY = value.attachY,
                    key = value.key
                })
            end
            return result
        end

        table.remove(var1, var6)
        table.remove(tbl5, var6)
        local var7 = table.remove(tbl4, 1)
        if var7 then
            table.insert(var1, var7)
            table.insert(tbl5, (place(var7, tbl5)))
        end
        refine()
    end
end
return module
