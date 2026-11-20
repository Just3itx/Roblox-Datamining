-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecycler").Flags).FFlagViewRecyclerReact084
local tbl1 = {}

local function nodeHeight(tbl2) -- Luacid: Inlined by compiler; 12 call sites recovered
    return if tbl2 == nil then 0 else tbl2.height
end

local function nodeItemCount(tbl2) -- Luacid: Inlined by compiler; 14 call sites recovered
    return if tbl2 == nil then 0 else tbl2.subtreeItemCount
end

local function nodeMeasuredCount(tbl2) -- Luacid: Inlined by compiler; 2 call sites recovered
    return if tbl2 == nil then 0 else tbl2.subtreeMeasuredCount
end

local nodeFixedCount = nil
local nodeMeasuredSum = nil
if FFlagViewRecyclerReact084 then
    nodeFixedCount = function(tbl2)
        return if tbl2 == nil then 0 else tbl2.subtreeFixedCount
    end
else
    nodeMeasuredSum = function(tbl2)
        return if tbl2 == nil then 0 else tbl2.subtreeMeasuredSum
    end
end

local function nodeCount(tbl2) -- Luacid: Inlined by compiler; 2 call sites recovered
    return if tbl2 == nil then 0 else tbl2.subtreeNodeCount
end

local function nodeEffectiveSum(tbl2, num1: number) -- Luacid: Inlined by compiler; 3 call sites recovered
    if tbl2 == nil then
        return 0
    end

    return (if FFlagViewRecyclerReact084 then tbl2.subtreeFixedSum else tbl2.subtreeMeasuredSum) + (tbl2.subtreeItemCount - (if FFlagViewRecyclerReact084 then tbl2.subtreeFixedCount else tbl2.subtreeMeasuredCount)) * num1
end

local var1 = nil
var1 = FFlagViewRecyclerReact084 and function(tbl2, num1: number) -- name: unitSize
    return tbl2.measuredSize or tbl2.estimatedSize or num1
end or var1

local function ownEffectiveSum(tbl2, num1: number) -- Luacid: Inlined by compiler; 2 call sites recovered
    if tbl2.measuredSize ~= nil then
        return tbl2.measuredSize
    end

    local itemCount = tbl2.itemCount

    if FFlagViewRecyclerReact084 then
        num1 = tbl2.estimatedSize or num1
    end

    return itemCount * num1
end

local function refresh(tbl2)
    local itemCount, measuredSize

    if FFlagViewRecyclerReact084 then
        itemCount = tbl2.itemCount
        measuredSize = tbl2.measuredSize
    else
        itemCount = nil
        measuredSize = nil
    end
    assert(
        (if FFlagViewRecyclerReact084 then itemCount else tbl2.itemCount) >= 1,
        "WeightedOrderStatisticTree: node itemCount must be positive"
    )

    local bool1 = not ((if FFlagViewRecyclerReact084 then measuredSize else tbl2.measuredSize) ~= nil)
        or (if FFlagViewRecyclerReact084 then itemCount else tbl2.itemCount) == 1
    assert(bool1, "WeightedOrderStatisticTree: measured nodes must represent exactly one item")
    local num1, num2, num3, num4, height, height2

    if FFlagViewRecyclerReact084 then
        num1 = 0
        num2 = 0
        num3 = 0
        num4 = 1
        height = 0
        height2 = 0
        if measuredSize == nil then
            local estimatedSize = tbl2.estimatedSize
            if estimatedSize ~= nil then
                num3 = itemCount * estimatedSize
                num2 = itemCount
            end
        else
            num3 = measuredSize
            num1 = 1
            num2 = 1
        end

        local left = tbl2.left
        if left ~= nil then
            itemCount += left.subtreeItemCount
            num1 += left.subtreeMeasuredCount
            num2 += left.subtreeFixedCount
            num3 += left.subtreeFixedSum
            num4 += left.subtreeNodeCount
            height = left.height
        end
        local right = tbl2.right
        if right ~= nil then
            itemCount += right.subtreeItemCount
            num1 += right.subtreeMeasuredCount
            num2 += right.subtreeFixedCount
            num3 += right.subtreeFixedSum
            num4 += right.subtreeNodeCount
            height2 = right.height
        end
    else
        itemCount = nil
        num1 = nil
        num2 = nil
        num3 = nil
        num4 = nil
        height2 = nil
        height = nil
    end

    if not FFlagViewRecyclerReact084 then
        itemCount = nodeItemCount(tbl2.left) + tbl2.itemCount + nodeItemCount(tbl2.right)
    end

    tbl2.subtreeItemCount = itemCount

    if not FFlagViewRecyclerReact084 then
        num1 = nodeMeasuredCount(tbl2.left) + (if tbl2.measuredSize == nil then 0 else 1) + nodeMeasuredCount(tbl2.right)
    end

    tbl2.subtreeMeasuredCount = num1

    if FFlagViewRecyclerReact084 then
        tbl2.subtreeFixedCount = num2
        tbl2.subtreeFixedSum = num3
    else
        tbl2.subtreeMeasuredSum = nodeMeasuredSum(tbl2.left) + (tbl2.measuredSize or 0) + nodeMeasuredSum(tbl2.right)
    end

    if not FFlagViewRecyclerReact084 then
        num4 = nodeCount(tbl2.left) + 1 + nodeCount(tbl2.right)
    end

    tbl2.subtreeNodeCount = num4

    local num5 = 1

    if FFlagViewRecyclerReact084 then
        if height2 < height then
            height2 = height
        end
    else
        height2 = math.max(nodeHeight(tbl2.left), (nodeHeight(tbl2.right)))
    end

    tbl2.height = num5 + height2
