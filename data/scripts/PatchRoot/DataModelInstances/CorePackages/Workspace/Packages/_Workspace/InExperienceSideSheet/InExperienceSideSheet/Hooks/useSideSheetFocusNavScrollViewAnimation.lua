-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")
local InExperienceSideSheetParent = InExperienceSideSheet.Parent

local React = require(InExperienceSideSheetParent.React)

local TweenDuration = require(InExperienceSideSheet.Common.Constants).TweenDuration

local GetDrawerVisibleStore = require(InExperienceSideSheetParent.Drawer).Stores.GetDrawerVisibleStore

local AnimateScrollViewToSelectionHelper = require(InExperienceSideSheetParent.AppBlox).AnimateScrollViewToSelectionHelper

local function useSideSheetFocusNavScrollViewAnimation()
    local var1 = React.useRef({})
    local var2 = React.useRef(nil)
    local var3 = React.useRef(nil)
    local getDrawerAnimating = GetDrawerVisibleStore(false).getDrawerAnimating

    local var4 = React.useCallback(function()
        if var1.current then
            for _, value in var1.current do
                value:Disconnect()
            end
            var1.current = {}
        end
        if var2.current then
            var2.current:Cancel()
            var2.current = nil
        end
    end, {})

    local var5 = React.useCallback(function(current)
        if var3.current == current then
            return
        end

        if not current then
            var3.current = nil
            var4()
            return
        end

        var4()
        var3.current = current

        local var5 = var1
        local var6 = var2
        local var7, var8 = AnimateScrollViewToSelectionHelper(current, TweenDuration, getDrawerAnimating)
        var5.current = var7
        var6.current = var8
    end, { var1, var4, getDrawerAnimating })

    React.useEffect(function()
        return var4
    end, { var4 })

    return var5
end

return useSideSheetFocusNavScrollViewAnimation
