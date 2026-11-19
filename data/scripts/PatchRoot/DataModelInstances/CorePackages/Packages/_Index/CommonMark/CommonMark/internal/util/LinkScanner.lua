-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:21:16Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local _Scanner = require(CommonMark.parser.beta.Scanner)

local byte = string.byte

local tbl1 = {}

for i = 1, 32 do
    tbl1[byte("!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~", i)] = true
end

local function isEscapable(num1: number): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    return tbl1[num1] == true
end

local module = {}

function module.scanLinkLabelContent(arg1)
    while arg1:hasNext() do
        local var1 = arg1:peek()
        if var1 == 92 then
            arg1:next()

            if isEscapable((arg1:peek())) then
                arg1:next()
            end
        else
            if var1 == 93 then
                return true
            elseif var1 == 91 then
                return false
            end
            arg1:next()
        end
    end
    return true
end

local function scanLinkDestinationWithBalancedParens(arg1)
    local bool1 = true
    local num1 = 0

    while arg1:hasNext() do
        local var1 = arg1:peek()
        if var1 == 32 then
            return not bool1
        end

        if var1 == 92 then
            arg1:next()

            if isEscapable((arg1:peek())) then
                arg1:next()
            end
        elseif var1 == 40 then
            num1 += 1

            if num1 > 32 then
                return false
            end
            arg1:next()
        elseif var1 == 41 then
            if num1 == 0 then
                return true
            end
            num1 -= 1

            arg1:next()
        else
            if var1 < 32 or var1 == 127 then
                return not bool1
            end
            arg1:next()
        end

        bool1 = false
    end

    return true
end

function module.scanLinkDestination(arg1)
    if not arg1:hasNext() then
        return false
    end

    if not arg1:nextChar(60) then
        return (scanLinkDestinationWithBalancedParens(arg1))
    end

    while arg1:hasNext() do
        local var1 = arg1:peek()
        if var1 == 92 then
            arg1:next()

            if isEscapable((arg1:peek())) then
                arg1:next()
            end
        else
            if var1 == 10 or var1 == 60 then
                return false
            end

            if var1 == 62 then
                arg1:next()
                return true
            end
            arg1:next()
        end
    end
    return false
end

function module.scanLinkTitle(arg1)
    if not arg1:hasNext() then
        return false
    end

    local var1 = arg1:peek()
    local num1

    if var1 == 34 then
        num1 = 34
    elseif var1 == 39 then
        num1 = 39
    else
        if var1 ~= 40 then
            return false
        end

        num1 = 41
    end
    arg1:next()

    if not module.scanLinkTitleContent(arg1, num1) then
        return false
    end
    if not arg1:hasNext() then
        return false
    end
    arg1:next()
    return true
end

function module.scanLinkTitleContent(arg1, num1: number)
    while arg1:hasNext() do
        local var1 = arg1:peek()
        if var1 == 92 then
            arg1:next()

            if isEscapable((arg1:peek())) then
                arg1:next()
            end
        else
            if var1 == num1 then
                return true
            end

            if num1 == 41 and var1 == 40 then
                return false
            end
            arg1:next()
        end
    end
    return true
end

return module
