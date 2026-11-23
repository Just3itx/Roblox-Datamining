-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = game:GetService("CorePackages").Packages._Index.Foundation.Foundation
local FoundationParent = Foundation.Parent
local React = require(FoundationParent.React)
local ReactUtils = require(FoundationParent.ReactUtils)

local BottomSheet = require(script.Parent.BottomSheet)
local CenterSheet = require(script.Parent.CenterSheet)
local SideSheet = require(script.Parent.SideSheet)
local useScreen = require(Foundation.Providers.Overlay.useScreen)
local GuiService = require(Foundation.Utility.Wrappers).Services.GuiService
local _DialogSize = require(Foundation.Enums.DialogSize)
local withDefaults = require(Foundation.Utility.withDefaults)

local _Types = require(script.Parent.Types)

local tbl1 = { testId = "--foundation-sheet" }

return React.memo(React.forwardRef(function(arg1, ref) -- name: Sheet
    local var1 = withDefaults(arg1, tbl1)
    local var2, var3 = React.useState(var1.isOpen == nil or var1.isOpen)
    local sheetRef = React.useRef(nil)
    local var5 = useScreen()

    local var6, var7 = React.useState(not var5 or var5.AbsoluteSize.X > var5.AbsoluteSize.Y)
    local displaySize, var9 = React.useState(GuiService.ViewportDisplaySize)

    React.useImperativeHandle(var1.sheetRef, function()
        return sheetRef.current
    end, {})

    React.useEffect(function()
        if var1.isOpen == false and sheetRef.current then
            sheetRef.current.close()
        elseif var1.isOpen then
            var3(true)
        end
    end, { var1.isOpen })

    React.useEffect(function()
        if not var2 and var1.isOpen then
            var3(true)
        end
    end, { var2 })

    ReactUtils.useEventConnection(GuiService:GetPropertyChangedSignal("ViewportDisplaySize"), function()
        var9(GuiService.ViewportDisplaySize)
    end, {})

    React.useLayoutEffect(function()
        local connection = nil
        if var5 then
            var7(var5.AbsoluteSize.X > var5.AbsoluteSize.Y)
            connection = var5:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                var7(var5.AbsoluteSize.X > var5.AbsoluteSize.Y)
            end)
        end

        return function()
            if connection then
                connection:Disconnect()
            end
        end
    end, { var5 })

    if not var2 then
        return nil
    end

    local var10 = table.clone(var1)
    var10.isOpen = nil
    var10.ref = ref
    var10.sheetRef = sheetRef
    var10.displaySize = displaySize
    function var10.onClose()
        if var1.onClose then
            var1.onClose()
        end
        var3(false)
    end

    if displaySize == Enum.DisplaySize.Small and not var6 then
        return React.createElement(BottomSheet, var10)
    elseif var1.preferCenterSheet then
        return React.createElement(CenterSheet, var10)
    end
    return React.createElement(SideSheet, var10)
end))
