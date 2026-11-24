-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationParent = script:FindFirstAncestor("Localization").Parent
local LocalizationService = game:GetService("LocalizationService")

local React = require(LocalizationParent.React)

local ArgCheck = require(LocalizationParent.ArgCheck)
local RobloxLocaleIdKey = require(script.Parent.RobloxLocaleIdKey)
local LocalizationRoactContext = require(script.Parent.LocalizationRoactContext)
local localizeStrings = require(script.Parent.localizeStrings)

local var1 = React.Component:extend("LocalizationConsumer")

function var1.init(arg1)
    local localization = arg1.props.localization

    if localization == nil then
        error("LocalizationConsumer must be below a LocalizationProvider.")
    end

    arg1.state = {
        locale = LocalizationService.RobloxLocaleId
    }

    function arg1.updateLocalization(locale)
        locale = localization:GetLocale()
        if locale ~= arg1.state.locale then
            arg1:setState({ locale = locale })
        end
    end

    arg1.connections = { localization.changed:connect(arg1.updateLocalization) }
end

function var1.willUnmount(arg1)
    for _, connection in pairs(arg1.connections) do
        connection:disconnect()
    end
end

function var1.render(arg1)
    local localization = arg1.props.localization

    local render2 = arg1.props.render
    local stringsToBeLocalized = arg1.props.stringsToBeLocalized

    ArgCheck.isType(render2, "function", "LocalizationConsumer.props.render")
    ArgCheck.isType(stringsToBeLocalized, "table", "LocalizationConsumer.props.stringsToBeLocalized")

    local var2 = localizeStrings(localization, stringsToBeLocalized)
    var2[RobloxLocaleIdKey] = arg1.state.locale

    return render2(var2)
end

local function LocalizationContextConsumer(arg1)
    return React.createElement(LocalizationRoactContext.Consumer, {
        render = function(localization)
            return React.createElement(
                var1,
                {
                    localization = localization,
                    render = arg1.render,
                    stringsToBeLocalized = arg1.stringsToBeLocalized
                }
            )
        end
    })
end
return LocalizationContextConsumer
