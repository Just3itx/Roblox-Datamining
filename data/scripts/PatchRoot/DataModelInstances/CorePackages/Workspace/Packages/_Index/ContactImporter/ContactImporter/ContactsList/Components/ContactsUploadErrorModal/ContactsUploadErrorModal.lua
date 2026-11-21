-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:30:49Z
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

local var1 = Roact.PureComponent:extend("ContactsUploadErrorModal")

function var1.render(_)
    return withLocalization({ hasUploadError = TextKeys.UPLOAD_CONTACTS_FAILURE })(function(arg1)
        return Roact.createElement(
            ContactsInformationModal,
            {
                image = Images["icons/status/error_large"],
                text = arg1.hasUploadError
            }
        )
    end)
end
return var1
