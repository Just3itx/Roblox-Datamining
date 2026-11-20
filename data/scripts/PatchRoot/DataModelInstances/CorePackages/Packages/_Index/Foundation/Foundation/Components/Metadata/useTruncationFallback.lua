-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:11:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Services = require(Foundation.Utility.Wrappers.Services)
local _Types = require(Foundation.Components.Types)
local getTextBoundsAsync = require(Foundation.Utility.getTextBoundsAsync)
local normalizeFontFace = require(Foundation.Utility.normalizeFontFace)
local RunService = Services.RunService

local tbl1 = {}

local function useTruncationFallback(key: string, num1: number, arg1)
    local var1, var2 = React.useState({ key = key, level = 0 })
    local var3 = if var1.key ~= key then 0 else var1.level
    local num2 = math.max(num1 - 1, 0)
    local str1 = `{arg1.Font}|{arg1.FontSize}`
    local minWidth = tbl1[str1] or 0
    local var5 = React.useRef({})
    local var6 = React.useRef({})

    React.useEffect(function()
        return function()
            for _, value in var5.current do
                value:Disconnect()
            end
            table.clear(var5.current)
            table.clear(var6.current)
        end
    end, { key })

    local current = React.useCallback(function(num3: number, num4: number, bool1: boolean)
        local bool2 = not bool1 and num4 <= minWidth + 1
        local var7 = var3
        if num3 == var3 and var3 < num2 and bool2 then
            var7 = var3 + 1
        elseif num3 == var3 - 1 and minWidth + 4 < num4 then
            var7 = var3 - 1
        end
        if var3 < var7 and tbl1[str1] == nil then
            local var8 = normalizeFontFace(arg1.Font)
            local textBoundsAsync = if typeof(var8) == "Font" then getTextBoundsAsync("…", var8, arg1.FontSize or 0) else nil

            if textBoundsAsync and textBoundsAsync.X > 0 then
                local tbl2 = tbl1
                local str2 = str1
                tbl2[str2] = math.ceil(textBoundsAsync.X)
            end
        end
        if var7 ~= var3 then
            var2({ key = key, level = var7 })
        end
    end, {
        key,
        var3,
        num2,
        minWidth,
        str1,
        arg1
    })

    local var8 = React.useRef(current)
    var8.current = current

    local onSizeChanged = React.useCallback(function(num3: number, arg2)
        var6.current[num3] = arg2
        if var5.current[num3] then
            return
        end
        local num4 = 0
        local function check()
            num4 += 1
            local absoluteSizeX = arg2.AbsoluteSize.X
            if arg2.TextBounds.X > absoluteSizeX + 1 and num4 < 10 then
                var5.current[num3] = RunService.Heartbeat:Once(check)
                return
            end
            var5.current[num3] = nil
            var8.current(num3, absoluteSizeX, arg2.TextFits)
        end
        var5.current[num3] = RunService.Heartbeat:Once(check)
    end, {})

    React.useEffect(function()
        for _, value in { var3 - 1, var3 } do
            local var10 = var6.current[value]
            if var10 and var10.Parent then
                onSizeChanged(value, var10)
            end
        end
    end, {
        var3,
        key,
        minWidth,
        onSizeChanged
    })
    return {
        minWidth = minWidth,
        getShrinkRatio = React.useCallback(function(num3: number)
            return if num3 <= var3 then 1000 ^ (var3 - num3) else nil
        end, { var3 }),
        isPinned = React.useCallback(function(num3: number): boolean
            return num3 < var3
        end, { var3 }),
        isDeciding = React.useCallback(function(num3: number): boolean
            return num3 == var3 or num3 == var3 - 1
        end, { var3 }),
        onSizeChanged = onSizeChanged
    }
end

return useTruncationFallback
