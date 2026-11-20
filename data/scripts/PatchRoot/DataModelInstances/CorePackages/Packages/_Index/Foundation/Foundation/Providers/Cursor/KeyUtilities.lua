-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local ColorNamespace = require(Foundation.Enums.ColorNamespace)
local CursorType = require(Foundation.Enums.CursorType)

local _Tokens = require(Foundation.Providers.Style.Tokens)
local _Types = require(Foundation.Components.Types)

local function encodeCursorTypeKey(arg1, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
    return arg1 .. " " .. (arg2 or ColorNamespace.Color)
end

local function migrateCursorType(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local str1 = tostring(arg1)
    local var1 = string.gsub(str1, if str1:find("Kind") then "CursorKind%." else "CursorType%.", "")
    return CursorType[var1]
end

return {
    encodeKey = function(arg1, uDim: UDim?, num1: number?, num2: number?, arg2)
        local var1 = uDim or UDim.new(0, 0)
        local thicker = arg1.Stroke.Thicker
        local var2 = num2 or thicker
        local var3 = (num1 or arg1.Size.Size_150) - var2
        local var4 = arg2 or ColorNamespace.Color

        return var1.Scale .. " " .. var1.Offset .. " " .. var3 .. " " .. var2 .. " " .. var4
    end,
    decodeKey = function(arg1)
        if typeof(arg1) == "string" then
            arg1 = string.split(arg1, " ")
        end

        local var1 = tonumber(arg1[1])
        local var2 = tonumber(arg1[2])
        local var3 = tonumber(arg1[3])
        local var4 = tonumber(arg1[4])
        local var5 = arg1[5]

        return UDim.new(var1, math.max(0, var2 + var3)), var3, var4, var5
    end,
    encodeCursorTypeKey = encodeCursorTypeKey,
    decodeCursorTypeKey = function(arg1)
        if typeof(arg1) == "string" then
            arg1 = string.split(arg1, " ")
        end

        return arg1[1], arg1[2]
    end,
    migrateCursorType = migrateCursorType,
    mapCursorToKey = function(arg1, arg2)
        if typeof(arg1) == "table" then
            local radius = arg1.radius
            local offset = arg1.offset
            local borderWidth = arg1.borderWidth
            local var1 = radius or UDim.new(0, 0)
            local thicker = arg2.Stroke.Thicker
            local var2 = borderWidth or thicker
            local var3 = (offset or arg2.Size.Size_150) - var2
            local colorNamespaceColor = ColorNamespace.Color

            return var1.Scale .. " " .. var1.Offset .. " " .. var3 .. " " .. var2 .. " " .. colorNamespaceColor
        elseif arg1 == nil then
            local uDim = UDim.new(0, 0)
            local thicker = arg2.Stroke.Thicker

            local var1 = arg2.Size.Size_150 - thicker
            local colorNamespaceColor = ColorNamespace.Color

            return uDim.Scale .. " " .. uDim.Offset .. " " .. var1 .. " " .. thicker .. " " .. colorNamespaceColor
        elseif typeof(arg1) == "userdata" then
            return encodeCursorTypeKey(migrateCursorType(arg1), false)
        else
            return (encodeCursorTypeKey(arg1, false))
        end
    end
}
