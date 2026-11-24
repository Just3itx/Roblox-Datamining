-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:11:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local React = require(InExperienceShopParent.React)
local ControlState = require(InExperienceShopParent.Foundation).Enums.ControlState

local submitFreeTrialTopBarChip = require(InExperienceShop.submitFreeTrialTopBarChip)
local getChipDismissInput = require(script.Parent.getChipDismissInput)
local isDismissSwipe = require(script.Parent.isDismissSwipe)

local function useFreeTrialChipDismiss(tbl1)
    local isVisible = tbl1.isVisible
    local isSettled = tbl1.isSettled
    local revealLayer = tbl1.revealLayer
    local chipRef = tbl1.chipRef
    local hovered, var2 = React.useState(false)
    local var3 = React.useRef(false)
    local var4 = React.useRef(nil)
    local pointerDismiss, var6 = getChipDismissInput()

    local function cancelHoverHide() -- Luacid: Inlined by compiler; 8 call sites recovered
        local current = var4.current
        if current ~= nil then
            task.cancel(current)
            var4.current = nil
        end
    end

    local function showCloseButton() -- Luacid: Inlined by compiler; 3 call sites recovered
        cancelHoverHide()
        var2(true)
    end

    local function scheduleHideCloseButton() -- Luacid: Inlined by compiler; 2 call sites recovered
        cancelHoverHide()

        var4.current = task.delay(0.15, function()
            var4.current = nil
            var2(false)
        end)
    end

    local function onChipStateChanged(arg1)
        if arg1 == ControlState.Hover or arg1 == ControlState.Selected then
            showCloseButton()
        elseif arg1 == ControlState.Default or arg1 == ControlState.Initialize then
            scheduleHideCloseButton()
        end
    end

    local function onCloseActivated()
        submitFreeTrialTopBarChip.dismiss()
    end

    local function onCloseStateChanged(arg1)
        if arg1 == ControlState.Hover or arg1 == ControlState.Pressed then
            showCloseButton()
        end
    end

    local var7 = React.useRef(function(_) end)
    local var8 = React.useRef(function(_) end)

    React.useLayoutEffect(function()
        local current = chipRef.current
        if current == nil or not isVisible then
            return
        end

        local tbl2 = {}
        if pointerDismiss then
            local mouseEnter = current.MouseEnter

            table.insert(tbl2, mouseEnter:Connect(function()
                showCloseButton()
            end))

            local mouseLeave = current.MouseLeave

            table.insert(tbl2, mouseLeave:Connect(function()
                scheduleHideCloseButton()
            end))
        end

        if var6 then
            local inputPosition = nil
            local function onTouchBegan(input: InputObject)
                if input.UserInputType == Enum.UserInputType.Touch then
                    inputPosition = input.Position
                end
            end
            local function onTouchEnded(input: InputObject)
                if input.UserInputType ~= Enum.UserInputType.Touch or inputPosition == nil then
                    return
                end
                local var9 = input.Position - inputPosition
                inputPosition = nil
                if isDismissSwipe(var9.X, var9.Y) then
                    var3.current = true
                    submitFreeTrialTopBarChip.dismiss()
                end
            end
            var7.current = onTouchBegan
            var8.current = onTouchEnded
            local inputBegan = current.InputBegan
            table.insert(tbl2, inputBegan:Connect(onTouchBegan))
            local inputEnded = current.InputEnded
            table.insert(tbl2, inputEnded:Connect(onTouchEnded))
        end

        return function()
            function var7.current(_) end
            function var8.current(_) end
            for _, value in tbl2 do
                value:Disconnect()
            end

            cancelHoverHide()
        end
    end, {
        isVisible,
        isSettled,
        revealLayer,
        pointerDismiss,
        var6
    })

    return {
        hovered = hovered,
        pointerDismiss = pointerDismiss,
        onChipStateChanged = onChipStateChanged,
        onCloseActivated = onCloseActivated,
        onCloseStateChanged = onCloseStateChanged,
        onTouchBegan = function(arg1)
            var7.current(arg1)
        end,
        onTouchEnded = function(arg1)
            var8.current(arg1)
        end,
        consumeSuppressedActivation = function(): boolean
            if not var3.current then
                return false
            end

            var3.current = false
            return true
        end
    }
end
return useFreeTrialChipDismiss
