-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local _typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

tbl1.HydrationStreamMode = {
    fromNumber = function(num1: number)
        if num1 == 0 then
            return "HYDRATION_STREAM_MODE_INVALID"
        elseif num1 == 1 then
            return "HYDRATION_STREAM_MODE_SINGLE"
        elseif num1 == 2 then
            return "HYDRATION_STREAM_MODE_STRUCTURE_THEN_HYDRATION"
        elseif num1 == 3 then
            return "HYDRATION_STREAM_MODE_ABOVE_FOLD"
        end

        return nil
    end,
    toNumber = function(arg1)
        if arg1 == "HYDRATION_STREAM_MODE_INVALID" then
            return 0
        elseif arg1 == "HYDRATION_STREAM_MODE_SINGLE" then
            return 1
        elseif arg1 == "HYDRATION_STREAM_MODE_STRUCTURE_THEN_HYDRATION" then
            return 2
        elseif arg1 == "HYDRATION_STREAM_MODE_ABOVE_FOLD" then
            return 3
        end

        return arg1
    end,
    fromName = function(str1: string)
        if str1 == "HYDRATION_STREAM_MODE_INVALID" then
            return "HYDRATION_STREAM_MODE_INVALID"
        elseif str1 == "HYDRATION_STREAM_MODE_SINGLE" then
            return "HYDRATION_STREAM_MODE_SINGLE"
        elseif str1 == "HYDRATION_STREAM_MODE_STRUCTURE_THEN_HYDRATION" then
            return "HYDRATION_STREAM_MODE_STRUCTURE_THEN_HYDRATION"
        elseif str1 == "HYDRATION_STREAM_MODE_ABOVE_FOLD" then
            return "HYDRATION_STREAM_MODE_ABOVE_FOLD"
        end

        return nil
    end
}

return {
    HydrationStreamMode = tbl1.HydrationStreamMode
}
