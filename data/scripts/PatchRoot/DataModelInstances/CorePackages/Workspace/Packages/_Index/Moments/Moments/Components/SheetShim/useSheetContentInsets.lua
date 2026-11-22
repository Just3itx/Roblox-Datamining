-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:41:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)

local _SheetShimTypes = require(script.Parent.SheetShimTypes)
local _getSheetStructure = require(script.Parent.getSheetStructure)
local readSheetContentInsets = require(script.Parent.readSheetContentInsets)

local RunService = game:GetService("RunService")

local var1 = table.freeze({ bottom = 0, right = 0 })

local function useSheetContentInsets(bool1: boolean, current: ((...any) -> (...any))?)
    local var2 = React.useRef(current)
    var2.current = current

    local var3 = React.useRef(nil)
    local var4 = React.useRef(false)

    local var5 = React.useCallback(function(current2)
        local current3 = var3.current
        if current3 ~= nil and current3.bottom == current2.bottom and current3.right == current2.right then
            return
        end
        var3.current = current2

        if var2.current ~= nil then
            var2.current(current2)
        end
    end, {})

    local bool2 = current ~= nil
    React.useLayoutEffect(function()
        if bool1 == nil or not bool2 then
            return nil
        end
        var4.current = false

        local function sample() -- Luacid: Inlined by compiler; 1 call site recovered
            if not var4.current then
                var5(readSheetContentInsets(bool1))
            end
        end

        sample()
        local tbl1 = { (if bool1.scroller ~= nil then bool1.scroller:GetPropertyChangedSignal("CanvasPosition") else bool1.sheet:GetPropertyChangedSignal("Position")):Connect(
                sample
            ), RunService.RenderStepped:Connect(sample) }

        return function()
            for _, value in tbl1 do
                value:Disconnect()
            end
            var5(var1)
        end
    end, { bool1, bool2, var5 })

    return React.useCallback(function()
        var4.current = true
        var5(var1)
    end, { var5 })
end

return useSheetContentInsets
