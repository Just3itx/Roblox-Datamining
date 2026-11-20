-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:21:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")
local _Types = require(Markdown.Types)

local Utils = require(script.Parent.Utils)

local module = {}

function module.collectDelimiterRun(tbl1, arg1, startIdx: number)
    local length = arg1.length
    local num1 = startIdx + 1

    while num1 <= #tbl1 do
        local delimiterInfo = Utils.getDelimiterInfo(tbl1[num1].name)
        if not delimiterInfo or delimiterInfo.char ~= arg1.char then
            break
        end

        length += delimiterInfo.length
        num1 += 1
    end

    local nextChar = nil

    local var1 = tbl1[startIdx]
    local prevChar = if var1 and var1.context then var1.context.prevChar else nil
    local var2 = tbl1[num1 - 1]
    if var2 and var2.context then
        nextChar = var2.context.nextChar
    end

    return {
        char = arg1.char,
        prevChar = prevChar,
        nextChar = nextChar,
        length = length,
        startIdx = startIdx,
        endIdx = num1 - 1
    }
end

function module.processEmphasisRun(tbl1, num1: number, num2: number)
    local num3 = 1
    local tbl2 = {}
    local tbl3 = ({})
    local tbl4 = {}

    while num1 <= num2 do
        local var1 = tbl1[num1]
        local delimiterInfo = Utils.getDelimiterInfo(var1.name)

        if not delimiterInfo then
            tbl3[num3] = var1

            if Utils.causesLineBreak(var1) then
                table.insert(tbl4, num1)
            end

            num3 += 1
            num1 += 1
        else
            local var2 = module.collectDelimiterRun(tbl1, delimiterInfo, num1)

            local canOpen = Utils.canOpenEmphasis(var2)
            local canClose = Utils.canCloseEmphasis(var2)

            table.insert(tbl2, {
                char = var2.char,
                runLength = var2.length,
                origRunLength = var2.length,
                canOpen = canOpen,
                canClose = canClose,
                startIdx = num3,
                tokenStart = var2.startIdx
            })

            local tbl5 = {
                name = "DELIMITER_RUN",
                text = "",
                delimiterIndex = #tbl2,
                offset = tbl1[var2.startIdx].offset
            }
            tbl3[num3] = tbl5

            num3 += 1
            num1 = var2.endIdx + 1
        end
    end

    local bool1 = false
    for i = num2 + 1, #tbl1 do
        if Utils.causesLineBreak(tbl1[i]) then
            bool1 = true
            break
        end
    end

    local tbl5 = {}

    for value, with in tbl2 do
        if with.canClose and with.runLength > 0 then
            local num4 = #tbl5
            while num4 >= 1 do
                local var1 = tbl2[tbl5[num4]]

                if var1.char == "`" and with.char ~= "`" and var1.canOpen then
                    break
                end

                if var1.char ~= with.char or not (var1.canOpen and var1.runLength > 0) or not Utils.canDelimitersMatch(var1, with) then
                    num4 -= 1
                else
                    local length = math.min(2, var1.runLength, with.runLength)

                    Utils.addDelimiterMatch(var1, { with = with, length = length, isOpener = true })

                    Utils.addDelimiterMatch(with, { with = var1, length = length, isOpener = false })

                    var1.runLength -= length
                    with.runLength -= length

                    for _ = #tbl5, num4 + 1, -1 do
                        table.remove(tbl5)
                    end

                    if var1.runLength == 0 then
                        table.remove(tbl5, num4)
                    end

                    if with.runLength == 0 then
                        break
                    end

                    num4 = #tbl5
                end
            end
        end

        if with.canOpen and with.runLength > 0 then
            table.insert(tbl5, value)
        end
    end

    local result = {}

    for value, value2 in tbl3 do
        if value2.name ~= "DELIMITER_RUN" then
            table.insert(result, value2)
        else
            local var1 = tbl2[value2.delimiterIndex]
            local bool2 = false

            if var1.char == "`" and var1.runLength > 0 and value2.delimiterIndex == #tbl2 and not bool1 and value < #tbl3 then
                local bool3 = false
                for i = #tbl4, 1, -1 do
                    local var2 = tbl4[i]
                    if var1.tokenStart < var2 then
                        bool3 = true
                        break
                    end

                    if var2 <= var1.tokenStart then
                        break
                    end
                end

                bool2 = not bool3
            end

            if bool2 then
                table.insert(result, { name = "EMPHASIS_START", text = "INLINE_CODE", offset = tbl1[var1.tokenStart].offset })
            else
                local matches = var1.matches
                if not matches or #matches == 0 then
                    table.insert(result, { name = "TEXT", text = string.rep(var1.char, var1.origRunLength), offset = value2.offset })
                elseif matches[1].isOpener then
                    local num4 = 0
                    for _, value3 in matches do
                        num4 += value3.length
                    end

                    local var2 = var1.origRunLength - num4
                    if var2 > 0 then
                        table.insert(result, { name = "TEXT", text = string.rep(var1.char, var2), offset = value2.offset })
                    end

                    for _, value3 in matches do
                        local length = value3.length
                        while length > 0 do
                            local num5 = math.min(length, 2)
                            table.insert(
                                result,
                                {
                                    name = "EMPHASIS_START",
                                    text = Utils.getTokenNameFromCharAndLength(var1.char, num5),
                                    offset = value2.offset
                                }
                            )
                            length -= num5
                        end
                    end
                else
                    local tbl6 = {}
                    for _, value3 in matches do
                        local length = value3.length
                        while length > 0 do
                            local num4 = math.min(length, 2)

                            table.insert(tbl6, { name = "EMPHASIS_END", text = "", offset = value2.offset })

                            length -= num4
                        end
                    end

                    for i = #tbl6, 1, -1 do
                        table.insert(result, tbl6[i])
                    end

                    local num4 = 0
                    for _, value3 in matches do
                        num4 += value3.length
                    end

                    local var2 = var1.origRunLength - num4
                    if var2 > 0 then
                        table.insert(result, { name = "TEXT", text = string.rep(var1.char, var2), offset = value2.offset })
                    end
                end
            end
        end
    end
    return result
end

return module
