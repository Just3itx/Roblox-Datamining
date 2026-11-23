-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local useChatIsVisible = require(script.Parent.useChatIsVisible)
local setTimeout = require(AppChatParent.LuauPolyfill).setTimeout
local getGuiObjectBackgroundTransparency = require(AppChat.Utils.getGuiObjectBackgroundTransparency)
local FFlagAppChatGuiVisibleUsesStyledTransparency = require(AppChat.Flags.FFlagAppChatGuiVisibleUsesStyledTransparency)

local num1 = game:DefineFastInt("AppChat.GuiVisibleBatchUpdateIntervalMs", 1000)

local function getGuiObjectIsObscuredAtPosition(current, num2: number, num3: number)
    for _, value in (CoreGui:GetGuiObjectsAtPosition(num2, num3)) do
        if not value:IsA("GuiObject") then
            continue
        end

        local var1 = if FFlagAppChatGuiVisibleUsesStyledTransparency then getGuiObjectBackgroundTransparency(value) else value.BackgroundTransparency

        if value == current then
            return false
        end

        if value.Visible ~= false and not (var1 > 0.95 or value:IsDescendantOf(current)) then
            return true
        end
    end
    return false
end

local function getGuiObjectIsObscured(current): boolean
    local absolutePosition = current.AbsolutePosition
    local absoluteSize = current.AbsoluteSize
    local var1 = absolutePosition + absoluteSize * 0.5

    local var2 = absolutePosition + absoluteSize
    local var3 = absolutePosition + Vector2.new(absoluteSize.X, 0)
    local var4 = absolutePosition + Vector2.new(0, absoluteSize.Y)
    local num2 = 1

    local uiCorner = current:FindFirstChildOfClass("UICorner")
    if uiCorner and uiCorner:IsA("UICorner") then
        local offset = uiCorner.CornerRadius.Offset

        if offset > 0 then
            num2 = math.ceil(offset * 0.3) + 1
        end
    end

    local guiObjectIsObscuredAtPosition = getGuiObjectIsObscuredAtPosition(current, var1.X, var1.Y)

    local guiObjectIsObscuredAtPosition2 = getGuiObjectIsObscuredAtPosition(current, absolutePosition.X + num2, absolutePosition.Y + num2)

    local guiObjectIsObscuredAtPosition3 = getGuiObjectIsObscuredAtPosition(current, var4.X + num2, var4.Y - num2)

    local guiObjectIsObscuredAtPosition4 = getGuiObjectIsObscuredAtPosition(current, var3.X - num2, var3.Y + num2)

    local guiObjectIsObscuredAtPosition5 = getGuiObjectIsObscuredAtPosition(current, var2.X - num2, var2.Y - num2)

    return guiObjectIsObscuredAtPosition
        or guiObjectIsObscuredAtPosition2
        or guiObjectIsObscuredAtPosition3
        or guiObjectIsObscuredAtPosition4
        or guiObjectIsObscuredAtPosition5
end

local function useIsGuiInChatVisible(tbl1, tbl2)
    local var1 = useChatIsVisible()
    local var2, var3 = React.useState(false)
    local var4 = React.useRef(nil)

    React.useEffect(function()
        local function updateIsGuiVisible() -- Luacid: Inlined by compiler; 3 call sites recovered
            if tbl1.current and tbl1.current:IsA("GuiObject") then
                local isNotOccluded = tbl1.current.IsNotOccluded
                local guiObjectIsObscured = getGuiObjectIsObscured(tbl1.current)
                var3(isNotOccluded and not guiObjectIsObscured)
                return
            end
            var3(false)
        end

        local function queueUpdateIsGuiVisible() -- Luacid: Inlined by compiler; 2 call sites recovered
            if var4.current then
                return
            end
            var4.current = setTimeout(function()
                var4.current = nil
                updateIsGuiVisible()
            end, num1)
        end
        local function onDescendantEvent(descendant: Instance)
            if not descendant:IsA("GuiObject") then
                return
            end

            queueUpdateIsGuiVisible()
        end

        queueUpdateIsGuiVisible()
        local tbl3 = {}
        if tbl1.current and tbl1.current:IsA("GuiObject") and var1 then
            local isNotOccludedChanged = tbl1.current:GetPropertyChangedSignal("IsNotOccluded")
            table.insert(tbl3, isNotOccludedChanged:Connect(queueUpdateIsGuiVisible))

            local layerCollector = tbl1.current:FindFirstAncestorWhichIsA("LayerCollector")
            if layerCollector then
                local descendantAdded = layerCollector.DescendantAdded
                table.insert(tbl3, descendantAdded:Connect(onDescendantEvent))
                local descendantRemoving = layerCollector.DescendantRemoving
                table.insert(tbl3, descendantRemoving:Connect(onDescendantEvent))
            end
        end

        return function()
            for _, value in tbl3 do
                value:Disconnect()
            end
        end
    end, Cryo.List.join(tbl2, { var1 }))

    return var1 and var2
end
return useIsGuiInChatVisible
