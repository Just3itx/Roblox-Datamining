-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationParent = script:FindFirstAncestor("MomentsCreation").Parent

local React = require(MomentsCreationParent.React)

local uDim = UDim.new(0, 0)

local function ensureUIPadding(guiObject: GuiObject): UIPadding -- Luacid: Inlined by compiler; 1 call site recovered
    local uiPadding = guiObject:FindFirstChildOfClass("UIPadding")
    if uiPadding then
        return uiPadding
    end
    local uiPadding2 = Instance.new("UIPadding")
    uiPadding2.Parent = guiObject
    return uiPadding2
end

local function isZeroed(uiPadding): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return uiPadding.PaddingTop == uDim
        and uiPadding.PaddingBottom == uDim
        and uiPadding.PaddingLeft == uDim
        and uiPadding.PaddingRight == uDim
end

local function relocateBoxPadding(arg1)
    local uiPadding = arg1:FindFirstChildOfClass("UIPadding")
    if uiPadding == nil or isZeroed(uiPadding) then
        return
    end

    local parent = arg1.Parent
    if parent == nil or not parent:IsA("GuiObject") then
        return
    end

    local uiPadding2 = ensureUIPadding(parent)
    uiPadding2.PaddingTop = uiPadding.PaddingTop
    uiPadding2.PaddingBottom = uiPadding.PaddingBottom
    uiPadding2.PaddingLeft = uiPadding.PaddingLeft
    uiPadding2.PaddingRight = uiPadding.PaddingRight

    uiPadding.PaddingTop = uDim
    uiPadding.PaddingBottom = uDim
    uiPadding.PaddingLeft = uDim
    uiPadding.PaddingRight = uDim
end

local function tryRelocate(arg1)
    local var1 = nil
    if arg1:IsA("TextBox") then
        var1 = arg1
    elseif arg1:IsA("UIPadding") then
        local parent = arg1.Parent
        if parent and parent:IsA("TextBox") then
            var1 = parent
        end
    end

    if var1 ~= nil and (var1.Name == "TextBox" or var1.Name == "MobileTextBox") then
        relocateBoxPadding(var1)
    end
end

local function useComposerParentTextPadding(bool1: boolean)
    local var1 = React.useRef(nil)

    return React.useCallback(function(arg1)
        if var1.current ~= nil then
            var1.current:Disconnect()
            var1.current = nil
        end

        if arg1 == nil or not bool1 then
            return
        end

        for _, descendant in arg1:GetDescendants() do
            tryRelocate(descendant)
        end
        var1.current = arg1.DescendantAdded:Connect(tryRelocate)
    end, { bool1 })
end

return useComposerParentTextPadding
