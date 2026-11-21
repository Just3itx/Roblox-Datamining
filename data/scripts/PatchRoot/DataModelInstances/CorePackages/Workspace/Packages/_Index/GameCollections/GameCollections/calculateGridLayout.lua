-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameCollectionsParent = script:FindFirstAncestor("GameCollections").Parent

local _DiscoveryTypes = require(GameCollectionsParent.DiscoveryTypes)
local reportWarning = require(GameCollectionsParent.DiscoveryAnalytics).Points.reportWarning

local LoggingProtocol = require(GameCollectionsParent.LoggingProtocol)

local function removeFromAvailableCells(tbl1, num1: number, num2: number)
    for i = 1, #tbl1 do
        local var1 = tbl1[i]
        if var1.X == num1 and var1.Y == num2 then
            table.remove(tbl1, i)
            return
        end
    end
end

local function markOccupiedCell(tbl1, num1: number, num2: number, num3: number, num4: number, num5: number, tbl2): (number, number) -- Luacid: Inlined by compiler; 2 call sites recovered
    tbl1[num2] = tbl1[num2] or {}
    tbl1[num2][num1] = num3

    num4 = math.max(num4, num2)
    num5 = math.max(num5, num1)

    if tbl2 then
        removeFromAvailableCells(tbl2, num1, num2)
    end

    return num4, num5
end

local function isCellOccupied(tbl1, num1: number, num2: number): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return if tbl1[num2] then tbl1[num2][num1] ~= nil else false
end

local function canInsertItem(tbl1, num1: number, num2: number, colSpan: number, rowSpan: number, num3: number)
    if num3 < num1 + colSpan - 1 then
        return false
    end

    for i = 0, rowSpan - 1 do
        for j = 0, colSpan - 1 do
            if isCellOccupied(tbl1, num1 + j, num2 + i) then
                return false
            end
        end
    end

    return true
end

local function markItemCells(tbl1, num1: number, num2: number, num3: number, colSpan: number, rowSpan: number, num4: number, num5: number, availableCells): (number, number)
    num4, num5 = markOccupiedCell(tbl1, num1, num2, num3, num4, num5, availableCells)

    for i = 0, rowSpan - 1 do
        for j = 0, colSpan - 1 do
            if j == 0 and i == 0 then
                continue
            end

            local num6 = num1 + j
            local num7 = num2 + i
            num4, num5 = markOccupiedCell(tbl1, num6, num7, -1, num4, num5, false)

            if availableCells then
                removeFromAvailableCells(availableCells, num6, num7)
            end
        end
    end
    return num4, num5
end

local function findPinnedInsertionPointAndMarkOccupiedItem(tbl1, num1: number, colSpan: number, rowSpan: number, num2: number, num3: number, num4: number, tbl2, num5: number, num6: number, num7: number)
    local num8 = num6 or 1

    if num2 < colSpan then
        reportWarning(
            LoggingProtocol.default,
            "InvalidGrid",
            `Item {num1} has colSpan {colSpan} greater than itemsPerRow {num2}`
        )
        return num3, num4, nil
    end

    if num5 < 1 or num2 < num5 + colSpan - 1 then
        reportWarning(
            LoggingProtocol.default,
            "InvalidGrid",
            `Item {num1} cannot be pinned at column {num5} with colSpan {colSpan} in grid with {num2} columns`
        )
        return num3, num4, nil
    end

    while num8 <= num7 do
        if tbl2.lastRow < num8 then
            local lastRow = tbl2.lastRow
            tbl2.lastRow = num8

            for i = lastRow * num2 + 1, num8 * num2 do
                table.insert(tbl2.availableCells, Vector2.new((i - 1) % num2 + 1, math.floor((i - 1) / num2) + 1))
            end
        end

        if canInsertItem(tbl1, num5, num8, colSpan, rowSpan, num2) then
            num3, num4 = markItemCells(tbl1, num5, num8, num1, colSpan, rowSpan, num3, num4, tbl2.availableCells)

            return num3, num4, num8
        end

        num8 += 1
    end

    reportWarning(
        LoggingProtocol.default,
        "InvalidGrid",
        `Item {num1} at column {num5} with colSpan {colSpan} could not be placed within allowed rows`
    )
    return num3, num4, nil
