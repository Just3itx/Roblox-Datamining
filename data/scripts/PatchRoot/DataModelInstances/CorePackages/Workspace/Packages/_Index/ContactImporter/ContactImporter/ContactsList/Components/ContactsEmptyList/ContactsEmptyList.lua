-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local dependencies = require(scriptParentParentParentParent.dependencies)

local Roact = dependencies.Roact
local UIBlox = dependencies.UIBlox
local withLocalization = dependencies.withLocalization

local Images = UIBlox.App.ImageSet.Images
local TextKeys = require(scriptParentParentParentParent.Common.TextKeys)
local ContactsInformationModal = require(scriptParentParentParentParent.ContactsList.Components.ContactsInformationModal)

local var1 = Roact.PureComponent:extend("ContactsEmptyList")

var1.defaultProps = {
    errorTextKey = TextKeys.EMPTY_STATE
}

function var1.render(arg1)
    local props = arg1.props

    return withLocalization({ emptyState = props.errorTextKey })(function(arg2)
        return Roact.createElement(
            ContactsInformationModal,
            {
                image = Images["icons/status/oof_xlarge"],
                layoutOrder = props.layoutOrder,
                text = arg2.emptyState
            }
        )
    end)
end
return var1
