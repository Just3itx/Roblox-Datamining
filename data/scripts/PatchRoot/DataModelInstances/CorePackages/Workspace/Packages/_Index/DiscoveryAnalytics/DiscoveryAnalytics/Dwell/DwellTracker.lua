-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    new = function(tbl1)
        local tbl2 = ({})
        local var1 = nil

        local function finish(view, reason: string, num1: number, timestamp: number) -- Luacid: unused: defined but never referenced
            view.maxGap = math.max(view.maxGap, num1 - view.lastPresent)
            return {
                view = view,
                timestamp = timestamp,
                duration = num1 - view.start,
                reason = reason
            }
        end
        return {
            sample = function(tbl3)
                local var2 = tbl1.now()
                local var3 = tbl1.wallNow()
                local tbl4 = ({})
                local tbl5 = {}
                local tbl6 = {}
                for _, cell in tbl3 do
                    local item = tbl1.getItem(cell)
                    if not item then
                        continue
                    end

                    local var4 = tbl1.identity(item)
                    if tbl4[var4] then
                        continue
                    end

                    tbl4[var4] = true
                    local var5 = tbl2[var4]
                    if var5 then
                        var5.maxGap = math.max(var5.maxGap, var2 - var5.lastPresent)
                        var5.lastPresent = var2
                        var5.count += 1
                        var5.cell = cell
                    else
                        local tbl7 = {
                            item = item,
                            cell = cell,
                            uuid = tbl1.newUuid(),
                            start = var2,
                            startTimestamp = var3,
                            precedingGap = if var1 then var2 - var1 else -1,
                            lastPresent = var2,
                            count = 1,
                            maxGap = 0
                        }

                        tbl2[var4] = tbl7
                        table.insert(tbl5, tbl7)
                    end
                end
                for value, view in tbl2 do
                    if tbl4[value] then
                        continue
                    end

                    local item = tbl1.getItem(view.cell)
                    local reason = if item then if tbl1.identity(item) == value then "notVisible" else "identityChanged" else "notVisible"
                    local maxGap = view.maxGap
                    local var4 = var2 - view.lastPresent
                    view.maxGap = math.max(maxGap, var4)
                    table.insert(tbl6, { view = view, timestamp = var3, duration = var2 - view.start, reason = reason })
                    tbl2[value] = nil
                end

                var1 = var2
                if #tbl6 > 0 then
                    tbl1.sendEnds(tbl6)
                end
                if #tbl5 > 0 then
                    tbl1.sendStarts(tbl5)
                end
            end,
            close = function(reason: string)
                local tbl3 = {}
                local var2 = tbl1.now()
                local timestamp = tbl1.wallNow()
                for _, view in tbl2 do
                    local maxGap = view.maxGap
                    local var4 = var2 - view.lastPresent
                    view.maxGap = math.max(maxGap, var4)
                    table.insert(tbl3, { view = view, timestamp = timestamp, duration = var2 - view.start, reason = reason })
                end
                table.clear(tbl2)
                var1 = nil
                if #tbl3 > 0 then
                    tbl1.sendEnds(tbl3)
                end
            end
        }
    end
}
