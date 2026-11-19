-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local Utility = require(RobloxGui.Modules.Settings.Utility)
local React = require(CorePackages.Packages.React)
local Foundation = require(CorePackages.Packages.Foundation)
local Responsive = require(CorePackages.Workspace.Packages.Responsive)

local useTokens = Foundation.Hooks.useTokens
local View = Foundation.View
local FoundationText = Foundation.Text
local Image = Foundation.Image
local PopoverSide = Foundation.Enums.PopoverSide

local TraversalHistoryMenu = require(RobloxGui.Modules.Settings.Components.Traversal.TraversalHistoryMenu)

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FFlagAddTraversalHistoryReactMenuButtons = require(RobloxGui.Modules.Settings.Flags.FFlagAddTraversalHistoryReactMenuButtons)
local FIntRelocateMobileMenuButtonsVariant = require(RobloxGui.Modules.Settings.Flags.FIntRelocateMobileMenuButtonsVariant)
local bool1 = game:DefineFastFlag("MenuButtonsIncreaseIconSize", false)
local FFlagIEMFocusNavSupportNewButtons = require(RobloxGui.Modules.Settings.Flags.FFlagIEMFocusNavSupportNewButtons)
local FFlagGamepadIconSupportCheck = SharedFlags.FFlagGamepadIconSupportCheck

local function func1(transparency: number): number -- Luacid: Inlined by compiler; 3 call sites recovered
    return transparency + (1 - transparency) * 0.5
end

local function KeyLabelIcon(text: string?, isDisabled: boolean)
    local var1 = useTokens()

    local createElement = React.createElement
    local var2 = View
    local tbl1 = {
        LayoutOrder = 1,
        backgroundStyle = {
            Color3 = var1.Color.ActionStandard.Background.Color3,
            Transparency = if isDisabled then func1(var1.Color.ActionStandard.Background.Transparency) else var1.Color.ActionStandard.Background.Transparency
        },
        tag = "size-1000-700 row align-x-center align-y-center radius-medium"
    }

    local tbl2 = {
        HotkeyText = React.createElement(FoundationText, {
            Text = text,
            textStyle = {
                Color3 = var1.Color.ActionStandard.Foreground.Color3,
                Transparency = if isDisabled then func1(var1.Color.ActionStandard.Foreground.Transparency) else var1.Color.ActionStandard.Foreground.Transparency
            },
            tag = "text-title-small"
        })
    }
    return createElement(var2, tbl1, tbl2)
end

local function Hint(arg1)
    if FIntRelocateMobileMenuButtonsVariant == 2 and Utility:IsSmallTouchScreen() then
        return nil
    elseif arg1.lastInput == Responsive.Input.Pointer or arg1.lastInput == Responsive.Input.Directional then
        local bool2 = bool1 and arg1.lastInput ~= Responsive.Input.Directional

        return React.createElement(Image, {
            Image = if arg1.lastInput == Responsive.Input.Directional then arg1.gamepadButtonImageHint else arg1.keyboardButtonImageHint,
            imageStyle = {
                Color3 = arg1.foregroundStyle.Color3,
                Transparency = if arg1.isDisabled then 0.5 else arg1.foregroundStyle.Transparency
            },
            tag = {
                ["size-700"] = not bool2 and arg1.isSmall,
                ["size-800"] = not (bool2 or arg1.isSmall),
                ["size-900"] = bool2 and arg1.isSmall,
                ["size-1000"] = bool2 and not arg1.isSmall
            }
        })
    elseif arg1.lastInput == Responsive.Input.Pointer then
        return KeyLabelIcon(arg1.keyboardHint, arg1.isDisabled)
    elseif arg1.lastInput == Responsive.Input.Directional then
        return React.createElement(Image, {
            Image = arg1.gamepadButtonImageHint,
            imageStyle = {
                Color3 = arg1.foregroundStyle.Color3,
                Transparency = if arg1.isDisabled then 0.5 else arg1.foregroundStyle.Transparency
            },
            tag = {
                ["size-600"] = not arg1.isSmall,
                ["size-500"] = arg1.isSmall
            }
        })
    else
        return nil
    end
end

local function ButtonText(arg1)
    return React.createElement(FoundationText, {
        Text = arg1.text,
        LayoutOrder = 2,
        textStyle = {
            Color3 = arg1.foregroundStyle.Color3,
            Transparency = if arg1.isDisabled then 0.5 else arg1.foregroundStyle.Transparency
        },
        tag = {
            ["auto-x"] = true,
            ["text-title-medium"] = not arg1.isSmall,
            ["text-title-small"] = arg1.isSmall,
            ["content-action-standard"] = not arg1.isEmphasized,
            ["content-action-soft-emphasis"] = arg1.isEmphasized
        }
    })
end

local function supportsButton(directional: string, keyCode: Enum.KeyCode)
    if not FFlagGamepadIconSupportCheck or not keyCode or directional ~= Responsive.Input.Directional then
        return true
    end
    return UserInputService:GamepadSupports(UserInputService:GetLastInputType(), keyCode)
end

