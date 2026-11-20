-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function applySplice(tbl1, tbl2, tbl3, num1: number, num2: number, tbl4)
    local num3 = #tbl2 - num1 - num2
    local num4 = #tbl3 - num1 - num2
    if num3 > 0 then
        tbl1.remove(num1 + 1, num3)
    end
    for i = 1, num4 do
        tbl1.insert(num1 + i, tbl3[num1 + i])
    end
    if tbl4 ~= nil then
        for _, value in tbl4 do
            tbl1.setItem(value, tbl3[value])
        end
    end
    for i = 0, num2 - 1 do
        local num5 = #tbl3 - i
        if tbl2[#tbl2 - i] ~= tbl3[num5] then
            tbl1.setItem(num5, tbl3[num5])
        end
    end
end

local function reconcileSplice(tbl1, tbl2, tbl3, func1: (...any) -> (...any)): boolean
    local num1 = #tbl2
    local num2 = #tbl3
    local num3 = math.min(num1, num2)
    local num4 = 0
    local var1 = nil
    while num4 < num3 do
        local num5 = num4 + 1
        local var2 = tbl2[num5]
        local var3 = tbl3[num5]
        if var2 ~= var3 then
            if func1(var2, num5) ~= func1(var3, num5) then
                break
            end

            var1 = var1 == nil and {} or var1

            table.insert(var1, num5)
        end
        num4 = num5
    end
    local num5 = 0
    while num3 - num4 > num5 do
        local num6 = num1 - num5
        local num7 = num2 - num5
        if func1(tbl2[num6], num6) ~= func1(tbl3[num7], num7) then
            break
        end

        num5 += 1
    end
    if num4 + num5 ~= num3 then
        return false
    end
    tbl1.transaction(function()
        applySplice(tbl1, tbl2, tbl3, num4, num5, var1)
    end)
    return true
end

local function reconcileSnapshot(tbl1, tbl2, tbl3, func1: (...any) -> (...any))
    if reconcileSplice(tbl1, tbl2, tbl3, func1) then
        return
    end

    local var1 = table.create(#tbl2)
    local var2 = table.create(#tbl3)
    local tbl4 = ({})
    local tbl5 = ({})
    for value, value2 in tbl2 do
        local var3 = func1(value2, value)
        if tbl5[var3] ~= nil then
            error(`DataSource.reconcileSnapshot: duplicate key "{var3}"`, 2)
        end
        tbl5[var3] = true
        var1[value] = var3
        tbl4[var3] = value2
    end
    table.clear(tbl5)
    for value, value2 in tbl3 do
        local var3 = func1(value2, value)
        if tbl5[var3] ~= nil then
            error(`DataSource.reconcileSnapshot: duplicate key "{var3}"`, 2)
        end
        tbl5[var3] = true
        var2[value] = var3
    end

    local bool1 = #var1 == #var2
    if bool1 then
        for _, value in var2 do
            if tbl4[value] == nil then
                bool1 = false
                break
            end
        end
    end

    local num1 = 0

    while true do
        local num2 = math.min(#var1, #var2)

        if not (num1 < num2) or var1[num1 + 1] ~= var2[num1 + 1] then
            break
        end

        num1 += 1
    end
    local function updateRetainedValues()
        for value, value2 in tbl3 do
            if tbl4[var2[value]] ~= value2 then
                tbl1.setItem(value, value2)
            end
        end
    end

    tbl1.transaction(function()
        if not bool1 then
            tbl1.reset(tbl3)

            return
        end

        local var3 = num1 + 1
        local var4 = table.find(var1, var2[var3])

        local function matchesMove(num2: number?, num3: number?)
            if num2 == nil or num3 == nil then
                return false
            end
            local var5 = table.clone(var1)
            table.insert(var5, num3, table.remove(var5, num2))
            for value, value2 in var2 do
                if var5[value] ~= value2 then
                    return false
                end
            end
            return true
        end

        local var5

        if matchesMove(var4, var3) then
            var5 = var3
            var3 = var4
        else
            var5 = table.find(var2, var1[var3])
        end
        if matchesMove(var3, var5) then
            tbl1.moveItem(var3, var5)
        else
            tbl1.reorder(var2)
        end
        updateRetainedValues()
    end)
end
return reconcileSnapshot
