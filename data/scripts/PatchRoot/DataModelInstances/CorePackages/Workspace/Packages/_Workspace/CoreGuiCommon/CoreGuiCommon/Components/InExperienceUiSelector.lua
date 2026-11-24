-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamepadService = game:GetService("GamepadService")
local GuiService = game:GetService("GuiService")

local CoreGuiCommon = script:FindFirstAncestor("CoreGuiCommon")
local CoreGuiCommonParent = CoreGuiCommon.Parent

local Chrome = require(CoreGuiCommonParent.Chrome)
local Foundation = require(CoreGuiCommonParent.Foundation)
local Localization = require(CoreGuiCommonParent.Localization)
local React = require(CoreGuiCommonParent.React)
local SignalsReact = require(CoreGuiCommonParent.SignalsReact)

local useLocalization = Localization.Hooks.useLocalization

local FocusOnChrome = Chrome.FocusUtils.FocusOnChrome

local FFlagUseSelectModeToggleLabel = require(CoreGuiCommon.Flags).FFlagUseSelectModeToggleLabel

local GetUiSelectorSignalStore = require(CoreGuiCommon.Stores).GetUiSelectorSignalStore

local BaseMenu = Foundation.UNSTABLE.BaseMenu
local InputSize = Foundation.Enums.InputSize

local function InExperienceUiSelector(_)
    local var1 = SignalsReact.useSignalState(GetUiSelectorSignalStore)
    local var2 = SignalsReact.useSignalState(var1.getVisibility)
    local ref = React.useRef(nil)
    local var3 = React.useRef(nil)
    local var5 = useLocalization({
        robloxMenu = "CoreScripts.InGameMenu.Controls.RobloxMenu",
        uiNavToggle = if FFlagUseSelectModeToggleLabel then "Feature.Accessibility.Menu.SelectModeToggle" else "CoreScripts.InGameMenu.GameSettings.UINavToggle"
    })

    React.useEffect(function()
        if var2 and var3.current then
            GuiService.SelectedCoreObject = var3.current
        elseif not var2 then
            GuiService.SelectedCoreObject = nil
        end
    end, { var2 })

    local items = React.useMemo(function()
        return {
            {
                id = "RobloxMenu",
                text = var5.robloxMenu,
                ref = var3,
                onActivated = function()
                    var1.setVisibility(false)
                    FocusOnChrome()
                end
            },
            {
                id = "UiNavigationMode",
                text = var5.uiNavToggle,
                onActivated = function()
                    var1.setVisibility(false)
                    GuiService.SelectedCoreObject = nil
                    local _success, _result = pcall(function()
                        GamepadService:AutoSelectGui()
                    end)
                end
            }
        }
    end, { var1, var5 })

    if not var2 then
        return nil
    end

    return (React.createElement(Foundation.View, {
        tag = "position-center-center anchor-center-center auto-xy radius-medium bg-surface-200",
        ref = ref,
        selectionGroup = {
            SelectionBehaviorDown = Enum.SelectionBehavior.Stop,
            SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
            SelectionBehaviorRight = Enum.SelectionBehavior.Stop,
            SelectionBehaviorUp = Enum.SelectionBehavior.Stop
        },
        testId = "in-experience-ui-selector"
    }, {
        Menu = React.createElement(BaseMenu.Root, { items = items, size = InputSize.Medium, radius = Foundation.Enums.Radius.Medium })
    }))
end
return InExperienceUiSelector
