-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:30:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContactImporterParent = script:FindFirstAncestor("ContactImporter").Parent

local React = require(ContactImporterParent.React)

local Foundation = require(ContactImporterParent.Foundation)
local FoundationText = Foundation.Text
local View = Foundation.View

local useLocalization = require(ContactImporterParent.Localization).Hooks.useLocalization

local function ContactsSyncWarningMessage(tbl1)
    local var1 = useLocalization({ message = "Feature.Contacts.Message.ContactsSyncWarning" })

    return React.createElement(View, {
        LayoutOrder = tbl1.layoutOrder,
        tag = "size-full-0 auto-y margin-y-small"
    }, {
        text = React.createElement(FoundationText, {
            tag = "auto-y size-full-0 text-align-x-left text-wrap radius-medium bg-action-alert padding-medium stroke-emphasis",
            Text = var1.message
        })
    })
end

return ContactsSyncWarningMessage