end

local newNode = FFlagViewRecyclerReact084 and function(num1: number, measuredSize: number?, estimatedSize: number?) -- name: newNode
    local tbl2 = {
        itemCount = num1,
        measuredSize = measuredSize,
        estimatedSize = estimatedSize,
        subtreeItemCount = num1,
        subtreeMeasuredCount = 0,
        subtreeFixedCount = 0,
        subtreeFixedSum = 0,
        subtreeNodeCount = 1,
        height = 1,
        left = nil,
        right = nil
    }

    refresh(tbl2)
    return tbl2
end or function(num1: number, num2: number?) -- name: newNode
    local tbl2 = {
        itemCount = num1,
        measuredSize = num2,
        subtreeItemCount = num1,
        subtreeMeasuredCount = if num2 == nil then 0 else 1,
        subtreeMeasuredSum = num2 or 0,
        subtreeNodeCount = 1,
        height = 1,
        left = nil,
        right = nil
    }

    refresh(tbl2)
    return tbl2
end

local function rotateRight(right) -- Luacid: Inlined by compiler; 2 call sites recovered
    local left = right.left
    right.left = left.right
    left.right = right
    refresh(right)
    refresh(left)
    return left
end

local function rotateLeft(left) -- Luacid: Inlined by compiler; 2 call sites recovered
    local right = left.right
    left.right = right.left
    right.left = left
    refresh(left)
    refresh(right)
    return right
end

local function balance(tbl2)
    refresh(tbl2)
    local var2 = nodeHeight(tbl2.left) - nodeHeight(tbl2.right)
    if var2 > 1 then
        local left = tbl2.left

        if nodeHeight(left.left) < nodeHeight(left.right) then
            tbl2.left = rotateLeft(left)
        end

        return rotateRight(tbl2)
    end

    if not (var2 < -1) then
        return tbl2
    end

    local right = tbl2.right

    if nodeHeight(right.right) < nodeHeight(right.left) then
        tbl2.right = rotateRight(right)
    end

    return rotateLeft(tbl2)
end

local function join(left, tbl2, right)
    if nodeHeight(left) > nodeHeight(right) + 1 then
        left.right = join(left.right, tbl2, right)
        return (balance(left))
    end

    if nodeHeight(right) > nodeHeight(left) + 1 then
        right.left = join(left, tbl2, right.left)
        return (balance(right))
    end
    tbl2.left = left
    tbl2.right = right
    return (balance(tbl2))
end

local function popMinimum(tbl2) -- Luacid: Inlined by compiler; 6 call sites recovered
    if tbl2.left ~= nil then
        local left, var3 = popMinimum(tbl2.left)
        tbl2.left = left
        return balance(tbl2), var3
    end

    local right = tbl2.right
    tbl2.left = nil
    tbl2.right = nil
    refresh(tbl2)
    return right, tbl2
