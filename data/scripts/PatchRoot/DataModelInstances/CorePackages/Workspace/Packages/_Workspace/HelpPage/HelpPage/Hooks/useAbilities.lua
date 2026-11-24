-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local React = require(scriptParentParentParent.React)
local BindingConfigs = require(scriptParentParent.Configs.BindingConfigs)
local _ConfigTypes = require(scriptParentParent.Configs.ConfigTypes)
local Constants = require(scriptParentParent.Constants)

local function getStaticCharacterMovementControlCount(): number
    local num1 = 0
    for _, control in BindingConfigs.Controls do
        if control.keyboardInput ~= nil and control.keyboardInput.group.id == BindingConfigs.ControlGroups.CharacterMovement.id then
            num1 += 1
        end
    end
    return num1
end

local staticCharacterMovementControlCount = getStaticCharacterMovementControlCount()

local function getAbilityLayoutOrder(name: string) -- Luacid: Inlined by compiler; 1 call site recovered
    if string.match(name, "^AbilityAction%d+$") == nil then
        return nil
    end

    local var1 = tonumber(string.sub(name, 14))
    return if var1 == nil then nil else staticCharacterMovementControlCount + var1
end

local function getCharacterContext(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    if arg1 == nil then
        return nil
    end

    local inputContexts = arg1:FindFirstChild("InputContexts")
    if inputContexts == nil then
        return nil
    end

    local characterContext = inputContexts:FindFirstChild("CharacterContext")
    return if characterContext == nil or not characterContext:IsA("InputContext") then nil else characterContext
end

local function getKeyboardCombo(arg1): {[any]: any}?
    local tbl1 = {}
    local primaryModifier = arg1.PrimaryModifier
    local secondaryModifier = arg1.SecondaryModifier
    local keyCode = arg1.KeyCode
    if primaryModifier ~= Enum.KeyCode.None then
        table.insert(tbl1, primaryModifier)
    end
    if secondaryModifier ~= Enum.KeyCode.None then
        table.insert(tbl1, secondaryModifier)
    end
    if keyCode ~= Enum.KeyCode.None then
        table.insert(tbl1, keyCode)
    end

    return if #tbl1 == 0 then nil else tbl1
end

local function getAssetAttribute(arg1, str1: string): string? -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = arg1:GetAttribute(str1)
    return if type(var1) == "string" and var1 ~= "" then var1 else nil
end

local function readAction(arg1): {actionAssetId: any, disabled: boolean, label: any}?
    local layoutOrder = getAbilityLayoutOrder(arg1.Name)
    if layoutOrder == nil then
        return nil
    end

    local input = {}
    local tbl1 = {}

    for _, child in arg1:GetChildren() do
        if not child:IsA("InputBinding") then
            continue
        end

        local keyCode = child.KeyCode
        if keyCode == nil then
            continue
        end

        if Constants.HELP_PAGE.GAMEPAD_LAYOUT_ORDER[keyCode] ~= nil then
            table.insert(tbl1, keyCode)
        else
            local keyboardCombo = getKeyboardCombo(child)
            if keyboardCombo ~= nil then
                table.insert(input, keyboardCombo)
            end
        end
    end

    local tbl3 = {
        label = arg1.DisplayName,
        disabled = not arg1.Enabled,
        actionAssetId = getAssetAttribute(arg1, "ButtonPressedAssetId")
    }
    if #input > 0 then
        tbl3.keyboardInput = {
            input = input,
            group = BindingConfigs.ControlGroups.CharacterMovement,
            layoutOrder = layoutOrder
        }
    end
    if #tbl1 > 0 then
        tbl3.gamepadInput = { input = tbl1 }
    end

    return tbl3
end

local function readAbilities(arg1)
    local characterContext = getCharacterContext(arg1)

    if characterContext == nil or not characterContext.Enabled then
        return nil
    end

    local result = {}
    for _, child in characterContext:GetChildren() do
        if not child:IsA("InputAction") then
            continue
        end

        local var1 = readAction(child)
        if var1 ~= nil then
            result[child.Name] = var1
        end
    end

    return result
end

local function disconnectAll(tbl1) -- Luacid: Inlined by compiler; 8 call sites recovered
    for _, value in tbl1 do
        value:Disconnect()
    end
    table.clear(tbl1)
end

local function useAbilities(arg1)
    local var1 = arg1 or Players.LocalPlayer
    local var2, var3 = React.useState((readAbilities(var1)))

    React.useEffect(function()
        if var1 == nil then
            return
        end

        local tbl1 = {}
        local tbl2 = {}
        local tbl3 = {}
        local tbl4 = {}

        local function refresh() -- Luacid: Inlined by compiler; 9 call sites recovered
            var3((readAbilities(var1)))
        end

        local function func1()
            disconnectAll(tbl4)

            local characterContext = getCharacterContext(var1)
            if characterContext == nil then
                return
            end

            for _, child in characterContext:GetChildren() do
                if not (child:IsA("InputAction") and string.match(child.Name, "^AbilityAction%d+$")) then
                    continue
                end

                table.insert(tbl4, child.Changed:Connect(refresh))
                table.insert(tbl4, child:GetAttributeChangedSignal("ButtonPressedAssetId"):Connect(refresh))

                local tbl5 = tbl4
                local childAdded = child.ChildAdded

                table.insert(tbl5, childAdded:Connect(function()
                    func1()
                    refresh()
                end))

                local tbl6 = tbl4
                local childRemoved = child.ChildRemoved

                table.insert(tbl6, childRemoved:Connect(function()
                    func1()
                    refresh()
                end))

                for _, child2 in child:GetChildren() do
                    if child2:IsA("InputBinding") then
                        table.insert(tbl4, child2.Changed:Connect(refresh))
                    end
                end
            end
        end

        local function func2()
            disconnectAll(tbl2)
            disconnectAll(tbl3)
            disconnectAll(tbl4)

            local inputContexts = var1:FindFirstChild("InputContexts")
            if inputContexts == nil then
                return
            end

            local tbl5 = tbl2
            local childAdded = inputContexts.ChildAdded

            table.insert(tbl5, childAdded:Connect(function()
                func2()
                refresh()
            end))

            local tbl6 = tbl2
            local childRemoved = inputContexts.ChildRemoved

            table.insert(tbl6, childRemoved:Connect(function()
                func2()
                refresh()
            end))

            local characterContext = getCharacterContext(var1)
            if characterContext == nil then
                return
            end

            table.insert(tbl3, characterContext.Changed:Connect(refresh))

            local tbl7 = tbl3
            local childAdded2 = characterContext.ChildAdded

            table.insert(tbl7, childAdded2:Connect(function()
                func1()
                refresh()
            end))

            local tbl8 = tbl3
            local childRemoved2 = characterContext.ChildRemoved

            table.insert(tbl8, childRemoved2:Connect(function()
                func1()
                refresh()
            end))

            func1()
        end

        local childAdded = var1.ChildAdded

        table.insert(tbl1, childAdded:Connect(function(child: Instance)
            if child.Name == "InputContexts" then
                func2()
                refresh()
            end
        end))

        local childRemoved = var1.ChildRemoved

        table.insert(tbl1, childRemoved:Connect(function(child: Instance)
            if child.Name == "InputContexts" then
                func2()
                refresh()
            end
        end))

        func2()
        refresh()

        return function()
            disconnectAll(tbl1)
            disconnectAll(tbl2)
            disconnectAll(tbl3)
            disconnectAll(tbl4)
        end
    end, { var1 })

    return var2
end

return useAbilities