return React.memo(function(tbl1) -- name: MenuButton
    local var1 = useTokens()
    local anchorRef = if FFlagIEMFocusNavSupportNewButtons then tbl1.buttonRef elseif FFlagAddTraversalHistoryReactMenuButtons then React.useRef(nil) else nil
    local background = if tbl1.isEmphasized then var1.Color.ActionSoftEmphasis.Background else var1.Color.ActionStandard.Background
    local foreground = if tbl1.isEmphasized then var1.Color.ActionSoftEmphasis.Foreground else var1.Color.ActionStandard.Foreground
    local var3, var4 = React.useState(supportsButton(tbl1.lastInput, tbl1.gamepadButton))

    React.useEffect(function()
        local connection = if FFlagGamepadIconSupportCheck and tbl1.gamepadButton then UserInputService.LastInputTypeChanged:Connect(function()
            var4(supportsButton(tbl1.lastInput, tbl1.gamepadButton))
        end) else nil

        return function()
            if connection then
                connection:Disconnect()
            end
        end
    end, { tbl1.gamepadButton, tbl1.lastInput })

    local bool2 = bool1 and tbl1.lastInput ~= Responsive.Input.Directional

    local createElement = React.createElement
    local var5 = View
    local tbl2 = {
        onActivated = tbl1.onActivated,
        isDisabled = tbl1.isDisabled,
        LayoutOrder = tbl1.layoutOrder,
        backgroundStyle = {
            Color3 = background.Color3,
            Transparency = if tbl1.isDisabled then func1(background.Transparency) else background.Transparency
        },
        tag = {
            ["fill auto-x row align-y-center align-x-center gap-small radius-medium"] = true,
            ["size-0-1200"] = not tbl1.isSmall,
            ["size-0-1000"] = tbl1.isSmall,
            ["bg-action-standard"] = not tbl1.isEmphasized,
            ["bg-action-soft-emphasis"] = tbl1.isEmphasized
        },
        ref = if FFlagAddTraversalHistoryReactMenuButtons then anchorRef elseif FFlagIEMFocusNavSupportNewButtons then anchorRef else nil,
        Selectable = if FFlagIEMFocusNavSupportNewButtons then true else nil
    }
    local tbl3 = { Button = 0, Hint = 0, ButtonText = 0, TraversalHistoryMenu = 0 }
    local element

    if FFlagAddTraversalHistoryReactMenuButtons then
        element = React.createElement(View, {
            tag = "auto-xy row align-y-center align-x-center grow gap-small"
        }, {
            Hint = if FFlagGamepadIconSupportCheck and not var3 then nil else React.createElement(Hint, {
                lastInput = tbl1.lastInput,
                gamepadButtonImageHint = tbl1.gamepadButtonImageHint,
                keyboardButtonImageHint = tbl1.keyboardButtonImageHint,
                isDisabled = tbl1.isDisabled,
                foregroundStyle = foreground,
                isSmall = tbl1.isSmall
            }),
            ButtonText = React.createElement(ButtonText, {
                text = tbl1.text,
                isDisabled = tbl1.isDisabled,
                foregroundStyle = foreground,
                isEmphasized = tbl1.isEmphasized,
                isSmall = tbl1.isSmall
            })
        })
    else
        element = nil
    end

    tbl3.Button = element
    local element2

    if FFlagGamepadIconSupportCheck and not var3
        or FFlagAddTraversalHistoryReactMenuButtons
        or FIntRelocateMobileMenuButtonsVariant == 2 and Utility:IsSmallTouchScreen()
    then
        element2 = nil
    elseif tbl1.lastInput == Responsive.Input.Pointer or tbl1.lastInput == Responsive.Input.Directional then
        element2 = React.createElement(Image, {
            Image = if tbl1.lastInput == Responsive.Input.Directional then tbl1.gamepadButtonImageHint else tbl1.keyboardButtonImageHint,
            imageStyle = {
                Color3 = foreground.Color3,
                Transparency = if tbl1.isDisabled then 0.5 else foreground.Transparency
            },
            tag = {
                ["size-700"] = not bool2 and tbl1.isSmall,
                ["size-800"] = not (bool2 or tbl1.isSmall),
                ["size-900"] = bool2 and tbl1.isSmall,
                ["size-1000"] = bool2 and not tbl1.isSmall
            }
        })
    elseif tbl1.lastInput == Responsive.Input.Pointer then
        element2 = KeyLabelIcon(tbl1.keyboardHint, tbl1.isDisabled)
    elseif tbl1.lastInput == Responsive.Input.Directional then
        element2 = React.createElement(Image, {
            Image = tbl1.gamepadButtonImageHint,
            imageStyle = {
                Color3 = foreground.Color3,
                Transparency = if tbl1.isDisabled then 0.5 else foreground.Transparency
            },
            tag = {
                ["size-600"] = not tbl1.isSmall,
                ["size-500"] = tbl1.isSmall
            }
        })
    else
        element2 = nil
    end

    tbl3.Hint = element2
    local element3

    if FFlagAddTraversalHistoryReactMenuButtons then
        element3 = nil
    else
        element3 = React.createElement(FoundationText, {
            Text = tbl1.text,
            LayoutOrder = 2,
            textStyle = {
                Color3 = foreground.Color3,
                Transparency = if tbl1.isDisabled then 0.5 else foreground.Transparency
            },
            tag = {
                ["auto-x"] = true,
                ["text-title-medium"] = not tbl1.isSmall,
                ["text-title-small"] = tbl1.isSmall,
                ["content-action-standard"] = not tbl1.isEmphasized,
                ["content-action-soft-emphasis"] = tbl1.isEmphasized
            }
        })
    end

    tbl3.ButtonText = element3
    local element4 = if FFlagAddTraversalHistoryReactMenuButtons and tbl1.addTraversalHistoryMenu then React.createElement(
        TraversalHistoryMenu,
        {
            anchorRef = anchorRef,
            idleButtonStateIsDown = true,
            currentPageChangeSignal = tbl1.currentPageChangeSignal,
            isDarkOnDarkMode = true,
            menuSide = if tbl1.isSmall then PopoverSide.Bottom else PopoverSide.Top
        }
    ) else nil
    tbl3.TraversalHistoryMenu = element4
    return createElement(var5, tbl2, tbl3)
end)
