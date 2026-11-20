-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local StatusIndicatorSize = require(Foundation.Enums.StatusIndicatorSize)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local function getStatusIndicatorSize(arg1, arg2, bool1: boolean)
    if arg2 == StatusIndicatorSize.Large or arg2 == StatusIndicatorSize.Pictogram then
        return arg1.Size.Size_500
    end

    if bool1 then
        return arg1.Size.Size_400
    end

    if arg2 == StatusIndicatorSize.Medium then
        return arg1.Size.Size_250
    end

    if arg2 == StatusIndicatorSize.Small then
        return arg1.Size.Size_200
    end

    return arg1.Size.Size_150
end

return getStatusIndicatorSize
