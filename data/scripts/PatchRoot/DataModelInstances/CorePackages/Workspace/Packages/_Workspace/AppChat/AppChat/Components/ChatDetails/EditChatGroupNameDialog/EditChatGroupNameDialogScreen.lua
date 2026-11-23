-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Roact = require(AppChatParent.Roact)

local EditChatGroupNameDialogContainer = require(script.Parent.EditChatGroupNameDialogContainer)
local Logger = require(script.Parent.Logger)

local var1 = Roact.PureComponent:extend("EditChatGroupNameDialogScreen")
var1.defaultProps = { navigation = nil }

function var1.init(arg1)
    function arg1.onEditChatGroupNameDialogClose()
        arg1.props.navigation.goBack()
    end
end

function var1.render(arg1)
    local navigation = arg1.props.navigation
    assert(type(navigation) ~= "nil", "EditChatGroupNameDialogScreen should be wrapped with Roact Navigation")

    local conversationId = navigation.getParam("conversationId", nil)
    if conversationId ~= nil then
        return Roact.createElement(
            EditChatGroupNameDialogContainer,
            {
                conversationId = conversationId,
                onModalClose = arg1.onEditChatGroupNameDialogClose
            }
        )
    end

    Logger:warning("ConversationId is required to open {screen}")
    return nil
end

function var1.didMount(_)
    Logger:info("{screen} mounted")
end

return var1
