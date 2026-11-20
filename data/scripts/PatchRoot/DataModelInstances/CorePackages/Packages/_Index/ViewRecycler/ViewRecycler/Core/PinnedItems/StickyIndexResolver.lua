-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local DataSourceChangeType = require(ViewRecycler.Core.Enums.DataSourceChangeType)
local _ItemSequence = require(ViewRecycler.Core.Virtualizer.ItemSequence)
local _Types = require(ViewRecycler.Core.Types)

local function createStickyIndexResolver(arg1, func1: ((...any) -> (...any))?)
    local var1 = arg1
    local var2 = func1
    local var3 = nil
    local bool1 = true

    local function applyShift(tbl1, num1: number) -- Luacid: Inlined by compiler; 64 call sites recovered
        if tbl1 ~= nil then
            tbl1.index += num1
            tbl1.lazy += num1
        end
    end

    local function push(tbl1) -- Luacid: Inlined by compiler; 29 call sites recovered
        local lazy = tbl1.lazy
        if lazy ~= 0 then
            applyShift(tbl1.left, lazy)
            applyShift(tbl1.right, lazy)
            tbl1.lazy = 0
        end
    end

    local function height(tbl1) -- Luacid: Inlined by compiler; 62 call sites recovered
        return if tbl1 == nil then 0 else tbl1.height
    end

    local function updateHeight(tbl1) -- Luacid: Inlined by compiler; 26 call sites recovered
        tbl1.height = math.max(height(tbl1.left), (height(tbl1.right))) + 1
    end

    local function rotateLeft(left) -- Luacid: Inlined by compiler; 2 call sites recovered
        local right = left.right
        push(left)
        push(right)
        left.right = right.left
        right.left = left
        updateHeight(left)
        updateHeight(right)
        return right
    end

    local function rotateRight(right) -- Luacid: Inlined by compiler; 2 call sites recovered
        local left = right.left
        push(right)
        push(left)
        right.left = left.right
        left.right = right
        updateHeight(right)
        updateHeight(left)
        return left
    end

    local function balance(tbl1)
        updateHeight(tbl1)
        local var4 = height(tbl1.left) - height(tbl1.right)
        if var4 > 1 then
            local left = tbl1.left
            push(left)

            if height(left.left) < height(left.right) then
                tbl1.left = rotateLeft(left)
            end

            return rotateRight(tbl1)
        end

        if not (var4 < -1) then
            return tbl1
        end

        local right = tbl1.right
        push(right)

        if height(right.right) < height(right.left) then
            tbl1.right = rotateRight(right)
        end

        return rotateLeft(tbl1)
    end

    local function func2(left, tbl1, right)
        local var4 = height(left)
        local var5 = height(right)

        if var5 + 1 < var4 then
            push(left)
            left.right = func2(left.right, tbl1, right)
            return (balance(left))
        end

        if var4 + 1 < var5 then
            push(right)
            right.left = func2(left, tbl1, right.left)
            return (balance(right))
        end
        tbl1.left = left
        tbl1.right = right
        tbl1.lazy = 0
        updateHeight(tbl1)
        return tbl1
    end

    local function split(tbl1, index: number)
        if tbl1 == nil then
            return nil, nil
        end

        push(tbl1)

        if tbl1.index < index then
            local var4, var5 = split(tbl1.right, index)
            local left = tbl1.left
            tbl1.left = nil
            tbl1.right = nil
            return func2(left, tbl1, var4), var5
        end
        local var4, var5 = split(tbl1.left, index)
        local right = tbl1.right
        tbl1.left = nil
        tbl1.right = nil
        return var4, func2(var5, tbl1, right)
    end

    local function removeFirst(tbl1) -- Luacid: Inlined by compiler; 10 call sites recovered
        push(tbl1)

        if tbl1.left ~= nil then
            local left, var5 = removeFirst(tbl1.left)
            tbl1.left = left
            return balance(tbl1), var5
        end

        local right = tbl1.right
        tbl1.right = nil
        updateHeight(tbl1)
        return right, tbl1
    end

    local function join(tbl1, tbl2) -- Luacid: Inlined by compiler; 9 call sites recovered
        if tbl1 == nil then
            return tbl2
        end

        if tbl2 == nil then
            return tbl1
        end

        local var4, var5 = removeFirst(tbl2)
        return func2(tbl1, var5, var4)
    end

    local function newNode(index: number) -- Luacid: unused: defined but never referenced
        return { index = index, height = 1, lazy = 0, left = nil, right = nil }
    end

    local function buildBalanced(tbl1, num1: number, num2: number): {height: number, index: any, lazy: number, left: any, right: any}?
        if num2 < num1 then
            return nil
        end
        local num3 = math.floor((num1 + num2) / 2)
        local tbl2 = {
            index = tbl1[num3],
            height = 1,
            lazy = 0,
            left = buildBalanced(tbl1, num1, num3 - 1),
            right = buildBalanced(tbl1, num3 + 1, num2)
        }
        updateHeight(tbl2)
        return tbl2
    end

    local function rebuild()
        local tbl1 = {}
        if var2 ~= nil then
            for i = 1, var1.getItemCount() do
                local itemKey = var1.getItemKey(i)
                if var2(itemKey) then
                    table.insert(tbl1, i)
                end
            end
        end
        var3 = buildBalanced(tbl1, 1, #tbl1)
        bool1 = false
    end

    return {
        setPredicate = function(arg2): boolean
            if var2 == arg2 then
                return false
            end

            var2 = arg2
            bool1 = true
            return true
        end,
        setItemSequence = function(arg2)
            if var1 ~= arg2 then
                var1 = arg2
                bool1 = true
            end
        end,
        applyDataSourceChange = function(arg2)
            if bool1 or var2 == nil then
                return
            end
            for _, value in arg2.changes do
                if value.type == DataSourceChangeType.Reset or value.type == DataSourceChangeType.Reorder then
                    bool1 = true
                    return
                end

                if value.type == DataSourceChangeType.Insert then
                    local index = value.index
                    local keysLen = #value.keys
                    local var4, var5 = split(var3, index)
                    applyShift(var5, keysLen)
                    local tbl1 = {}
                    for k, key in value.keys do
                        if var2(key) then
                            table.insert(tbl1, index + k - 1)
                        end
                    end
                    var3 = join(join(var4, (buildBalanced(tbl1, 1, #tbl1))), var5)
                elseif value.type == DataSourceChangeType.Remove then
                    local index = value.index
                    local var4 = index + #value.keys - 1
                    local var5, var6 = split(var3, index)
                    local _, var7 = split(var6, var4 + 1)
                    applyShift(var7, -#value.keys)
                    var3 = join(var5, var7)
                elseif value.type == DataSourceChangeType.Move then
                    local fromIndex = value.fromIndex
                    local toIndex = value.toIndex
                    if fromIndex < toIndex then
                        local var4, var5 = split(var3, fromIndex)
                        local var6, var7 = split(var5, fromIndex + 1)
                        local var8, var9 = split(var7, toIndex + 1)
                        applyShift(var8, -1)

                        if var6 ~= nil then
                            var6.index = toIndex
                        end
                        var3 = join(join(join(var4, var8), var6), var9)
                    else
                        local var4, var5 = split(var3, toIndex)
                        local var6, var7 = split(var5, fromIndex)
                        local var8, var9 = split(var7, fromIndex + 1)
                        applyShift(var6, 1)

                        if var8 ~= nil then
                            var8.index = toIndex
                        end
                        var3 = join(join(join(var4, var8), var6), var9)
                    end
                end
            end
        end,
        resolveActive = function(func3: (...any) -> (...any))
            if bool1 then
                rebuild()
            end

            local var4 = var3
            local index = nil
            local index2 = nil

            while var4 ~= nil do
                push(var4)

                if func3(var4.index) then
                    index = var4.index
                    var4 = var4.right
                else
                    index2 = var4.index
                    var4 = var4.left
                end
            end
            return index, index2
        end
    }
end
return createStickyIndexResolver
