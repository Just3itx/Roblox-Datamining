-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:30:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local dependencies = require(scriptParentParentParentParent.dependencies)

local t = dependencies.t
local Roact = dependencies.Roact
local UIBlox = dependencies.UIBlox
local withLocalization = dependencies.withLocalization
local RoactRodux = dependencies.RoactRodux

local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local withStyle = UIBlox.Style.withStyle
local TextKeys = require(scriptParentParentParentParent.Common.TextKeys)
local Constants = require(scriptParentParentParentParent.Common.Constants)
local getFFlagPassNavigationToContactsRevoked = require(scriptParentParentParentParent.Flags.getFFlagPassNavigationToContactsRevoked)

local var1 = Roact.PureComponent:extend("ContactsRevokedAccessDialog")

var1.validateProps = t.strictInterface({ navigation = t.table, screenSize = t.Vector2 })

function var1.render(arg1)
    return withLocalization({
        titleText = TextKeys.CONTACTS_LIST_TITLE,
        revokedFlow = TextKeys.CONTACTS_REVOKED_FLOW,
        closeModalOk = TextKeys.CLOSE_MODAL_OK
    })(
        function(arg2)
            return withStyle(function(_)
                local props = arg1.props

                local navigation = props.navigation
                local var2 = navigation.getParam(Constants.CLOSE_MODAL) or getFFlagPassNavigationToContactsRevoked() and navigation.pop
                return Roact.createElement(InteractiveAlert, {
                    title = arg2.titleText,
                    screenSize = props.screenSize,
                    buttonStackInfo = {
                        buttons = {{
                            buttonType = ButtonType.Secondary,
                            props = {
                                onActivated = function()
                                    var2()
                                end,
                                text = arg2.closeModalOk
                            }
                        }},
                        buttonHeight = 48,
                        forcedFillDirection = Enum.FillDirection.Vertical
                    },
                    bodyText = arg2.revokedFlow
                })
            end)
        end
    )
end
return RoactRodux.connect(function(arg1)
    return {
        screenSize = arg1.ScreenSize
    }
end, nil)(var1)
