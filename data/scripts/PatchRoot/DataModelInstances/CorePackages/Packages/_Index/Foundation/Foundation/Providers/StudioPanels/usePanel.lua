-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:50:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)
local ReactUtils = require(FoundationParent.ReactUtils)

local Flags = require(Foundation.Utility.Flags)
local _StudioUri = require(Foundation.Utility.Plugin.StudioUri)

local _Types = require(script.Parent.Types)

local function usePanel(tbl1)
    local var1 = React.useRef(nil)
    local var2 = ReactUtils.useRefToState({
        anchorUri = tbl1.anchorUri,
        position = tbl1.position,
        depth = tbl1.depth,
        parentPopoverId = tbl1.parentPopoverId,
        isFocusable = if Flags.FoundationPopoverPluginFocusable then tbl1.isFocusable else nil,
        initialSize = if Flags.FoundationPopoverPluginPoolReclaim then tbl1.initialSize else nil
    })

    local var3 = React.useRef(tbl1.onClose)
    var3.current = tbl1.onClose

    local var4 = React.useRef(tbl1.registerPanelAsync)
    var4.current = tbl1.registerPanelAsync

    local var5, var6 = React.useState(false)

    local var7 = React.useCallback(function()
        var6(true)
        var3.current()
    end, {})

    local var8 = ReactUtils.useAsync(function()
        if not tbl1.isOpen or var5 then
            if var1.current then
                var1.current()
                var1.current = nil
            end

            return nil
        end

        local var8, current = var4.current(
            var2.current.anchorUri,
            var2.current.position,
            var7,
            var2.current.depth,
            var2.current.parentPopoverId,
            if Flags.FoundationPopoverPluginFocusable then var2.current.isFocusable else nil,
            if Flags.FoundationPopoverPluginPoolReclaim then var2.current.initialSize else nil
        )

        var1.current = current
        return var8
    end, { tbl1.isOpen, var2, var5 })

    local value = if not var5 and var8.status == "ok" then var8.value else nil

    React.useEffect(function()
        if not tbl1.isOpen then
            var6(false)
        end
    end, { tbl1.isOpen })

    ReactUtils.useAsync(function()
        if value then
            value.updateAsync({
                targetWidgetUri = tbl1.anchorUri,
                targetAnchorPoint = tbl1.position.targetAnchorPoint,
                subjectAnchorPoint = tbl1.position.subjectAnchorPoint,
                offset = tbl1.position.offset
            })
        end

        return nil
    end, { value, tbl1.anchorUri, tbl1.position })

    React.useEffect(function()
        return function()
            if var1.current then
                var1.current()
            end
        end
    end, {})

    return value
end

return usePanel
