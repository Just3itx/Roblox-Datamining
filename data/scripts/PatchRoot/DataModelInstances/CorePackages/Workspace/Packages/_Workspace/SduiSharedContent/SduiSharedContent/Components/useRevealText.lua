-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)

local function getDelimiter(delimiter: string?): string -- Luacid: Inlined by compiler; 1 call site recovered
    return if delimiter == nil or delimiter == "" then " " else delimiter
end

local function getRevealInterval(revealInterval: number?): number -- Luacid: Inlined by compiler; 1 call site recovered
    if revealInterval == nil then
        return 0.05
    end
    return math.max(revealInterval, 0)
end

local function shouldRenderDelimiter(bool1: boolean?): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not bool1
end

local function getTagName(str1: string, bool1: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
    return string.match(str1, if bool1 then "^<%s*/%s*([%w]+)" else "^<%s*([%w]+)")
end

local function isSelfClosingTag(str1: string, tagName: string?): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return tagName == "br" or string.match(str1, "/%s*>$") ~= nil
end

local function removeLastMatchingTag(tbl1, tagName: string)
    for i = #tbl1, 1, -1 do
        if tbl1[i] == tagName then
            table.remove(tbl1, i)
            return
        end
    end
end

local function buildBalancedText(tbl1, tbl2): string -- Luacid: Inlined by compiler; 3 call sites recovered
    local str1 = table.concat(tbl1)
    for i = #tbl2, 1, -1 do
        str1 ..= `</{tbl2[i]}>`
    end
    return str1
end

local function appendFrame(tbl1, tbl2, tbl3) -- Luacid: Inlined by compiler; 2 call sites recovered
    local balancedText = buildBalancedText(tbl2, tbl3)

    if balancedText ~= tbl1[#tbl1] then
        table.insert(tbl1, balancedText)
    end
end

local function buildRevealTextFrames(text: string?, delimiter: string?, richText: boolean?, removeDelimiter: boolean?)
    if text == nil or text == "" then
        return { text or "" }
    end

    local delimiter2 = getDelimiter(delimiter)
    local textLen = #text
    local delimiter2Len = #delimiter2
    local num1 = 1
    local bool1 = false
    local tbl1 = {}
    local tbl2 = {}
    local tbl3 = {}

    while true do
        if not (num1 <= textLen) then
            appendFrame(tbl3, tbl1, tbl2)
            return tbl3
        end

        local bool2 = false

        if delimiter2Len > 0 and string.sub(text, num1, num1 + delimiter2Len - 1) == delimiter2 then
            if bool1 then
                appendFrame(tbl3, tbl1, tbl2)
                bool1 = false
            end

            if shouldRenderDelimiter(removeDelimiter) then
                table.insert(tbl1, delimiter2)
            end
            num1 += delimiter2Len
            bool2 = true
        elseif richText and string.sub(text, num1, num1) == "<" then
            local var1 = string.find(text, ">", num1, true)
            if var1 then
                local str1 = string.sub(text, num1, var1)
                table.insert(tbl1, str1)

                local bool3 = string.sub(str1, 1, 2) == "</"
                local tagName = getTagName(str1, bool3)

                if tagName then
                    if bool3 then
                        removeLastMatchingTag(tbl2, tagName)
                    elseif not isSelfClosingTag(str1, tagName) then
                        table.insert(tbl2, tagName)
                    end
                end

                num1 = var1 + 1
                bool2 = true
            end
        end

        if not bool2 then
            table.insert(tbl1, string.sub(text, num1, num1))

            num1 += 1
            bool1 = true
        end
    end
end

local function useRevealText(tbl1)
    local text = tbl1.text
    local delimiter = tbl1.delimiter
    local removeDelimiter = tbl1.removeDelimiter
    local richText = tbl1.richText
    local revealInterval = tbl1.revealInterval

    local var1 = React.useMemo(function()
        return (buildRevealTextFrames(text, delimiter, richText, removeDelimiter))
    end, {
        text,
        delimiter,
        richText,
        removeDelimiter
    })

    local revealInterval2 = getRevealInterval(revealInterval)
    local var2, var3 = React.useState(if revealInterval2 == 0 then var1[#var1] else var1[1])

    React.useEffect(function()
        local var4 = task.spawn(function()
            if revealInterval2 == 0 then
                var3(var1[#var1])
                return
            end

            var3(var1[1])

            for i = 2, #var1 do
                task.wait(revealInterval2)
                var3(var1[i])
            end
        end)

        return function()
            task.cancel(var4)
        end
    end, { var1, revealInterval2 })

    return var2
end

return useRevealText