end

local function popMaximum(tbl2)
    if tbl2.right ~= nil then
        local right, var3 = popMaximum(tbl2.right)
        tbl2.right = right
        return balance(tbl2), var3
    end

    local left = tbl2.left
    tbl2.left = nil
    tbl2.right = nil
    refresh(tbl2)
    return left, tbl2
end

local function concatenate(tbl2, tbl3) -- Luacid: Inlined by compiler; 5 call sites recovered
    if tbl2 == nil then
        return tbl3
    end

    if tbl3 == nil then
        return tbl2
    end

    local var2, var3 = popMinimum(tbl3)
    return (join(tbl2, var3, var2))
end

local function splitByItems(tbl2, num1: number)
    if tbl2 == nil then
        return nil, nil
    end

    local var2 = nodeItemCount(tbl2.left)
    local var3 = var2 + tbl2.itemCount
    if num1 < var2 then
        local var4, left = splitByItems(tbl2.left, num1)
        tbl2.left = left
        return var4, (balance(tbl2))
    end

    if var3 < num1 then
        local right, var5 = splitByItems(tbl2.right, num1 - var3)
        tbl2.right = right
        return balance(tbl2), var5
    end

    if num1 == var2 then
        local left = tbl2.left
        local right = tbl2.right
        tbl2.left = nil
        tbl2.right = nil
        refresh(tbl2)
        return left, (concatenate(tbl2, right))
    end
    if num1 == var3 then
        local left = tbl2.left
        local right = tbl2.right
        tbl2.left = nil
        tbl2.right = nil
        refresh(tbl2)
        return concatenate(left, tbl2), right
    end

    assert(tbl2.measuredSize == nil, "WeightedOrderStatisticTree: cannot split a measured node")
    local var4 = num1 - var2
    local var5 = tbl2.itemCount - var4
    local var6 = if FFlagViewRecyclerReact084 then concatenate(tbl2.left, (newNode(var4, nil, tbl2.estimatedSize))) else concatenate(tbl2.left, (newNode(var4, nil)))
    local var7 = if FFlagViewRecyclerReact084 then newNode(var5, nil, tbl2.estimatedSize) else newNode(var5, nil)
    return var6, (concatenate(var7, tbl2.right))
end

local insertUnitAt

if FFlagViewRecyclerReact084 then
    insertUnitAt = function(tbl2, num1: number, num2: number?, num3: number?)
        if tbl2 == nil then
            return newNode(1, num2, num3)
        end

        local var2 = nodeItemCount(tbl2.left) + 1
        if num1 <= var2 then
            tbl2.left = insertUnitAt(tbl2.left, num1, num2, num3)
        else
            tbl2.right = insertUnitAt(tbl2.right, num1 - var2, num2, num3)
        end
        return (balance(tbl2))
    end
else
    insertUnitAt = function(tbl2, num1: number, num2: number?)
        if tbl2 == nil then
            return newNode(1, num2)
        end

        local var2 = nodeItemCount(tbl2.left) + 1
        if num1 <= var2 then
            tbl2.left = insertUnitAt(tbl2.left, num1, num2)
        else
            tbl2.right = insertUnitAt(tbl2.right, num1 - var2, num2)
        end
        return (balance(tbl2))
    end
end

local function findMin(tbl2) -- Luacid: Inlined by compiler; 1 call site recovered
    if tbl2.left ~= nil then
        return (findMin(tbl2.left))
    end

    return tbl2
end

local function removeUnitAt(tbl2, num1: number)
    if tbl2 == nil then
        return nil
    end

    local var2 = nodeItemCount(tbl2.left) + 1
    if num1 < var2 then
        tbl2.left = removeUnitAt(tbl2.left, num1)
    elseif var2 < num1 then
        tbl2.right = removeUnitAt(tbl2.right, num1 - var2)
    else
        if tbl2.left == nil then
            return tbl2.right
        end

        if tbl2.right == nil then
            return tbl2.left
        end
        local min = findMin(tbl2.right)
        tbl2.measuredSize = min.measuredSize

        if FFlagViewRecyclerReact084 then
            tbl2.estimatedSize = min.estimatedSize
        end
        tbl2.itemCount = min.itemCount
        tbl2.right = removeUnitAt(tbl2.right, 1)
    end
    return (balance(tbl2))
