-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:40:52Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local _UrlSanitizer = require(CommonMark.renderer.html.UrlSanitizer)

local byte = string.byte
local gsub = string.gsub
local lower = string.lower
local sub = string.sub

local module = {}
module.__index = module

function module.new()
    return module.newCollection({ "http", "https", "mailto", "data" })
end

function module.newCollection(tbl1)
    local _protocols = ({})
    for _, value in ipairs(tbl1) do
        _protocols[value] = true
    end
    return (setmetatable({ _protocols = _protocols }, module))
end

function module:sanitizeLinkUrl(str1: string)
    str1 = self:stripHtmlSpaces(str1)

    for i = 0, #str1 - 1 do
        local var1 = byte(str1, i + 1)
        if var1 == 47 or var1 == 35 then
            break
        end

        if var1 == 63 then
            return str1
        end

        if var1 ~= 58 then
            continue
        end

        local var2 = gsub(lower((sub(str1, 1, i))), "K", "k")
        if not self._protocols[var2] then
            return ""
        end

        break
    end

    return str1
end

function module.sanitizeImageUrl(arg1, str1: string)
    return arg1:sanitizeLinkUrl(str1)
end

function module:stripHtmlSpaces(str1: string)
    local num1 = #str1
    local num2 = 0

    while num2 < num1 do
        local num3 = num1 - 1 + 1

        if not self:isHtmlSpace(byte(str1, num3)) then
            break
        end

        num1 -= 1
    end
    while num2 < num1 do
        local num3 = num2 + 1

        if not self:isHtmlSpace(byte(str1, num3)) then
            break
        end

        num2 += 1
    end
    if num2 == 0 and num1 == #str1 then
        return str1
    end
    return (sub(str1, num2 + 1, num1))
end

function module:isHtmlSpace(num1: number): boolean
    return num1 == 32 or num1 == 9 or num1 == 10 or num1 == 12 or num1 == 13
end

return module
