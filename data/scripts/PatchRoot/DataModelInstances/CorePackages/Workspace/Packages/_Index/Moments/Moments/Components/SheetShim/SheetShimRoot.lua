-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:41:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)
local ReactUtils = require(MomentsParent.ReactUtils)

local _SheetShimTypes = require(script.Parent.SheetShimTypes)
local getSheetStructure = require(script.Parent.getSheetStructure)
local useHiddenBackdrop = require(script.Parent.useHiddenBackdrop)
local useSheetContentInsets = require(script.Parent.useSheetContentInsets)

local useComposedRef = ReactUtils.useComposedRef

return React.forwardRef(function(arg1, arg2) -- name: SheetShimRoot
    local var1, var2 = React.useState(nil)
    local var3 = React.useMemo(function()
        if var1 ~= nil then
            return (getSheetStructure(var1))
        end

        return nil
    end, { var1 })
    local var4 = useSheetContentInsets(var3, arg1.onContentInsetChanged)
    useHiddenBackdrop(var3, arg1.hideBackdrop == true)

    local onClose = arg1.onClose
    local var5 = React.useCallback(function()
        var4()
        onClose()
    end, { var4, onClose })
    local ref = useComposedRef(var2, arg2)

    local var7 = table.clone(arg1)
    var7.onContentInsetChanged = nil
    var7.hideBackdrop = nil
    var7.onClose = var5
    var7.ref = ref
    return React.createElement(Foundation.Sheet.Root, var7)
end)