end

local function updateUnitAt(tbl2, num1: number, measuredSize: number?)
    if tbl2 == nil then
        return
    end

    local var2 = nodeItemCount(tbl2.left) + 1
    if num1 < var2 then
        updateUnitAt(tbl2.left, num1, measuredSize)
    elseif var2 < num1 then
        updateUnitAt(tbl2.right, num1 - var2, measuredSize)
    else
        tbl2.measuredSize = measuredSize
    end
    refresh(tbl2)
end

local function updateAt(tbl2, num1: number, measuredSize: number?): {[any]: any}?
    if tbl2 == nil then
        return nil
    end
    local var2 = nodeItemCount(tbl2.left)
    if num1 <= var2 then
        tbl2.left = updateAt(tbl2.left, num1, measuredSize)
    elseif var2 + tbl2.itemCount < num1 then
        tbl2.right = updateAt(tbl2.right, num1 - var2 - tbl2.itemCount, measuredSize)
    else
        assert(tbl2.itemCount == 1, "WeightedOrderStatisticTree: in-place update requires a unit node")
        tbl2.measuredSize = measuredSize
    end
    refresh(tbl2)
    return tbl2
end

local function measuredAt(tbl2, num1: number)
    if tbl2 == nil then
        return nil
    end
    local var2 = nodeItemCount(tbl2.left)
    if num1 <= var2 then
        return measuredAt(tbl2.left, num1)
    elseif var2 + tbl2.itemCount < num1 then
        return measuredAt(tbl2.right, num1 - var2 - tbl2.itemCount)
    end
    return tbl2.measuredSize
end

local unitSizeAt = nil
local estimatedAt = nil
if FFlagViewRecyclerReact084 then
    unitSizeAt = function(tbl2, num1: number, num2: number)
        if tbl2 == nil then
            return num2
        end
        local var2 = nodeItemCount(tbl2.left)
        if num1 <= var2 then
            return unitSizeAt(tbl2.left, num1, num2)
        elseif var2 + tbl2.itemCount < num1 then
            return unitSizeAt(tbl2.right, num1 - var2 - tbl2.itemCount, num2)
        end
        return var1(tbl2, num2)
    end

    estimatedAt = function(tbl2, num1: number)
        if tbl2 == nil then
            return nil
        end
        local var2 = nodeItemCount(tbl2.left)
        if num1 <= var2 then
            return estimatedAt(tbl2.left, num1)
        elseif var2 + tbl2.itemCount < num1 then
            return estimatedAt(tbl2.right, num1 - var2 - tbl2.itemCount)
        end
        return tbl2.estimatedSize
    end
end

local function prefixSumUpTo(tbl2, num1: number, num2: number)
    if tbl2 == nil or num1 <= 0 then
        return 0
    end
    local var2 = nodeItemCount(tbl2.left)
    if num1 <= var2 then
        return prefixSumUpTo(tbl2.left, num1, num2)
    end

    local num3 = math.min(tbl2.itemCount, num1 - var2)
    local measuredSize = if tbl2.measuredSize == nil then num3 * (if FFlagViewRecyclerReact084 then tbl2.estimatedSize or num2 else num2) else tbl2.measuredSize
    local var3 = nodeEffectiveSum(tbl2.left, num2) + measuredSize

    if num1 <= var2 + tbl2.itemCount then
        return var3
    end

    return var3 + prefixSumUpTo(tbl2.right, num1 - var2 - tbl2.itemCount, num2)
end

local function entryAtPrefixSum(tbl2, num1: number, num2: number)
    if tbl2 == nil then
        return 0, 0, 0
    end
    local var2 = nodeEffectiveSum(tbl2.left, num2)
    if num1 < var2 then
        return entryAtPrefixSum(tbl2.left, num1, num2)
    end

    local var3 = nodeItemCount(tbl2.left)
    local var4 = ownEffectiveSum(tbl2, num2)

    if not (num1 < var2 + var4) then
        local var5, var6, var7 = entryAtPrefixSum(tbl2.right, num1 - var2 - var4, num2)
        if var5 == 0 then
            return 0, 0, 0
        end
        return var3 + tbl2.itemCount + var5, var2 + var4 + var6, var7
    end

    if tbl2.measuredSize ~= nil then
        return var3 + 1, var2, tbl2.measuredSize
    end

    local var5 = if FFlagViewRecyclerReact084 then tbl2.estimatedSize or num2 else nil
    local num3 = math.floor((num1 - var2) / (if FFlagViewRecyclerReact084 then var5 else num2))
    local var6 = var3 + num3 + 1
    local var7 = var2 + num3 * (if FFlagViewRecyclerReact084 then var5 else num2)
    if FFlagViewRecyclerReact084 then
        return var6, var7, var5
    end

    return var6, var7, num2
