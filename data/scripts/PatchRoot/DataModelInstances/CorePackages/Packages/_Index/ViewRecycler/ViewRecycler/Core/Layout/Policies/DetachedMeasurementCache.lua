-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local function resolveCapacity(num1: number?) -- Luacid: Inlined by compiler; 1 call site recovered
    if num1 == nil then
        return 256
    end
    if num1 == math.huge then
        return nil
    end
    assert(
        type(num1) == "number" and num1 >= 0 and num1 < math.huge and num1 % 1 == 0,
        "Layout.measured: detachedMeasurementCapacity must be zero, a positive integer, or math.huge"
    )

    return num1
end

function module.new(num1: number?)
    local var1 = resolveCapacity(num1)
    local tbl1 = ({})
    local var2 = nil
    local var3 = nil
    local num2 = 0

    local function unlink(tbl2) -- Luacid: Inlined by compiler; 3 call sites recovered
        if tbl2.previous ~= nil then
            tbl2.previous.next = tbl2.next
        else
            var2 = tbl2.next
        end
        if tbl2.next ~= nil then
            tbl2.next.previous = tbl2.previous
        else
            var3 = tbl2.previous
        end
        tbl2.previous = nil
        tbl2.next = nil
    end

    local function append(next) -- Luacid: Inlined by compiler; 2 call sites recovered
        next.previous = var3
        if var3 ~= nil then
            var3.next = next
        else
            var2 = next
        end
        var3 = next
    end

    return {
        put = function(key: string, value: number)
            if var1 == 0 then
                return
            end

            local var4 = tbl1[key]
            if var4 ~= nil then
                var4.value = value
                unlink(var4)
                append(var4)
                return
            end

            local tbl2 = { key = key, value = value, previous = nil, next = nil }

            tbl1[key] = tbl2
            append(tbl2)
            num2 += 1

            if var1 ~= nil and var1 < num2 then
                local var5 = var2
                unlink(var5)
                tbl1[var5.key] = nil
                num2 -= 1
            end
        end,
        take = function(str1: string)
            local var4 = tbl1[str1]
            if var4 == nil then
                return nil
            end

            unlink(var4)
            tbl1[str1] = nil
            num2 -= 1
            return var4.value
        end
    }
end
return module