end

local function findInsertionPointAndMarkOccupiedItem(tbl1, num1: number, colSpan: number, rowSpan: number, num2: number, num3: number, num4: number, tbl2)
    if num2 < colSpan then
        reportWarning(
            LoggingProtocol.default,
            "InvalidGrid",
            `Item {num1} has colSpan {colSpan} greater than itemsPerRow {num2}`
        )
        return num3, num4
    end

    if num3 + 1 > tbl2.lastRow then
        local lastRow = tbl2.lastRow
        local num5 = num3 + 1
        tbl2.lastRow = num5

        for i = lastRow * num2 + 1, num5 * num2 do
            table.insert(tbl2.availableCells, Vector2.new((i - 1) % num2 + 1, math.floor((i - 1) / num2) + 1))
        end
    end

    local num5 = 1

    while num5 <= #tbl2.availableCells do
        local availableCell = tbl2.availableCells[num5]
        local availableCellX = availableCell.X
        local availableCellY = availableCell.Y

        if canInsertItem(tbl1, availableCellX, availableCellY, colSpan, rowSpan, num2) then
            num3, num4 = markItemCells(tbl1, availableCellX, availableCellY, num1, colSpan, rowSpan, num3, num4, tbl2.availableCells)

            return num3, num4
        end

        num5 += 1
    end

    return num3, num4
end

local function calculateGridLayout(num1: number, num2: number, tbl1)
    if not num2 or num2 <= 0 then
        return {
            layout = {},
            totalRows = 0,
            totalCols = 0
        }
    end

    local layout = ({})
    local num3 = 0
    local num4 = 0
    local tbl3 = {
        lastRow = 0,
        availableCells = {}
    }

    local bool1 = false
    local num5 = 1

    local num6 = 0
    for i = 1, num1 do
        local var1 = tbl1 and tbl1[i]
        num6 += (var1 and var1.colSpan or 1) * (var1 and var1.rowSpan or 1)
    end
    local num7 = math.ceil(num6 / num2)
    local var1 = if num6 % num2 == 0 then num7 else math.max(1, num7 - 1)

    for i = 1, num1 do
        local colSpan = tbl1 and tbl1[i] and tbl1[i].colSpan or 1
        local rowSpan = tbl1 and tbl1[i] and tbl1[i].rowSpan or 1
        local alignmentType = if tbl1 and tbl1[i] then tbl1[i].alignmentType or nil else nil
        local minRowPadding = tbl1 and tbl1[i] and tbl1[i].minRowPadding or 0

        if colSpan ~= 1 or rowSpan ~= 1 or alignmentType then
            bool1 = true
        end

        if bool1 then
            if alignmentType == "RightPin" then
                local var2 = num2 - colSpan + 1
                local var3
                num3, num4, var3 = findPinnedInsertionPointAndMarkOccupiedItem(layout, i, colSpan, rowSpan, num2, num3, num4, tbl3, var2, num5, var1)

                if var3 and minRowPadding and minRowPadding > 0 then
                    num5 = var3 + minRowPadding
                end
            elseif alignmentType == "LeftPin" then
                local var2
                num3, num4, var2 = findPinnedInsertionPointAndMarkOccupiedItem(layout, i, colSpan, rowSpan, num2, num3, num4, tbl3, 1, num5, num7)

                if var2 and minRowPadding and minRowPadding > 0 then
                    num5 = var2 + minRowPadding
                end
            else
                num3, num4 = findInsertionPointAndMarkOccupiedItem(layout, i, colSpan, rowSpan, num2, num3, num4, tbl3)
            end
        else
            local num8 = (i - 1) % num2 + 1
            local num9 = math.floor((i - 1) / num2) + 1
            layout[num9] = layout[num9] or {}
            layout[num9][num8] = i

            num3 = math.max(num3, num9)
            num4 = math.max(num4, num8)
        end
    end

    return { layout = layout, totalRows = num3, totalCols = num4 }
end

return calculateGridLayout