end

local function fillRangeFromNode(tbl2, num1: number, num2: number, num3: number, num4: number, num5: number, tbl3)
    if tbl2 == nil then
        return
    end
    local var2 = num1 + nodeItemCount(tbl2.left) + 1
    local var3 = var2 + tbl2.itemCount - 1
    local var4 = num2 + nodeEffectiveSum(tbl2.left, num5)

    if num3 < var2 then
        fillRangeFromNode(tbl2.left, num1, num2, num3, num4, num5, tbl3)
    end

    local num6 = math.max(num3, var2)
    local num7 = math.min(num4, var3)
    if num6 <= num7 then
        local length = if FFlagViewRecyclerReact084 then var1(tbl2, num5) else tbl2.measuredSize or num5

        for i = num6, num7 do
            local num8 = i - num3 + 1
            local tbl4 = tbl3[num8]
            if tbl4 == nil then
                tbl4 = { startOffset = 0, length = 0 }
                tbl3[num8] = tbl4
            end
            tbl4.startOffset = var4 + (i - var2) * length
            tbl4.length = length
        end
    end

    if var3 < num4 then
        fillRangeFromNode(tbl2.right, var3, var4 + ownEffectiveSum(tbl2, num5), num3, num4, num5, tbl3)
    end
end

local function buildBalanced(tbl2, num1: number, num2: number)
    if num2 < num1 then
        return nil
    end
    local num3 = (num1 + num2) // 2
    local var2 = tbl2[num3]
    local var3 = if FFlagViewRecyclerReact084 then newNode(var2.itemCount, var2.measuredSize, var2.estimatedSize) else newNode(var2.itemCount, var2.measuredSize)
    var3.left = buildBalanced(tbl2, num1, num3 - 1)
    var3.right = buildBalanced(tbl2, num3 + 1, num2)
    refresh(var3)
    return var3
end

local function appendToArray(tbl2, tbl3, num1: number)
    if tbl2 == nil then
        return
    end
    appendToArray(tbl2.left, tbl3, num1)
    local var2 = if FFlagViewRecyclerReact084 then var1(tbl2, num1) else tbl2.measuredSize or num1

    for _ = 1, tbl2.itemCount do
        table.insert(tbl3, var2)
    end
    appendToArray(tbl2.right, tbl3, num1)
end

tbl1.newNode = newNode
tbl1.refresh = refresh
tbl1.balance = balance
tbl1.join = join
tbl1.popMinimum = popMinimum
tbl1.popMaximum = popMaximum
tbl1.concatenate = concatenate
tbl1.splitByItems = splitByItems
tbl1.insertUnitAt = insertUnitAt
tbl1.removeUnitAt = removeUnitAt
tbl1.updateUnitAt = updateUnitAt
tbl1.updateAt = updateAt
tbl1.measuredAt = measuredAt

if FFlagViewRecyclerReact084 then
    tbl1.estimatedAt = estimatedAt
    tbl1.unitSize = var1
    tbl1.unitSizeAt = unitSizeAt
end
tbl1.prefixSumUpTo = prefixSumUpTo
tbl1.entryAtPrefixSum = entryAtPrefixSum
tbl1.fillRangeFromNode = fillRangeFromNode
tbl1.buildBalanced = buildBalanced
tbl1.appendToArray = appendToArray
tbl1.nodeItemCount = nodeItemCount
tbl1.nodeMeasuredCount = nodeMeasuredCount

if FFlagViewRecyclerReact084 then
    tbl1.nodeFixedCount = nodeFixedCount
end
tbl1.nodeCount = nodeCount
tbl1.nodeEffectiveSum = nodeEffectiveSum

return tbl1
