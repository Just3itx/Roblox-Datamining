-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object
local tbl1 = {}

local invariant = require(scriptParentParent.jsUtils.invariant)

local CellRenderMask = {}
CellRenderMask.__index = CellRenderMask

function CellRenderMask.new(_numCells: number)
    local self = (setmetatable({}, CellRenderMask))
    invariant(_numCells >= 0, "CellRenderMask must contain a non-negative number os cells")
    self._numCells = _numCells
    if _numCells == 0 then
        self._regions = {}
    else
        self._regions = {{
            first = 0,
            last = _numCells - 1,
            isSpacer = true
        }}
    end

    return self
end

function CellRenderMask:enumerateRegions()
    return self._regions
end

function CellRenderMask:addCells(tbl3)
    invariant(
        tbl3.first >= 0
            and tbl3.first < self._numCells
            and tbl3.last >= 0
            and tbl3.last < self._numCells
            and tbl3.last >= tbl3.first,
        "CellRenderMask.addCells called with invalid cell range"
    )
    local var1, var2 = self:_findRegion(tbl3.first)
    local var3, var4 = self:_findRegion(tbl3.last)

    if var2 == var4 and not var1.isSpacer then
        return
    end

    local tbl4 = {}
    local tbl5 = {}
    local var5 = Object.assign({}, tbl3, { isSpacer = false })
    if var1.first < var5.first then
        if var1.isSpacer then
            table.insert(tbl4, { first = var1.first, last = var5.first - 1, isSpacer = true })
        else
            var5.first = var1.first
        end
    end
    if var3.last > var5.last then
        if var3.isSpacer then
            table.insert(tbl5, { first = var5.last + 1, last = var3.last, isSpacer = true })
        else
            var5.last = var3.last
        end
    end
    local var6 = Array.concat(tbl4, { var5 }, tbl5)
    local var7 = var4 - var2 + 1
    Array.splice(self._regions, var2, var7, table.unpack(var6))
end

function CellRenderMask:equals(tbl3)
    return self._numCells == tbl3._numCells and #self._regions == #tbl3._regions and Array.every(self._regions, function(arg1, arg2): boolean
        return arg1.first == tbl3._regions[arg2].first
            and arg1.last == tbl3._regions[arg2].last
            and arg1.isSpacer == tbl3._regions[arg2].isSpacer
    end)
end

function CellRenderMask:_findRegion(num1: number)
    local _regionsLen = #self._regions
    local num2 = 1

    while num2 <= _regionsLen do
        local num3 = math.floor((num2 + _regionsLen) / 2)
        local _region = self._regions[num3]
        if _region.first <= num1 and num1 <= _region.last then
            return _region, num3
        end

        if num1 < _region.first then
            _regionsLen = num3 - 1
        elseif _region.last < num1 then
            num2 = num3 + 1
        end
    end
    invariant(false, string.format("A region was not found containing cellIdx %s", tostring(num1)))
    return nil, nil
end
tbl1.CellRenderMask = CellRenderMask
return tbl1
